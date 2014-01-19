From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH/WIP v2 00/14] inotify support
Date: Sun, 19 Jan 2014 18:04:36 +0100
Message-ID: <87mwirewd7.fsf@thomasrast.ch>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 18:05:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4voQ-0003ca-4l
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 18:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbaASRE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 12:04:56 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:53156 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbaASREy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 12:04:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 0D2A54D6572;
	Sun, 19 Jan 2014 18:04:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gZnrcsyKB9cd; Sun, 19 Jan 2014 18:04:39 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.196])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 5F43B4D64BD;
	Sun, 19 Jan 2014 18:04:38 +0100 (CET)
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 17
 Jan 2014 16:47:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240693>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>   read-cache: save trailing sha-1
>   read-cache: new extension to mark what file is watched
>   read-cache: connect to file watcher
>   read-cache: ask file watcher to watch files
>   read-cache: put some limits on file watching
>   read-cache: get modified file list from file watcher
>   read-cache: add config to start file watcher automatically
>   read-cache: add GIT_TEST_FORCE_WATCHER for testing
>   file-watcher: add --shutdown and --log options
>   file-watcher: automatically quit
>   file-watcher: support inotify
>   file-watcher: exit when cwd is gone
>   pkt-line.c: increase buffer size to 8192
>   t1301: exclude sockets from file permission check

I never got the last three patches, did you send them?

Also, this doesn't cleanly apply anywhere at my end.  Can you push it
somewhere for easier experimentation?

> This is getting in better shape. Still wondering if the design is
> right, so documentation, tests and some error cases are still
> neglected. I have not addressed Jonathan's and Jeff's comments in thi=
s
> reroll, but I haven't forgotten them yet. The test suite seems to be
> fine when file-watcher is forced on with GIT_TEST_FORCE_WATCHER set..

I tried to figure out whether there were any corners you are painting i=
t
into, but doing so without a clear overview of the protocol makes my
head spin.

So here's what I gather from the patches (I would have started from the
final result, but see above).

The slow path, before the watcher is ready, works like:

  spawn watcher
  send "hello $index_sha1"
  receive "hello "
  mark most files CE_WATCHED
  send "watch $paths" for each CE_WATCHED
    the paths are actually a pkt-line-encoded series of paths
    get back "fine $n" (n =3D number of watches processed)
  do work as usual (including lstat())

The fast path:

  load CE_WATCHED from index
  send "hello $index_sha1"
  receive "hello $index_sha1"
  send "status"
    get back "new $path" for each changed file
    again aggregate
  mark files that are "new" as ~CE_WATCHED
  files that are CE_WATCHED can skip their lstat(), since they are unch=
anged

On index writing (both paths):

  save CE_WATCHED in index extension
  send "bye $index_sha1"
  send "forget $index_sha1 $path" for every path that is known to be ch=
anged

So I think the watcher protocol can be specified roughly as:

  Definitions: The watcher is a separate process that maintains a set o=
f
  _watched paths_.  Git uses the commands below to add or remove paths
  from this set.

  In addition it maintains a set of _changed paths_, which is a subset
  of the watched paths.  Git occasionally queries the changed paths.  I=
f
  at any time after a path P was added to the "watched" set, P has or
  may have changed, it MUST be added to the "changed" set.

  Note that a path being "unchanged" under this definition does NOT mea=
n
  that it is unchanged in the index as per `git diff`.  It may have bee=
n
  changed before the watch was issued!  Therefore, Git MUST test whethe=
r
  the path started out unchanged using lstat() AFTER it was added to th=
e
  "watched" set.

  Handshake::
    On connecting, git sends "hello <magic>".  <magic> is an opaque
    string that identifies the state of the index.  The watcher MUST
    respond with "hello <previous_magic>", where previous_magic is
    obtained from the "bye" command (below).  If <magic> !=3D
    <previous_magic>, the watcher MUST reset state for this repository.

  Watch::
    Git sends "watch <pathlist>" where the <pathlist> consists of a
    series of 4-digit lengths and literal pathnames (as in the pkt-line
    format) for each path it is interested in.  The watcher MUST respon=
d
    with "fine <n>" after processing a message that contained <n> paths=
=2E
    The watcher MUST add each path to the "watched" set and remove it
    from the "changed" set (no error if it was already watched, or not
    changed).

  Status::
    Git sends "status".  The watcher MUST respond with its current
    "changed" set.  This uses the format "new <pathlist>", with
    <pathlist> formatted as for the "watch" command.

  Bye::
    Git sends "bye <magic>" to indicate it has finished writing the
    index.  The watcher must store <magic> so as to use it as the
    <previous_magic> in a "hello" response.

  Forget::
    Git sends "forget <pathlist>", with the <pathlist> formatted as for
    the "watch" command.  The watcher SHOULD remove each path in
    <pathlist> from its watched set.

Did I get that approximately straight?  Perhaps you can fix up as neede=
d
and then turn it into the documentation for the protocol.

There are several points about this that I don't like:

* What does the datagram socket buy us?  You already do a lot of
  pkt-line work for the really big messages, so why not just use
  pkt-line everywhere and a streaming socket?

* The handshake should have room for capabilities, so that we can exten=
d
  the protocol.

* The hello/hello handshake is confusing, and probably would allow you
  to point two watchers at each other without them noticing.  Make it
  hello/ready, or some other unambiguous choice.

* I took some liberty and tried to fully define the transitions between
  the sets.  So even though I'm not sure this is currently handled, I
  made it well-defined to issue "watch" for a path that is in the
  changed set.

* "bye" is confusing, because in practice git issues "forget"s after
  "bye".  The best I can come up with is "setstate", I'm sure you have
  better ideas.

There's also the problem of ordering guarantees between the socket and
inotify.  I haven't found any, so I would conservatively assume that th=
e
socket messages may in fact arrive before inotify, which is a race in
the current code.  E.g., in the sequence 'touch foo; git status' the
daemon may see

  socket                    inotify                 =20
  < hello...
  < status
  > new <empty list>
                            touch foo

I think a clever way to handle this would be to add a new command:

  Wait::
    This command serves synchronization.  Git creates a file of its
    choice in $GIT_DIR/watch (say, `.git/watch/wait.<random>`).  Then i=
t
    sends "wait <path>".  The watcher MUST block until it has processed
    all change notifications up to and including <path>.

This assumes the FS notification API to be ordered, which appears to be
the case for inotify; from inotify(7):

  The events returned by reading from an inotify file descriptor form a=
n
  ordered queue.  Thus, for example, it is guaranteed that when renamin=
g
  from one directory to another, events will be produced in the correct
  order on the inotify file descriptor.

As a corollary, from watching .git/watch you get free notification of
'rm .git/watch/socket' as a termination signal.

We also need to think about how other OS's APIs work with this.  From
what I've heard about the Windows API, it should work well, so that's
great.  I suspect the *bsd/darwin API corresponding to inotify won't be
too different, but it's better to work this out now.

> Thomas, you were a proponent of per-user daemon last time. I agree
> that is a better solution when you need to support submodules. So if
> you have time, have a look and see if anything I did may prevent
> per-user daemon changes later (hint, I have a few unfriendly exit() i=
n
> file-watcher.c). You also worked with inotify before maybe you can
> help spot some mishandling too as I'm totally new to inotify.

As you note, the protocol for "help, I don't know what's true any more"
(i.e., it got an inotify buffer overflow event) needs to be a special
"reset" message, not exit().

The per-repo approach does require keeping open an extra FD per repo
though, regardless of whether the daemon is actually for all of the
user's repos.  The linuxen I run as desktop systems usually default
ulimit -n to 1024, so that's not a massive restriction, but still.

As a reminder to other reviewers, the reason I wanted a per-user watche=
r
is that /proc/sys/fs/inotify/max_user_instances defaults to 128 on my
systems.  We need one inotify FD per watcher process, and given that a
full android tree had something on the order of 300 repos last I looked=
,
that just won't fly.

As far as inotify corner-cases go, the only one I'm aware of is
directory renames.  I suspect we'll have to watch directories all the
way up to the repository root to reliably detect when this happens.  No=
t
sure how to best handle this.  Perhaps we should declare Git completely
agnostic wrt such issues, and behind the scenes issue all watches up to
the root even if we don't need them for anything other than directory
renames.


Ok, that's probably a confused sum of rambles.  Let me know if you can
make any sense of it.

--=20
Thomas Rast
tr@thomasrast.ch

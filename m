From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP v2 00/14] inotify support
Date: Mon, 20 Jan 2014 08:28:26 +0700
Message-ID: <CACsJy8AbsC8m5ju8pj2r3GzyUEiYSp5Kye=d+OhhTDaOhte8hg@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com> <87mwirewd7.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Jan 20 02:29:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W53fj-0004r1-PG
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 02:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbaATB26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 20:28:58 -0500
Received: from mail-qe0-f53.google.com ([209.85.128.53]:41745 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbaATB25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 20:28:57 -0500
Received: by mail-qe0-f53.google.com with SMTP id s1so1231094qeb.12
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 17:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o33yPwfq44WAc61wHZTHggGYHQhJcbJi/6PiWRRkqjE=;
        b=pLRlsxZCJvQ5ArG2MbNTilW4HBnw7Z73qqRufX5N4XdO2/QiYe3VB0aOjMKpbRXyzT
         WZU1g4ASCQqZAwN8YB49AqnODlZ9Br0VqRQG71oYmhxu1mrVoq+L4QrxE23YbWiR6Ia+
         v8LlcD6UlgUNkWoEKEzUnC9fp0dUuGxdheJY6odAFSDcl4R846FPTyK21GgzCn+Hqdso
         DHkMushJRXI2kKJ2SlSjlfCl9MZmxAYHsgIn3qdS3QC4Wm80xDgNqXOLulJg7tZe/3K6
         kKivZujp9KsuyoVrqSO1hb0hZLMl6kja+5PqVTf7OSMR637IF7+K9Ec9moMJMgM3tD6Q
         fkMw==
X-Received: by 10.224.167.84 with SMTP id p20mr24073722qay.24.1390181336505;
 Sun, 19 Jan 2014 17:28:56 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 19 Jan 2014 17:28:26 -0800 (PST)
In-Reply-To: <87mwirewd7.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240703>

On Mon, Jan 20, 2014 at 12:04 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> I never got the last three patches, did you send them?
>
> Also, this doesn't cleanly apply anywhere at my end.  Can you push it
> somewhere for easier experimentation?

Sorry I rebased it on top of kb/fast-hashmap but never got around to
actually using hash tables. The code is here (and on top of master)

https://github.com/pclouds/git.git file-watcher

> So I think the watcher protocol can be specified roughly as:
>
>   Definitions: The watcher is a separate process that maintains a set of
>   _watched paths_.  Git uses the commands below to add or remove paths
>   from this set.
>
>   In addition it maintains a set of _changed paths_, which is a subset
>   of the watched paths.  Git occasionally queries the changed paths.  If
>   at any time after a path P was added to the "watched" set, P has or
>   may have changed, it MUST be added to the "changed" set.
>
>   Note that a path being "unchanged" under this definition does NOT mean
>   that it is unchanged in the index as per `git diff`.  It may have been
>   changed before the watch was issued!  Therefore, Git MUST test whether
>   the path started out unchanged using lstat() AFTER it was added to the
>   "watched" set.

Correct.

>   Handshake::
>     On connecting, git sends "hello <magic>".  <magic> is an opaque
>     string that identifies the state of the index.  The watcher MUST
>     respond with "hello <previous_magic>", where previous_magic is
>     obtained from the "bye" command (below).  If <magic> !=
>     <previous_magic>, the watcher MUST reset state for this repository.

In addition, git must reset itself (i.e. clear all CE_WATCHED flags)
because nothing can be trusted at this point.

...
>
> Did I get that approximately straight?  Perhaps you can fix up as needed
> and then turn it into the documentation for the protocol.

Will do (and probably steal some of your text above).

> There are several points about this that I don't like:
>
> * What does the datagram socket buy us?  You already do a lot of
>   pkt-line work for the really big messages, so why not just use
>   pkt-line everywhere and a streaming socket?

With datagram sockets I did not have to maintain the connected
sockets, which made it somewhat simpler to handle so far.

The default SO_SNDBUF goes up to 212k, so we can send up to that
amount without blocking. With current pkt-line we send up to 64k in
"watch" message then we have to wait for "fine", which results in more
context switches. But I think we can extend pkt-line's length field to
5 hex digit to cover this.

Streaming sockets are probably the way to go for per-user daemon, so
we can identify a socket with a repo.

> * The handshake should have room for capabilities, so that we can extend
>   the protocol.

Yeah. One more point for streaming sockets. With datagram sockets it's
harder to define a "session" and thus hard to add capabilities.

> * The hello/hello handshake is confusing, and probably would allow you
>   to point two watchers at each other without them noticing.  Make it
>   hello/ready, or some other unambiguous choice.

OK

> * I took some liberty and tried to fully define the transitions between
>   the sets.  So even though I'm not sure this is currently handled, I
>   made it well-defined to issue "watch" for a path that is in the
>   changed set.

Yes that should avoid races. The path can be removed from "watched"
set later after git acknowledges it.

> * "bye" is confusing, because in practice git issues "forget"s after
>   "bye".  The best I can come up with is "setstate", I'm sure you have
>   better ideas.

Originally it was "forget", "forget", "forget" then "bye". But with
that order, if git crashes before sending "bye" we could lose info in
"changed" set so the order was changed but I did not update the
command name.

> There's also the problem of ordering guarantees between the socket and
> inotify.  I haven't found any, so I would conservatively assume that the
> socket messages may in fact arrive before inotify, which is a race in
> the current code.  E.g., in the sequence 'touch foo; git status' the
> daemon may see
>
>   socket                    inotify
>   < hello...
>   < status
>   > new <empty list>
>                             touch foo
>
> I think a clever way to handle this would be to add a new command:
>
>   Wait::
>     This command serves synchronization.  Git creates a file of its
>     choice in $GIT_DIR/watch (say, `.git/watch/wait.<random>`).  Then it
>     sends "wait <path>".  The watcher MUST block until it has processed
>     all change notifications up to and including <path>.

So wait.<random> inotify event functions as a barrier. Nice.

> As far as inotify corner-cases go, the only one I'm aware of is
> directory renames.  I suspect we'll have to watch directories all the
> way up to the repository root to reliably detect when this happens.  Not
> sure how to best handle this.  Perhaps we should declare Git completely
> agnostic wrt such issues, and behind the scenes issue all watches up to
> the root even if we don't need them for anything other than directory
> renames.

Under normal circumstances we would watch all directories in the
worktree anyway. I'll need to write some tests for inotify..

> Ok, that's probably a confused sum of rambles.  Let me know if you can
> make any sense of it.

Thank you for your input. Now I'm back to the white board (or paper).
-- 
Duy

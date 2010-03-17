From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads is available
Date: Wed, 17 Mar 2010 22:28:18 +0100
Message-ID: <201003172228.18939.j6t@kdbg.org>
References: <cover.1267889072.git.j6t@kdbg.org> <201003092100.36616.j6t@kdbg.org> <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 22:30:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns0or-0000XF-UL
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 22:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab0CQVaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 17:30:19 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:55991 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752166Ab0CQVaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 17:30:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7FAD41001C;
	Wed, 17 Mar 2010 22:30:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1637F19F5E9;
	Wed, 17 Mar 2010 22:28:19 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142438>

On Mittwoch, 10. M=C3=A4rz 2010, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > On Samstag, 6. M=C3=A4rz 2010, Shawn O. Pearce wrote:
> >> I'm in favor of that.  If we have threaded delta search enabled,
> >> we probably can also run these async procedures in a POSIX thread
> >> rather than forking off a child.
> >
> > OK. The patch could look like this.
>
> Will queue in 'pu', but as Shawn said, we should probably give anothe=
r
> closer look at the callees that are started with this interface befor=
e
> moving forward.

So here is my analysis.

There are currently these users of the async infrastructure:

builtin-fetch-pack.c
builtin-receive-pack.c
builtin-send-pack.c
convert.c
remote-curl.c
upload_pack.c

The list below shows all functions that read or write potentially globa=
l state=20
that are called from the async procedure (except for upload_pack.c, see=
=20
below). I ignored all functions that do not depend on global state, lik=
e=20
strcmp, memcpy, sprintf, strerror, etc.

----------
remote-curl.c:write_discovery():
  write
  close

These two functions only communicate with the parent. This is absolutel=
y=20
thread-safe.

----------
builtin-fetch-pack.c:sideband_demux() and
builtin-send-pack.c:sideband_demux() are virtually identical, and
builtin-receive-pack.c:copy_to_sideband() has the same footprint:
  getenv
  read
  die_errno
  die
  write
  close

Again, the functions only communicate with the parent and nothing else.=
 getenv=20
could be a problem if the parent called setenv, but it doesn't. die (an=
d=20
die_errno) are overridden in the threaded version, and are uncritical. =
In=20
total, this user is thread-safe.

(This is getenv("TERM") from recv_sideband, btw.)

----------
convert.c:filter_buffer()
  pipe
  close
  getenv
  fork
  read
  write
  fprintf
  waitpid

if GIT_TRACE is set:
  xrealloc
  die
  free

This one is less trivial. It calls start_command+finish_command from th=
e async=20
procedure. The parent calls
  read()
  xrealloc() (via strbuf_read())
  error()
(and nothing else) between start_async() and finish_async().

As long as GIT_TRACE is not set, we are safe, because the async procedu=
re=20
carefully releases all global resources that it allocated, and the pare=
nt is=20
looking in the other direction while it does os. Even if GIT_TRACE is s=
et,=20
xrealloc() in the parent and the async procedure cannot be called=20
simultanously because the procedure calls it only before it begins writ=
ing=20
output, and the parent only after it received this output.

On Windows, the situation is slightly different, because we always call=
 into=20
xmalloc() during start_command, but again we do so before the output is=
=20
produced.

I think we are safe in all cases.

----------
upload_pack:create_pack_file(): This user is different because it calls=
 into=20
the revision walker in the async procedure, which definitely affects gl=
obal=20
state. Therefore, here is the list of functions called by the parent un=
til it=20
exits:
  pipe
  close
  getenv
  fork
  read
  write
  fprintf
  waitpid
  alarm
  die
  die_errno
  pthread_join / waitpid

if GIT_TRACE is set:
  xrealloc
  die
  free

It also calls start_command+finish_command. If GIT_TRACE is set, we are=
 less=20
safe because this time, xrealloc() can be called simultanously with pac=
k=20
functions while the revision walker is operating.

But as long as GIT_TRACE is not set, it looks like we are safe, though =
I=20
haven't looked through the revision walker whether it messes with alarm=
s or=20
the environment.

One aspect is, though, that the async procedure is used *only* for a sh=
allow=20
clone, and the reason that it is used is that pack-objects (or the way =
it is=20
called from upload-pack?) has not been taught to produce a pack for a s=
hallow=20
clone.

This concludes my analysis.

-- Hannes

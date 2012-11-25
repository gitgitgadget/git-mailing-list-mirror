From: Thorsten Glaser <tg@debian.org>
Subject: Multiple threads of compression
Date: Sun, 25 Nov 2012 16:27:32 +0000 (UTC)
Message-ID: <loom.20121125T171702-64@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 17:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcfKR-0004XG-2X
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 17:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab2KYQoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2012 11:44:55 -0500
Received: from plane.gmane.org ([80.91.229.3]:54455 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab2KYQoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 11:44:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TcfKJ-0004VJ-R8
	for git@vger.kernel.org; Sun, 25 Nov 2012 17:45:03 +0100
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:45:03 +0100
Received: from tg by static-87-79-237-121.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.79.237.121 (Opera/9.27 (X11; MirBSD i386; U; en))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210374>

Hi,

I=E2=80=99m asking here informally first, because my information relate=
s
to a quite old version (the one from lenny-backports). A tl;dr
is at the end.

On a multi-core machine, the garbage collection of git, as well
as pack compression on the server side when someone clones a
repository remotely, the compression is normally done automatically
using multiple threads of execution.

That may be fine for your typical setups, but in my cases, I have
two scenarios where it isn=E2=80=99t:

=E2=93=90 The machine where I want it to use only, say, 2 of my 4 or 8 =
cores
  as I=E2=80=99m also running some VMs on the box which eat up a lot of=
 CPU
  and which I don=E2=80=99t want to slow down.

=E2=93=91 The server VM which has been given 2 or 3 VCPUs to cope with =
all
  the load done by clients, but which is RAM-constrained to only
  512 or, when lucky, 768 MiB. It previously served only http/https
  and *yuk* Subversion, but now, git comes into the play, and I=E2=80=99=
ve
  seen the one server box I think about go down *HARD* because git
  ate up all RAM *and* swap when someone wanted to update their clone
  of a repository after someone else committed=E2=80=A6 well, an ~100 M=
iB large
  binary file they shouldn=E2=80=99t. (It required manual intervention =
on the
  server to kill that revision and then the objects coupled with it,
  but even *that* didn=E2=80=99t work, read on for more.)

In both cases, I had to apply a quick hack. One I can reproduce
by now is, that, on the first box, I added a --threads=3D2 to the
line calling git pack-objects in /usr/lib/git-core/git-repack,
like this:

   83 args=3D"$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
   84 names=3D$(git pack-objects --threads=3D2 --keep-true-parents --ho=
nor-pack-
keep --non-empty --all --reflog $arg
   85         exit 1

(By the way, wrapping source code at 80c is still way to go IMHO.)

On the second box, IIRC I added --threads=3D1, but that box got
subsequently upgraded from lenny to wheezy so any local modification
is lost (luckily, the problem didn=E2=80=99t occur again recently, or a=
t
least I didn=E2=80=99t notice it, save for the VM load going up to 6-8
several times a day).

tl;dr: I would like to have a *global* option for git to restrict
the number of threads of execution it uses. Several subcommands,
like pack-objects, are already equipped with an optioin for this,
but unfortunately, these are seldom invoked by hand=C2=B9, so this can=E2=
=80=99t
work in my situations.

=E2=91=A0 automatic garbage collection, =E2=80=9Cgit gc --aggressive --=
prune=3Dnow=E2=80=9D,
  and cloning are the use cases I have at hand right now.

=C3=80 propos, while here: is gc --aggressive safe to run on a live,
online-shared repository, or does it break other users accessing
the repository concurrently? (If it=E2=80=99s safe I=E2=80=99d very muc=
h like to do
that in a, say weekly, cronjob on FusionForge, our hosting system.)

Thanks in advance!
//mirabilos

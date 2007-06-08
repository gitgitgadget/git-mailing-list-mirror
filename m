From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Fri, 08 Jun 2007 23:06:42 +0100
Message-ID: <4669D2F2.90801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Josh Triplett <josh@freedesktop.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwn1O-0005N1-Nm
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S971345AbXFHWcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S971361AbXFHWca
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:32:30 -0400
Received: from anchor-fallback-93.mail.demon.net ([194.217.242.93]:57548 "EHLO
	anchor-fallback-93.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S971353AbXFHWc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 18:32:29 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1507 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-93.mail.demon.net
	with ESMTP id S294287AbXFHWcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 23:32:20 +0100
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmxo-0005mM-0a; Fri, 08 Jun 2007 22:29:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49513>

Hi Junio,

Since the Git Makefile has a "check" target that uses sparse, I decided to
take a look at the sparse project to see what it was about, and what it
has to say about the git source code.

Initially, I had many problems because I am using cygwin, but I was able to
fix most of those problems. (the output from "make check" was about 16k lines
at one point!). Git also tickled a bug in sparse 0.2, which resulted in some
120+ lines of bogus warnings; that was fixed in version 0.3 (commit 0.2-15-gef25961).
As a result, sparse version 0.3 + my patches, elicits 106 lines of output
from "make check".

Naturally, I decided to "fix" the warnings produced by sparse, which resulted
in the following patch series:

[PATCH 01/10] Sparse: fix "non-ANSI function declaration" warnings
[PATCH 02/10] Sparse: fix some "using integer as NULL pointer" warnings
[PATCH 03/10] Sparse: fix some "symbol not declared" warnings (Part 1)
[PATCH 04/10] Sparse: fix some "symbol not declared" warnings (Part 2)
[PATCH 05/10] Sparse: fix some "symbol not declared" warnings (Part 3)
[PATCH 06/10] Sparse: fix "'add_head' not declared" warning
[PATCH 07/10] Sparse: fix "'merge_file' not declared" warning
[PATCH 08/10] Sparse: fix an "incorrect type in argument n" warning
[PATCH 09/10] Sparse: fix some "symbol 's' shadows an earlier one" warnings
[PATCH 10/10] Sparse: fix a "symbol 'weak_match' shadows an earlier one" warning

However, this patch series does not completely remove all warnings; the output
is reduced to:

builtin-pack-objects.c:312:31: warning: Using plain integer as NULL pointer
csum-file.c:152:22: warning: Using plain integer as NULL pointer
exec_cmd.c:7:40: error: undefined identifier 'GIT_EXEC_PATH'
git.c:209:35: error: undefined identifier 'GIT_VERSION'
http.c:203:46: error: undefined identifier 'GIT_USER_AGENT'
index-pack.c:201:25: warning: Using plain integer as NULL pointer
index-pack.c:538:26: warning: Using plain integer as NULL pointer

The three "undefined identifier 'GIT_...'" are easy to remove, I just didn't
get around to doing it (The GIT_... symbols are macros, defined in individual
make rules rather than CFLAGS, an thus not passed to sparse).

The four "Using plain integer...", whilst equally easy to remove, arguably should
not be ;-)  If you look at the code you will find they are all of the form
    x = crc32(0, Z_NULL, 0);
where the second parameter type is basically (unsigned char *) and the Z_NULL
macro is defined in the zlib header file as 0.  It could be said that this is
"idiomatic zlib usage" and should remain as written.  If you don't subscribe
to that view, then the required patch is obvious :P)

The above is one reason why this is an RFC series.  With one notable exception,
the patches do not fix a bug, add a feature or alter the program behaviour.
The only thing they do is remove sparse warnings; so you really have to believe
that this is a worthwhile thing to do, otherwise they are worthless!

[Note: As far as the NULL pointer warnings are concerned, I don't much care either
way. I just used that as an example (also note patch 02). Having said that, I
do think that the "NULL is the only one true null pointer" brigade need to
chill out a little; in fact I remember when 0 was the *only* null pointer.]

Another reason for the RFC, is that the patches are against the v1.5.2 tar-ball.
Since this was released a few weeks ago, the patches may not apply cleanly to
current git. (Yes, I really need to bite the bullet and get a broadband
connection so that I can clone the git repo.)

Also, that "one notable exception" is patch 10, which fixes a bug caused by a
"shadow" declaration.  Unfortunately, it also crashes my laptop when running
the test-suite. Yes, the machine freezes solid, with no option but to pull
the power-cord, and then the battery ... (I blush to have to admit that it
wasn't until the third time this happened that I realized that it might be
an idea not to put the battery back ... ;-))

The first nine patches all pass "make test" no problem, but patch 10 causes
totally unpredictable mayhem. The crash seems to occur randomly, on any test,
even those which can't possibly be affected by the change (when have you
heard that before...). As far as I can see, only git-http-push, git-send-pack
and git-push should be affected, which in turn means only t5400-send-pack.sh,
t5401-update-hooks.sh and t9400-git-cvsserver-server.sh.  None of those tests
have caused a crash. (actually, since I don't have cvs installed, t9400* is
not even running)

The nature of the crash has made debugging this such a nightmare that I've
just given up!  Hopefully, somebody on a system which does not grind to a
halt (ie. not using cygwin) can find the bug. (I think that cygwin may be
part of the problem here)

If the patches are whitespace damaged, please let me know and I will resend
as attachments.  (As josh noticed on the sparse list, my thunderbird
configuration was causing WS damage to the patches. I hope I have finally
fixed that, but I can't guarantee it!)

I've included a few more notes below, if you want to reproduce the
sparse output.

Hopefully someone will find this useful.

All the best,

Ramsay Jones

If you are on Linux and want to play along, then the official version 0.3
release of sparse should work for you, along with a minor change to the
Makefile thus:

--->8---
diff --git a/Makefile b/Makefile
index 19b6da1..ac3e2af 100644
--- a/Makefile
+++ b/Makefile
@@ -184,7 +184,7 @@ export TCL_PATH TCLTK_PATH
 
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
-SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
+SPARSE_FLAGS = -D__STDC__=1 $(shell cat .sparse_flags)
 
 
 
--->8---

where the .sparse_flags file is created with a script (gen-sparse-flags.sh)
as follows:

--->8---
#/bin/sh

rm -f /tmp/foo.h .macros; touch /tmp/foo.h

gcc -E -dM /tmp/foo.h >.macros
sed -e "s/^#define /-D'/" -e "s/ /=/" -e "s/$/'/" <.macros >.sparse_flags 

rm -f /tmp/foo.h

--->8---

Note: setting __STDC__ in the SPARSE_FLAGS should not be necessary (I thought
I needed it at one point...) but I didn't get around to removing it.

As an alternative, you could clear the SPARSE_FLAGS and change the "check" target
to call "cgcc -no-compile" in place of sparse.

BTW sparse Git repo: git://git.kernel.org/pub/scm/devel/sparse/sparse.git

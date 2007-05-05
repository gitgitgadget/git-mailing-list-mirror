From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: use --unsafe option under Cygwin with asciidoc
Date: Sat, 05 May 2007 02:06:06 -0700
Message-ID: <7v3b2bk5c1.fsf@assigned-by-dhcp.cox.net>
References: <ejlze97d.fsf@cante.net> <46388CBE.1080605@byu.net>
	<7vslaf4121.fsf@assigned-by-dhcp.cox.net>
	<7v7irnlmgo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Sat May 05 11:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkGDW-0007Ji-HE
	for gcvg-git@gmane.org; Sat, 05 May 2007 11:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbXEEJGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 05:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbXEEJGK
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 05:06:10 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52499 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbXEEJGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 05:06:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505090607.HTJW6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 5 May 2007 05:06:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vM661W0041kojtg0000000; Sat, 05 May 2007 05:06:06 -0400
In-Reply-To: <7v7irnlmgo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 05 May 2007 01:10:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46254>

Junio C Hamano <junkio@cox.net> writes:

> I haven't dug into the list archive article I quoted yet (the
> pointer is also found in TODO file in 'todo' branch) and haven't
> tried the backward compatibility pragma, but you can clearly see
> that the above differences are simply unacceptable.  They are
> not insignificant cosmetic differences -- the most important
> techinical details are being mangled, rendering the
> documentation useless.  We _do_ need the backward compatiblity
> enabled in asciidoc.conf or somewhere.

For AsciiDoc 8, this is minimally necessary.  I vaguely recalled
that this needs to be conditional on the actual version of
asciidoc as AsciiDoc 7 did not like it, but I haven't tried it
recently.

-- >8 snip >8 --
diff --git a/Documentation/Makefile b/Documentation/Makefile
index ad87736..28c33f0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -32,7 +32,7 @@ man1dir=$(mandir)/man1
 man7dir=$(mandir)/man7
 # DESTDIR=
 
-ASCIIDOC=asciidoc
+ASCIIDOC = asciidoc -a asciidoc7compatible
 ASCIIDOC_EXTRA =
 INSTALL?=install
 DOC_REF = origin/man

-- 8< snap 8< --

This seems to make the build-product from asciidoc 8.2.1 mostly
equivalent to asciidoc 7, but there still is one troubling
difference I spotted.

    --- 7	2007-05-05 01:56:18.000000000 -0700
    +++ 8	2007-05-05 01:56:29.000000000 -0700
    @@ -2,6 +2,6 @@
     A suffix \fI~<n>\fR to a revision parameter means the
     commit object that is the <n>th generation grand\-parent
     of the named commit object, following only the first parent.
    -I.e. rev~3 is equivalent to rev^^^ which is equivalent to
    -rev^1^1^1. See below for a illustration of the usage of this form.
    +I.e. rev~3 is equivalent to rev^ which is equivalent to
    +rev11^1. See below for a illustration of the usage of this form.
     .TP 3n

Again, this is an unacceptable breakage that makes this part of the
documentation useless.  However, this part of the documentation
uses our own "[attributes] caret=^" to work around the bug/misfeature
in AsciiDoc 7, so maybe this could be (and needs to be) worked
around by conditionally adjusting that macro to the version of
AsciiDoc.

I do not think we can say the current documentation set can be
formatted sanely with AsciiDoc 8.  Although I can say with
reasonable comfort level that the output with AsciiDoc 7 has
been proofread by enough people already, I cannot say the same
for AsciiDoc 8.

Somebody needs to do some homework to devise a compatibility
study between two versions, as we would eventually need to
support both versions (iow, make our documentation set
formattable with either version) at the same time.

While "use --unsafe" (I did not trigger any unsafe_error(), so
it may not be an issue) and giving "-a asciidoc7compatible" at
the command line might be one part of that compatibility study,
I do not think that is the end of it.  Proofreading the output
and making sure the technical details are not lost in formatting
errors is the most important part.

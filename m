From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Thu, 16 Feb 2012 09:34:48 +0100
Message-ID: <vpq39abrxav.fsf@bauges.imag.fr>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120216003300.17228570@sirion>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Haga <timhaga@ebene6.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:35:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxwnx-0005mE-6h
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab2BPIe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:34:59 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35801 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab2BPIe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:34:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1G8VhPr004845
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Feb 2012 09:31:43 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rxwnh-0000lo-6c; Thu, 16 Feb 2012 09:34:49 +0100
In-Reply-To: <20120216003300.17228570@sirion> (Tim Haga's message of "Thu, 16
	Feb 2012 00:33:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Feb 2012 09:31:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1G8VhPr004845
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329985908.38793@OqJOs4ty2+F3/bZXf9/snA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190884>

Tim Haga <timhaga@ebene6.org> writes:

> While testing your script on my office machine i discovered that the
> following might be a problem:
>
>> +if [ "$view" = 1 ] || [ "$view" = maybe ] && [ "$output" = "" ]; then
>> +    xpdf "$pdffile"
>> +fi
>
> Xpdf is not installed on all machines (e.g. it's not installed on my
> office machine), so maybe it would be a good idea to use a environment
> variable instead?

Right. I'm squashing this into the next version to allow configuration
(environment variable or --pdf-viewer) and sensible auto-detection:

diff --git a/contrib/latex/git-latexdiff b/contrib/latex/git-latexdiff
index 13aeb9a..85aafda 100755
--- a/contrib/latex/git-latexdiff
+++ b/contrib/latex/git-latexdiff
@@ -20,6 +20,8 @@ Options:
 	--no-view	Don't display the resulting PDF file
 	--view		View the resulting PDF file
 			(default if -o is not used)
+	--pdf-viewer CMD
+			Use CMD to view the PDF file (default: \$PDFVIEWER)
 	--no-cleanup	Don't cleanup temp dir after running
 	-o FILE, --output FILE
 			Copy resulting PDF into FILE
@@ -46,7 +48,7 @@ verbose_progress () {
 
 verbose_done () {
     if [ "$verbose" = 1 ]; then
-	echo " done."
+	echo " ${1:-done}."
     fi
 }
 
@@ -75,6 +77,10 @@ while test $# -ne 0; do
 	"--view")
 	    view=1
 	    ;;
+	"--pdf-viewer")
+	    shift
+	    PDFVIEWER="$1"
+	    ;;
 	"--no-cleanup")
 	    cleanup=0
 	    ;;
@@ -114,6 +120,28 @@ if [ "$old" = "" ]; then
     exit 1
 fi
 
+verbose "Auto-detecting PDF viewer"
+for command in xdg-open evince okular xpdf acroread; do
+    if [ "$PDFVIEWER" = "" ]; then
+	if command -v "$command" >/dev/null 2>&1; then
+	    PDFVIEWER="$command"
+	else
+	    verbose_progress
+	fi
+    fi
+done
+verbose_done "$PDFVIEWER"
+
+case "$view" in
+    maybe|1)
+	if [ "$PDFVIEWER" = "" ]; then
+	    echo "warning: could not find a PDF viewer on your system."
+	    echo "warning: Please set \$PDFVIEWER or use --pdf-viewer CMD."
+	    PDFVIEWER=false
+	fi
+	;;
+esac
+
 if [ "$main" = "" ]; then
     printf "%s" "No --main provided, trying to guess ... "
     main=$(git grep -l '^[ \t]*\\documentclass')
@@ -212,7 +240,7 @@ if [ "$output" != "" ]; then
 fi
 
 if [ "$view" = 1 ] || [ "$view" = maybe ] && [ "$output" = "" ]; then
-    xpdf "$pdffile"
+    "$PDFVIEWER" "$pdffile"
 fi
 
 if [ "$cleanup" = 1 ]; then

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

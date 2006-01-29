From: Junio C Hamano <junkio@cox.net>
Subject: Re: git commit error on initial (the very first) commit
Date: Sun, 29 Jan 2006 13:05:28 -0800
Message-ID: <7v8xsyiw2v.fsf@assigned-by-dhcp.cox.net>
References: <200601292026.54893.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 22:05:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Jjv-0003jV-LP
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 22:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWA2VFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWA2VFa
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 16:05:30 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:56561 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751085AbWA2VF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 16:05:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129210251.PBPF17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 16:02:51 -0500
To: Andrey Borzenkov <arvidjaar@mail.ru>
In-Reply-To: <200601292026.54893.arvidjaar@mail.ru> (Andrey Borzenkov's
	message of "Sun, 29 Jan 2006 20:26:54 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15244>

Andrey Borzenkov <arvidjaar@mail.ru> writes:

> May be I do something wrong? What is correct procedure to initially import 
> tree? git 1.1.4
>
> {pts/0}% git init-db
> defaulting to local storage area
> {pts/0}% git add .
> {pts/0}% git commit -m 'initial import'
> usage: git-diff-index [-m] [--cached] [<common diff options>] <tree-ish> 
> [<path>...]
> common diff options:
> ... etc

I suspect you have $(template_dir)/hooks/pre-commit enabled.

-- >8 --
[PATCH] pre-commit sample hook: do not barf on the initial import

The example hook barfs on the initial import.  Ideally it should
produce a diff from an empty tree, but for now let's stop at
squelching the bogus error message.  Often an initial import
involves tons of badly formatted files from foreign SCM, so not
complaining about them like this patch does might actually be a
better idea than enforcing the "Perfect Patch" format on them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 4bb6803..6b3a21b 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -10,8 +10,16 @@
 # This is slightly modified from Andrew Morton's Perfect Patch.
 # Lines you introduce should not have trailing whitespace.
 # Also check for an indentation that has SP before a TAB.
+
+if git-rev-parse --verify HEAD 2>/dev/null
+then
+	git-diff-index -p -M --cached HEAD
+else
+	# NEEDSWORK: we should produce a diff with an empty tree here
+	# if we want to do the same verification for the initial import.
+	:
+fi |		
 perl -e '
-    my $fh;
     my $found_bad = 0;
     my $filename;
     my $reported_filename = "";
@@ -31,8 +39,7 @@ perl -e '
 	print STDERR "* $why (line $lineno)\n";
 	print STDERR "$filename:$lineno:$line\n";
     }
-    open $fh, "-|", qw(git-diff-index -p -M --cached HEAD);
-    while (<$fh>) {
+    while (<>) {
 	if (m|^diff --git a/(.*) b/\1$|) {
 	    $filename = $1;
 	    next;

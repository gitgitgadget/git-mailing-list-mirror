From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 0/2] Fix interactive rebase when the editor saves with
 CR/LF
Date: Wed, 28 Oct 2015 15:54:14 +0100 (CET)
Message-ID: <cover.1446043983.git.johannes.schindelin@gmx.de>
References: <cover.1445939154.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrS7P-0006dx-Sw
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 15:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbbJ1OyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 10:54:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:64092 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbbJ1OyW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 10:54:22 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Lg5kl-1aGKXr1TgZ-00pbYl;
 Wed, 28 Oct 2015 15:54:16 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445939154.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:RKyz/H4XlcwXqr6PDWN6ohMTOi7B0K1DxMvXn4QAH71JKwr1/ke
 0cV8tOdT1jchsO3UGtAXhgze+ePYc/TM4FICuENUFPewkZscboFY6/NPM7DvQYlP2JEig2c
 y+KjJhydklX5hfI5tF36FWbC901c44dz50gW1Csz5YUWsVhV9XS+YdUBseqF0p2jgmoc62/
 qqp+Wv+d7YB/kV/SRAFzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kSMzaf+XuBc=:a3xDcwiwH8dRRYPkKblgJo
 SX8RpSiN1DXuayrbmjcGkvYzbYNKjA8hxMY7u9VEAHO0UT/KoaIFpUqAAeeV4xGkkd1SBfuzD
 S9zIZP3VQHpeZUXfWDI35R4AJMopBW3vKB5C7/6QKw80Ht1SnaEJNVXuaSe1QM/t2xDOLrRJL
 Yvg5aGiYMSt8oEIi4zPJFsq225xHWsAW2fEvlvnVxrZ+rf85xUeGWjbEk/YnLAzXsGUNsS1Gk
 DlPD1gHwMnZbs7iHfMwOTfYJuUyIxsv04lHGk5habVC3Gg4LoyHsEIMvmG6LvsZRU6WSApy9w
 YdBPgu93tQh3mz/iNbEi/etZUf4kBd2lm32T1CxiCenjHjyFqAp6ZqidAtVreoOCC13L8ge6I
 43pbIsa2dToby6n0/ggyTZPKbANRDhxHsvooJHugAD/pgJPaFJgzEARha/oLwYLLVQG+52445
 61LDhil4LL6qPPdtuWyHO9xtoBUllpZfLw8yyOTS45lnfWPBXO8xQIE9D+bvoYNC3Gn6Mizzy
 gZYr2lB5GZS77b+kuVw6VHFTU9lORLvfPJuNTTm8h2PfqnFpuPKlYoK4w3PZTmTavrYG1D4AR
 /98atTdt/ehmqf6Av7+tqkCRToJOMC8QIWtESlDcxMmgy67O0gvN43WjoWsy215b/KMfOhF40
 yF4IOM/UjIpTHxJ6esklLOxpUqC+j6Rs3iGOSzp2TWJV5cTptm1mLnoNfO7zGT8utksmag5en
 iU8mCyaaRygmomttmv7VfuEjdE8FBF/SO3DGjF4iHXyTFIxgAflY/9HmWn/OKNbyKs8KBRG0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280367>

Chad Boles reported that `git rebase -i` recently started producing
errors when the editor saves files with DOS line endings. The symptom
is:

	Warning: the command isn't recognized in the following line:
	 -

	You can fix this with 'git rebase --edit-todo'.
	Or you can abort the rebase with 'git rebase --abort'.

The real bummer is that simply calling `git rebase --continue` "fixes"
it.

Turns out that we now check whether a single Carriage Return is a valid
command. This new check was introduced recently (1db168ee9, ironically
named "rebase-i: loosen over-eager check_bad_cmd check").

The fix provided by Junio works around this issue by testing for an
explicit trailing carriage return and handles it like an empty line.

Unfortunately, this is the best we can do for now as there is
disagreement about a more general fix.

This iteration clarifies the comments in git-rebase--interactive,
updates the commit message to state that this has been tested with Git
for Windows, and replaces the description of the proposed fix with a
description of the actual work-around provided by Junio.


Johannes Schindelin (1):
  Demonstrate rebase fails when the editor saves with CR/LF

Junio C Hamano (1):
  rebase-i: work around Windows CRLF line endings

 git-rebase--interactive.sh    | 12 ++++++++++++
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 24 insertions(+)

Interdiff vs v3:

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index daadf2d..34cfe66 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,8 +77,7 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
-# Work around a Windows port of shell that does not strip
-# the newline at the end of a line correctly.
+# Work around Git for Windows' Bash that strips only LFs but no CRs.
 cr=$(printf "\015")
 
 strategy_args=
@@ -523,8 +522,8 @@ do_next () {
 		mark_action_done
 		;;
 	"$cr")
-		# Windows port of shell not stripping the newline
-		# at the end of an empty line correctly.
+		# Work around Carriage Returns not being stripped (e.g. with
+		# Git for Windows' Bash).
 		mark_action_done
 		;;
 	pick|p)
@@ -906,8 +905,8 @@ check_bad_cmd_and_sha () {
 			# Doesn't expect a SHA-1
 			;;
 		"$cr")
-			# Windows port of shell not stripping the newline
-			# at the end of an empty line correctly.
+			# Work around Carriage Returns not being stripped
+			# (e.g. with Git for Windows' Bash).
 			;;
 		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"

-- 
2.1.4

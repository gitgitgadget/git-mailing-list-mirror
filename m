From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] stash: reject stash name starting with a dash.
Date: Tue, 18 Aug 2009 23:38:43 +0200
Message-ID: <1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 18 23:42:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWRj-0003Go-IL
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZHRVmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbZHRVmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:42:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:63048 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbZHRVmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:42:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7ILdfe7007653
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 23:39:41 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdWP6-0005Lo-SG; Tue, 18 Aug 2009 23:39:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdWP6-0002mM-R0; Tue, 18 Aug 2009 23:39:40 +0200
X-Mailer: git-send-email 1.6.4.rc2.31.g2d7d7
In-Reply-To: <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Aug 2009 23:39:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126467>

This avoids typos like 'git stash save --invalid-option', particularly
nasty since one can omit the 'save' subcommand. The syntax
'git stash save -- "-name starting with dash" still allows such stash name.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Jeff King <peff@peff.net> writes:

>> But I may have missed its drawbacks ;-)
>
> The only I can think of is that bogus input will provoke 'save'. So
> something like:
>
>   git stash --apply
>
> will invoke "git stash save --apply", which doesn't even complain. It
> just tries to make a stash with message --apply. Now of course this
> input is obviously bogus, but probably the right thing to do is
> complain.
>
> OTOH, I think it is the fault of "git stash save --apply" for not doing
> the complaining, so your patch really isn't making it worse. Probably it
> should barf on anything unrecognized starting with a '-', and allow '--'
> to separate the message from the rest of the options (in the rare case
> that you want a message starting with '-').
>
> -Peff

So, here it is!

 Documentation/git-stash.txt |    2 +-
 git-stash.sh                |   10 +++++++++-
 t/t3903-stash.sh            |   10 ++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7e515ce..ded62e0 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save] [--patch] [--[no-]keep-index|-k] [-q|--quiet] [<message>]
+'git stash' [save] [--patch] [--[no-]keep-index|-k] [-q|--quiet] [--] [<message>]
 'git stash' clear
 'git stash' create
 
diff --git a/git-stash.sh b/git-stash.sh
index bb36bc7..642e265 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save] [-k|--keep-index] [-q|--quiet] [<message>]
+   or: $dashless [save] [-k|--keep-index] [-q|--quiet] [--] [<message>]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -145,6 +145,14 @@ save_stash () {
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			echo "error: unknown option for 'stash save': $1"
+			usage
+			;;
 		*)
 			break
 			;;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0e831e0..87e5a14 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -208,4 +208,14 @@ test_expect_success 'stash -k' '
        test bar,bar4 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash --invalid-option' '
+       echo bar5 > file &&
+       echo bar6 > file2 &&
+       git add file2 &&
+       ! git stash --invalid-option &&
+       test bar5,bar6 = $(cat file),$(cat file2) &&
+       git stash -- -message-starting-with-dash &&
+       test bar,bar2 = $(cat file),$(cat file2)
+'
+
 test_done
-- 
1.6.4.rc2.31.g2d7d7

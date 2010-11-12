From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v3] rebase -X: do not clobber strategy
Date: Fri, 12 Nov 2010 20:00:59 +0100
Message-ID: <1289588459-7064-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	srabbelier@gmail.com, trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Sat Nov 13 02:01:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH4Un-000344-9Z
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 02:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719Ab0KMBB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 20:01:28 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62109 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757577Ab0KMBB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 20:01:28 -0500
Received: by vws13 with SMTP id 13so1198464vws.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 17:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ztPWVl5M8aiXSLo1LcMYbZes2qr5zEu+KfsooD8kszY=;
        b=Us9tpEzX3sO41GaW3supfEisyBVjTIxivtHEaX513RDA40WytWBvu0xJB7NXTCeLpu
         wrNU3kG5v0ODeaXdWfpOjuDs7URIoHY3z/LdBpCz/uW8ibLrtL5mpYqmaehWX74YZqIN
         gM1/b4Gw8vtjK1ANC7BkpTpe3M8lu5+QJHt+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ltHpyP0C9jHlU0n7R33ngFKR4HDEZfiPwkDLQpSDebsdV6+AouoQvy41wMPZbGfnsA
         oRHsEMrt3U7A9Xrylg/HQsKHHYWxO6y+fr+hUEqXxCeyXaMnhSAMZxkXkexoZS8hiNfO
         ea0SzmhGdfSKeC8XzJj3yQNpKQlh0A+XHSPvY=
Received: by 10.220.186.2 with SMTP id cq2mr684821vcb.142.1289610086715;
        Fri, 12 Nov 2010 17:01:26 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id o17sm1471001vbi.2.2010.11.12.17.01.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 17:01:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161376>

If any strategy options are passed to -X, the strategy will always be
set to 'recursive'. According to the documentation, it should default to
'recursive' if it is not set, but it should be possible to set it to
other values.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Changes since v2: Now includes a test case provided by Junio.

 git-rebase.sh           |    4 ----
 t/t3402-rebase-merge.sh |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 42c0628..ec08f9c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -312,10 +312,6 @@ do
 		esac
 		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$newopt")"
 		do_merge=t
-		if test -n "$strategy"
-		then
-			strategy=recursive
-		fi
 		;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 2bea656..be8c1d5 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -117,4 +117,25 @@ test_expect_success 'picking rebase' '
 	esac
 '
 
+test_expect_success 'rebase -s funny -Xopt' '
+	test_when_finished "rm -fr test-bin funny.was.run" &&
+	mkdir test-bin &&
+	cat >test-bin/git-merge-funny <<-EOF &&
+	#!$SHELL_PATH
+	case "\$1" in --opt) ;; *) exit 2 ;; esac
+	shift &&
+	>funny.was.run &&
+	exec git merge-recursive "\$@"
+	EOF
+	chmod +x test-bin/git-merge-funny &&
+	git reset --hard &&
+	git checkout -b test-funny master^ &&
+	test_commit funny &&
+	(
+		PATH=./test-bin:$PATH
+		git rebase -s funny -Xopt master
+	) &&
+	test -f funny.was.run
+'
+
 test_done
-- 
1.7.3.2.167.ga361b

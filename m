From: Julien Carsique <julien.carsique@gmail.com>
Subject: [PATCH] git-prompt.sh: show the upstream abbrev name
Date: Thu, 10 Oct 2013 15:32:13 +0200
Message-ID: <1381411933-20600-1-git-send-email-jcarsique@nuxeo.com>
Cc: Julien Carsique <julien.carsique@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R . D'Avila" <erdavila@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 10 15:33:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUGMa-0007B0-DU
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 15:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab3JJNdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 09:33:07 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44515 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab3JJNdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 09:33:06 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so2441059wgh.26
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5kHAR7CVZLrPjFxrKeYWdr76ktQXJvJMJ02KGzTsVb4=;
        b=iBAVtrD0lS1+8CQ5OaQsMog/EAZDE8LJ4L+yMlDbP5NvbfqGt35xQ7zDZ/PdoSJYfJ
         Gj29x9rOaryd4F859/9heKXqA71q5aZ5c8qHl6N3JBHHrg7UFwwGalYjhABB3NFcg67P
         Xk1hotxfMwZgvehDMh5MiqDbIWuteQ2RE3YHaXOedc0zDP0BYdcu7FluW6Pb/tOsRKft
         2MPdxXosI/Np4NR5vpFv8fY2RqoVRxpj5cPuGOq82idKvn/06xNOfmN1xBoC8xVNdUcJ
         eJ0tbRow/9Gy5y7aHV2hkDODk/agNDKbCHmsEtiGXODDDRFqcX5lSqPOE+ylY18+YUe/
         MSAw==
X-Received: by 10.180.73.109 with SMTP id k13mr7672787wiv.35.1381411984697;
        Thu, 10 Oct 2013 06:33:04 -0700 (PDT)
Received: from nocebo.in.nuxeo.com ([176.57.246.10])
        by mx.google.com with ESMTPSA id jf2sm25692551wic.2.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 06:33:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235861>

From: Julien Carsique <julien.carsique@gmail.com>

When working with multiple remotes, it is common to switch the upstream
from a remote to another. Doing so, the prompt may not be the expected
one. Providing an option to display tracking information sounds useful.

Add a "name" option to GIT_PS1_SHOWUPSTREAM which will show the upstream
abbrev name. This option is ignored if "verbose" is false.

Signed-off-by: Julien Carsique <julien.carsique@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index d6c61b2..452f7ee 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -60,6 +60,7 @@
 # of values:
 #
 #     verbose       show number of commits ahead/behind (+/-) upstream
+#     name          if verbose, then also show the upstream abbrev name
 #     legacy        don't use the '--count' option available in recent
 #                   versions of git-rev-list
 #     git           always compare HEAD to @{upstream}
@@ -94,7 +95,7 @@ __git_ps1_show_upstream ()
 {
 	local key value
 	local svn_remote svn_url_pattern count n
-	local upstream=git legacy="" verbose=""
+	local upstream=git legacy="" verbose="" name=""
 
 	svn_remote=()
 	# get some config options from git-config
@@ -122,6 +123,7 @@ __git_ps1_show_upstream ()
 		git|svn) upstream="$option" ;;
 		verbose) verbose=1 ;;
 		legacy)  legacy=1  ;;
+		name)   name=1 ;;
 		esac
 	done
 
@@ -204,6 +206,9 @@ __git_ps1_show_upstream ()
 		*)	    # diverged from upstream
 			p=" u+${count#*	}-${count%	*}" ;;
 		esac
+		if [[ -n "$count" && -n "$name" ]]; then
+			p+=" $(git rev-parse --abbrev-ref "$upstream" 2>/dev/null)"
+		fi
 	fi
 
 }
-- 
1.8.1.2

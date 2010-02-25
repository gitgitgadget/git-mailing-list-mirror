Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 21170 invoked by uid 107); 25 Feb 2010 19:26:46 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 25 Feb 2010 14:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897Ab0BYT0W (ORCPT <rfc822;peff@peff.net>);
	Thu, 25 Feb 2010 14:26:22 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:39658 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633Ab0BYT0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 14:26:21 -0500
Received: by pzk32 with SMTP id 32so893720pzk.4
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 11:26:21 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=uUtj65I46YCbIR4AKcX75dQMCM+d0pfApsjbLcLEQgc=;
        b=tlsvtlrnF55D1iBVKoIlwpL5Z3bsT7EY0zV7XwmAaP3Keo0oN//T1nnVkpXhlF6z+E
         MAWw9MbOUU3sjvGpUDnXnf24XnmEaR+EunBBtCAMqZcbPiPjT+WI1eZsx/PWfcpXLuvB
         nYyCHCX9PUNWN9qRuhS3rn27yoO9dKSogIFCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=g2LoftAVOnCn3ikZy+cfBpLmp4eGdUnDQKYYPGeREG6qQVlG0Zrrhr7BZioSd275PY
         O5blaDu0lG3y0rjq6g+noRqkgNgvSKOKCDeHSBszEzjEGOA+1FOl4c5T1nLwUs9rYClh
         2jRyPDyTr48QTAcBG3tUNNRPwxjIox4bDIWuo=
Received: by 10.142.121.10 with SMTP id t10mr833060wfc.152.1267125981119;
        Thu, 25 Feb 2010 11:26:21 -0800 (PST)
Received: from localhost.localdomain ([70.102.219.22])
        by mx.google.com with ESMTPS id 20sm2370860pzk.7.2010.02.25.11.26.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 11:26:20 -0800 (PST)
From:	Jacob Helwig <jacob.helwig@gmail.com>
To:	git@vger.kernel.org
Cc:	Jacob Helwig <jacob.helwig@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] submodule: Improve handling of relative submodule URLs.
Date:	Thu, 25 Feb 2010 11:28:29 -0800
Message-Id: <1267126109-14638-1-git-send-email-jacob.helwig@gmail.com>
X-Mailer: git-send-email 1.7.0.91.g53050
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Relative URLs only worked with <proto>://<host>/<location> style URLs, and
would break when cloning a repository using <user>@<host>:<location> (scp)
style "URL"s.

When a submodule's URL was set to "../submodule.git", and the repository
using it was cloned from "git@example.com:repo.git", git would try to
clone the submodule from "git@example.com:repo.git/submodule.git", which
would not likely work.

This updates resolve_relative_url to handle the scp style URLs.

Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
---
 git-submodule.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 664f217..97787a3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -37,18 +37,19 @@ resolve_relative_url ()
 	while test -n "$url"
 	do
 		case "$url" in
-		../*)
+		..[/:]*)
 			url="${url#../}"
-			remoteurl="${remoteurl%/*}"
+			remoteurl="$(echo "$remoteurl" | sed -e 's|\(.*[/:]\).*|\1|')"
 			;;
-		./*)
+		.[/:]*)
 			url="${url#./}"
+			remoteurl="$remoteurl/"
 			;;
 		*)
 			break;;
 		esac
 	done
-	echo "$remoteurl/${url%/}"
+	echo "$remoteurl${url#[/:]}"
 }
 
 #
-- 
1.7.0.91.g310a


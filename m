X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: [PATCH] clear error message for clone a gitweb URL
Date: Wed, 08 Nov 2006 15:25:01 +0800
Message-ID: <4551864D.3010301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 07:26:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dpERbOHl3+rmjeTzlfpb2Yra9YFwp8jv0ZBMPu1LXvJmfJRBDWqVbEIoKty3KWso8aYuQYJTJ3wp3dTbvtK+hR16rCedqadSEpvW51h2AWEbZPR4Wl69CnE3caTJe2L2f1VS3M3YKpC3elGKCToIUydTbgf245EzIez5wq3u2RY=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31124>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghhp2-0000bT-QU for gcvg-git@gmane.org; Wed, 08 Nov
 2006 08:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754404AbWKHH0E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 02:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbWKHH0E
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 02:26:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:34021 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1754404AbWKHH0C
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 02:26:02 -0500
Received: by wx-out-0506.google.com with SMTP id s14so1671977wxc for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 23:26:01 -0800 (PST)
Received: by 10.70.9.8 with SMTP id 8mr8868157wxi.1162970761580; Tue, 07 Nov
 2006 23:26:01 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 44sm8699080wri.2006.11.07.23.26.00; Tue, 07 Nov 2006 23:26:01 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

When clone a gitweb URL, git reports "Can't lock ref", it's not clear for users,
this patch adds clear error message for this case.

diff --git a/fetch.c b/fetch.c
index c426c04..40c5183 100644
--- a/fetch.c
+++ b/fetch.c
@@ -266,6 +266,14 @@ int pull(int targets, char **target, con
 		if (!write_ref || !write_ref[i])
 			continue;
 
+		if (*write_ref[i] == '\0') {
+			if (strncmp(write_ref_log_details, "http", 4) == 0)
+				error("Can't feed empty ref, seems you are fetching from a gitweb URL, "
+				      "check it in web browser for git URL.");
+			else
+				error("Can't feed empty ref");
+			goto unlock_and_fail;
+		}
 		lock[i] = lock_ref_sha1(write_ref[i], NULL);
 		if (!lock[i]) {
 			error("Can't lock ref %s", write_ref[i]);
diff --git a/git-clone.sh b/git-clone.sh
index 3f006d1..c8274e0 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -55,6 +55,10 @@ Perhaps git-update-server-info needs to
 		else
 			tname=$name
 		fi
+		if [ -z "$tname" -o -z "$name" ]; then
+			die "Cannot feed empty ref or commit-id, seems you are fetching
+from a gitweb URL, check it in web browser for git URL."
+		fi
 		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
 	done <"$clone_tmp/refs"

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 17/28] rebase: cherry-pick: fix command invocations
Date: Fri, 30 Aug 2013 00:56:11 -0500
Message-ID: <1377842182-18724-18-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmK-0007TR-8I
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab3H3GBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:45 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:38540 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab3H3GBo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:44 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so1798726oah.11
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aweronKl1uFlpLflzk10nbXeE9bfDAooXTH7tW/x3qQ=;
        b=WkiupRi1VulhopDFTMOA1exMlunQe37GT/TK1X7shuoifgdRsjbDuFTG03N/t2sPOA
         HKodyNhvoXse9aB+YGWI1xgunGZyqJQOo+Za4Uj6TFnpLzrK0/CuDZr6+f6n7sH2YktD
         mL0hKq5VPVBmB7UKWFsSLk+pUx+9LvTsSc6XtzyDHDE4fRgGq7kWwjwiod/ahSXLfq5d
         lhhyiAH4iAHpJ4LGf49cahngMr5cO2qah3iqcubzAr1/qKkip7gzZ8pHfbf/mjB7qttl
         IAsst2/wqVCFSi31qpRs7YrFfP0yotTFWGcW9QndoO6guFZFtpxZl1AwNjm7gLpp0Xlf
         +Miw==
X-Received: by 10.182.98.162 with SMTP id ej2mr5450698obb.61.1377842503722;
        Thu, 29 Aug 2013 23:01:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm36954158oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233411>

So that all the tests pass.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index d8d32fe..e9ecccc 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -21,7 +21,22 @@ test -n "$rebase_root" && root_flag=--root
 mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
 : > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
 
-git cherry-pick --allow-empty "$revisions"
+if test -n "$rebase_root"
+then
+	revisions="$onto...$orig_head"
+else
+	revisions="$upstream...$orig_head"
+fi
+
+if test -n "$keep_empty"
+then
+	extra="--allow-empty"
+else
+	extra="--skip-empty --cherry-pick"
+fi
+test -n "$GIT_QUIET" && extra="$extra -q"
+test -z "$force_rebase" && extra="$extra --ff"
+git cherry-pick --no-merges --right-only --topo-order --do-walk $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.4-fc

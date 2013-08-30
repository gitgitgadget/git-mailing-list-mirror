From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 14/28] rebase: cherry-pick: fix mode storage
Date: Fri, 30 Aug 2013 00:56:08 -0500
Message-ID: <1377842182-18724-15-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmI-0007TR-In
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab3H3GBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:38 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:43371 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab3H3GBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:36 -0400
Received: by mail-oa0-f54.google.com with SMTP id n10so1410543oag.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ejLuE4N3kEFw2/EbU1rXO3CYxiVdiekJrK/2jG2fQgc=;
        b=wwi5AuYY+RifKtujfRXZc8aEeFd+a/n0OdbJl7ksLMi1GgycNdFK6ua83NdwfH5wZu
         DzrBNbJg7m9J/TPH43KkXfyNJQPQ01vob28L7To0kZIABxJEX5e+SWJIE05wJXEWy0ho
         3FKrUYvI9Aupoe5uSA56qT4I3juovVg6AC48KN2GL3RiDtVXJw5r+WnmxDbzg4CNW0Eh
         Gac271GfQ9k1WBnYxFuGBid7wGm71Xa3w7+zPudY380Vvld0Ms4KgSE7MsafStCh8kaV
         9joJJHZ+hXuVzGJEJxDsxanvOYCxwg3fJpCX2gN0ODyP/WomaCYdnNwkdqrkOc9ybWix
         uVpg==
X-Received: by 10.182.104.36 with SMTP id gb4mr5671659obb.43.1377842496061;
        Thu, 29 Aug 2013 23:01:36 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qi5sm35715369obb.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233408>

We don't use the 'rebase-apply'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 5 ++++-
 git-rebase.sh             | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 2c16995..e142cfb 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -18,12 +18,15 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
+mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
+: > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
+
 git cherry-pick --allow-empty "$revisions"
 ret=$?
 
 if test 0 != $ret
 then
-	test -d "$state_dir" && write_basic_state
+	write_basic_state
 	return $ret
 fi
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 2310638..b28addc 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -204,6 +204,9 @@ then
 	then
 		type=interactive
 		interactive_rebase=explicit
+	elif test -f "$merge_dir"/cherrypick
+	then
+		type=cherrypick
 	else
 		type=merge
 	fi
@@ -415,7 +418,7 @@ then
 elif test -n "$keep_empty"
 then
 	type=cherrypick
-	state_dir="$apply_dir"
+	state_dir="$merge_dir"
 else
 	type=am
 	state_dir="$apply_dir"
-- 
1.8.4-fc

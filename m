From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 06/28] Fix and simplify the do_get_patch function.
Date: Fri, 21 Mar 2014 08:31:44 +0100
Message-ID: <1395387126-13681-7-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxL-0002BU-Qk
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606AbaCUHd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:26 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:49543 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbaCUHdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:09 -0400
Received: by mail-la0-f52.google.com with SMTP id ec20so1401496lab.11
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sv+of5UuKrda9UTMa4tJzx7rcHkP334Nb8Rgs9Szc5s=;
        b=hCT6slHAphqAsI3dWLLgx09li2Yghnp3YAd1TZMfG9LnmGTMpcaFnoUJt10OaysXQ4
         Mb9/0KEVOgifVIJtBuaPdQUDb5ytjpFCNLs/mysPFD32kgt9o5a/LgGTPdYLQJ/g/V5G
         gnDAs3r02HuR9/Kr/IGPzXdWNLmar8Qy1wGcelkC37INuPcfsBE7XgavqoLPMtAsf03t
         hLdQdzYEmzkqWAa7r8WvDerbW14eCbSLezghGmXpz3orkPQj+HUpFXZFrTpHzKv31kOG
         5jUoRbj57gFmpcuRaaJk9GyzH9og7bsGN4cS93/w27CK4yWBp7AyzxSXqUkPt5cGf72x
         wFmg==
X-Gm-Message-State: ALoCoQmkdzyNl7q7qXkUAgeKMU9dfXA80Z3lqVgw3eVn96DET+ZEFmhjDDU8hfDZBh7ZyYwEnRsW
X-Received: by 10.112.171.67 with SMTP id as3mr31092623lbc.10.1395387188100;
        Fri, 21 Mar 2014 00:33:08 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244649>

When extracting the patch, we only want the actual patches.  We don't
want the "---" delimiter.  Simplify the extraction by simply deleting
everything before the first "diff " line.  (Use sed instead of awk to
simplify the code.)

Without this patch, "guilt fold" and "guilt push" sometimes fails if
guilt.diffstat is true.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/guilt b/guilt
index 8701481..c59cd0f 100755
--- a/guilt
+++ b/guilt
@@ -332,12 +332,7 @@ do_make_header()
 # usage: do_get_patch patchfile
 do_get_patch()
 {
-	awk '
-BEGIN{}
-/^(diff |---$|--- )/ {patch = 1}
-patch == 1 {print $0}
-END{}
-' < "$1"
+	sed -n '/^diff /,$p' < "$1"
 }
 
 # usage: do_get_header patchfile
-- 
1.8.3.1

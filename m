From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/6] line-log.c: fix a memleak
Date: Mon, 30 Mar 2015 18:22:08 -0700
Message-ID: <1427764931-27745-4-git-send-email-sbeller@google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	tr@thomasrast.ch
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:22:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yckst-0008IG-2s
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbbCaBWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:22:22 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37495 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbbCaBWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:22:18 -0400
Received: by igcxg11 with SMTP id xg11so5055224igc.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 18:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=NkptB9BTsr4NHxOpljJTe1SLRfJ6P0o0CJ+9+mpoJ6X3LcmE4ODc1yOA8M0TrQJisR
         m5lbz688iPTRqAwbZwnNfyMVqGKgXM+V0xYCEFRmu57Ntaxzmzs4ZyvEf8ADR14rTa7I
         1siN2Qlw8cBdulNjI9mPNzZDdVdp5dDpmtWcXTtW1wHu9NXdQnk3fu5238FUjEHEHRpD
         u3rZlSL+bgW2fKx6noX1c8X26abhzmO4S3Y+dWxqc2tXFHrkcFHTI07+aEQz0eNg0Tua
         flbztVjlwU+4XHVKj5F6qlO1T/phBHGEtroJMU0wLDn/VniifQi4g2b3///ekVyAryax
         QCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=OFQGN6h2ZpC+7L/5uAcSTjAire/iPBTJ94nY1XWqzpJi3X4MTb95DsUY+DRJ1wAhUn
         AN/ZS/dP1KKDyKWPaesDyPJZIFeKmzavJ4ZTSum5eLfUAfvZJKKOIL5pCSuT3Om/Xjx4
         9aj9fLl6jZHREzicHdOdOY2NHFehLw3XTKXhe+S8NsUEx804x90U65zk9vxotRWz7FKA
         Gv+mzF9IE4trykvD7MTVJCBFAiKhhqc0lYczVjrVAEI1pmUSSHeSU1gHxkUD//pvr7nj
         Yd9l78j2lgTaIjrE2fCJGI3dlBtylzMB4FWIhdoQCBeDfGz1clQ1aY/ujyGovBCPhjKe
         9xTA==
X-Gm-Message-State: ALoCoQl7tPY1O47KXgnjQqDxTVVtA4X4cbB+0uGaSds8QuzFk2GdtPSH11a7Wr7ge/Rl8/kXimCe
X-Received: by 10.50.79.229 with SMTP id m5mr697770igx.23.1427764937269;
        Mon, 30 Mar 2015 18:22:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3c88:d48a:4382:4b5])
        by mx.google.com with ESMTPSA id k82sm8661687ioi.5.2015.03.30.18.22.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:22:16 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427764931-27745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266499>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 line-log.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/line-log.c b/line-log.c
index b43ac58..db6e58d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1129,6 +1129,9 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
+	else
+		free_line_log_data(parent_range);
+
 	return changed;
 }
 
-- 
2.3.0.81.gc37f363

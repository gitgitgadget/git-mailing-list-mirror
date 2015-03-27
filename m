From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] line-log.c: fix a memleak
Date: Fri, 27 Mar 2015 15:09:05 -0700
Message-ID: <1427494150-8085-6-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSl-0005Ur-1i
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbbC0WKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:42 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33470 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbbC0WKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:13 -0400
Received: by iecvj10 with SMTP id vj10so81260350iec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=GudOEhHEBn9nQcxcP738ECcz/NXi4nrWNFgZcPALpvhqQiGXMMRBGa7ZxcF7pnns5O
         yrCGEgB4I48/+ZwP1zVSl97wlUs7hr7AFZWYYpMKRLHDlTIsEQnBJMZBMVCwuNsPdPsg
         zs8na4lv5ZOZ6MXtg2VcEcuaaGYQfN9Jqu211e4tbzues/yULYzJlklcKWaeRvZ+EBEL
         uIfERlmTGhWpUPtU03dDAaIGU80lX2/dtVInTXYP6JwnN9xcExLiRy8Y+kvt6uvGKnRJ
         YzSV+IeXlKAqqea/uUaOWjo+Ew22WNedMY4x2hHfdo/C+t1cd8hqtAxF+08mow5PXF8O
         PoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=ZK7qnWuARrQVQAs9+ezXWjZISKBU2r26+QZNwKarCfTsCjktguO1S7ume97J++vISa
         M2fpertLYK2xiPOuXtz0u6nIRRrPCe6/4aj62hy7/RSMEYCPntFdBSs1OnH53hhzb1Ds
         ezZ+UM2HPribK45Ws3CbDoClyMI3kB8MxrGFH5TCQv7dKlWxCYJanll/e2Hs4v92SDfd
         UzBj6keo161DtKurd+LPhjApevfZiI9P4a2Q5afWuDYek8BZ0U4WnuxlmSUjGL8lpiwB
         Jbqt+iJyVcoPxFOmNIGvO5Dtl/sOJmEzuDaBtG6gt1F+X/GX+V/5kIt3ok1OgueQhR/9
         LCNw==
X-Gm-Message-State: ALoCoQkHXx3Fyw9Y7zR8/WNnyde+klJdYO5Pz0G70fvB8UUwRtmi/O5x5gf/FSEN8Rry78DFwanE
X-Received: by 10.42.171.8 with SMTP id h8mr12175771icz.25.1427494213012;
        Fri, 27 Mar 2015 15:10:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id 137sm2131930ioe.40.2015.03.27.15.10.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:12 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266390>

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

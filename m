From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] line-log.c: fix a memleak
Date: Fri, 27 Mar 2015 15:09:06 -0700
Message-ID: <1427494150-8085-7-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSd-0005M6-L6
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbbC0WKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:35 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33578 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbbC0WKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:14 -0400
Received: by ignm3 with SMTP id m3so39605374ign.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=mQ4w5PTTDjkosOuSEoNongzQXG4zoJNyHcJx3Slt6ew1tZIkZAmtsEw4SEqeipb71f
         uKZrTv0lpjJ6/+fq5FpdYkvur2JqyEqWLBZoTOgZxlZA+HsgXK4RFwo6dlaG0oObP9FS
         tykOjxZTA2Bze7EVjO6j7o8N2hUwOhT70FW4a/ZZFhSwtOZWEEa/BRfKcN0PH2W6V9ad
         RKlYty3cCygwznYin4SpOHVW0uI3gO26OmAcHx9NdxeEivjNizUpsNE1fdA1fCj/ZCX0
         yX+QUvKGJoUQX1fzOe599PMVVPkPHLgih0FMYCSwrIyzNpT1H+gzaX0S7HlwEpKWvc2j
         mmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=BldLPk/l9IVoJKGxYj9815Ez5xr+mdP7TKremnR5X//6hyyTQCAt1FYyGyduIKX1JZ
         L/t4fRoVn2Pg8DwcemaNNKFIp8U6n9yaZtvFhDTj3Ae2OJuLaJDSir5fx97N3v2oJJqq
         0exoWkHhY4KU1F11oQzhb/UDJjtb+mlgTMe7cv0hdpakNb6wbDHL6fQVRrf8mywOXniJ
         Z7ApdDExHx5AW+qN3OT1bmpYnfNyTFgx1gsTIVfSAsyeK9Q5It23x1W+W3UYb8zcdpAV
         qip71upuhBELFwQQKcuNbIwcDn2cJL0CrN/7BejPW5iEOayRTrpYIIBmjoXLkppVgA3u
         hNwA==
X-Gm-Message-State: ALoCoQk95J//l2osjjyTOI4zQvN2yBWkeYBrEgXGlHzkgmOApe0E8AF8s2hdto4gitQKQcx1sPlw
X-Received: by 10.50.36.103 with SMTP id p7mr1551730igj.20.1427494214043;
        Fri, 27 Mar 2015 15:10:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id x10sm2211002igl.13.2015.03.27.15.10.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:13 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266389>

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

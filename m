From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] line-log.c: fix a memleak
Date: Fri, 27 Mar 2015 15:09:03 -0700
Message-ID: <1427494150-8085-4-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSN-00057y-7a
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbbC0WKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:18 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37230 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbbC0WKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:11 -0400
Received: by igcxg11 with SMTP id xg11so32165106igc.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I80pIwJdZ2HgbPlXHsUfoYYQb+vgBtcdIRIeBVJ2PLs=;
        b=HBhV8CMrFxTbTnp8EUN9J6iAe4gSnXMVRC2xav7qOzpccVrAPpr9TSdJvjz7/PLm6L
         3AjVNDa1nRq5qwZG2kkDQigHRn0uB+RLdUhf3aG55ETSdErZkfx7dS1XGIULYLpA4u4Z
         dZrERBGGji6SNUsqEMI3w5vBMpcBODTj+ATnJqvFF/vNwgjaAZcqNeIYqY9bGFJFNt8h
         ED8sIik7lxEXzZM7gruLEiQ2wUW9i3D+DBKpm2V7TaZkwl58Dh0KbT8Y9tV89zUWMnNA
         FchczKGwc6c0P3CF2L2FyykO4w6ligthSRQzh5xWzXuuT7nC8rNqIRkDWSbbJdUvDLj0
         oRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I80pIwJdZ2HgbPlXHsUfoYYQb+vgBtcdIRIeBVJ2PLs=;
        b=VrgarxG6jo0DF83n03BeFxteTwA0dhsiPkNnIbiwfFYaddjl59mNe3PuuH3aVhCyf5
         yJQCnABRpGPQXnxgtBDyf/jSMN1eeHRhyeRNi80NN3+fYgn9cnq9e/2zJp6dI5AKYur3
         sb3azDFeN/mw+QnoCi/1GZifj1xt9iGK6Bm7301SaOUhZloON0OJd7gHuy5kdNChjSsZ
         4f19KbubIk86QusjAKrCaQLGSrBUqK13dJk42352RLDNYgsYHtRvXYK3Ha16s2OSVyjR
         bU4K1UtvRfPhzN0Z1Wog96g0NpxRvT4Uwzentip6OUhbLIC9gWvm41P0g267wsq3JHDd
         uvoA==
X-Gm-Message-State: ALoCoQloj98lGwoJT8ceidfJb30ruelyQo0Uyy9jptAwxbGgH/6LX91gB6p3IvNSpwqqyzZFX/fZ
X-Received: by 10.43.14.199 with SMTP id pr7mr47440851icb.3.1427494210449;
        Fri, 27 Mar 2015 15:10:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id 94sm2149098iod.23.2015.03.27.15.10.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:10 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266382>

The `filepair` is assigned new memory with any iteration via
process_diff_filepair, so free it before the current iteration ends.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 line-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/line-log.c b/line-log.c
index a490efe..b43ac58 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1099,6 +1099,7 @@ static int process_all_files(struct line_log_data **range_out,
 			rg->pair = diff_filepair_dup(queue->queue[i]);
 			memcpy(&rg->diff, pairdiff, sizeof(struct diff_ranges));
 		}
+		free(pairdiff);
 	}
 
 	return changed;
-- 
2.3.0.81.gc37f363

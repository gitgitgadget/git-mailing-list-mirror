From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/15] merge-recursive: fix memleaks
Date: Fri, 20 Mar 2015 17:28:04 -0700
Message-ID: <1426897692-18322-8-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7Hd-00021W-Ml
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbbCUA2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:54 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33890 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbCUA20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:26 -0400
Received: by igcau2 with SMTP id au2so1270423igc.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9dlnJoPa8vj8m0BBPtk/yB6mbB71fHXkwYXBUSzK184=;
        b=LWWH1NuI58+QsNFi3bTsGFopCw9L9c+pHDnnhUeY42MCBWKZ3UEBY5faR121VaV9RG
         2IpqOEokzUvxWsBzYWnJ6GZspgvNRqYRwSL5Szn/L+dFHod+oRI71k85/jB6+zJMFLIb
         IkqhCeArWj/W/NkKcNuwwVDLmJiYlV/IGkspxzW5q60kZ5G2go2myYp7vANy7QZXTsyp
         85A6PDoseE5KSGrYTrFcaGrKKLmiN+5PItePP8Lc8klrAgAFGUiqBEOHHsoWybAYa4pd
         6UtSpOZ4YcNOIArYnCDAy384HsQLC9WP9uAYzzS8GLgdznGvfHuDzq3+PZcTPNBiDNRv
         CAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9dlnJoPa8vj8m0BBPtk/yB6mbB71fHXkwYXBUSzK184=;
        b=iBfc6cAEqTohRB55x5hDYjQbtWz1S7s+3TDmaPRWjXCmeuH61I0rAzPeAicUPyhcqy
         b3x0nDfNZLoFbeRZoYZ6WMfmWbUuVbSW2T+CvKB/RyaaLwHTn33vUcG5MDPpEyNeO7ri
         f2VEtyFemXGMIA621hUP/MvRtrYu3ZuQfZ9Ff0s86HkLH3qFyojLdWf5qyR9xyCWZe3+
         /tdNSizwj6fh+XesAfufgdTtqQBPbKWygKT7p9AFgG8lQg8aWBQ26fmYk2gxW/M+Jk3s
         5rEvU7b1qscQjWgErFtKlHxEnBdPGzDKyPMharnrBvNlT/71zONb4tlTbF+LjvML1yfJ
         v8wA==
X-Gm-Message-State: ALoCoQkdJvpMOpPJRZk/t+HDd1U8b2JVAa9XGdpIcmXpMViZCDp2tllXMN4Jon6UQzvRoN5/f093
X-Received: by 10.50.29.109 with SMTP id j13mr522472igh.2.1426897705235;
        Fri, 20 Mar 2015 17:28:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id qs3sm186555igb.8.2015.03.20.17.28.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:24 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265990>

Usually when using string lists it looks like:
    struct string_list a = STRING_LIST_INIT_NODUP;
    // do stuff with a such as
    string_list_insert(&a, "test string");
    print_string_list(&a, "test prefix");
    // Cleaning up works on everything inside the struct, not on the
    // struct itself:
    string_list_clear(&a);

But as we deal with the pointers to the string lists directly, we also
need to free the actual struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 merge-recursive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 771f5e2..1c9c30d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1858,6 +1858,9 @@ int merge_trees(struct merge_options *o,
 		string_list_clear(re_head, 0);
 		string_list_clear(entries, 1);
 
+		free(re_merge);
+		free(re_head);
+		free(entries);
 	}
 	else
 		clean = 1;
-- 
2.3.0.81.gc37f363

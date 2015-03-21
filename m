From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/15] update-index: fix a memleak
Date: Fri, 20 Mar 2015 17:28:01 -0700
Message-ID: <1426897692-18322-5-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7Hd-00021W-2k
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbbCUA2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:25 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33871 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbCUA2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:22 -0400
Received: by igcau2 with SMTP id au2so1269968igc.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f+/pYCIdW6p7qPbUxkcWpOTS1ZYTJtCIUdTqXIvSo2A=;
        b=FFBCUW1MWFWnNPyygtqXvrHtlm4mFQKVKeEuBZvQvaM0KDkKJg7FpzoMepXXRtuBIE
         fIsCO+rru1jsNuiWQyppXSD+OP08apbpHHUMRHNXfhy98a3OyCn04g3OvTYk2CaRvKpI
         Vsm7OoNMColF/IW0wq9DicL6olNSXJFh+3/cQs/5ICJWG3/XnFXhveFPRNcLllv+LXuc
         iHuC7n5DilsDqi8Rn189FgQBG5XGLPYn1PzkjSzAZ5ZGoY4stBJSpn1or5DJZ89Ty8/C
         on2OKOt+3qQVuIIBG/9B8/Rtu5QEC1qT4BSTCCI8CkbTv+JbPIWGp43LVzw6FfqTNvbs
         zk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f+/pYCIdW6p7qPbUxkcWpOTS1ZYTJtCIUdTqXIvSo2A=;
        b=CGqFBCsZeP0jB/JSmJp2jn/R8JEMG6UwsRfu+1RdqZd3D9DeZlj242ywZzH0g2zeW5
         uMJ12qMYbedmOQTextbGPHj+hicK9DcSFJahTsJ6oXBJVptf99gpwa4+sDpATDqPp/op
         +QSBDRJRQMaqpLAsaGrGOgRDkC5Yos/QXSgGUiImGifYkzC+bKWdDulgL1AyaQeCFPN8
         XpFPVNv0kx2haZwf6v3k9bfCPKR7luKXtiNUtFbM6WZV0LVjK+C/8lnGZVlWvyE9v6FU
         gZa0cd9gKiDXlxxSULo+ax73feVIFtTu2iDfMFZoDgwrhIIOIHBsyZtGKOgY7pfQ4ymR
         HYhw==
X-Gm-Message-State: ALoCoQkZ0w0Hdd2yuyYk9hYnK7U57l+vklPuoW/Wl/Mm26QXLy/knY7ljc4szCNznhNA5SzKJI65
X-Received: by 10.50.79.193 with SMTP id l1mr458977igx.27.1426897702029;
        Fri, 20 Mar 2015 17:28:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id m5sm190154ige.5.2015.03.20.17.28.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:21 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265995>

`old` is not used outside the loop and would get lost
once we reach the goto.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/update-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5878986..6271b54 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -584,6 +584,7 @@ static int do_reupdate(int ac, const char **av,
 		path = xstrdup(ce->name);
 		update_one(path);
 		free(path);
+		free(old);
 		if (save_nr != active_nr)
 			goto redo;
 	}
-- 
2.3.0.81.gc37f363

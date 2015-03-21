From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/15] merge-blobs.c: Fix a memleak
Date: Fri, 20 Mar 2015 17:28:03 -0700
Message-ID: <1426897692-18322-7-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7Ho-0002Dq-42
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbbCUA26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:58 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33543 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbCUA2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:24 -0400
Received: by iecvj10 with SMTP id vj10so1847882iec.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lG98KgbSQqBcSar4Wd2bcnNMkAaWY+yD/0pW0xidRTo=;
        b=HgXonqPVXMBu1uNTlIKRs2FsO0otR6vIaYhHtSfiphyQ0g9U41yuuUYUukO2mfpCc8
         GKRVZRRY93c7tksmYnxA2eHnELEMHOcTHARq36LgFfugNoZC6Q1YuZzkLksT3m4XNK5+
         bNzwj8quam3/KSwWJ9S2WpLuN32BgrgwcnW1wl0TlUtfLF1qd8eDi8lRegr2GG9bufIq
         pbEoYFp+WizNkuUHP/Y3njPh44rOBDSfsqtF0ShOKaI7CQzOgUzlVaPgN4DAiN778xH2
         s9H0AcS+xKTO72M36FGluJN16qRrpU0PQVHVR4L3qC8Ah+EIvtLJWeC8GFoDQrCQGUPW
         9F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lG98KgbSQqBcSar4Wd2bcnNMkAaWY+yD/0pW0xidRTo=;
        b=WkGENwtjzWc/poflVbgq+PK+b6xx3APOWUApibrBr5rFThI0dLeBNpT9hR/s5MwCH1
         i0u5OddxJdPLLYzugBFwLkZFs8/C/xW9pojgg3dvrI0DCRruHGWzOqe2/Q22hJvoUp6h
         6VlsFW/0KNcpnF7pIIJZxo0c5jbx5bxJQu0IVR43Pbhv7crvkTKGfZ/kFeNIOUdhOLrf
         /rRBG/56UskO7AeFsUXP59E8hftqUxmlW64ggsbjeMJrf1ZfqaE1v/VEML/0SemNHMen
         zBob1iYvkYYLSa/hrZ77YMopFaK87ghvxWIEEvvDCKAnGPiyMeU8XA7KFoM0TLBDlPfW
         tkGQ==
X-Gm-Message-State: ALoCoQmhIlIWCMV3YUxqqXgMpQreeZtBsSIvkojAF9xgAclJEtQ9MjlYS8TBecjGKnKgQe9chFau
X-Received: by 10.42.188.83 with SMTP id cz19mr7022330icb.69.1426897704168;
        Fri, 20 Mar 2015 17:28:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id c8sm186328igx.9.2015.03.20.17.28.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:23 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265996>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 merge-blobs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-blobs.c b/merge-blobs.c
index 57211bc..7abb894 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -14,8 +14,10 @@ static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 	buf = read_sha1_file(obj->object.sha1, &type, &size);
 	if (!buf)
 		return -1;
-	if (type != OBJ_BLOB)
+	if (type != OBJ_BLOB) {
+		free(buf);
 		return -1;
+	}
 	f->ptr = buf;
 	f->size = size;
 	return 0;
-- 
2.3.0.81.gc37f363

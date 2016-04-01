From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/4] bundle: don't leak an fd in case of early return
Date: Thu, 31 Mar 2016 17:35:45 -0700
Message-ID: <1459470946-16522-4-git-send-email-sbeller@google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:36:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aln4E-0007ms-D9
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbcDAAf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:35:56 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32888 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757394AbcDAAfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:35:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id 4so81172517pfd.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RC6BIXkSyWzxaHjIYN4KkGtfX0+7X3aJCEHwUbUW/0g=;
        b=SsXN0/dINUSlgp+ZqvoXcJ1YD51Myo9NsfU+vF6V7pz3xUAH/pPBcsj7lVqL7HY4Hd
         zBmHyOs95LQSnm/n1RFnnz/Cy8ATsGCDUP449m9LBCuFi8hBAEKCGnEEGlnDNsPV/iYf
         zI7PDihdroCCj3LHO0NQ4lACyjT58hRkbu7Zt/CC9EUIwS/o8pN3dvmdGznnGF3AP7mB
         Dshpru5nskOj8hrd3lD1EHkRq9CLNOZHa9wwxNc098W41OR+VLnoIOTsVluWbAgonWsx
         L7o5UaLc8bS6IgPgksV7ILiFNOSToIwDK4GF0oO+bgb6hoXHgCPeRhkgGbG/sfpggqxN
         dMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RC6BIXkSyWzxaHjIYN4KkGtfX0+7X3aJCEHwUbUW/0g=;
        b=KmU4tOY6dzYahlbmQDbO1jgOVo7Njz+Ln1RpaLdNSvKGgPNv5Cw8NM/5OINj4uOInR
         fAdL9uBpDjsNDDaYNEqTNEaGb8HESF4Sg4P1xZMyotbW1REGzDrksaC8nuZRi78HWy0t
         jC89gdWv5kUsaXQ8g4ynUgkF/mSY3/rvbg+j/OYY9Dtvmyvd2RYVZJ0LApyfV4H8zYgy
         szxIKiwcHtOKReOx8S2STnDZ/SPhuL8DAJOlD5QCAk7tqvkglsy0O+2Ru5iMsIgvHmb9
         qQz/jCtSk9KeQrp05RIJH+98hqY5imysL2jM3Ws99VEwMHHq1SFAmVKeVy5HMyoNj8Pl
         wzHw==
X-Gm-Message-State: AD7BkJJn7Sq3usMj6X7ADjptrj5ldCj641KK4cEThnnvZTsqz2O5U/khCboAIZqSj38V0T28
X-Received: by 10.98.86.157 with SMTP id h29mr26187756pfj.105.1459470952349;
        Thu, 31 Mar 2016 17:35:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id 17sm15950176pfp.96.2016.03.31.17.35.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:35:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1459470946-16522-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290498>

In successful operation `write_pack_data` will close the `bundle_fd`,
but when we exit early, we need to take care of the file descriptor
as well as the lock file ourselves. The lock file may be deleted at the
end of running the program, but we are in library code, so we should
not rely on that.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bundle.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index 506ac49..08e32ca 100644
--- a/bundle.c
+++ b/bundle.c
@@ -435,12 +435,14 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
-		return -1;
+		goto err;
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
-	if (argc > 1)
-		return error(_("unrecognized argument: %s"), argv[1]);
+	if (argc > 1) {
+		error(_("unrecognized argument: %s"), argv[1]);
+		goto err;
+	}
 
 	object_array_remove_duplicates(&revs.pending);
 
@@ -448,17 +450,23 @@ int create_bundle(struct bundle_header *header, const char *path,
 	if (!ref_count)
 		die(_("Refusing to create empty bundle."));
 	else if (ref_count < 0)
-		return -1;
+		goto err;
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &revs))
-		return -1;
+		goto err;
 
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
 			die_errno(_("cannot create '%s'"), path);
 	}
 	return 0;
+err:
+	if (!bundle_to_stdout) {
+		close(bundle_fd);
+		rollback_lock_file(&lock);
+	}
+	return -1;
 }
 
 int unbundle(struct bundle_header *header, int bundle_fd, int flags)
-- 
2.5.0.264.gc776916.dirty

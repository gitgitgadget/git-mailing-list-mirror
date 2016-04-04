From: santiago@nyu.edu
Subject: [PATCH v4 1/6] builtin/verify-tag.c: Ignore SIGPIPE on gpg-interface
Date: Mon,  4 Apr 2016 18:22:10 -0400
Message-ID: <1459808535-8895-2-git-send-email-santiago@nyu.edu>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:22:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCtU-0007kR-53
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbcDDWWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:22:43 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33004 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbcDDWW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:22:26 -0400
Received: by mail-qg0-f45.google.com with SMTP id j35so165058429qge.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9mgKl1WGqOXAtzgz8IpYS3JN0hfc4lrKnfFCSuRYI+Q=;
        b=IMFUJOE3+WMMil9SdsSfZ+hlvUE4/nWT2UsHt0KA+hwLNEmPbOWpMGbQYobE2Lf5uK
         2sy/a1Ln78Fy2RwyH58XKuv8HGS0TpZl0ZBIjPJNU9v1h527XHttGOZsOHe3MRqraQ5Q
         Tw1U6oRwymbX5586VgLYgzLFj9Vx4JAAULxbUT9mN0zpqn+Z/hcaXE2n49Ftk1jHBl9r
         tRWVrXvUHImc/tztAlJ/3AFZFRkid1XaVwAbba7p3ny6of75v4oEbrYreQ9lusfaLe66
         TuyijBXL05RepBCs2PFA3KPRs7o0jbe9sadEZQePT2ngKVF7CnD8GyEyKuyM+DGCUhAS
         PCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9mgKl1WGqOXAtzgz8IpYS3JN0hfc4lrKnfFCSuRYI+Q=;
        b=I2f0SZIGqNRkctbsD2YL0yFPhbfQI6U8jbNrb4e9K/9o97CkRisiqNCH7ynDWEVYxD
         V5L3xWXX5HT3E+cjUfEMJRWj+9jsXSAuGwOkT6uSRJkNE/0o2fwRCM/wKm5cUDJcdtJi
         e3vKiL/yObfygV9E4i4GtkV3+Ei4wtpJqtaKMaSKdOOdLv8mtLAqPwX2zI44037rNmLk
         ebhrDsVcKfygPUJxgbdoFUQSS5QgptE0FrB4wt5Ah77dZ/yufPQxXU7trKHSRDezZgnz
         y05+sHgtd6AFs/WrTF9N1Xd1rVTv++XGvn+d3aWjH2mECIJgM+eTMzfgr9kppLHDOk/U
         JYLw==
X-Gm-Message-State: AD7BkJJUavKPP5MKoiyhLAhIxm5MDt3tz6E5Nd3oL6liSVjt5YUjbJPQU2L0f7y3ztK37xCZ
X-Received: by 10.140.132.68 with SMTP id 65mr26406764qhe.13.1459808545079;
        Mon, 04 Apr 2016 15:22:25 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id h9sm13180670qhh.29.2016.04.04.15.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 15:22:24 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290733>

From: Santiago Torres <santiago@nyu.edu>

The verify_signed_buffer comand might cause a SIGPIPE signal when the
gpg child process terminates early (due to a bad keyid, for example) and
git tries to write to it afterwards. Previously, ignoring SIGPIPE was
done on the builtin/verify-tag.c command to avoid this issue. However,
any other caller who wanted to use the verify_signed_buffer command
would have to include this signal call.

Instead, we use sigchain_push(SIGPIPE, SIG_IGN) on the
verify_signed_buffer call (pretty much like in sign_buffer()) so
that any caller is not required to perform this task. This will avoid
possible mistakes by further developers using verify_signed_buffer.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
	Note: On this version i moved the sigchain_push below the return error
in the same way that sign_buffer does(). Thanks to Johanes Sixt for catching
this. 

 builtin/verify-tag.c | 3 ---
 gpg-interface.c      | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 00663f6..77f070a 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -95,9 +95,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	/* sometimes the program was terminated because this signal
-	 * was received in the process of writing the gpg input: */
-	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
 		if (verify_tag(argv[i++], flags))
 			had_error = 1;
diff --git a/gpg-interface.c b/gpg-interface.c
index 3dc2fe3..2259938 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -237,6 +237,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		return error(_("could not run gpg."));
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(gpg.in, payload, payload_size);
 	close(gpg.in);
 
@@ -250,6 +251,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	close(gpg.out);
 
 	ret = finish_command(&gpg);
+	sigchain_pop(SIGPIPE);
 
 	unlink_or_warn(path);
 
-- 
2.8.0

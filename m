From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 17/44] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date: Fri, 10 Jun 2016 22:10:51 +0200
Message-ID: <20160610201118.13813-18-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmt-0003KY-L8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbcFJUMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34998 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbcFJUME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so1048509wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sb1p3Gi/bw+S/+21lKKLSdmywR5mH7d1nZqfGWmE+78=;
        b=TI0CfJceAkRvfrJdtR2TUszl8wIISYV6tzuAJwxuGlm5I5BICHZjM2LBfU8kFXp09s
         dgfoWLxtCDz9AHuWjEUrBD4n1k7j1p9xDXwEznlbrd+Yd/RYdqLs7O2l7POkTVSWW5tz
         Y0c74rbiBaUj/MnjT2awaoOoENcAHgWOXFZnnzeBWrLRYwSnfgKVKhudE5jJ+Btoqo6k
         0zVRs1wr/jKctftxfQdJ/qhssUKAW3PbSBPK3ujZNp+DYVoFcJ/18SBTPgrG3tbf6jVB
         RJWIcDJxZGYb5c3EDkdBUe6USFbImlzwG9l2dElfDZKXNVEOzxoqH1eQtLHnvAM/4SrN
         B8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sb1p3Gi/bw+S/+21lKKLSdmywR5mH7d1nZqfGWmE+78=;
        b=G9HhxPYVaiF9GmmSrlVpjsq7RA6Vpcz9i3nyXBQODdDIKiSXy2cifoxqoqEdto8Esk
         /k4CHSQqQWZPDPblHQZt8cwGKnkt0tR4bfHpFdUKIWO74o+ECFiZ6XcFsexDHGfrIkw0
         JY0dAxm4Qd5mcjAe594/6GDZYwElHLOShFgrMLbGPkessImKGUdrgKXsLuAI6LNdS3JL
         rIZMQey1GA95s6Gtje0bJauZ6WmrzpJjR8xUEWXAceeESWUSP2kUL1lEBpn5SbXLEe02
         fm5+4aLA6QNSuKsU5Q9Xc5NbQ/o9prmkWvCFNl+FIKXRqrCDRcaEkiGxU/zdSk+C+4Pn
         vDPw==
X-Gm-Message-State: ALyK8tKw+a0LNA2IF/n1PcekxVX4YEdBbZPRuUUgdcPn12FSRfZn9Bfc8tphkyHmeAmjOA==
X-Received: by 10.194.150.130 with SMTP id ui2mr3747412wjb.11.1465589523180;
        Fri, 10 Jun 2016 13:12:03 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:02 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297033>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", die_on_unsafe_path() should return -1 using
error() instead of calling die(), so while doing that let's change
its name to check_unsafe_path().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b506369..429fddd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3697,7 +3697,7 @@ static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
 	return ret;
 }
 
-static void die_on_unsafe_path(struct patch *patch)
+static int check_unsafe_path(struct patch *patch)
 {
 	const char *old_name = NULL;
 	const char *new_name = NULL;
@@ -3709,9 +3709,10 @@ static void die_on_unsafe_path(struct patch *patch)
 		new_name = patch->new_name;
 
 	if (old_name && !verify_path(old_name))
-		die(_("invalid path '%s'"), old_name);
+		return error(_("invalid path '%s'"), old_name);
 	if (new_name && !verify_path(new_name))
-		die(_("invalid path '%s'"), new_name);
+		return error(_("invalid path '%s'"), new_name);
+	return 0;
 }
 
 /*
@@ -3801,8 +3802,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!state->unsafe_paths)
-		die_on_unsafe_path(patch);
+	if (!state->unsafe_paths && check_unsafe_path(patch))
+		return -1;
 
 	/*
 	 * An attempt to read from or delete a path that is beyond a
-- 
2.9.0.rc2.362.g3cd93d0

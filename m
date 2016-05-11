From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 82/94] apply: roll back index lock file in case of error
Date: Wed, 11 May 2016 15:17:33 +0200
Message-ID: <20160511131745.2914-83-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U51-0004sl-5U
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbcEKNV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33142 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932375AbcEKNVS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so9418870wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edkjhPKkH1pQhxezh07FMOVBhQ68tVagV5YhrCbnbhE=;
        b=T0/Q+/tfukT0fpm1AKadHE5dNNNbA1kWH9y0KyajMS5fjnpl4auJR7BCFZjsog3HGY
         lY/lcLZgqdD2FrpmylOIeQbQjXD+hsrg9DapYLaT5P2fEJR+ZnrHPI7+fzFeRY0qHZvq
         qM8y2Wswovcl6W+pTt43IRa3xqf6R1mvZxGm0U/qofbNQfFAySLgV43wt5Bkzzv6KIzA
         ooUj3llx3d5vP5aIh9pCIV7dsUYsd732sX07gwtGdY2vTeCCRAyvBR1pRLxgBN90/7gT
         rfIf9UtKOIOpzzTzHKeNRdJO88q1CFBPDvhuUqGlD0O+BpBTaOy5Cl7gTjDHjrLyFkHi
         AvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edkjhPKkH1pQhxezh07FMOVBhQ68tVagV5YhrCbnbhE=;
        b=DN+Gj8sgR77KLcleYrQsQ93jMrcbAtsv77wbeD/cQw1pwzBULugJuzUdqVJZlM5oqu
         5iwxvEu41tv4uXhqYNP6Qy6L3B2U9Kffq5FWy4HfI183VKJVMJHWeOzGF3AA5AJ5E3M3
         RiIQcBeGGERI/BgAyrnbD4uh5nEOfbs+xT/FRcgnp7mZZRqBd6cSOpyGEZYDn3SLBtNa
         pMYjPeCrcvdq+xOXdCLXxs3aG/feWogVpytlFDFVT3XyTQhRHmCmGNyYF90yPN4b7nt9
         zKOQY7o54Ea5e4HQFfBZRETFXtJF+uW7s+UwB70G0MCuWBktT/V8v/VBIqJRYakksBy0
         QyOg==
X-Gm-Message-State: AOPr4FVwgNspAHR+HZSr9I9fH0KBG1t5YChI/nPRQmp3DVILtfvp9zXBZwg4Bw98CXG3wQ==
X-Received: by 10.28.16.17 with SMTP id 17mr50644wmq.17.1462972876520;
        Wed, 11 May 2016 06:21:16 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:15 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294301>

According to the lockfile API, when finished with a lockfile, one
should either commit it or roll it back.

This is even more important now that the same lockfile can be passed
to init_apply_state() many times to be reused by series of calls to
the apply lib functions.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 3285bf7..7480ae8 100644
--- a/apply.c
+++ b/apply.c
@@ -4739,7 +4739,7 @@ int apply_all_patches(struct apply_state *state,
 		if (!strcmp(arg, "-")) {
 			res = apply_patch(state, 0, "<stdin>", options);
 			if (res < 0)
-				return -1;
+				goto rollback_end;
 			errs |= res;
 			read_stdin = 0;
 			continue;
@@ -4749,21 +4749,23 @@ int apply_all_patches(struct apply_state *state,
 					      arg);
 
 		fd = open(arg, O_RDONLY);
-		if (fd < 0)
-			return error(_("can't open patch '%s': %s"), arg, strerror(errno));
+		if (fd < 0) {
+			error(_("can't open patch '%s': %s"), arg, strerror(errno));
+			goto rollback_end;
+		}
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
 		res = apply_patch(state, fd, arg, options);
 		close(fd);
 		if (res < 0)
-			return -1;
+			goto rollback_end;
 		errs |= res;
 	}
 	set_default_whitespace_mode(state);
 	if (read_stdin) {
 		res = apply_patch(state, 0, "<stdin>", options);
 		if (res < 0)
-			return -1;
+			goto rollback_end;
 		errs |= res;
 	}
 
@@ -4777,11 +4779,13 @@ int apply_all_patches(struct apply_state *state,
 				   squelched),
 				squelched);
 		}
-		if (state->ws_error_action == die_on_ws_error)
-			return error(Q_("%d line adds whitespace errors.",
-					"%d lines add whitespace errors.",
-					state->whitespace_error),
-				     state->whitespace_error);
+		if (state->ws_error_action == die_on_ws_error) {
+			error(Q_("%d line adds whitespace errors.",
+				 "%d lines add whitespace errors.",
+				 state->whitespace_error),
+			      state->whitespace_error);
+			goto rollback_end;
+		}
 		if (state->applied_after_fixing_ws && state->apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
@@ -4802,5 +4806,12 @@ int apply_all_patches(struct apply_state *state,
 	}
 
 	return !!errs;
+
+rollback_end:
+	if (state->newfd >= 0) {
+		rollback_lock_file(state->lock_file);
+		state->newfd = -1;
+	}
+	return -1;
 }
 
-- 
2.8.2.490.g3dabe57

From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 81/83] apply: roll back index in case of error
Date: Sun, 24 Apr 2016 15:39:47 +0200
Message-ID: <1461505189-16234-2-git-send-email-chriscool@tuxfamily.org>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:40:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKGk-0001qZ-8A
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbcDXNkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:40:08 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34809 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbcDXNkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:40:05 -0400
Received: by mail-wm0-f48.google.com with SMTP id v200so10022932wmv.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UA88DQqylunvAhO2voeYE6JQ5xPBAT3L40ilxIiGp5Q=;
        b=lNMqc69Pe1ZSNFUMNBpklH5bpS2D/nmKwbVCZSjGJuk+4ENE/4KWgD37Bz7fB+gmeA
         P/VprzoM4D39NyBc41TST4n2FyBlc1XW9ejMTGK5RNnFyvcXc81q/m9HrXpddi9AURoG
         zuXB6NaQHbb9z7enMX0VcCJDZTRZ1irgVVkmk6Z25TYBGqQQf/6k8AIaV6znVMR99uFw
         EOu8sFJwScMsdi483x+gHLKwwweAqUB5/JnIYQwaNMex02VZF/Yu6HY3zsdLKQovIgI9
         bzkFZ2QFbVsv3JJDCkph7ULqxwlWlKtPSZkzdpANY9iB5Lnmn9YADJT0hRQkDJGM7PQS
         719w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UA88DQqylunvAhO2voeYE6JQ5xPBAT3L40ilxIiGp5Q=;
        b=HHpd0yvgucDZ7Cv6nUnAqWjcn8Pg9s9V/9544AIWMHzTvwpvnvx4HzSPLOPPm1iroD
         NIBqR97NJ9jaPoP6hVpv6BoiG+RB/sOtVntym7H9HBtssYbeD51RCbe6eWaT0hl6osq5
         7/Sq6nwGw4QXNgOlalxFMyvSa5QusCUdmbjgMXAh52q9U6nHXhPC9qffbXsWSnk+O7vF
         pPcVPba7FN5j5n1/lBl/gw4JzL9P8DOX5bc6rTmV0v+V8zs3a1sMP8WtUVtCh2deqY06
         wy22Myr3/zP+K4mdvTv9chVIDyhsWNI2FrOq5j9wScHg24Mxu8V+iEmcjqcU4oi0iRD/
         HLsA==
X-Gm-Message-State: AOPr4FXNArkric3gmprrRxXJGQcuxMqcP6KRzXZVav0gM5lzKzA5jJRwQrL+NFPh3H8Fyw==
X-Received: by 10.28.146.135 with SMTP id u129mr6681326wmd.8.1461505203912;
        Sun, 24 Apr 2016 06:40:03 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id by7sm18530771wjc.18.2016.04.24.06.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:40:02 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292403>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 86e0d20..7cee834 100644
--- a/apply.c
+++ b/apply.c
@@ -4718,8 +4718,11 @@ int apply_all_patches(struct apply_state *state,
 
 		if (!strcmp(arg, "-")) {
 			res = apply_patch(state, 0, "<stdin>", options);
-			if (res < 0)
+			if (res < 0) {
+				if (state->lock_file)
+					rollback_lock_file(state->lock_file);
 				return -1;
+			}
 			errs |= res;
 			read_stdin = 0;
 			continue;
@@ -4734,16 +4737,22 @@ int apply_all_patches(struct apply_state *state,
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
 		res = apply_patch(state, fd, arg, options);
-		if (res < 0)
+		if (res < 0) {
+			if (state->lock_file)
+				rollback_lock_file(state->lock_file);
 			return -1;
+		}
 		errs |= res;
 		close(fd);
 	}
 	set_default_whitespace_mode(state);
 	if (read_stdin) {
 		res = apply_patch(state, 0, "<stdin>", options);
-		if (res < 0)
+		if (res < 0) {
+			if (state->lock_file)
+				rollback_lock_file(state->lock_file);
 			return -1;
+		}
 		errs |= res;
 	}
 
@@ -4757,11 +4766,14 @@ int apply_all_patches(struct apply_state *state,
 				   squelched),
 				squelched);
 		}
-		if (state->ws_error_action == die_on_ws_error)
+		if (state->ws_error_action == die_on_ws_error) {
+			if (state->lock_file)
+				rollback_lock_file(state->lock_file);
 			return error(Q_("%d line adds whitespace errors.",
 					"%d lines add whitespace errors.",
 					state->whitespace_error),
 				     state->whitespace_error);
+		}
 		if (state->applied_after_fixing_ws && state->apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
-- 
2.8.1.300.g5fed0c0

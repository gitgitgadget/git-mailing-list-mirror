From: Marios Titas <redneb@gmx.com>
Subject: [PATCH 1/2] ident: check for useConfigOnly before auto-detection of name/email
Date: Wed, 30 Mar 2016 22:29:42 +0300
Message-ID: <1459366183-15451-1-git-send-email-redneb@gmx.com>
Cc: Marios Titas <redneb@gmx.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 21:30:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alLoY-0003PI-NI
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 21:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbcC3T34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 15:29:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:63498 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbcC3T3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 15:29:55 -0400
Received: from localhost.localdomain ([79.103.155.63]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0LkP8Z-1aAuOx0s2t-00cNZi; Wed, 30 Mar
 2016 21:29:52 +0200
X-Mailer: git-send-email 2.8.0
X-Provags-ID: V03:K0:ggSY/HqPfVj+Hrf3hOdWD1sGV2sgbslNMMJ2Rc/DGm8rrv27XuZ
 TYVw+tWmGzx/NrCHQoED5XIw/v78ZHTto7E60GEDQBqedDSRnRtlpPGzinXWRsBrtKkRDkJ
 aidKgPlFuYZU002d6wySLTl1cIuPo5mKEKu0chNYCYwJ3ZZkS/s7sSvOityMZ0zJg07drnb
 bbjefV8HwEJyr7+a7IF0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iE27LZ//YuA=:TVcx/GSck3yVa3JhV8FLjm
 mzy06ons7uJfHVVCwTk1jXYX1wIIphh6cDwlDesDXWBCZ9DFCq+EPPgQGJgHd+fwZk7VY+nMM
 mzdTOHLsadW4nAE0J3igkiJZSf0DBjrXu3C48umAHqei6Yjvz5utoKOFwgWfTpebVumjrgVAA
 65YwY/xYCqztqkM5DsYjUfizcsKp+Os438kfHL49rmdaoybdaNNwiU31RXGJMeELqHSljx5T7
 RrUp/A9LAPezbpYiFu+uugm1VAi+b5HFYeGJj4NDuPR/RSAvlHYJbLzvp9nOYz/4M6cZNwAt1
 FR5XH68i07UvSNi/4Kf0XyG68bxSuthsA6DDme+UPzObqxseL5wxuWzw212Cwr7znfdMsFvJc
 P7JcnXqpGV4uNntayW6Dw5MuwiIkvOnbb1bUA5/wwYeCoancmVTwCIpU6ZZrj4vmX7lLXOUsV
 jGkrb1HRSe+TeP76NbziPz/BLua7Bv2CfFcigahR6SBLlIb8PJ1WKVozCTrwrYqFkifEs/3RK
 cxvxjP6rq/sRrCAGTS9zg+0bpDpDq39W73xmGT8++YOx8OvhM6WtNuHKwIg9uW4Ss+0Dx1Rih
 MXm49tnOREt8u4GDjzCqPsGxC25Uh7jfBi/SfNs4hin9VZUQQqfCjAeh4rkOOVGHFEmeh5cUc
 YzUcmMsKojfYC3O8p577QCa/7u3Rw9So/nMe6/3j1egthDaZkBxcUFI9tHt3hpDPYwgcnNWWU
 gUJ0C7J1k5gzMAzxxH7CsoVJPMUOhTALfKOobNGq71fkxaLAqQIWPz3jvEI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290340>

If user.useConfigOnly is set, it does not make sense to try to
auto-detect the name and/or the email. So it's better to do the
useConfigOnly checks first.

Signed-off-by: Marios Titas <redneb@gmx.com>
---
 ident.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ident.c b/ident.c
index 6e12582..74b2663 100644
--- a/ident.c
+++ b/ident.c
@@ -351,15 +351,15 @@ const char *fmt_ident(const char *name, const char *email,
 	if (want_name) {
 		int using_default = 0;
 		if (!name) {
+			if (strict && ident_use_config_only
+			    && !(ident_config_given & IDENT_NAME_GIVEN))
+				die("user.useConfigOnly set but no name given");
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
 				fputs(env_hint, stderr);
 				die("unable to auto-detect name (got '%s')", name);
 			}
-			if (strict && ident_use_config_only
-			    && !(ident_config_given & IDENT_NAME_GIVEN))
-				die("user.useConfigOnly set but no name given");
 		}
 		if (!*name) {
 			struct passwd *pw;
@@ -374,14 +374,14 @@ const char *fmt_ident(const char *name, const char *email,
 	}
 
 	if (!email) {
+		if (strict && ident_use_config_only
+		    && !(ident_config_given & IDENT_MAIL_GIVEN))
+			die("user.useConfigOnly set but no mail given");
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
 			fputs(env_hint, stderr);
 			die("unable to auto-detect email address (got '%s')", email);
 		}
-		if (strict && ident_use_config_only
-		    && !(ident_config_given & IDENT_MAIL_GIVEN))
-			die("user.useConfigOnly set but no mail given");
 	}
 
 	strbuf_reset(&ident);
-- 
2.8.0

From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 10/17] ref-filter: introduce refname_atom_parser_internal()
Date: Sun, 15 May 2016 16:15:26 +0530
Message-ID: <1463309133-14503-11-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:46:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tYv-0003qV-Hs
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbcEOKqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:46:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33462 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbcEOKqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:46:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so13141916pfb.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bg4W9NQo01OBAv3jX9FgUL0th+4h5p6CBVwmDQzmzpo=;
        b=lgGDXgVuyZITcDWep39ZDMmUHm+WEJI3Ex6ob1jMDiTiUvmqQT7xnr5w2TY/NDjZaK
         mmnTpwGSsGBlGwQrV+VL2MusW5EkIIOABaanKEbCDK/EbbdbZawWtpI1abeaqz6ZJV4O
         a61YZwDB2rph9pzvjRG/Rb+XLEiAtPjJRudse9on3fFF/Ihf6FWohWBhDGwu5Vm7kkiX
         fO9nX7hUtFoPx4wfN3OKTda4M7sB7EhHxhpduJIViadyX5irOYnre8PFryEck4gO89qC
         RsSWHQ/e8WL/4SmUc8k9c437JGXICKK3bBgkFHIH38lwNB7aei4P+xh+vPrpV/BA29u4
         +7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bg4W9NQo01OBAv3jX9FgUL0th+4h5p6CBVwmDQzmzpo=;
        b=FOEaRGxTJDI/SFfzPwU46LDzA0UKqYoSHLLQWzlGq0nV5zMzSMBLpXXG96b+7vgGcC
         7CfY0Bb2X744QiKPL4+WwG/RICQXhqGXZ+Ig9M7z47jcCsPHVn4/afipfTeEkhImzMJx
         wc7Y+ZrRADJWkxnt5XlTWJGA0k2LMVoB8GwihNpzObTnmEmaXgv6dhalPjcuWVFFO+kU
         FGZiJrLnjr6G6g6ksWX9qFJ4fj84ozEj4b1vVXyAD7ymdsVEJrMvOn7FfzD64rLePWCY
         c9EfHbYqmeOp6J/8khLoIoFEWJWNVD8Cxt8yodZI1x2KVkvriagI9hNSuMX2BtZni0EP
         Gq0g==
X-Gm-Message-State: AOPr4FV9gF4OPZNmbl12WW8MmZ1+1s/fscna1vuW5lBMF4EKZkTqyLNHPSsKnuq377/JcA==
X-Received: by 10.98.85.194 with SMTP id j185mr36715560pfb.68.1463309165974;
        Sun, 15 May 2016 03:46:05 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:46:05 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294659>

Since there are multiple atoms which print refs ('%(refname)',
'%(symref)', '%(push)', '%upstream'), it makes sense to have a common
ground for parsing them. This would allow us to share implementations of
the atom modifiers between these atoms.

Introduce refname_atom_parser_internal() to act as a common parsing
function for ref printing atoms. This would eventually be used to
introduce refname_atom_parser() and symref_atom_parser() and also be
internally used in remote_ref_atom_parser().

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 083cc27..778fe02 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -30,6 +30,11 @@ struct if_then_else {
 		condition_satisfied : 1;
 };
 
+struct refname_atom {
+	enum { R_NORMAL, R_SHORT, R_STRIP } option;
+	unsigned int strip;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -62,6 +67,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -75,6 +81,21 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static void refname_atom_parser_internal(struct refname_atom *atom,
+					 const char *arg, const char *name)
+{
+	if (!arg)
+		atom->option = R_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->option = R_SHORT;
+	else if (skip_prefix(arg, "strip=", &arg)) {
+		atom->option = R_STRIP;
+		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
+			die(_("positive value expected refname:strip=%s"), arg);
+	} 	else
+		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+}
+
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
-- 
2.8.2

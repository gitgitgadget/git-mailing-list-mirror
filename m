From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 2/3] grep: prepare grep for submodules
Date: Wed, 29 Sep 2010 13:28:53 -0700
Message-ID: <1285792134-26339-3-git-send-email-judge.packham@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed Sep 29 22:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13HL-0002Fp-K7
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab0I2U3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 16:29:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62995 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab0I2U3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 16:29:07 -0400
Received: by pzk34 with SMTP id 34so291094pzk.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NvisYLwvKv1K2OiX21WwGuuXaTAMCCSfUWs6wgXi0Ck=;
        b=V0uoDzqBdOGgMGmIwIXHxvTWUnFfmaQAzs6aht4ShUAK21POrGmB1WZTmqC8Vup3bw
         xcn3wZp/FzPZD1Fx99L3SU7KPq3Q8G4htxS9oJDYCusZpPXgPnfimHwbUPmoyUvoGjeN
         LXkYsof9RLfdq6O1LfCb7NsOnAnvQB7CLzqnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SEgrsmDhSyo73DIMzaXf4gQpQO7926JKzvPKvn5NJvgqS6OZnv4n/zNPm1IOqG21Gg
         QB/3t5vuBWw/BnIJ+VSnZQrBCYdaAz5L9MrHvz1MkX6QTlsNVLO1L/MqTqRc1kWhxyjP
         a9kcLIlb5zXtqgQ7/DLjnfH2GsXDu/NHkHZ9E=
Received: by 10.114.61.1 with SMTP id j1mr2660458waa.76.1285792140200;
        Wed, 29 Sep 2010 13:29:00 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm15169981wal.9.2010.09.29.13.28.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 13:28:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.dirty
In-Reply-To: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157601>

Add --submodule-prefix option to pass to subprocess grep invocations. The
prefix is then used when outputting the results.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 builtin/grep.c |    2 ++
 grep.c         |    8 ++++++++
 grep.h         |    1 +
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..8315ff0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -927,6 +927,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
+		OPT_STRING(0, "submodule-prefix", &opt.submodule_prefix, "DIR",
+			"prepend this to submodule path output"),
 		OPT_END()
 	};
 
diff --git a/grep.c b/grep.c
index 63c4280..36bec98 100644
--- a/grep.c
+++ b/grep.c
@@ -370,6 +370,10 @@ static void output_sep(struct grep_opt *opt, char sign)
 
 static void show_name(struct grep_opt *opt, const char *name)
 {
+	if (opt->submodule_prefix) {
+		output_color(opt, opt->submodule_prefix,
+			strlen(opt->submodule_prefix), opt->color_filename);
+	}
 	output_color(opt, name, strlen(name), opt->color_filename);
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
@@ -644,6 +648,10 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	}
 	opt->last_shown = lno;
 
+	if (opt->submodule_prefix) {
+		output_color(opt, opt->submodule_prefix,
+			strlen(opt->submodule_prefix), opt->color_filename);
+	}
 	if (opt->pathname) {
 		output_color(opt, name, strlen(name), opt->color_filename);
 		output_sep(opt, sign);
diff --git a/grep.h b/grep.h
index 06621fe..d918da4 100644
--- a/grep.h
+++ b/grep.h
@@ -67,6 +67,7 @@ struct grep_opt {
 	struct grep_expr *pattern_expression;
 	const char *prefix;
 	int prefix_length;
+	const char *submodule_prefix;
 	regex_t regexp;
 	int linenum;
 	int invert;
-- 
1.7.3.dirty

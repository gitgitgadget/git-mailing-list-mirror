From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] submodule: prepare for recursive checkout of submodules
Date: Thu, 26 Dec 2013 08:02:40 -0800
Message-ID: <20131226160239.GM20443@google.com>
References: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 17:02:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwDOa-0004b6-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 17:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3LZQCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 11:02:44 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:34554 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab3LZQCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 11:02:43 -0500
Received: by mail-qc0-f169.google.com with SMTP id r5so7822023qcx.28
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MQrKqnjBGHOe7x5/J4JdVaT1xbTFeoVJImx/FOGvjFQ=;
        b=MymZnS7h+WHWeA5kpgdx7Zvp6dvdnnf49QdVmV/5MiHJiMQfY+EYSI4RnRcn5zrcLC
         k7pGRmd3O5kgjpB45dUtC9DYmbtSt++YoG2AcGyzjbOa/uXcRMFJgVkUAJciZOmvgNpQ
         DZ+HJyMdXhXu8eCIlh1Hdiv2wUEEfI5DCVsHSUO4XOgZtnX94ixQxXNjScJPnOYGgHED
         /drgXk/M1Td+UURHth9QtjIhQyDx5qwsNed5KjmZ1nGr1Fbb3ru8JBjOktzmNwUWtV4J
         diXmw7Ru2IaNZFd/eilas31x68tTbWoFUItqCRSnzW/eNHJp4cVci2n5o/UELzHB3byW
         +1TA==
X-Received: by 10.49.52.102 with SMTP id s6mr73531176qeo.60.1388073763225;
        Thu, 26 Dec 2013 08:02:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w5sm46282548qat.10.2013.12.26.08.02.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 08:02:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131226155857.GL20443@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239696>

From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Mon, 18 Jun 2012 22:17:59 +0200

This commit adds the functions needed for configuration, for setting the
default behavior and for determining if a submodule path should be updated
automatically.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Should probably be squashed into a patch that uses and documents this
configuration.

 submodule.c | 36 ++++++++++++++++++++++++++++++++++++
 submodule.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/submodule.c b/submodule.c
index 613857e..3f18d4d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,6 +16,8 @@ static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
+static int option_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
@@ -382,6 +384,34 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	}
 }
 
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "checkout"))
+			return RECURSE_SUBMODULES_ON;
+		die("bad %s argument: %s", opt, arg);
+	}
+}
+
+int submodule_needs_update(const char *path)
+{
+	struct string_list_item *path_option;
+	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (!path_option)
+		return 0;
+
+	/* update can't be "none", "merge" or "rebase" */
+
+	if (option_update_recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
+		return 1;
+	return config_update_recurse_submodules != RECURSE_SUBMODULES_OFF;
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
@@ -589,6 +619,12 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 	return ret;
 }
 
+void set_config_update_recurse_submodules(int default_value, int option_value)
+{
+	config_update_recurse_submodules = default_value;
+	option_update_recurse_submodules = option_value;
+}
+
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 {
 	int is_present = 0;
diff --git a/submodule.h b/submodule.h
index 7beec48..055918c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -22,12 +22,15 @@ void gitmodules_config(void);
 int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+int submodule_needs_update(const char *path);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
+void set_config_update_recurse_submodules(int default_value, int option_value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
1.8.5.1

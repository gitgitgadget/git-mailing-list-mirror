From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Wed, 28 Jan 2015 17:50:07 +0700
Message-ID: <20150128105007.GA761@lanh>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
 <CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
 <xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
 <CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
 <xmqqa916nq4p.fsf@gitster.dls.corp.google.com>
 <CAGXKyzEYVsz-nRs52pTKo+6JLBiO9daU_C3qev3H43=Vzuygiw@mail.gmail.com>
 <xmqqtwzem776.fsf@gitster.dls.corp.google.com>
 <54C7CC6D.80906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Craig Silverstein <csilvers@khanacademy.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGfBf-0005Fs-3H
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 03:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760808AbbA2CuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 21:50:25 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41259 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760620AbbA2CuX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 21:50:23 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so32994299pad.8
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 18:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m7M8GPexheOKw7OPQEfTxUIUN+2pfFSwWHwJse9HZdY=;
        b=mEy6kn7Gyk0BQP26n1wLClw8zJBoM6HIBKAk635Q8s753iI4kj5os4lajBmn8MsF5V
         OQDQ+VnQ/gHNwzHudRuDq6/pL5Du2YgkK9ai1AgM2AKhbtUBpLgrUHjejb5wctfvO2/z
         FW8ezmoqYQGtLXE0yE4Dfq8vXOzUszzomukR4qYLMPPHOHtAnLQJtt1dZEQq2+yPMXLx
         2P01vXTwYttr4OQB8dDVIhGlEbfjezlLFD5H0rTWt1uiwX3L+YcPZkLX3jurHv5veXOM
         pPYEPHvpDuO7EX8rgAdSozGQSSeFXzKJROva24XF7wP1pbmlZ8Xhea/YTq9OVDDXV2XL
         ZXkw==
X-Received: by 10.68.96.194 with SMTP id du2mr4537015pbb.107.1422442213283;
        Wed, 28 Jan 2015 02:50:13 -0800 (PST)
Received: from lanh ([115.73.229.37])
        by mx.google.com with ESMTPSA id ns6sm4276277pbb.77.2015.01.28.02.50.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2015 02:50:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 28 Jan 2015 17:50:07 +0700
Content-Disposition: inline
In-Reply-To: <54C7CC6D.80906@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263134>

On Tue, Jan 27, 2015 at 06:35:41PM +0100, Jens Lehmann wrote:
> > One way to do so might be to move the bits it stores in the config
> > file to somewhere else that is more closely tied to the checkout
> > state and handle that similar to .git/index and .git/HEAD when it
> > comes to multiple work-trees.
> 
> Yup, the idea of separating config entries into worktree and repo
> specific files sounds like the solution for these problems.

OK, would this work? This PoC patch adds a config key namespace
local.* that is written to $GIT_DIR/config.local instead of
$GIT_DIR/config (I still need to ban local.* in global config
files). This config.local is loaded togethr with $GIT_DIR/config.

For nd/multiple-work-trees we can transparently map
$GIT_DIR/config.local to $SUPER/worktrees/<id>/config.local. For
git-new-workdir.sh, perhaps we can teach include.path to make
config.local path relative to where the config symlink is, not where
the symlink target is.

We can then teach setup.c to read local.core.worktree if core.worktree
is not present, and more apdation in git-submodule.sh.. I don't expect
big changes because git-submodule.sh just needs to read some other
config keys and dont need to care if git-new-workdir.sh or
nd/multiple-work-trees is being used.

-- 8< --
diff --git a/config.c b/config.c
index 752e2e2..237bd8e 100644
--- a/config.c
+++ b/config.c
@@ -1177,6 +1177,15 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
+static int config_local_filter(const char *var, const char *value, void *data)
+{
+	struct config_include_data *inc = data;
+
+	if (!starts_with(var, "local."))
+		return error("$GIT_DIR/config.local can only contain local.*");
+	return inc->fn(var, value, inc->data);
+}
+
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
@@ -1202,8 +1211,19 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	}
 
 	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+		char *wt_config;
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
+		wt_config = git_pathdup("config.local");
+		if (!access_or_die(wt_config, R_OK, 0)) {
+			struct config_include_data inc = CONFIG_INCLUDE_INIT;
+			inc.fn = fn;
+			inc.data = data;
+			ret += git_config_from_file(config_local_filter,
+						    wt_config, &inc);
+			found += 1;
+		}
+		free(wt_config);
 	}
 
 	switch (git_config_from_parameters(fn, data)) {
@@ -1942,8 +1962,12 @@ int git_config_set_multivar_in_file(const char *config_filename,
 
 	store.multi_replace = multi_replace;
 
-	if (!config_filename)
-		config_filename = filename_buf = git_pathdup("config");
+	if (!config_filename) {
+		if (starts_with(key, "local."))
+			config_filename = filename_buf = git_pathdup("config.local");
+		else
+			config_filename = filename_buf = git_pathdup("config");
+	}
 
 	/*
 	 * The lock serves a purpose in addition to locking: the new
-- 8< --

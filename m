From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Thu, 18 Jun 2015 14:46:36 -0700
Message-ID: <xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net> <20150618202205.GA16517@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:46:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hdy-0007nX-VI
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbbFRVqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:46:39 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34660 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbFRVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:46:38 -0400
Received: by igboe5 with SMTP id oe5so2108497igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FattsCrVLgj8QlTl60VzXgdFYeF4vtOcUrmXIC8f148=;
        b=arP6Znr72kDX/2OeniWQu+i5fDDU26YEAN3wotQjLXYJ5raKYojRyX/mOIBNGMwTq+
         H50mzszwRQiXT2g16IRKf+Jma3BHcjLw6rvDfhuo6LV78jUSkeEY7AdEGz6ZHm/Sb1Hr
         /AkFOG539Dmu2E0nUkN3Pp8WX3V6ELPHqZYvyrgMaEk5KdMLgIlvIARv1qgeVkJSGPwv
         2q5q9tFDEVBmO5qgtIPsnPJacFaaMbStt1kGy+eWyq6tmxtB8P1QmpK8lwoVc+aHn/b5
         QYniwKYaIcovSmzhNB5IUQdQml4EgsPlcJI7pVFI+zAlfwl+fdjEh/YKcoxBLfQdIkC9
         OOOw==
X-Received: by 10.50.225.35 with SMTP id rh3mr175138igc.29.1434663997885;
        Thu, 18 Jun 2015 14:46:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id k186sm5742900ioe.9.2015.06.18.14.46.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 14:46:37 -0700 (PDT)
In-Reply-To: <20150618202205.GA16517@peff.net> (Jeff King's message of "Thu,
	18 Jun 2015 16:22:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272083>

Jeff King <peff@peff.net> writes:

> Much worse, though, is that we also have to interact with "--stdout". We
> currently treat "--stdout -o foo" as an error; you need a separate
> config_output_directory to continue to handle that (and allow "--stdout"
> to override the config).
>
> If I were designing from scratch, I would consider making "-o -" output
> to stdout, and letting it override a previous "-o" (or vice versa). We
> could still do that (and make "--stdout" an alias for that), but I don't
> know if it is worth the trouble (it does change the behavior for anybody
> who wanted a directory called "-", but IMHO it is more likely to save
> somebody a headache than create one).

I agree with "later -o should override an earlier one", but I do not
necessarily agree with "'-o -' should be --stdout", for a simple
reason that "-o foo" is not "--stdout >foo".

Perhaps something like this to replace builtin/ part of Alexander's
patch?

 builtin/log.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index e67671e..e022d62 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -682,6 +682,8 @@ enum {
 	COVER_AUTO
 };
 
+static const char *config_output_directory;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -752,6 +754,9 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.outputdirectory")) {
+		return git_config_string(&config_output_directory, var, value);
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1337,6 +1342,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die (_("--subject-prefix and -k are mutually exclusive."));
 	rev.preserve_subject = keep_subject;
 
+	if (!output_directory && !use_stdout)
+		output_directory = config_output_directory;
+
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
 		die (_("unrecognized argument: %s"), argv[1]);

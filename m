From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: deprecate using "" as boolean value false.
Date: Mon, 11 Feb 2008 00:46:09 -0800
Message-ID: <7vmyq7anji.fsf@gitster.siamese.dyndns.org>
References: <20080211082216.e9212310.chriscool@tuxfamily.org>
	<7vskzzaoop.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUJW-0004s1-4s
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYBKIqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYBKIqX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:46:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbYBKIqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:46:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E87B4129;
	Mon, 11 Feb 2008 03:46:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 772C54125;
	Mon, 11 Feb 2008 03:46:11 -0500 (EST)
In-Reply-To: <7vskzzaoop.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Feb 2008 00:21:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73485>

Junio C Hamano <gitster@pobox.com> writes:

> So far I've seen and queued only two usable fixes since that
> [Janitor] request.  Maybe I should have ignored all this
> discussion in this thread and spent my time on doing the
> Janitorial work.

In the thread I mentioned erroring out when a value we expect is
missing instead of silently ignoring such a misconfiguration,
and I showed an incorrect example of doing so using die().

The caller of the callback reports the line number and the
filename upon error.  So we should just return an error and let
the caller do the more detailed reporting.

With this patch, a misconfiguration:

	[apply]
        	whitespace

will result in:

	$ git apply
        error: Missing value for 'apply.whitespace'
        fatal: bad config file line 29 in .git/config

which is much nicer.

---

 cache.h         |    1 +
 config.c        |    9 +++++++++
 builtin-apply.c |    2 ++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 549f4bb..6abcee4 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,7 @@ extern int git_config_set_multivar(const char *, const char *, const char *, int
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value);
+extern int config_error_nonbool(const char *);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index 498259e..e9a9a6f 100644
--- a/config.c
+++ b/config.c
@@ -1074,3 +1074,12 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	free(config_filename);
 	return ret;
 }
+
+/*
+ * Call this to report error for your variable that should not
+ * get a boolean value (i.e. "[my] var" means "true").
+ */
+int config_error_nonbool(const char *var)
+{
+	return error("Missing value for '%s'", var);
+}
diff --git a/builtin-apply.c b/builtin-apply.c
index 15432b6..a11b1bb 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2746,6 +2746,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 static int git_apply_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "apply.whitespace")) {
+		if (!value)
+			return config_error_nonbool(var);
 		apply_default_whitespace = xstrdup(value);
 		return 0;
 	}

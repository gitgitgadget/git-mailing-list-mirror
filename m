From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add `log.decorate' configuration variable.
Date: Tue, 16 Feb 2010 17:08:34 -0800
Message-ID: <7vljespt2l.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 02:08:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhYPJ-0001CP-WB
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 02:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933801Ab0BQBIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 20:08:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933749Ab0BQBIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 20:08:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 172C49AAB9;
	Tue, 16 Feb 2010 20:08:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KNQBppYzu67bg2i5nZdTzaG9RPs=; b=dt3U3e
	WWKWRkj2JOi2hPcSNL12C4ecXbEqu0ZJb4Zzdacc1j7NBCQGPKbPTLFa5YYkfnR9
	7ArIpFXbIWQmhboAOesMdQsmbksl6VC1IuiAHWLNwzgYte6y38aazo7Ome2/QK6X
	Utf1ZbRY3ordjNy0X8tMBE/iA72MY/zsyLG6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=msBfXL2h8hy1kb5tAnbGlH/52V1VslJV
	TkxdNgBQ+AzEBj6EMdPn6tqn0b8noQi9MziX0WqhRgg9WL7ZHQdUxFyHsRsYmTd9
	ix+jPcinI03SxhD6UyqbflmkrRk3hSCEn6JaoJiJy+zY6Hqce0+cwrhe+u+wXrVA
	GGHPQwa0NdQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E420F9AAB8;
	Tue, 16 Feb 2010 20:08:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E311F9AAB6; Tue, 16 Feb
 2010 20:08:35 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am> (Steven
 Drake's message of "Wed\, 17 Feb 2010 12\:39\:52 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB295A60-1B60-11DF-96DA-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140194>

Steven Drake <sdrake@xnet.co.nz> writes:

> This alows the 'git-log --decorate' to be enabled by default so that normal
> log outout contains ant ref names of commits that are shown.
>
> Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
> ---

Thanks.

This needs some test to make sure that it triggers when configuration is
set, it doesn't when configuration is not set, and it doesn't for commands
in log family when it shouldn't (most notably, format-patch).

> +log.decorate::
> +	Print out the ref names of any commits that are shown by the log
> +	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
> +	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
> +	specified, the full ref name (including prefix) will be printed.
> +	This is the same as the log commands '--decorate' option.

This should be the same as --decorate option, so it should be possible to
set it as a boolean true to mean "short", i.e.

	[log]
        	decorate
		decorate = true

should be treated exactly the same way as

	[log]
        	decorate = short

> diff --git a/builtin-log.c b/builtin-log.c
> index 89f8d60..cd6158c 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -249,6 +249,13 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		return git_config_string(&fmt_patch_subject_prefix, var, value);
>  	if (!strcmp(var, "log.date"))
>  		return git_config_string(&default_date_mode, var, value);
> +	if (!strcmp(var, "log.decorate")) {
> +		if (!strcmp(value, "full"))
> +			decoration_style = DECORATE_FULL_REFS;
> +		else if (!strcmp(value, "short"))
> +			decoration_style = DECORATE_SHORT_REFS;
> +		return 0;

Hence you need to be prepared to see (value == NULL) here without
segfaulting.  Perhaps something like this patch on top of yours.

 cache.h       |    1 +
 config.c      |   12 +++++++++---
 builtin-log.c |   11 +++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d478eff..24addea 100644
--- a/cache.h
+++ b/cache.h
@@ -923,6 +923,7 @@ extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
+extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
diff --git a/config.c b/config.c
index 6963fbe..6642d30 100644
--- a/config.c
+++ b/config.c
@@ -322,9 +322,8 @@ unsigned long git_config_ulong(const char *name, const char *value)
 	return ret;
 }
 
-int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
+int git_config_maybe_bool(const char *name, const char *value)
 {
-	*is_bool = 1;
 	if (!value)
 		return 1;
 	if (!*value)
@@ -333,7 +332,14 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return 1;
 	if (!strcasecmp(value, "false") || !strcasecmp(value, "no") || !strcasecmp(value, "off"))
 		return 0;
-	*is_bool = 0;
+	return -1;
+}
+
+int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
+{
+	int v = git_config_maybe_bool(name, value);
+	if (0 <= v)
+		return v;
 	return git_config_int(name, value);
 }
 
diff --git a/builtin-log.c b/builtin-log.c
index 3100dc0..23c00f0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -253,6 +253,16 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
+		switch (git_config_maybe_bool(var, value)) {
+		case 0:
+			decoration_style = 0;
+			return 0;
+		case 1:
+			decoration_style = DECORATE_SHORT_REFS;
+			return 0;
+		default:
+			break;
+		}
 		if (!strcmp(value, "full"))
 			decoration_style = DECORATE_FULL_REFS;
 		else if (!strcmp(value, "short"))

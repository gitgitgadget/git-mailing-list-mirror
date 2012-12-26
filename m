From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: add log.mailmap configuration option
Date: Wed, 26 Dec 2012 08:14:38 -0800
Message-ID: <7vlickpz81.fsf@alter.siamese.dyndns.org>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
 <1356195512-4846-3-git-send-email-apelisse@gmail.com>
 <7v8v8ppf6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 17:19:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnthV-0005zJ-SO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 17:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab2LZQOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 11:14:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab2LZQOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 11:14:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1517E95D2;
	Wed, 26 Dec 2012 11:14:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QMo9PvJLng2CtpgBGQ9fnRLlM8=; b=tXMQLg
	AclXGI/8+vlTCMn7ebY4gFKXt5pNQRtcfvz+KzT/XyZiWVWYPuz0SVBi8QCQ2Kld
	yb16FACpZ/kzXN9qbdg/WWO/pTQIEuMXRen8XR7BYiFbFKwvi5RnWGxgrWqBFO2G
	D5Qc4NAs6yWy8prF1MFvAhzv6Kfo/nlGJLdAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mnQySsY1HwxsDb9ab3hBwiW8NTbPgqZd
	WLH1X+rT+GVR02q+3QyPN0EL/Urrcu0wbI8/0gZeiNAA7d1+JDnWxcCSwGA9U8cp
	xRp9Tet3yvP/sd1En37PUtsKnZfgta8nozb7DKftrbqA57KeTVVZUsugLpQdjcSm
	3lloxb3W/KM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 009E395D1;
	Wed, 26 Dec 2012 11:14:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 541B695D0; Wed, 26 Dec 2012
 11:14:40 -0500 (EST)
In-Reply-To: <7v8v8ppf6f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 22 Dec 2012 20:26:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59F5D562-4F77-11E2-9FD0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212140>

Junio C Hamano <gitster@pobox.com> writes:

> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> I'm wondering if it would be needed to add a no-use-mailmap option to
>> log command so that it can cancel this configuration option.
>
> The usual way for adding a new feature is to add a --enable-feature
> long-option without any configuration variable to let users try it
> out in the field, and then add the configuration to let it be
> default for users who opt in.  The first step should also allow a
> command line option to disable (which should come for free if you
> use parse-options API correctly).

It should be sufficient to squash something like this in.  Use the
configured value, if available, to initialize the existing "mailmap"
variable, which is in turn updated from the command line option with
either --use-mailmap or --no-use-mailmap.  What is left in "mailmap"
after the command line parsing returns is what the user told us to
use.

Thanks.

 builtin/log.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f6936ff..16e6520 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,7 +31,7 @@ static int default_abbrev_commit;
 static int default_show_root = 1;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap;
+static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -107,6 +107,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
+	mailmap = use_mailmap_config;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
@@ -139,7 +140,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;
 
-	if (mailmap || use_mailmap) {
+	if (mailmap) {
 		rev->mailmap = xcalloc(1, sizeof(struct string_list));
 		read_mailmap(rev->mailmap, NULL);
 	}
@@ -360,7 +361,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
 	if (!strcmp(var, "log.mailmap")) {
-		use_mailmap = git_config_bool(var, value);
+		use_mailmap_config = git_config_bool(var, value);
 		return 0;
 	}
 

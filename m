From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/10] parse-options: allow git commands to invent new option
 types
Date: Wed, 1 Dec 2010 17:32:16 -0600
Message-ID: <20101201233216.GH31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:32:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNwAA-0002DA-Rz
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525Ab0LAXc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:32:26 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46222 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab0LAXcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:32:25 -0500
Received: by qwb7 with SMTP id 7so7673264qwb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SMiGWAN8k88TwN4W8eqanLCt7/rAyY2LvJZ09mmhUu8=;
        b=cKkeOH2fWL0ayHabOQiUHm+rgbI6/HKMYOabIcVSeTBJMegP1SR+mjdmVT5XJwdlBx
         mk8/4FLOXovKjkWuzxacaGUHVgWDrLUfFdqY0i5W1kH/tPlGLP6tbGRTC2jp8j2bPmYL
         4XRZo4E9SEl1NdIaeYIJmAR0N4zkrpyyckdSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ouRukqNbH9buR6DCZrusxDNfKYP+IdJItgMcFS7IPlaYrPu7xtIa0o5Q2Vl/vcppc2
         +OfuvGhsWtnIKO5EUQdOAjBfWY6UzcthunXDbX9V+NkzO5i6hyQ2pksloNZJcQh8AbV9
         SyY6ti06MpT7s1ckp60b86de9Vhw09R0P1dro=
Received: by 10.224.67.211 with SMTP id s19mr1219676qai.142.1291246344709;
        Wed, 01 Dec 2010 15:32:24 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id t17sm352432qcp.26.2010.12.01.15.32.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:32:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162645>

parse-options provides a variety of option behaviors, including
OPTION_CALLBACK, which should take care of just about any sane
behavior.  All supported behaviors obey the following constraint:

 A --foo option can only accept (and base its behavior on)
 one argument, which would be the following command-line
 argument in the "unsticked" form.

Alas, some existing git commands have options that do not obey that
constraint.  For example, update-index --cacheinfo takes three
arguments, and update-index --resolve takes all later parameters as
arguments.

Introduces an OPTION_LOWLEVEL_CALLBACK backdoor to parse-options so
such option types can be supported without tempting inventors of other
commands through mention in the public API.  Commands can set the
callback field to a function accepting three arguments: the option
parsing context, the option itself, and a flag indicating whether the
the option was negated.  When the option is encountered, that function
is called to take over from get_value().  The return value should be
zero for success, -1 for usage errors.

Thanks to Stephen Boyd for API guidance.

Improved-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |    3 +++
 parse-options.h |    8 +++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b640ac5..4c58e7f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -66,6 +66,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return opterror(opt, "takes no value", flags);
 
 	switch (opt->type) {
+	case OPTION_LOWLEVEL_CALLBACK:
+		return (*(parse_opt_ll_cb *)opt->callback)(p, opt, unset);
+
 	case OPTION_BIT:
 		if (unset)
 			*(int *)opt->value &= ~opt->defval;
diff --git a/parse-options.h b/parse-options.h
index cfa03d5..ab1bdf0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -17,6 +17,7 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
+	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
 };
 
@@ -43,6 +44,10 @@ enum parse_opt_option_flags {
 struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
+struct parse_opt_ctx_t;
+typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
+				const struct option *opt, int unset);
+
 /*
  * `type`::
  *   holds the type of the option, you must have an OPTION_END last in your
@@ -87,7 +92,8 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *				useful for users of OPTION_NEGBIT.
  *
  * `callback`::
- *   pointer to the callback to use for OPTION_CALLBACK.
+ *   pointer to the callback to use for OPTION_CALLBACK or
+ *   OPTION_LOWLEVEL_CALLBACK.
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
-- 
1.7.2.3

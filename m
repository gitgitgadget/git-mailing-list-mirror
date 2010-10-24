From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] parse-options: allow git commands to invent new option
 types
Date: Sun, 24 Oct 2010 03:15:07 -0500
Message-ID: <20101024081507.GB29630@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 10:19:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9vnK-0001ZJ-Ve
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 10:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab0JXITB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 04:19:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56319 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0JXIS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 04:18:59 -0400
Received: by iwn34 with SMTP id 34so2938002iwn.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n4F1TA9XMbEGM6P6zjuB4hZDbrJpwmhsWx7uT/b7SCA=;
        b=EGntRymSQMDSAcK3z0rRbGXoKp6Yp/4FEN/uOPIoFxktAVtCwK/EXs8w6nsATcIrh3
         R6m0l3fYDF/8/FVdArGXuEE+d74EIPwHgOkvVFI4NdwqPrlnJ6d6eUA4E7akWkW9ouQa
         plGZJqoT/T/mXGR5pfAK3cT7FfZtoSEoy6aWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wBHkQxG2R5/bI4kUyCKAIKOj9ku37LoJwnc4BsMlhxJLavWukTR7deCfctWQ9UhO0B
         NkZW9Zf7uPivw4WA2+SPpAEbk1R1rD7ZYSLxS5ydnKt2zDBgWSkRhqjHZqVvdb5We+xA
         DGipO8P0a3+E4B6rt1pr86iLjMnYbvuKAEY4o=
Received: by 10.42.191.18 with SMTP id dk18mr3705177icb.251.1287908338891;
        Sun, 24 Oct 2010 01:18:58 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 8sm6104754iba.16.2010.10.24.01.18.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 01:18:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101024081316.GA29630@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159839>

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

Introduce a new option type (OPTION_LOWLEVEL_CALLBACK) to support
such unusual options.  parse_options() callers can implement an
arbitrary custom get_value() function to override the usual one and
pass it through the callback field for options of interest.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |    6 +++---
 parse-options.h |    9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..7907306 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -8,9 +8,6 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 			       const char * const *usagestr,
 			       const struct option *opts, int err);
 
-#define OPT_SHORT 1
-#define OPT_UNSET 2
-
 static int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
@@ -51,6 +48,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 	const int unset = flags & OPT_UNSET;
 	int err;
 
+	if (opt->type == OPTION_LOWLEVEL_CALLBACK)
+		return (*(parse_opt_ll_cb *)opt->callback)(p, opt, flags);
+
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
diff --git a/parse-options.h b/parse-options.h
index d982f0f..fa400da 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -17,6 +17,7 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
+	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
 };
 
@@ -40,8 +41,16 @@ enum parse_opt_option_flags {
 	PARSE_OPT_SHELL_EVAL = 256
 };
 
+enum parse_opt_ll_flags {
+	OPT_SHORT = 1,
+	OPT_UNSET = 2
+};
+
 struct option;
+struct parse_opt_ctx_t;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
+typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
+			    const struct option *opt, int flags);
 
 /*
  * `type`::
-- 
1.7.2.3

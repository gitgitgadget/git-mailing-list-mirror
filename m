From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] allow mangling short options which take integer
	arguments
Date: Thu, 1 Oct 2009 22:23:01 +0200
Message-ID: <20091001202301.GB12175@localhost>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 22:23:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtSB7-0008Sa-6j
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 22:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbZJAUW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756240AbZJAUWz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 16:22:55 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:60597 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667AbZJAUWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 16:22:55 -0400
Received: by bwz6 with SMTP id 6so457499bwz.37
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RvfN/ELrDv7PIBH7gPLul75RV5Br3Yn18WZeinRP6Fs=;
        b=XOh9GNnhETDmz0b3tLFnv1XwjiyEVkZ445wyXG/PKSAjWWNrm2q0leZdk8r5llpwtp
         TdfT9VR1oRBPPlvcO/rdWHu9YeWZ+l/1g0OJYNrTuH9hZsvI30DRLrNELlcHdeVk4oWi
         abKBiIB73ilttWyfUemsoaWpv0EFpk6wkAC40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=QuQpIFpP3MAXK1FZ5dhLt7YubqV8G6JWCTS0I31iHJb0xQVftJCuTWiFDS9vgYY0Qy
         O5Vy/j3iuBE//TCZ39G11Rl1CLGkogXdIKNqvzM00H2Cdcb450RQbnP+8JHr75ZfPBuB
         L9kPg1VouxpX/U0m01+H3PxRuUVKfxaAHEEjI=
Received: by 10.204.155.69 with SMTP id r5mr348002bkw.136.1254428577848;
        Thu, 01 Oct 2009 13:22:57 -0700 (PDT)
Received: from darc.lan (p549A5338.dip.t-dialin.net [84.154.83.56])
        by mx.google.com with ESMTPS id 17sm628660bwz.81.2009.10.01.13.22.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Oct 2009 13:22:56 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MtSB3-0003rI-CA; Thu, 01 Oct 2009 22:23:01 +0200
Content-Disposition: inline
In-Reply-To: <20091001201648.GA12175@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129409>

This patch allows you to do things like for example

  $ git <cmd> -bn100

where -b is a boolean and -n is an integer option.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

 parse-options.c |    2 +-
 parse-options.h |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4f16f37..bfe01ee 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -48,7 +48,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 	const int unset = flags & OPT_UNSET;
 	int err;
 
-	if (many && !(opt->flags & PARSE_OPT_NOARG))
+	if (many && !(opt->flags & (PARSE_OPT_NOARG | PARSE_OPT_MANY)))
 		return opterror(opt, "must not be mangled with other options", flags);
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
diff --git a/parse-options.h b/parse-options.h
index f295a2c..33ce529 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -37,6 +37,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
 	PARSE_OPT_NEGHELP = 128,
+	PARSE_OPT_MANY = 256,
 };
 
 struct option;
@@ -84,6 +85,8 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *   PARSE_OPT_NEGHELP: says that the long option should always be shown with
  *				the --no prefix in the usage message. Sometimes
  *				useful for users of OPTION_NEGBIT.
+ *   PARSE_OPT_MANY: the short option may be mangled, despite a possible
+ *				argument.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK.
@@ -121,7 +124,7 @@ struct option {
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
-#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "n", (h) }
+#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "n", (h), PARSE_OPT_MANY }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
-- 
1.6.5.rc1.214.g13c5a

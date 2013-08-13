From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 08:05:30 -0400
Message-ID: <20130813120530.GA622@sigill.intra.peff.net>
References: <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net>
 <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net>
 <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
 <20130813114635.GA16506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 14:05:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9DM2-0004ll-58
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 14:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab3HMMFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 08:05:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:56022 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757659Ab3HMMFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 08:05:33 -0400
Received: (qmail 13977 invoked by uid 102); 13 Aug 2013 12:05:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Aug 2013 07:05:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Aug 2013 08:05:30 -0400
Content-Disposition: inline
In-Reply-To: <20130813114635.GA16506@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232222>

On Tue, Aug 13, 2013 at 07:46:35AM -0400, Jeff King wrote:

> The only downside I can think of is that we might want to use the
> subsection in "include.SUBSECTION.*" for some other limiting conditions
> (e.g., "only include this config when running version >= X.Y", or even
> "include only when environment variable FOO is true").
> 
> I guess we could do something like:
> 
>   [include "repo:...your regex here..."]
>     path = .gitconfig-only-for-some-repos
>   [include "env:USE_MY_MAGIC_CONFIG"]
>     path = .gitconfig-only-when-magic-env-set
> 
> Adding the "repo:" prefix for this repo-dir matching is pretty trivial.
> Adding a similar env-matching is only slightly less trivial; but does
> anybody actually want it?

Here it is with the "repo:" prefix, if you want to build on that.

Adding the "env" spec is as easy as doing this on top:


	diff --git a/config.c b/config.c
	index f1ca6fa..64ba141 100644
	--- a/config.c
	+++ b/config.c
	@@ -150,6 +150,8 @@ static int match_config_include(const char *spec)
	 	const char *val;
	 	if ((val = skip_prefix(spec, "repo:")))
	 		return match_repo_path(val);
	+	if ((val = skip_prefix(spec, "env:")))
	+		return git_env_bool(val, 0);
	 
	 	/* Unknown specs are considered "no match". */
	 	return 0;

---
diff --git a/config.c b/config.c
index e13a7b6..f1ca6fa 100644
--- a/config.c
+++ b/config.c
@@ -119,10 +119,55 @@ int git_config_include(const char *var, const char *value, void *data)
 	return ret;
 }
 
+static NORETURN void die_bad_regex(int err, regex_t *re)
+{
+	char errbuf[1024];
+	regerror(err, re, errbuf, sizeof(errbuf));
+	if (cf && cf->name)
+		die("bad regex (at %s:%d): %s", cf->name, cf->linenr, errbuf);
+	else
+		die("bad regex: %s", errbuf);
+}
+
+static int match_repo_path(const char *re_str)
+{
+	regex_t re;
+	int ret;
+	const char *repo_path;
+
+	ret = regcomp(&re, re_str, REG_EXTENDED);
+	if (ret)
+		die_bad_regex(ret, &re);
+
+	repo_path = absolute_path(get_git_dir());
+	ret = regexec(&re, repo_path, 0, NULL, 0);
+	regfree(&re);
+	return !ret;
+}
+
+static int match_config_include(const char *spec)
+{
+	const char *val;
+	if ((val = skip_prefix(spec, "repo:")))
+		return match_repo_path(val);
+
+	/* Unknown specs are considered "no match". */
+	return 0;
+}
+
+static int match_config_include_mem(const char *spec, int spec_len)
+{
+	char *spec_str = xmemdupz(spec, spec_len);
+	int ret = match_config_include(spec_str);
+	free(spec_str);
+	return ret;
+}
+
 int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
-	const char *type;
+	const char *match, *type;
+	int match_len;
 	int ret;
 
 	/*
@@ -133,8 +178,9 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	type = skip_prefix(var, "include.");
-	if (!type)
+	if (parse_config_key(var, "include", &match, &match_len, &type))
+		return ret;
+	if (match && !match_config_include_mem(match, match_len))
 		return ret;
 
 	if (!strcmp(type, "path"))

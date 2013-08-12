From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Mon, 12 Aug 2013 08:39:21 -0400
Message-ID: <20130812123921.GA16088@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 14:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8rPF-00023B-T9
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 14:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab3HLMjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 08:39:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:46855 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994Ab3HLMjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 08:39:24 -0400
Received: (qmail 13347 invoked by uid 102); 12 Aug 2013 12:39:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Aug 2013 07:39:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Aug 2013 08:39:21 -0400
Content-Disposition: inline
In-Reply-To: <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232187>

On Mon, Aug 12, 2013 at 09:52:45PM +1000, Andrew Ardill wrote:

> On 11 August 2013 02:58, Junio C Hamano <gitster@pobox.com> wrote:
> > Perhaps we need a lighter-weight mechanism
> >
> >         git init --profile=open
> >         git clone --profile=open git://git.kernel.org/git.git
> 
> This is something I would definitely use.
> 
> All of my work git directories are in a separate folder to my other
> git directories, and as such it would be extremely convenient if every
> repository under that folder defaulted to the same profile. That may
> be asking for too much though!

We could do something like the patch below, which allows:

  $ git config --global include./magic/.path .gitconfig-magic

to read ~/.gitconfig-magic only when we are in a repository with a
directory component "/magic/".

I can see how such a thing might be useful, even though I do not have a
use for that much flexibility myself. I find myself doing this trick for
things like editor settings, but not for git config. So do not count
this necessarily as a vote for doing this; it was a fun exercise for me
that others might find useful.

Comparing this against a "profile" type of solution:

  1. This handles only config, not full templates (so no custom hooks;
     however, we could provide a level of indirection for hooks inside
     the config).

  2. Unlike a profile that is used during repository init, this is
     resolved at runtime, so it keeps up to date as you change
     ~/.gitconfig-magic.

---
diff --git a/config.c b/config.c
index e13a7b6..a31dc85 100644
--- a/config.c
+++ b/config.c
@@ -119,10 +119,45 @@ int git_config_include(const char *var, const char *value, void *data)
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
+static int match_repo_path_mem(const char *re_buf, int len)
+{
+	char *re_str = xmemdupz(re_buf, len);
+	int ret = match_repo_path(re_str);
+	free(re_str);
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
@@ -133,8 +168,9 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	type = skip_prefix(var, "include.");
-	if (!type)
+	if (parse_config_key(var, "include", &match, &match_len, &type))
+		return ret;
+	if (match && !match_repo_path_mem(match, match_len))
 		return ret;
 
 	if (!strcmp(type, "path"))

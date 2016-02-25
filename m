From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 02:11:59 -0500
Message-ID: <20160225071159.GA22529@sigill.intra.peff.net>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <20160225014149.GA31616@sigill.intra.peff.net>
 <CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
 <20160225070036.GA5654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 08:12:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYq5v-0004Hc-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 08:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050AbcBYHMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 02:12:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:48874 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756834AbcBYHMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 02:12:09 -0500
Received: (qmail 18942 invoked by uid 102); 25 Feb 2016 07:12:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 02:12:02 -0500
Received: (qmail 17248 invoked by uid 107); 25 Feb 2016 07:12:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 02:12:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 02:11:59 -0500
Content-Disposition: inline
In-Reply-To: <20160225070036.GA5654@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287337>

On Thu, Feb 25, 2016 at 02:00:36AM -0500, Jeff King wrote:

> I think something like this would work:
> [...]
> but it does not seem to pass with your patch (even after I fixed up the
> weird "local" thing). I think the problem is that we ask
> submodule--helper to do the clone, and it uses local_repo_env. So in
> addition to your patch, you probably need a C version of the same thing
> which outputs to an argv_array.

Something like this (which passes my test, but I didn't think hard about
it beyond that):

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8b3320e..fa941fd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -124,6 +124,27 @@ static int module_name(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
+
+/* this (and submodule_config_ok) should be static in the original */
+int sanitize_submodule_config(const char *, const char *, void *);
+
+static void add_submodule_repo_env(struct argv_array *out)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
+			struct strbuf sanitized_config = STRBUF_INIT;
+			git_config_from_parameters(sanitize_submodule_config,
+						   &sanitized_config);
+			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
+			strbuf_release(&sanitized_config);
+		} else {
+			argv_array_push(out, *var);
+		}
+	}
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, const char *reference, int quiet)
 {
@@ -145,7 +166,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 	argv_array_push(&cp.args, path);
 
 	cp.git_cmd = 1;
-	cp.env = local_repo_env;
+	add_submodule_repo_env(&cp.env_array);
 	cp.no_stdin = 1;
 
 	return run_command(&cp);

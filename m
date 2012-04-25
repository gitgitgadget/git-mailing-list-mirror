From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] config: allow ~/ and ~user/ in include.path value
Date: Wed, 25 Apr 2012 08:00:36 -0400
Message-ID: <20120425120036.GB21579@sigill.intra.peff.net>
References: <1335265689-2270-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335292396-8502-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 25 14:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN0tp-0003ss-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 14:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021Ab2DYMAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 08:00:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44563
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758647Ab2DYMAk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 08:00:40 -0400
Received: (qmail 955 invoked by uid 107); 25 Apr 2012 12:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Apr 2012 08:00:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Apr 2012 08:00:36 -0400
Content-Disposition: inline
In-Reply-To: <1335292396-8502-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196313>

On Tue, Apr 24, 2012 at 08:33:16PM +0200, Matthieu Moy wrote:

> Subject: Re: [PATCH v2] config: allow ~/ and ~user/ in include.path value

It seems like such an obvious choice, I'm not sure why I didn't put it
in the initial implementation.

>  config.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

No docs or tests. :P

> -static int handle_path_include(const char *path, struct config_include_data *inc)
> +static int handle_path_include(const char *raw_path, struct config_include_data *inc)
>  {
>  	int ret = 0;
>  	struct strbuf buf = STRBUF_INIT;
> -
> +	int must_free_path = 1;
> +	char *path = expand_user_path(raw_path);
> +	if (!path)
> +		return error("Could not expand include path '%s'.", raw_path);
>  	/*
>  	 * Use an absolute path as-is, but interpret relative paths
>  	 * based on the including config file.
> @@ -52,6 +55,8 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>  		if (slash)
>  			strbuf_add(&buf, cf->name, slash - cf->name + 1);
>  		strbuf_addstr(&buf, path);
> +		free(path);
> +		must_free_path = 0;
>  		path = buf.buf;
>  	}
>  
> @@ -63,6 +68,8 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>  		inc->depth--;
>  	}
>  	strbuf_release(&buf);
> +	if (must_free_path)
> +		free(path);

Ugh. This must_free_path business in the middle was quite confusing for
me to read (and I think maybe for you to write, since you ended up with
a leak in the initial version).

If you just detach the strbuf buffer, then must_free_path can go away
(you must always free it then). But I think it is even simpler to just
keep the allocated bits in a separate variable. Patch is below, with
documentation updates and tests.

-Peff

-- >8 --
Subject: [PATCH] config: expand tildes in include.path variable

You can already use relative paths in include.path, which
means that including "foo" from your global "~/.gitconfig"
will look in your home directory. However, you might want to
do something clever like putting "~/.gitconfig-foo" in a
specific repository's config file.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt  |    5 ++++-
 config.c                  |    6 ++++++
 t/t1305-config-include.sh |    8 ++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb386ab..0b3f291 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -95,7 +95,9 @@ included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
 `include.path` variable is a relative path, the path is considered to be
 relative to the configuration file in which the include directive was
-found. See below for examples.
+found. The value of `include.path` is subject to tilde expansion: `~/`
+is expanded to the value of `$HOME`, and `~user/` to the specified
+user's home directory. See below for examples.
 
 Example
 ~~~~~~~
@@ -122,6 +124,7 @@ Example
 	[include]
 		path = /path/to/foo.inc ; include by absolute path
 		path = foo ; expand "foo" relative to the current file
+		path = ~/foo ; expand "foo" in your $HOME directory
 
 Variables
 ~~~~~~~~~
diff --git a/config.c b/config.c
index 68d3294..2bbf02d 100644
--- a/config.c
+++ b/config.c
@@ -37,6 +37,11 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 {
 	int ret = 0;
 	struct strbuf buf = STRBUF_INIT;
+	char *expanded = expand_user_path(path);
+
+	if (!expanded)
+		return error("Could not expand include path '%s'", path);
+	path = expanded;
 
 	/*
 	 * Use an absolute path as-is, but interpret relative paths
@@ -63,6 +68,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		inc->depth--;
 	}
 	strbuf_release(&buf);
+	free(expanded);
 	return ret;
 }
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 4b1cbaa..a707076 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -29,6 +29,14 @@ test_expect_success 'chained relative paths' '
 	test_cmp expect actual
 '
 
+test_expect_success 'include paths get tilde-expansion' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = ~/one" >.gitconfig &&
+	echo 1 >expect &&
+	git config test.one >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'include options can still be examined' '
 	echo "[test]one = 1" >one &&
 	echo "[include]path = one" >.gitconfig &&
-- 
1.7.9.6.11.gd9951

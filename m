From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: teach "git config --file -" to read from the
 standard input
Date: Tue, 18 Feb 2014 03:41:44 -0500
Message-ID: <20140218084144.GA2692@sigill.intra.peff.net>
References: <CAPig+cSRgpABwzC36FoBst52hCOPieMBTvsTx9CPFoHifHG9yg@mail.gmail.com>
 <1392552781-23275-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Tue Feb 18 09:41:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFgFS-00016O-JY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 09:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbaBRIlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 03:41:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:52508 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754135AbaBRIlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 03:41:45 -0500
Received: (qmail 20326 invoked by uid 102); 18 Feb 2014 08:41:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Feb 2014 02:41:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Feb 2014 03:41:44 -0500
Content-Disposition: inline
In-Reply-To: <1392552781-23275-1-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242281>

On Sun, Feb 16, 2014 at 02:13:01PM +0200, Kirill A. Shutemov wrote:

> The patch extends git config --file interface to allow read config from
> stdin.
> 
> Editing stdin or setting value in stdin is an error.
> 
> Include by absolute path is allowed in stdin config, but not by relative
> path.

Thanks, this looks very cleanly done.

One nit:

> diff --git a/config.c b/config.c
> index 6269da907964..7b42608f5c89 100644
> --- a/config.c
> +++ b/config.c
> @@ -443,10 +443,20 @@ static int git_parse_source(config_fn_t fn, void *data)
>  		if (get_value(fn, data, var) < 0)
>  			break;
>  	}
> -	if (cf->die_on_error)
> -		die("bad config file line %d in %s", cf->linenr, cf->name);
> -	else
> -		return error("bad config file line %d in %s", cf->linenr, cf->name);
> +	if (cf->die_on_error) {
> +		if (cf->name)
> +			die("bad config file line %d in %s",
> +					cf->linenr, cf->name);
> +		else
> +			die("bad config file line %d", cf->linenr);
> +
> +	} else {
> +		if (cf->name)
> +			return error("bad config file line %d in %s",
> +					cf->linenr, cf->name);
> +		else
> +			return error("bad config file line %d", cf->linenr);
> +	}

I think I preferred the earlier version where you had "<stdin>" in the
name field, and this hunk could just go away. I know you switched it to
NULL here to avoid making bogus relative filenames in includes.

But that would be pretty straightforward to fix by splitting the "name"
field into an additional "path" field. It looks like "git config --blob"
has the same problem (it will try relative lookups in the filesystem,
even though that is nonsensical from the blob). So we could fix the
existing bug at the same time. :)

Perhaps this could go at the start of your series?

-- >8 --
Subject: config: disallow relative include paths from blobs

When we see a relative config include like:

  [include]
  path = foo

we make it relative to the containing directory of the file
that contains the snippet. This makes no sense for config
read from a blob, as it is not on the filesystem.  Something
like "HEAD:some/path" could have a relative path within the
tree, but:

  1. It would not be part of include.path, which explicitly
     refers to the filesystem.

  2. It would need different parsing rules anyway to
     determine that it is a tree path.

The current code just uses the "name" field, which is wrong.
Let's split that into "name" and "path" fields, use the
latter for relative includes, and fill in only the former
for blobs.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't think we considered includes at all when adding --blob. I cannot
think of any good reason to have even an absolute filesystem include
from a blob. And I wonder if it is possible to cause security mischief
by convincing git to look at /etc/passwd or similar (it would not parse,
of course, but you might be able to glean information from the error
messages or something).

It's probably OK, though, because you would generally not read real
config from an untrusted source (there are many bad things they could
set), and other code which uses the config reader explicitly does not
turn on includes.

 config.c                  | 10 ++++++----
 t/t1305-config-include.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index d969a5a..b295310 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@ struct config_source {
 		} buf;
 	} u;
 	const char *name;
+	const char *path;
 	int die_on_error;
 	int linenr;
 	int eof;
@@ -97,12 +98,12 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cf || !cf->name)
+		if (!cf || !cf->path)
 			return error("relative config includes must come from files");
 
-		slash = find_last_dir_sep(cf->name);
+		slash = find_last_dir_sep(cf->path);
 		if (slash)
-			strbuf_add(&buf, cf->name, slash - cf->name + 1);
+			strbuf_add(&buf, cf->path, slash - cf->path + 1);
 		strbuf_addstr(&buf, path);
 		path = buf.buf;
 	}
@@ -1040,7 +1041,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		struct config_source top;
 
 		top.u.file = f;
-		top.name = filename;
+		top.name = top.path = filename;
 		top.die_on_error = 1;
 		top.do_fgetc = config_file_fgetc;
 		top.do_ungetc = config_file_ungetc;
@@ -1062,6 +1063,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.u.buf.len = len;
 	top.u.buf.pos = 0;
 	top.name = name;
+	top.path = NULL;
 	top.die_on_error = 0;
 	top.do_fgetc = config_buf_fgetc;
 	top.do_ungetc = config_buf_ungetc;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index a707076..6edd38b 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -122,6 +122,22 @@ test_expect_success 'relative includes from command line fail' '
 	test_must_fail git -c include.path=one config test.one
 '
 
+test_expect_success 'absolute includes from blobs work' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path=$(pwd)/one" >blob &&
+	blob=$(git hash-object -w blob) &&
+	echo 1 >expect &&
+	git config --blob=$blob test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative includes from blobs fail' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path=one" >blob &&
+	blob=$(git hash-object -w blob) &&
+	test_must_fail git config --blob=$blob test.one
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
1.8.5.2.500.g8060133

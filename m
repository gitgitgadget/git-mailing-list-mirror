From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2] convert filter: supply path to external driver
Date: Mon, 20 Dec 2010 08:09:11 -0800
Message-ID: <20101220160911.GA32136@honk.padd.com>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 17:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUiIZ-0005g0-7h
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 17:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab0LTQJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 11:09:13 -0500
Received: from honk.padd.com ([74.3.171.149]:34073 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757900Ab0LTQJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 11:09:12 -0500
Received: by honk.padd.com (Postfix, from userid 7770)
	id 436C427EE; Mon, 20 Dec 2010 08:09:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzks1e84p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163998>

Filtering to support keyword expansion may need the name of
the file being filtered.  In particular, to support p4 keywords
like

    $File: //depot/product/dir/script.sh $

the smudge filter needs to know the name of the file it is
smudging.

Add a "%s" conversion specifier to the gitattribute for filter.
It will be expanded with the path name to the file when invoking
the external filter command.  The path name is quoted and
special characters are escaped to prevent the shell from splitting
incorrectly.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
gitster@pobox.com wrote on Sun, 19 Dec 2010 13:59 -0800:
> This is not backward compatible for people who wanted to use '%' literal
> on their filter command line for whatever reason, so please do not
> advertise as such.  A fair argument you could make is "Even though this is
> not strictly backward compatible, it is very unlikely that people passed a
> literal % to their filter command line, and the benefit of being able to
> give the pathname information would outweigh the downside of not being
> compatible", and people can agree or disagree.

I overlooked that, but agree it is unlikely anyone was using % in
filter definitions.  Putting the path in an environment variable
is the other option I considered.

> I am personally moderately negative about $any expansion$ (I don't use it
> myself, and I don't think sane people use it either).  As far as I can
> tell, this should has no impact on the correctness and very little impact
> on the performance for people who do not use $any expansion$, so I am Ok
> with the patch.

Keyword expansion is indeed nasty.  My only motivation is to
support working with an upstream that relies on it.

This version of the patch handles quoting of shell
meta-characters, as pointed out by Hannes.  I decided to invoke
sq_quote_buf directly on the path before expanding %s, rather
than writing a dict entry to understand %'s.  There is no
requirement for users to use single-quotes around %s in their
config files, this way, either.

Also added a test case to make sure %s and quoting works as
advertised.

		-- Pete

 Documentation/gitattributes.txt |   12 ++++++++++
 convert.c                       |   22 +++++++++++++++++-
 t/t0021-conversion.sh           |   47 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..9ac2138 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -317,6 +317,18 @@ command is "cat").
 	smudge = cat
 ------------------------
 
+If your filter needs the path of the file it is working on,
+you can use the "%s" conversion specification.  It will be
+replaced with the relative path to the file.  This is important
+for keyword substitution that depends on the name of the
+file.  Like this:
+
+------------------------
+[filter "p4"]
+	clean = git-p4-filter --clean %s
+	smudge = git-p4-filter --smudge %s
+------------------------
+
 
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/convert.c b/convert.c
index e41a31e..1ef83a0 100644
--- a/convert.c
+++ b/convert.c
@@ -317,6 +317,7 @@ struct filter_params {
 	const char *src;
 	unsigned long size;
 	const char *cmd;
+	const char *path;
 };
 
 static int filter_buffer(int in, int out, void *data)
@@ -329,7 +330,23 @@ static int filter_buffer(int in, int out, void *data)
 	int write_err, status;
 	const char *argv[] = { NULL, NULL };
 
-	argv[0] = params->cmd;
+	/* replace optional %s with path */
+	struct strbuf cmd = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf_expand_dict_entry dict[] = {
+	    "s", NULL,
+	    NULL, NULL,
+	};
+
+	/* quote the path to preserve spaces, etc. */
+	sq_quote_buf(&path, params->path);
+	dict[0].value = path.buf;
+
+	/* expand all %s with the quoted path */
+	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
+	strbuf_release(&path);
+
+	argv[0] = cmd.buf;
 
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
@@ -349,6 +366,8 @@ static int filter_buffer(int in, int out, void *data)
 	status = finish_command(&child_process);
 	if (status)
 		error("external filter %s failed %d", params->cmd, status);
+
+	strbuf_release(&cmd);
 	return (write_err || status);
 }
 
@@ -376,6 +395,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	params.src = src;
 	params.size = len;
 	params.cmd = cmd;
+	params.path = path;
 
 	fflush(NULL);
 	if (start_async(&async))
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 828e35b..c5c394d 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -93,4 +93,51 @@ test_expect_success expanded_in_repo '
 	cmp expanded-keywords expected-output
 '
 
+cat <<EOF >argc.sh
+#!$SHELL_PATH
+echo argc: \$# "\$@"
+echo argc running >&2
+EOF
+chmod +x argc.sh
+
+#
+# The use of %s in a filter definition is expanded to the path to
+# the filename being smudged or cleaned.  It must be shell escaped.
+#
+test_expect_success 'shell-escaped filenames' '
+    norm=name-no-magic &&
+    spec=$(echo name:sgl\"dbl\ spc!bang | tr : \\047) &&
+    echo some test text > test
+    cat test > $norm &&
+    cat test > "$spec" &&
+    git add $norm &&
+    git add "$spec" &&
+    git commit -m "add files" &&
+
+    echo "name* filter=argc" > .gitattributes &&
+
+    # delete the files and check them out again, using the smudge filter
+    git config filter.argc.smudge "./argc.sh %s" &&
+    rm $norm "$spec" &&
+    git checkout -- $norm "$spec" &&
+
+    # make sure argc.sh counted the right number of args
+    echo "argc: 1 $norm" > res &&
+    cmp res $norm &&
+    echo "argc: 1 $spec" > res &&
+    cmp res "$spec" &&
+
+    # %s with other args
+    git config filter.argc.smudge "./argc.sh %s --myword" &&
+    rm $norm "$spec" &&
+    git checkout -- $norm "$spec" &&
+
+    # make sure argc.sh counted the right number of args
+    echo "argc: 2 $norm --myword" > res &&
+    cmp res $norm &&
+    echo "argc: 2 $spec --myword" > res &&
+    cmp res "$spec" &&
+    :
+'
+
 test_done
-- 
1.7.2.3

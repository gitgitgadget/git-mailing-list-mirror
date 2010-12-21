From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v3] convert filter: supply path to external driver
Date: Tue, 21 Dec 2010 05:44:03 -0800
Message-ID: <20101221134403.GA10401@honk.padd.com>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
 <20101220160911.GA32136@honk.padd.com>
 <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 14:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV2Vg-0000iY-7j
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 14:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0LUNoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 08:44:07 -0500
Received: from honk.padd.com ([74.3.171.149]:34369 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab0LUNoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 08:44:05 -0500
Received: by honk.padd.com (Postfix, from userid 7770)
	id 773212680; Tue, 21 Dec 2010 05:44:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164033>

Filtering to support keyword expansion may need the name of
the file being filtered.  In particular, to support p4 keywords
like

    $File: //depot/product/dir/script.sh $

the smudge filter needs to know the name of the file it is
smudging.

Add a "%f" conversion specifier to the gitattribute for filter.
It will be expanded with the path name to the file when invoking
the external filter command.  The path name is quoted and
special characters are escaped to prevent the shell from splitting
incorrectly.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
gitster@pobox.com wrote on Mon, 20 Dec 2010 09:59 -0800:
> Another nitpick is if 's' is the right letter to use for the pathname
> information.  I think you took 's' after "string", but if this is to be
> extensible, you should anticipate that later there will be other kinds of
> information you may want to throw at the filters, and expect that some of
> them also will be of type "string", and you will have painted the person
> who wants to add that new information into a tight corner as you already
> took the valuable 's'.
> 
> Which would suggest that you shouldn't be naming the placeholder after the
> type but after what the placeholder means, no?  Perhaps %f (for filename)
> would be a better choice?

Agree.  The "s" doesn't convey much meaning.  Nothing in
pretty-formats.txt really applies either, but "f" makes sense.

		-- Pete

 Documentation/gitattributes.txt |   12 ++++++++++
 convert.c                       |   22 +++++++++++++++++-
 t/t0021-conversion.sh           |   47 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..1afcf01 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -317,6 +317,18 @@ command is "cat").
 	smudge = cat
 ------------------------
 
+If your filter needs the path of the file it is working on,
+you can use the "%f" conversion specification.  It will be
+replaced with the relative path to the file.  This is important
+for keyword substitution that depends on the name of the
+file.  Like this:
+
+------------------------
+[filter "p4"]
+	clean = git-p4-filter --clean %f
+	smudge = git-p4-filter --smudge %f
+------------------------
+
 
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/convert.c b/convert.c
index e41a31e..8f020bc 100644
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
+	/* apply % substitution to cmd */
+	struct strbuf cmd = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf_expand_dict_entry dict[] = {
+	    "f", NULL,
+	    NULL, NULL,
+	};
+
+	/* quote the path to preserve spaces, etc. */
+	sq_quote_buf(&path, params->path);
+	dict[0].value = path.buf;
+
+	/* expand all %f with the quoted path */
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
index 828e35b..534a735 100755
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
+# The use of %f in a filter definition is expanded to the path to
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
+    git config filter.argc.smudge "./argc.sh %f" &&
+    rm $norm "$spec" &&
+    git checkout -- $norm "$spec" &&
+
+    # make sure argc.sh counted the right number of args
+    echo "argc: 1 $norm" > res &&
+    cmp res $norm &&
+    echo "argc: 1 $spec" > res &&
+    cmp res "$spec" &&
+
+    # %f with other args
+    git config filter.argc.smudge "./argc.sh %f --myword" &&
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

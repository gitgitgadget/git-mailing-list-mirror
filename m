From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v5] convert filter: supply path to external driver
Date: Wed, 22 Dec 2010 06:40:13 -0800
Message-ID: <20101222144013.GA22089@honk.padd.com>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
 <20101220160911.GA32136@honk.padd.com>
 <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
 <20101221134403.GA10401@honk.padd.com>
 <20101221181924.GB25812@burratino>
 <20101221203322.GA13868@honk.padd.com>
 <7vzkry7rb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 15:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVPrb-0008By-Ea
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 15:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab0LVOkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 09:40:15 -0500
Received: from honk.padd.com ([74.3.171.149]:60944 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010Ab0LVOkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 09:40:14 -0500
Received: by honk.padd.com (Postfix, from userid 7770)
	id 52A9B2144; Wed, 22 Dec 2010 06:40:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzkry7rb4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164086>

Filtering to support keyword expansion may need the name of
the file being filtered.  In particular, to support p4 keywords
like

    $File: //depot/product/dir/script.sh $

the smudge filter needs to know the name of the file it is
smudging.

Allow "%f" in the custom filter command line specified in the
configuration.  This will be substituted by the filename
inside a single-quote pair to be passed to the shell.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---

gitster@pobox.com wrote on Tue, 21 Dec 2010 13:24 -0800:
> [detailed review]

Changes from v4:
- Updated commit message, docs per Junio mods
- Removed space after shell redirection ">"
- Simplified test case per Junio recommendations

Hopefully this is the last round of review and it is
safe to stage now.  Thanks,

		-- Pete

 Documentation/gitattributes.txt |   10 +++++++++
 convert.c                       |   22 +++++++++++++++++++-
 t/t0021-conversion.sh           |   42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..8c2fdd1 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -317,6 +317,16 @@ command is "cat").
 	smudge = cat
 ------------------------
 
+Sequence "%f" on the filter command line is replaced with the name of
+the file the filter is working on.  A filter might use this in keyword
+substitution.  For example:
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
index 828e35b..aacfd00 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -93,4 +93,46 @@ test_expect_success expanded_in_repo '
 	cmp expanded-keywords expected-output
 '
 
+# The use of %f in a filter definition is expanded to the path to
+# the filename being smudged or cleaned.  It must be shell escaped.
+# First, set up some interesting file names and pet them in
+# .gitattributes.
+test_expect_success 'filter shell-escaped filenames' '
+	cat >argc.sh <<-EOF &&
+	#!$SHELL_PATH
+	echo argc: \$# "\$@"
+	EOF
+	normal=name-no-magic &&
+	special="name  with '\''sq'\'' and \$x" &&
+	echo some test text >"$normal" &&
+	echo some test text >"$special" &&
+	git add "$normal" "$special" &&
+	git commit -q -m "add files" &&
+	echo "name* filter=argc" >.gitattributes &&
+
+	# delete the files and check them out again, using a smudge filter
+	# that will count the args and echo the command-line back to us
+	git config filter.argc.smudge "sh ./argc.sh %f" &&
+	rm "$normal" "$special" &&
+	git checkout -- "$normal" "$special" &&
+
+	# make sure argc.sh counted the right number of args
+	echo "argc: 1 $normal" >expect &&
+	test_cmp expect "$normal" &&
+	echo "argc: 1 $special" >expect &&
+	test_cmp expect "$special" &&
+
+	# do the same thing, but with more args in the filter expression
+	git config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
+	rm "$normal" "$special" &&
+	git checkout -- "$normal" "$special" &&
+
+	# make sure argc.sh counted the right number of args
+	echo "argc: 2 $normal --my-extra-arg" >expect &&
+	test_cmp expect "$normal" &&
+	echo "argc: 2 $special --my-extra-arg" >expect &&
+	test_cmp expect "$special" &&
+	:
+'
+
 test_done
-- 
1.7.2.3

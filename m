From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] convert filter: supply path to external driver
Date: Sun, 19 Dec 2010 16:29:25 -0500
Message-ID: <20101219212925.GA7393@arf.padd.com>
References: <20101218223822.GA18902@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 19 22:29:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUQoy-00019C-Ad
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 22:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522Ab0LSV3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 16:29:33 -0500
Received: from honk.padd.com ([74.3.171.149]:52147 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932515Ab0LSV3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 16:29:33 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 428D8EE;
	Sun, 19 Dec 2010 13:29:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 563C331AD7; Sun, 19 Dec 2010 16:29:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20101218223822.GA18902@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163969>

Filtering to support keyword expansion may need the name of
the file being filtered.  In particular, to support p4 keywords
like

    $File: //depot/product/dir/script.sh $

the smudge filter needs to know the name of the file it is
smudging.

Add a "%s" conversion specifier to the gitattribute for filter.
It will be expanded with the path name to the file when invoking
the external filter command.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---

pw@padd.com wrote on Sat, 18 Dec 2010 17:38 -0500:
> I'm using git-p4 to import and work with upstream p4
> repositories.  Some of the files are ktext, meaning they expect
> expansion of $Id$ and similar identifiers.
> 
> Using the filter driver for this file, I can do the "clean" part
> easily, but to calculate the "smudge" correctly, I need to know
> the filename inside the filter driver.

This works fine for me.  It is backward compatible, and leaves
open the possibility of adding other % modifiers if we find
a need later.

I have a filter that handles all the p4 $Keyword$ expansions,
now, using this patch.  It can go into contrib if others would
find it useful.  This seriously reduces many hassles associated
with my git-p4 workflow, where a plethora of ancillary systems
rely on keyword expansion in the source.

Cc Junio for comments as the original author of convert filter
code.

		-- Pete


 Documentation/gitattributes.txt |   12 ++++++++++++
 convert.c                       |   15 ++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletions(-)

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
index e41a31e..d4c6ed1 100644
--- a/convert.c
+++ b/convert.c
@@ -317,6 +317,7 @@ struct filter_params {
 	const char *src;
 	unsigned long size;
 	const char *cmd;
+	const char *path;
 };
 
 static int filter_buffer(int in, int out, void *data)
@@ -329,7 +330,16 @@ static int filter_buffer(int in, int out, void *data)
 	int write_err, status;
 	const char *argv[] = { NULL, NULL };
 
-	argv[0] = params->cmd;
+	/* replace optional %s with path */
+	struct strbuf cmd = STRBUF_INIT;
+	struct strbuf_expand_dict_entry dict[] = {
+	    "s", params->path,
+	    NULL, NULL,
+	};
+
+	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
+
+	argv[0] = cmd.buf;
 
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
@@ -349,6 +359,8 @@ static int filter_buffer(int in, int out, void *data)
 	status = finish_command(&child_process);
 	if (status)
 		error("external filter %s failed %d", params->cmd, status);
+
+	strbuf_release(&cmd);
 	return (write_err || status);
 }
 
@@ -376,6 +388,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	params.src = src;
 	params.size = len;
 	params.cmd = cmd;
+	params.path = path;
 
 	fflush(NULL);
 	if (start_async(&async))
-- 
1.7.2.3

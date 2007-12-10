From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Mon, 10 Dec 2007 23:55:38 +0100
Message-ID: <200712102355.39084.jnareb@gmail.com>
References: <200712102332.53114.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 23:56:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1rXj-00020v-DN
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 23:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXLJWzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXLJWzp
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 17:55:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:60571 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbXLJWzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 17:55:45 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1119058nfb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=1mnJM77B3rxrGfUsBhJxYNXVqTeaCQkxMGfqIMr7EPo=;
        b=aOihx6xExW1q51WPZ4kPXBI/iWRDfWXFGQUJ5mzHhHNeo83jVzdAA4dq0PF+as6lRSMl9DuaWupCWJ5THC2PCW2XE7rm286bLfZHlr+IqvTbqelnOPs9zt7RPXYaTPjapEZ+9Jx2of5mH0iAyNmL3BNakxGdhAG3eR0FukvpFdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fxOREtp9ZngSAWosiRhHJrruDnZPOBOkoPer60SO5Pm8ONVm9CYh21NArkfqG7rqpTky00OowRr7v5JZ8KI0QP/Up4Nxf3S/REvrq2VVke+26Z4DAfOPGGtu6F9nFH6/26FgVLU1ZzRsz4iFyqyAzZ/HeUe2OWuHqYKgrkVai7Y=
Received: by 10.86.50.8 with SMTP id x8mr6008388fgx.1197327342600;
        Mon, 10 Dec 2007 14:55:42 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.16])
        by mx.google.com with ESMTPS id 12sm1021988fgg.2007.12.10.14.55.40
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 14:55:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712102332.53114.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67767>

"git diff --numstat" used the same format as "git diff --stat" for
renamed (and copied) files, except that filenames were not shortened
when they didn't fit in the column width.  This format is suitable for
human consumption, but it cannot be unambiguously parsed.

Instead of that always use final file name ("to" name) for numstat.
It is possible to find name before rename when name after is known.

This required to use pprint_rename (pretty print rename) during output
(in the show_stats function) and not during parsing (in diffstat_add
function).

Adding from_name field to struct diffstat_t makes is_renamed bitfield
redundant; nevertheless for the sake of clarity, readability and
making this patch minimal (and because it would not reduce memory
footprint) it was not removed, and its used not replaced by checking
from_name field.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Sorry for mistake: I have tested this commit, corrected it... and forgot
to update patch to send.


Previous version of this patch (from 7 May 2007) used instead of current
only "to_name" format similar to git-diff-tree raw format for renames:

  added deleted TAB path for "src" TAB path for "dst" LF
    
The problem was when -z option was used: how to separate end of record
from end of from_name and start of to_name. For git-diff we have status
to distinguish those; no such thing for numstat output. Previous version
of patch used (or was to use actually, because of error in the code)

  added deleted TAB path for "src" NUL NUL path for "dst" NUL

when -z option was used.
    
This is left now for future --numstat-extended option...

 diff.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index f780e3e..8039ac7 100644
--- a/diff.c
+++ b/diff.c
@@ -735,6 +735,7 @@ struct diffstat_t {
 	int alloc;
 	struct diffstat_file {
 		char *name;
+		char *from_name;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
@@ -755,11 +756,14 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 	}
 	diffstat->files[diffstat->nr++] = x;
 	if (name_b) {
-		x->name = pprint_rename(name_a, name_b);
+		x->from_name = xstrdup(name_a);
+		x->name      = xstrdup(name_b);
 		x->is_renamed = 1;
 	}
-	else
+	else {
+		x->from_name = NULL;
 		x->name = xstrdup(name_a);
+	}
 	return x;
 }
 
@@ -837,7 +841,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		struct diffstat_file *file = data->files[i];
 		int change = file->added + file->deleted;
 
-		if (!file->is_renamed) {  /* renames are already quoted by pprint_rename */
+		if (!file->is_renamed) {  /* renames will be quoted by pprint_rename */
 			struct strbuf buf;
 			strbuf_init(&buf, 0);
 			if (quote_c_style(file->name, &buf, NULL, 0)) {
@@ -846,6 +850,11 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 			} else {
 				strbuf_release(&buf);
 			}
+		} else {
+			char *qname = pprint_rename(file->from_name, file->name);
+			free(file->name);
+			free(file->from_name);
+			file->name = qname;
 		}
 
 		len = strlen(file->name);
@@ -982,12 +991,7 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", file->added, file->deleted);
-		if (!file->is_renamed) {
-			write_name_quoted(file->name, stdout, options->line_termination);
-		} else {
-			fputs(file->name, stdout);
-			putchar(options->line_termination);
-		}
+		write_name_quoted(file->name, stdout, options->line_termination);
 	}
 }
 
-- 
1.5.3.7

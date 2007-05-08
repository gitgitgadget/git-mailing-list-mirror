From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] diff: Make numstat machine friendly also for renames
Date: Tue,  8 May 2007 02:43:42 +0200
Message-ID: <11785850223782-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 02:39:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlDjr-0003sY-Uy
	for gcvg-git@gmane.org; Tue, 08 May 2007 02:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967563AbXEHAjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 20:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967562AbXEHAjX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 20:39:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:20014 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967570AbXEHAjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 20:39:20 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1784031nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 17:39:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=A24o2OemWE1WgoUhUnQspk0AaPCFJ0lNrcLMlFgJAJOGKT0f1UwTop8qPYHQndWl08p6H0AnPwDP5tdA3hH5PXfnKTdJPol4XB9qCE70BDbSX/c5TBe5SNrT6fHMSA2GtkAcDHnbqE66vHbGNrtU6vtXrh47zIbAbQtG2Vna7Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=MNyydDY5AO335dqPgh2cfNHxK0LSSmz30pHd8VK1B87reMcXNBYJWHvxPPV2Dr14KTIStw87IXxFgk57/wIfeORxj+UMQadHDUpi/I8NKjxqWugn7JzKrpA1UsuK+MAy+8AMzORpi2BL+9bQXD8kc2rCs8PNOM6SrBTUV4X0Uks=
Received: by 10.64.153.4 with SMTP id a4mr11132627qbe.1178584758751;
        Mon, 07 May 2007 17:39:18 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id f16sm6171924qba.2007.05.07.17.39.16;
        Mon, 07 May 2007 17:39:17 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l480hj4c000574;
	Tue, 8 May 2007 02:43:45 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l480hg9r000573;
	Tue, 8 May 2007 02:43:42 +0200
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46500>

Instead of saving human readable rename information in the 'name'
field when diffstat info is generated, do it when writing --stat
output. Change --numstat output to be machine friendly.

This makes result of git-diff --numstat more suitable for machines
also when renames are involved, by using format similar to the one for
renames in the raw diff format, instead of the format more suited for
humans.

The numstat format for rename is now

  added deleted TAB path for "src" TAB path for "dst" LF

or if -z option is used

  added deleted TAB path for "src" NUL NUL path for "dst" NUL

When -z option is not used, ", TAB, LF, and backslash characters in
pathnames are represented as \", \t, \n, and \\, respectively. If any
character needs to be quoted then pathnames are enclosed in double
quotes.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This change increases memory footprint a bit, as struct diffstat_file
is wider by sizeof(char *) wide field, which is NULL except for
renames.

I have thought about storing it using one pointer to fragment of
memory of the form "dst name \0 src name \0", but this trades a little
memory for CPU time.


The goal of this change is to make it possible to generate HTML
diffstat against first parent for merge commits in gitweb. The current
notation for renames, which looks for example like below:

  t/{t6030-bisect-run.sh => t6030-bisect-porcelain.sh}

is not easy to parse by machines (note that filename may contain
"=>"), but easy to understand _usually_ by humans.


P.S. By the way, what is the difference between quote_one and
quote_c_style, i.e. when one calls one and when the other?


 diff.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 7bbe759..568c59b 100644
--- a/diff.c
+++ b/diff.c
@@ -703,6 +703,7 @@ struct diffstat_t {
 	int alloc;
 	struct diffstat_file {
 		char *name;
+		char *from_name;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
@@ -722,12 +723,13 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 				diffstat->alloc * sizeof(x));
 	}
 	diffstat->files[diffstat->nr++] = x;
+	x->name = xstrdup(name_a);
 	if (name_b) {
-		x->name = pprint_rename(name_a, name_b);
+		x->from_name = xstrdup(name_b);
 		x->is_renamed = 1;
 	}
 	else
-		x->name = xstrdup(name_a);
+		x->from_name = NULL;
 	return x;
 }
 
@@ -805,7 +807,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		struct diffstat_file *file = data->files[i];
 		int change = file->added + file->deleted;
 
-		if (!file->is_renamed) {  /* renames are already quoted by pprint_rename */
+		if (!file->is_renamed) {  /* renames are quoted by pprint_rename */
 			len = quote_c_style(file->name, NULL, NULL, 0);
 			if (len) {
 				char *qname = xmalloc(len + 1);
@@ -813,6 +815,10 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 				free(file->name);
 				file->name = qname;
 			}
+		} else {
+			char *qname = pprint_rename(file->name, file->from_name);
+			free(file->name);
+			file->name = qname;
 		}
 
 		len = strlen(file->name);
@@ -949,11 +955,19 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", file->added, file->deleted);
-		if (options->line_termination && !file->is_renamed &&
+		if (options->line_termination &&
 		    quote_c_style(file->name, NULL, NULL, 0))
 			quote_c_style(file->name, NULL, stdout, 0);
 		else
 			fputs(file->name, stdout);
+		if (file->is_renamed) {
+			printf("%s", options->line_termination ? "\t" : "\0\0");
+			if (options->line_termination &&
+			    quote_c_style(file->from_name, NULL, NULL, 0))
+				quote_c_style(file->from_name, NULL, stdout, 0);
+			else
+				fputs(file->from_name, stdout);
+		}
 		putchar(options->line_termination);
 	}
 }
-- 
1.5.1.3

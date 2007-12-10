From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] diff: Make numstat machine friendly also for renames (and copies)
Date: Mon, 10 Dec 2007 23:32:51 +0100
Message-ID: <200712102332.53114.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 23:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1rC6-0001VS-1Y
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 23:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbXLJWdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 17:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbXLJWdK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 17:33:10 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:31594 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbXLJWdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 17:33:06 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2811774mue
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 14:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Rg8nvJq3uDBQ29UgbPuTt9Sex5Gx1aW2k17nt1AxWao=;
        b=tktek3nJqXenA1WIpG0p4PQ54tJQLwl57VndRdJRz8b4eOpXOGj7Mr8P1KMLk04mVjZObP57T2m1P/0clLHPmmKBjxP+gBWrb0knOw82x49ELqIEWnxq4ZFrjGX7yUFaef4IMl6MQHLsk0O+UBYQ1uyHq+lxDztAapUDz5qIsqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EE7kCp/xcVfCikbt6fEBvuMtZ2Ae0uOhu5HrKzcW7T356AqyjduLcH/HtebgIMCqbt4yqpOf5s/7gXv5YJZzXZNdvEG/waZM+N2mFC2zPjYc4TAKiEfwoJHIpqqtMVRiVjoygt1M08JynRXHm44tMnm9w0oXfh7FvfyTBhLzG60=
Received: by 10.82.145.7 with SMTP id s7mr8188682bud.1197325983770;
        Mon, 10 Dec 2007 14:33:03 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.16])
        by mx.google.com with ESMTPS id i5sm9451664mue.2007.12.10.14.32.59
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 14:33:00 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67764>

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
This would be useful for gitweb, later.

I hope I have made it in time before feature freeze...

 diff.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index f780e3e..38b9367 100644
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
-- 
1.5.3.7

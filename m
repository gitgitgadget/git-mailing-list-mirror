From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 3/4] fast-import: add option command
Date: Wed, 12 Aug 2009 22:09:45 -0700
Message-ID: <1250140186-12363-4-git-send-email-srabbelier@gmail.com>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com>
 <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
 <1250140186-12363-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSaM-0001rC-RA
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbZHMFKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbZHMFK0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:10:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:1751 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbZHMFKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:10:22 -0400
Received: by rv-out-0506.google.com with SMTP id f6so169015rvb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 22:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=grXm+lI2leuNKer5gvzqUE3dqDJ5OXbtBq2g6MDjt5M=;
        b=oVq02ZYYoYyYoCofDCAP/2MY3CqGS0iITxnKZ42KdL5akPJ4ghER3sHsgopMLYQtj5
         ssMJeBpdV68GzC4hELK/k7wBNYiqZPfE1tWMtYnfjBI92o8G/S0dCPEoQQY1L34AnIN+
         h0oj7cJX7fMaSOPKOlHgiWfrxNeYepk5Jq2Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mwtvbowhf0w2ry0Ietyhut2/YjtIa5Rshzqoi496MZfvM21j6rioSphNolaYA2mlTQ
         KMWZSgDFzaDO42mQ3MvsB9YkqvzRW5mTj/nZuCLg6YnTZNzfsSrWnI3rASglVL7fHFG2
         nStGNsfpyNQ61Rb9zf6n21N3GBEisuSIcr1Nk=
Received: by 10.140.225.17 with SMTP id x17mr389870rvg.47.1250140224422;
        Wed, 12 Aug 2009 22:10:24 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm6740240rvb.20.2009.08.12.22.10.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 22:10:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250140186-12363-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125781>

This allows the frontend to specify any of the supported options as
long as no non-option command has been given. This way the
user does not have to include any frontend-specific options, but
instead she can rely on the frontend to tell fast-import what it
needs.
---

    This is a lot simpler from the previous version as we can now
    reuse parse_one_option from 1/4.

 fast-import.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 17d57ab..2ec804d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -348,6 +348,7 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static int seen_non_option_command;
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1663,6 +1664,10 @@ static int read_next_command(void)
 			if (stdin_eof)
 				return EOF;
 
+			if (!seen_non_option_command
+				&& prefixcmp(command_buf.buf, "option "))
+				seen_non_option_command = 1;
+
 			rc = rc_free;
 			if (rc)
 				rc_free = rc->next;
@@ -2460,6 +2465,16 @@ static void parse_one_option(const char *option)
     }
 }
 
+static void parse_option(void)
+{
+    char* option = command_buf.buf + 7;
+
+	if (seen_non_option_command)
+		die("Got option command '%s' after non-option command", option);
+
+    parse_one_option(option);
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2534,6 +2549,8 @@ int main(int argc, const char **argv)
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
 			parse_progress();
+		else if (!prefixcmp(command_buf.buf, "option "))
+			parse_option();
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
-- 
1.6.4.16.g72c66.dirty

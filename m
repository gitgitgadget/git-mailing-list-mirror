From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Mon, 17 Nov 2014 17:40:28 -0800
Message-ID: <20141118014028.GF4336@google.com>
References: <20141118003426.GA6528@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 02:40:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXmS-00027T-2J
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbaKRBk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:40:28 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:51387 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbaKRBk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:40:27 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so3382369igb.11
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ctg/vDOlecHizU69gtmKeDWufy8wBehxbXcbKvbcoZ8=;
        b=VSNQy2/n4wTG35O8lqW0MPnszXdfeSJkvs4U9igRspTHL661v5CWYrT/NShxwMWRub
         3ZIf7vGth6mZ1mdjePL6B4e4Ox52yPdCAJtHg0fZs6mUf2e9OCG8fwwAjXRJFAyogP4m
         VdijUDgyvJdDWWw4ZDRNQeRxOyY4wb841ikS4Ih9uPmfnFeVA2ntaz3iJ84Lgi+wwr9d
         R/8BQOcqxBKwBHEZx/NddQPafPQCVn+wUbm2fipmguFz2PAmwbsucJxbe4V7ND3IgT/v
         csOzzDZkqbs37vEcr7rInmsc5b5/Ui2J0X9fZCRYVjZH6d3i6Xx+1IlRuuYOyWl5adrh
         X+1g==
X-Received: by 10.42.25.204 with SMTP id b12mr31162637icc.14.1416274826883;
        Mon, 17 Nov 2014 17:40:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id 131sm19793504ioo.8.2014.11.17.17.40.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:40:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118003426.GA6528@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey wrote:

> - fast-import's `ls` command documentation about its output format
>   mentions that the output may contain commits, so I tried the trick of
>   creating a tree with commits, but fast-import then fails with:
>     fatal: Not a blob (actually a commit)
>   which I totally understand, but then I wonder why the documentation
>   mentions it and how one would get a tree containing references to
>   commits. I guess the documentation should be fixed.

Odd.  Here's what happens when I try:

 $ echo "ls $(git rev-parse HEAD)" | git fast-import --quiet
 fatal: Missing space after tree-ish: ls a4a226a366ab0a173ed9e5f70f2a95d0d21e54c5
 fast-import: dumping crash report to .git/fast_import_crash_14080
 $ echo "ls $(git rev-parse HEAD) " | git fast-import --quiet
 040000 tree d3d38e7d71cb40ebbaf2798b01837b3de43fd4a1

How did you get that "Not a blob" message?

I think a good fix would be to teach parse_ls a mode with no <path>
parameter.  Something like this (untested; needs cleanup and tests):

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/fast-import.c w/fast-import.c
index d0bd285..a9a46be 100644
--- i/fast-import.c
+++ w/fast-import.c
@@ -278,6 +278,8 @@ struct recent_command {
 	char *buf;
 };
 
+extern const char *tag_type;
+
 /* Configured limits on output */
 static unsigned long max_depth = 10;
 static off_t max_packsize;
@@ -3047,6 +3049,49 @@ static void parse_ls(const char *p, struct branch *b)
 	struct tree_entry *root = NULL;
 	struct tree_entry leaf = {NULL};
 
+	/* ls SP <tree-ish> */
+	if (*p != '"' && !strchr(p, ' ')) {
+		unsigned char sha1[20];
+		struct object_entry *e;
+		static struct strbuf line = STRBUF_INIT;
+		const char *type;
+
+		if (*p == ':') {	/* <mark> */
+			e = find_mark(parse_mark_ref_eol(p));
+			if (!e)
+				die("Unknown mark: %s", command_buf.buf);
+			hashcpy(sha1, e->idx.sha1);
+		} else {	/* <sha1> */
+			if (get_sha1_hex(p, sha1))
+				die("Invalid dataref: %s", command_buf.buf);
+			e = find_object(sha1);
+			p += 40;
+			if (*p)
+				die("Garbage after dataref: %s", command_buf.buf);
+		}
+
+		switch (e->type) {
+		case OBJ_COMMIT:
+			type = commit_type;
+			break;
+		case OBJ_TREE:
+			type = tree_type;
+			break;
+		case OBJ_BLOB:
+			type = blob_type;
+			break;
+		case OBJ_TAG:
+			type = tag_type;
+			break;
+		default:
+			die("Not a tree-ish: %s", command_buf.buf);
+		}
+
+		strbuf_reset(&line);
+		strbuf_addf(&line, "%s %s\n", type, sha1_to_hex(sha1));
+		cat_blob_write(line.buf, line.len);
+	}
+
 	/* ls SP (<tree-ish> SP)? <path> */
 	if (*p == '"') {
 		if (!b)

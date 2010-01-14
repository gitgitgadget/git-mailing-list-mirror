From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v3] fast-import: tag may point to any object type
Date: Thu, 14 Jan 2010 07:44:19 +0300
Message-ID: <20100114044419.GE10586@dpotapov.dyndns.org>
References: <1263186165-23920-1-git-send-email-dpotapov@gmail.com>
 <20100111171454.GO32155@spearce.org>
 <20100113123532.GC10586@dpotapov.dyndns.org>
 <20100113172456.GB18625@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 05:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVHb5-0002ls-UG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 05:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab0ANEqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 23:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262Ab0ANEqL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 23:46:11 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:57983 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0ANEqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 23:46:10 -0500
Received: by fxm25 with SMTP id 25so138095fxm.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 20:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EDhxterRwdMBkziUPRVH1v5FhcF2e41zXCZRrzg2JiM=;
        b=WYT5MtkBME3AUvNZWdy3bCgzu10cTSeme5qHmZ16jFt4w6HLVvp4sRir3QpI1RvEGG
         CBRsqkxqm6roPmr+1fH8HB5orsp93xcvP2fGsVe2hNe4IpXElbh2FDH0ZGvCV0ZvU2cl
         pSvUgelvK+IBekezzVg2goMh8fwCeeH8SE+S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vdrUqYjjXj/sFAMMyH1TMZ4cWLuSCPRVdIRR5fYf4DdBpOjGJqg/Ccfm1UvPymUtGQ
         qX/nBDMU1qBhp+j7UFCSC9+wAEmPZ7prbC8kQAV6Tpvx3RQnfUDwI79DnKnOQmYs+en0
         wH4hyYqMUqv/KHqmpaNp0VZZxOX+SIjG/d+TU=
Received: by 10.87.64.27 with SMTP id r27mr385759fgk.29.1263444369213;
        Wed, 13 Jan 2010 20:46:09 -0800 (PST)
Received: from localhost (ppp91-77-224-149.pppoe.mtu-net.ru [91.77.224.149])
        by mx.google.com with ESMTPS id 16sm130416fxm.8.2010.01.13.20.46.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 20:46:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100113172456.GB18625@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136925>

If you tried to export the official git repository, and then to import it
back then git-fast-import would die complaining that "Mark :1 not a commit".

Accordingly to a generated crash file, Mark 1 is not a commit but a blob,
which is pointed by junio-gpg-pub tag. Because git-tag allows to create such
tags, git-fast-import should import them.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---

On Wed, Jan 13, 2010 at 09:24:56AM -0800, Shawn O. Pearce wrote:
> Dmitry Potapov <dpotapov@gmail.com> wrote:
> >  
> > +		type = sha1_object_info(sha1, NULL);
> >  		buf = read_object_with_reference(sha1,
> > -			commit_type, &size, sha1);
> > +			typename(type), &size, sha1);
> 
> This is better spelled as:
> 
>   buf = read_sha1_file(sha1, &type, &size);

Thank you for correction.

> 
> But otherwise the patch looks correct now, thanks.
> 
> If you could make this one change, add my
> 
>   Acked-by: Shawn O. Pearce <spearce@spearce.org>
> 
> and resend so Junio can apply, thanks.

 fast-import.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cd87049..60d0aa2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2305,6 +2305,7 @@ static void parse_new_tag(void)
 	struct tag *t;
 	uintmax_t from_mark = 0;
 	unsigned char sha1[20];
+	enum object_type type;
 
 	/* Obtain the new tag name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2325,19 +2326,18 @@ static void parse_new_tag(void)
 	s = lookup_branch(from);
 	if (s) {
 		hashcpy(sha1, s->sha1);
+		type = OBJ_COMMIT;
 	} else if (*from == ':') {
 		struct object_entry *oe;
 		from_mark = strtoumax(from + 1, NULL, 10);
 		oe = find_mark(from_mark);
-		if (oe->type != OBJ_COMMIT)
-			die("Mark :%" PRIuMAX " not a commit", from_mark);
+		type = oe->type;
 		hashcpy(sha1, oe->sha1);
 	} else if (!get_sha1(from, sha1)) {
 		unsigned long size;
 		char *buf;
 
-		buf = read_object_with_reference(sha1,
-			commit_type, &size, sha1);
+		buf = read_sha1_file(sha1, &type, &size);
 		if (!buf || size < 46)
 			die("Not a valid commit: %s", from);
 		free(buf);
@@ -2362,7 +2362,7 @@ static void parse_new_tag(void)
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n",
-		    sha1_to_hex(sha1), commit_type, t->name);
+		    sha1_to_hex(sha1), typename(type), t->name);
 	if (tagger)
 		strbuf_addf(&new_data,
 			    "tagger %s\n", tagger);
-- 
1.6.6.137.g1acb

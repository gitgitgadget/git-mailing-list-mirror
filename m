From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] fast-import: tag may point to any object type
Date: Wed, 13 Jan 2010 15:35:32 +0300
Message-ID: <20100113123532.GC10586@dpotapov.dyndns.org>
References: <1263186165-23920-1-git-send-email-dpotapov@gmail.com>
 <20100111171454.GO32155@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:37:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV2TT-0007th-Em
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 13:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab0AMMhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 07:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262Ab0AMMhM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 07:37:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:17840 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0AMMhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 07:37:11 -0500
Received: by fg-out-1718.google.com with SMTP id 19so27783fgg.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 04:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0/sz5tVT2bq1cvR1Vq8nGT3kyTLJwBXTqAY+w0lqvFU=;
        b=JGSTSmL4TE6+csZual2EDJ28FnyPHlrKYqGKNaYrLP/w4+WTWn93zzMM0LPDr2bVCg
         Iv1xLUivJtdF9hd1L7YGMldQkvWc3kgKFPClnlzutKa7y+m/EAHjtdcou/6qtCaKlm/L
         hXg1U5rx8/LOJ1gENaQeaTBo08XlEsSkLmYKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pp//GI/Z+1MuEyUE+VPkT5oS4bcW57P/9zKxfPLNOWoNkHmjV4W8TYYzbGrYHDRRTV
         QBjxRcMKP3mkO906skD7ZNN9jF3n4SeGqUL3fJL/lf/p9d4KRMqNtrSdEWmJmTnVH18G
         S7+qmE10VcKs5/PUhtRdvd1DIXeNTOJa/xgGs=
Received: by 10.87.47.37 with SMTP id z37mr605059fgj.9.1263386229623;
        Wed, 13 Jan 2010 04:37:09 -0800 (PST)
Received: from localhost (ppp91-77-224-149.pppoe.mtu-net.ru [91.77.224.149])
        by mx.google.com with ESMTPS id l19sm3855635fgb.23.2010.01.13.04.37.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 04:37:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100111171454.GO32155@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136812>

If you tried to export the official git repository, and then to import it
back then git-fast-import would die complaining that "Mark :1 not a commit".

Accordingly to a generated crash file, Mark 1 is not a commit but a blob,
which is pointed by junio-gpg-pub tag. Because git-tag allows to create such
tags, git-fast-import should import them.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Mon, Jan 11, 2010 at 09:14:54AM -0800, Shawn O. Pearce wrote:
> 
> Your patch is the right idea.  But you need to make sure all of
> the branch arms are handled correctly.
> 
> That is, if we do this, the get_sha1() on line 2459 should also
> permit non-commit objects, and the lookup_branch() earlier up on
> line 2451 should do "type = OBJ_COMMIT".

Thank you for guideliness. I do not understand this code well.
I hope I got it right this time.

 fast-import.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cd87049..4fdf809 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2305,6 +2305,7 @@ static void parse_new_tag(void)
 	struct tag *t;
 	uintmax_t from_mark = 0;
 	unsigned char sha1[20];
+	enum object_type type;
 
 	/* Obtain the new tag name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2325,19 +2326,20 @@ static void parse_new_tag(void)
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
 
+		type = sha1_object_info(sha1, NULL);
 		buf = read_object_with_reference(sha1,
-			commit_type, &size, sha1);
+			typename(type), &size, sha1);
 		if (!buf || size < 46)
 			die("Not a valid commit: %s", from);
 		free(buf);
@@ -2362,7 +2364,7 @@ static void parse_new_tag(void)
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

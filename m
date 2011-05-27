From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] vcs-svn: guard against overflow when computing preimage
 length
Date: Fri, 27 May 2011 06:12:33 -0500
Message-ID: <20110527111233.GD7972@elie>
References: <BANLkTi=O9AeOZTHVLbq+rKv5k-CqNGb+LQ@mail.gmail.com>
 <BANLkTinpta+a4MAr0e2YtMa1Kr1QcJmYWg@mail.gmail.com>
 <20110525235520.GA6971@elie>
 <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
 <20110527110828.GA7972@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri May 27 13:12:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPuyB-0003s1-Ms
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 13:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab1E0LMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 07:12:39 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48090 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab1E0LMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 07:12:38 -0400
Received: by iyb14 with SMTP id 14so1283719iyb.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 04:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lP7S8YTupp2Ej/BIB1XAGdASZsHsMDISPKzgjRzs5uY=;
        b=bulfKxQPyVInDggpazfWVryT6Ci55cuvATaPlEQUKqZ8lIK6m8MymbCt0+hIZIBaBO
         b4Tx18GEdm473JP2t22TT6r9lYHo+VGbtntaaMWWbUnuun3iqln4apjWv9V0Aexfdify
         ypGwWnRQE8+QKpOJW7XDNWdAyzxOQ1+ymsx1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VQxtBHgeaF0d+EeFeDEwqbisjQFD6Ft+jo/cxEoOBOPYRWJjvYDPa7O9xxHmg1Riwd
         7Tr13eEosrASn188UDpp9xSmrOsskdfbSDvFcRMEAmALFp2VsVmvG234U9ucaBzl/sQl
         uSoziYB5AJqsUDa0E1ZFiJlBTHrRaHTXIm7oc=
Received: by 10.42.239.138 with SMTP id kw10mr3075762icb.417.1306494757932;
        Fri, 27 May 2011 04:12:37 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id gb8sm490534ibb.9.2011.05.27.04.12.36
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 04:12:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110527110828.GA7972@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174608>

Signed integer overflow produces undefined behavior in C and off_t is
a signed type.  For predictable behavior, add some checks to protect
in advance against overflow.

On 32-bit systems, ftell as called by buffer_tmpfile_prepare_to_read
is likely to fail with EOVERFLOW when reading the corresponding
postimage, and this patch does not change that.  So this is more of a
futureproofing measure than a complete fix.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index edc658d..96a75d5 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -166,6 +166,7 @@ static int ends_with(const char *s, size_t len, const char *suffix)
 static int parse_cat_response_line(const char *header, off_t *len)
 {
 	size_t headerlen = strlen(header);
+	uintmax_t n;
 	const char *type;
 	const char *end;
 
@@ -174,14 +175,25 @@ static int parse_cat_response_line(const char *header, off_t *len)
 	type = memmem(header, headerlen, " blob ", strlen(" blob "));
 	if (!type)
 		return error("cat-blob header has wrong object type: %s", header);
-	*len = strtoumax(type + strlen(" blob "), (char **) &end, 10);
+	n = strtoumax(type + strlen(" blob "), (char **) &end, 10);
 	if (end == type + strlen(" blob "))
 		return error("cat-blob header does not contain length: %s", header);
+	if (memchr(type + strlen(" blob "), '-', end - type - strlen(" blob ")))
+		return error("cat-blob header contains negative length: %s", header);
+	if (n == UINTMAX_MAX || n > maximum_signed_value_of_type(off_t))
+		return error("blob too large for current definition of off_t");
+	*len = n;
 	if (*end)
 		return error("cat-blob header contains garbage after length: %s", header);
 	return 0;
 }
 
+static void check_preimage_overflow(off_t a, off_t b)
+{
+	if (signed_add_overflows(a, b))
+		die("blob too large for current definition of off_t");
+}
+
 static long apply_delta(off_t len, struct line_buffer *input,
 			const char *old_data, uint32_t old_mode)
 {
@@ -204,6 +216,7 @@ static long apply_delta(off_t len, struct line_buffer *input,
 	}
 	if (old_mode == REPO_MODE_LNK) {
 		strbuf_addstr(&preimage.buf, "link ");
+		check_preimage_overflow(preimage_len, strlen("link "));
 		preimage_len += strlen("link ");
 	}
 	if (svndiff0_apply(input, len, &preimage, out))
-- 
1.7.5.1

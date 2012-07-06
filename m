From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] vcs-svn: suppress a signed/unsigned comparison warning
Date: Fri, 6 Jul 2012 12:25:28 -0500
Message-ID: <20120706172528.GI31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:25:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnCHk-0002hi-GU
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab2GFRZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:25:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38461 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab2GFRZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:25:32 -0400
Received: by yhmm54 with SMTP id m54so9634271yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Dx0Fd1oUPm8koCVXUB+dflJ1KuRrGYN6kWztTvSyhJ0=;
        b=08j4mJymlsqajixzLaj3Wv2pXdDD8O5gkdfLBFYZgOKpOxk3VMzzPokRproWiI3TQ8
         ook23BZhP1VcqPV6GxDD2LSzItKiJG+iJmnt41y0Y/FAc2hQOVkj5dtOlIfNTPjHWuFt
         9nn//lrPbCBQ4+zFnTf1t7A2yIC0KEPLFKxlEqSIigm5AFxsDiIYqH0U58AH5IOx0/NC
         V3ltlV5sccHsMMzvXYHBpi3AlbfeQIP+RqGhFcg/bGQfNd+cptYu1rZoYvYEuZIj4V1+
         EyWwMyhD5K1yh/x5Tbgndd/MwNdYKyMFNg7UCIOsz/Zob3BD+E4iKjkRA7Yhp5gV5fOA
         WsTA==
Received: by 10.50.89.130 with SMTP id bo2mr3164580igb.19.1341595532188;
        Fri, 06 Jul 2012 10:25:32 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nh1sm2834650igc.11.2012.07.06.10.25.31
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:25:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201133>

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Thu, 5 Jul 2012 22:21:09 -0500

All callers pass a nonnegative delta_len, so the code is already safe.
Add an assertion to ensure that remains so and add a cast to keep
clang and gcc -Wsign-compare from worrying.

Reported-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
v2 suppressed the warning by casting "len" to an off_t, producing an
unintentional change (breakage) in functionality on 64-bit systems
when "len" is large.

This version is longer but more conservative.

 vcs-svn/svndiff.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index e810d0c3..74c97c45 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -77,8 +77,9 @@ static int error_short_read(struct line_buffer *input)
 static int read_chunk(struct line_buffer *delta, off_t *delta_len,
 		      struct strbuf *buf, size_t len)
 {
+	assert(*delta_len >= 0);
 	strbuf_reset(buf);
-	if (len > *delta_len ||
+	if (len > (uintmax_t) *delta_len ||
 	    buffer_read_binary(delta, buf, len) != len)
 		return error_short_read(delta);
 	*delta_len -= buf->len;
@@ -290,7 +291,7 @@ error_out:
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 			struct sliding_view *preimage, FILE *postimage)
 {
-	assert(delta && preimage && postimage);
+	assert(delta && preimage && postimage && delta_len >= 0);
 
 	if (read_magic(delta, &delta_len))
 		return -1;
-- 
1.7.10.4

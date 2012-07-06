From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] vcs-svn: simplify cleanup in apply_one_window
Date: Fri, 6 Jul 2012 12:18:00 -0500
Message-ID: <20120706171759.GD31001@burratino>
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
X-From: git-owner@vger.kernel.org Fri Jul 06 19:18:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnCAX-0005Fx-Ph
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758025Ab2GFRSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:18:06 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41204 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab2GFRSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:18:04 -0400
Received: by gglu4 with SMTP id u4so8828594ggl.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uTRsw6YlRgg6r37/7Hf0fuZ9Nvp8f/8etAmA+ImGnhQ=;
        b=RarISRHYH2CPCVsoUSRot+ikvDl+qRQSFfxJiEq/i4Jja5/s5LjnBMNHLRYwuAsxQz
         kNZibYYYLFHjxFHcmu/uDF9cTx3kwSGrv+AiCsXFDrUKxzUg8+YpJcAKlHn5RiVrvybG
         jtAxR+MKUmaqi8bqzh0sQXwlPFoXXKrr1CtnnybtR9/InNhDN0iXiSWfhJTMfnsfZPH2
         IdSw2maguhKRXwpcf/x84uouA3zh+qvHYugn2X6MmaaFDZR9SzJaZgXSCoTwk1fEHj3u
         2KR+Ogtki54yGQmfQhJB8iw8rsv2UuvsUgO60HmfaiftHRVYx8Ens90ZHRRFWbxdD7ZU
         2Zaw==
Received: by 10.50.140.70 with SMTP id re6mr3152254igb.23.1341595083746;
        Fri, 06 Jul 2012 10:18:03 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g5sm2829018ign.4.2012.07.06.10.18.03
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:18:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201127>

From: David Barr <davidbarr@google.com>
Date: Fri, 1 Jun 2012 00:41:26 +1000

Currently the cleanup code looks like this:

	free resources
	return 0;
 error_out:
	free resources
	return -1;

Avoid duplicating the "free resources" part by keeping the return
value in a variable and sharing code between the success and
exceptional case:

	ret = 0;
 out:
	free resources
	return ret;

Noticed in the svn-dump-fast-export project, where using the error()
macro in void context produces a warning.

Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v2:
 - new description

 vcs-svn/svndiff.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index c89d9623..e810d0c3 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -258,6 +258,7 @@ static int apply_window_in_core(struct window *ctx)
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 			    struct sliding_view *preimage, FILE *out)
 {
+	int rv = -1;
 	struct window ctx = WINDOW_INIT(preimage);
 	size_t out_len;
 	size_t instructions_len;
@@ -275,16 +276,15 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 	if (apply_window_in_core(&ctx))
 		goto error_out;
 	if (ctx.out.len != out_len) {
-		error("invalid delta: incorrect postimage length");
+		rv = error("invalid delta: incorrect postimage length");
 		goto error_out;
 	}
 	if (write_strbuf(&ctx.out, out))
 		goto error_out;
-	window_release(&ctx);
-	return 0;
+	rv = 0;
 error_out:
 	window_release(&ctx);
-	return -1;
+	return rv;
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-- 
1.7.10.4

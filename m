From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 05/11] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Sun, 27 Jan 2013 18:21:48 -0800
Message-ID: <20130128022148.GG8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-6-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:22:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzeMT-000081-JY
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab3A1CV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:21:56 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51785 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab3A1CVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:21:55 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1225517pad.30
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 18:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Gt1vQ0ozfpjX5m6VOqGlrqoWh/BEXkIuKhGmpN8AL1w=;
        b=bMQcZAObJBG8oWQgoDZdMxyee4JbyLdu1bDQUCTgPCFVQswVBjT/KfUqxHP8VHWLAB
         FvpSnyv5lqlMp737uk8aPSPPSV7ARtw37I0Hdxd12HQuKZu1KTshmA3MxPVi70LNBTJZ
         9++1Un6lUOQQo1VI6TZI6T6AsLTDSxVnW+K2Z+Xfuf6Qa1HCkBRefzSVi7aYoV4JHKxf
         eHHrvgdPcD4h7/Gj6GPiZk5h931dlQoEk5zTmOcx5xC/Beuo1xk5KW9ubzOpMLpOUzdF
         xMEbBkSknBog4w4VEj+Qo7Z3MMQn2F0zHhXirrzJVenS02WXtP2nqHS3qTLUdLLnhx9d
         4dsQ==
X-Received: by 10.68.238.165 with SMTP id vl5mr34244209pbc.0.1359339714891;
        Sun, 27 Jan 2013 18:21:54 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a1sm5728768pav.2.2013.01.27.18.21.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 18:21:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-6-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214788>

Brandon Casey wrote:

> Let's detect "(cherry picked from...)" as part of the footer so that we
> will produce this:
>
>    Signed-off-by: A U Thor <author@example.com>
>    (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>    Signed-off-by: C O Mmitter <committer@example.com>
>
> instead of this:
>
>    Signed-off-by: A U Thor <author@example.com>
>    (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>
>    Signed-off-by: C O Mmitter <committer@example.com>

Here's the tweak I suggested last time.  I think its behavior is
slightly better in the "ends with incomplete line" case because it
limits the characters examined by is_rfc2822_line() and
is_cherry_picked_from_line() not to include buf[len] (which would
presumably sometimes be '\0').

diff --git i/sequencer.c w/sequencer.c
index 0b5cd18c..fa29c7c5 100644
--- i/sequencer.c
+++ w/sequencer.c
@@ -1043,9 +1043,7 @@ static int is_cherry_picked_from_line(const char *buf, int len)
 	/*
 	 * We only care that it looks roughly like (cherry picked from ...)
 	 */
-	return !prefixcmp(buf, cherry_picked_prefix) &&
-		(buf[len - 1] == ')' ||
-		 (buf[len - 1] == '\n' && buf[len - 2] == ')'));
+	return !prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
 }
 
 static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
@@ -1072,8 +1070,8 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		if (!(is_rfc2822_line(buf + i, k - i) ||
-			is_cherry_picked_from_line(buf + i, k - i)))
+		if (!is_rfc2822_line(buf + i, k - i - 1) &&
+		    !is_cherry_picked_from_line(buf + i, k - i - 1))
 			return 0;
 	}
 	return 1;

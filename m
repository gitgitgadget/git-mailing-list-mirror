From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 05/11] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Sun, 27 Jan 2013 18:51:41 -0800
Message-ID: <20130128025140.GI8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-6-git-send-email-drafnel@gmail.com>
 <20130128022148.GG8206@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:52:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzepO-0008TW-4O
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab3A1Cvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:51:48 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43076 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab3A1Cvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:51:47 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1227696pad.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 18:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fVQDNb0LN/++CWEjFvZ5kxtFszEakfPyjfIYpAtRhvo=;
        b=ySi/dCzPQUXgL07EkDVQdbExIFT4ORc9mjHEl3vwDdrtvrwqGVLxeNYaMVDDzI9qmJ
         Cmmbt5xEThXjolmW+vTTh2DXxPT8+G/GVlaB870ZQCr1bOuVzfBb9GcJu+MuvV5GlKoH
         t1Lh5Fc6fxNLWrdjpvFSvyKk8OQzF5ss0bTCWNY09fQJYtY7aJ8uO7kTnINHzCgZ97/T
         ocoAwayNUzTHOevpr7YZYmBFmTs5hcOCm58/Xia3lYQO97pZAPWYjCg1rLHhjK8wJeJg
         5E3yFcRELJGI7QUMCpouzCGyfbwgDv2vRD1E9s1n4qZdEa67oq5+UaV7hHH2RwxGtFPG
         6bzQ==
X-Received: by 10.68.238.39 with SMTP id vh7mr34349123pbc.6.1359341507137;
        Sun, 27 Jan 2013 18:51:47 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a1sm5775807pav.2.2013.01.27.18.51.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 18:51:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130128022148.GG8206@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214792>

Jonathan Nieder wrote:

> Here's the tweak I suggested last time.  I think its behavior is
> slightly better in the "ends with incomplete line" case because it
> limits the characters examined by is_rfc2822_line() and
> is_cherry_picked_from_line() not to include buf[len] (which would
> presumably sometimes be '\0').

Whoops, that revealed a subtlety --- the '\n' or '\0' is what prevents
exiting the loop in is_rfc2822_line when the line does not contain a
colon.  Here's a corrected version of the tweak, that should actually
work. :)

diff --git i/sequencer.c w/sequencer.c
index 0b5cd18c..108ea27b 100644
--- i/sequencer.c
+++ w/sequencer.c
@@ -1029,13 +1029,11 @@ static int is_rfc2822_line(const char *buf, int len)
 	for (i = 0; i < len; i++) {
 		int ch = buf[i];
 		if (ch == ':')
+			return 1;
+		if (!isalnum(ch) && ch != '-')
 			break;
-		if (isalnum(ch) || (ch == '-'))
-			continue;
-		return 0;
 	}
-
-	return 1;
+	return 0;
 }
 
 static int is_cherry_picked_from_line(const char *buf, int len)
@@ -1043,9 +1041,7 @@ static int is_cherry_picked_from_line(const char *buf, int len)
 	/*
 	 * We only care that it looks roughly like (cherry picked from ...)
 	 */
-	return !prefixcmp(buf, cherry_picked_prefix) &&
-		(buf[len - 1] == ')' ||
-		 (buf[len - 1] == '\n' && buf[len - 2] == ')'));
+	return !prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
 }
 
 static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
@@ -1072,8 +1068,8 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		if (!(is_rfc2822_line(buf + i, k - i) ||
-			is_cherry_picked_from_line(buf + i, k - i)))
+		if (!is_rfc2822_line(buf + i, k - i - 1) &&
+		    !is_cherry_picked_from_line(buf + i, k - i - 1))
 			return 0;
 	}
 	return 1;

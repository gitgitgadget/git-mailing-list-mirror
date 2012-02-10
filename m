From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Thu, 9 Feb 2012 16:00:20 -0800
Message-ID: <20120210000020.GA21092@tgrennan-laptop>
References: <1328816616-18124-1-git-send-email-tmgrennan@gmail.com>
 <1328816616-18124-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:00:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvdug-0000bK-3l
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758499Ab2BJAAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 19:00:25 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:34834 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab2BJAAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 19:00:25 -0500
Received: by qafk1 with SMTP id k1so1561251qaf.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lcXoa1Zv4M7BIIifdb+SO8ixcBZ4T71woMiybTDgFe4=;
        b=GRV/1OWrzQA/VTckrl8tGmKSnPIaLMG/5wsStt3Cya1fE9Im/vKwIco3m64nyngykN
         wQ1+TRDDXJrnuYHx9e0wRPa0H30C28cpvtfLF0nJNfXWoWQxEKlZAXkq2f6g/MnEEe5B
         o/1qSZ3spOLeA9EP6pZxLLl00Gu86gJa/5260=
Received: by 10.229.135.130 with SMTP id n2mr2520754qct.127.1328832024406;
        Thu, 09 Feb 2012 16:00:24 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id j17sm9015323qaj.9.2012.02.09.16.00.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 16:00:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328816616-18124-2-git-send-email-tmgrennan@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190346>

On Thu, Feb 09, 2012 at 11:43:36AM -0800, Tom Grennan wrote:
>Use the "!" prefix to ignore tags of the given pattern.
>This has precedence over other matching patterns.
>For example,
...

> static int match_pattern(const char **patterns, const char *ref)
> {
>+	int ret;
>+
> 	/* no pattern means match everything */
> 	if (!*patterns)
> 		return 1;
>-	for (; *patterns; patterns++)
>-		if (!fnmatch(*patterns, ref, 0))
>-			return 1;
>-	return 0;
>+	for (ret = 0; *patterns; patterns++)
>+		if (**patterns == '!') {
>+		    if (!fnmatch(*patterns+1, ref, 0))
>+			    return 0;
>+		} else if (!fnmatch(*patterns, ref, 0))
>+			ret = 1;
>+	return ret;
> }

Correction, match_pattern() needs to be as follows to support all these cases,
  $ git tag -l
  $ git tag -l \!*-rc?
  $ git tag -l \!*-rc? v1.7.8*
  $ git tag -l v1.7.8* \!*-rc?
  $ git tag -l v1.7.8*

-- 
TomG

diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..e99be5c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -32,13 +32,16 @@ struct tag_filter {
 
 static int match_pattern(const char **patterns, const char *ref)
 {
-	/* no pattern means match everything */
-	if (!*patterns)
-		return 1;
+	int had_match_pattern = 0, had_match = 0;
+
 	for (; *patterns; patterns++)
-		if (!fnmatch(*patterns, ref, 0))
-			return 1;
-	return 0;
+		if (**patterns != '!') {
+			had_match_pattern = 1;
+			if (!fnmatch(*patterns, ref, 0))
+				had_match = 1;
+		} else if (!fnmatch(*patterns+1, ref, 0))
+			return 0;
+	return had_match_pattern ? had_match : 1;
 }
 
 static int in_commit_list(const struct commit_list *want, struct commit *c)

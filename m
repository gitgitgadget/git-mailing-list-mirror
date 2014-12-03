From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/14] hold_lock_file_for_update: pass error message back
 through a strbuf
Date: Wed, 3 Dec 2014 10:53:03 -0800
Message-ID: <20141203185303.GB31609@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203052602.GV6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:53:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwF35-00063d-3a
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbaLCSxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 13:53:10 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:44696 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaLCSxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:53:09 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so13292588igb.11
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 10:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LpuFohoROwgg+dNxKpG6rI4Kz5eAa27+ge2lNwF7gCM=;
        b=Bfsgo7eBeHwONGUaC+hfSNDl0bB14X8cITbj6DRr7IFd16DKPzAI/hK3zAdy4w0n01
         mJ/wQPxE3AagqiEIHo9pArNceWX/65LB78empMEekpTGRwyz+xzsMGxj1lfnRNAXhpmp
         FNdFn99CQLp5gIjPxz1SzrcCVY/UOQh1Gwtm1LSN9fH84C8vQ7uf6noA3FTtoRRGI8OC
         S0A1VETQFJnhorrgomj85q2Lm4LFDIx+oZaw8/XRshrRyRvBDHN2evyx8Hqnw5KGo7ah
         XxUpJXyRHij2mx+xbNUgP8bEnLxfaozJOwvZmje+WcDr5a2Y/BY4NnIdvlqGj3l8/nGc
         BfRQ==
X-Received: by 10.107.41.148 with SMTP id p142mr5876934iop.64.1417632788833;
        Wed, 03 Dec 2014 10:53:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id o8sm13979812igh.18.2014.12.03.10.53.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 10:53:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203052602.GV6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260678>

Jonathan Nieder wrote:

> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -55,13 +55,17 @@ static void print_line(struct strbuf *buf)
>  static void rewrite_credential_file(const char *fn, struct credential *c,
>  				    struct strbuf *extra)
>  {
> -	hold_lock_file_for_update(&credential_lock, fn,
> -				  LOCK_DIE_ON_ERROR | LOCK_OUTSIDE_REPOSITORY);
> +	struct strbuf err = STRBUF_INIT;
> +
> +	if (hold_lock_file_for_update(&credential_lock, fn,
> +				      LOCK_OUTSIDE_REPOSITORY, &err) < 0);
> +		die("%s", err.buf);

I forgot to squash this in.  Sorry for the confusion.  (I'm planning to
reroll with this and the commit clarification tboegi mentioned --- other
comments welcome before then.)

-- >8 --
Subject: fixup! hold_lock_file_for_update: pass error message back through a strbuf

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 credential-store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential-store.c b/credential-store.c
index beffa87..2d5d92f 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -58,7 +58,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 	struct strbuf err = STRBUF_INIT;
 
 	if (hold_lock_file_for_update(&credential_lock, fn,
-				      LOCK_OUTSIDE_REPOSITORY, &err) < 0);
+				      LOCK_OUTSIDE_REPOSITORY, &err) < 0)
 		die("%s", err.buf);
 	if (extra)
 		print_line(extra);

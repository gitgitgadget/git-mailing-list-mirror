From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:13:55 -0700
Message-ID: <20130325221355.GH1414@google.com>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Weinberger <richard@nod.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFew-0004dI-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758993Ab3CYWOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:14:02 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40381 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758655Ab3CYWOA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:14:00 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so2729002pde.18
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OziIOIQgKgRZd4q2EH7VAC6lHG8BadG4XCDK3qkRMNU=;
        b=VxY9enluBsjbETx/FyG590rrv82zu+kSmho9elvObAIVHS0U9bdw7ivmgGOZurYn8F
         yvsTwSyDWCzzc/89b9D+mGiKk5L/lF7TMdmZythycCoQB0GsJbRp2q/MXqjS5hhzF7H8
         8UqExiGZJGlEK6uXk9ebLdeSFjFKNSBIQ9tw00ShPsJ464UfDcG23DYcmycWKCl/zSzD
         Vo33QXuVhk6YGjLE2e+HA14VBtRG9iOeqnUz7nIfp8CqZvbU6X3Taca2v7XP8gNQ+U7A
         IYKmxdF6UCtahkxi61tZSxNpw996mJQMdb/8zPwsau0CpC/ehZ5VUGH8d9qHgc9HtNFG
         FZ5g==
X-Received: by 10.68.96.129 with SMTP id ds1mr19571930pbb.204.1364249640351;
        Mon, 25 Mar 2013 15:14:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id yp2sm3948505pab.10.2013.03.25.15.13.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 15:13:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219108>

Junio C Hamano wrote:

>                                                            I do not
> know how things will break when the end user sets and exports it to
> the environment, and I do not think we would want to make any
> promise on how it works.

That's a reasonable desire, and it means it's a good thing we noticed
this before the envvar escaped to "master".  People *will* use such
exposed interfaces unless they are clearly marked as internal.  That's
just a fact of life.

Here's a rough patch to hopefully improve matters.

Longer term, it would be nice to have something like
GIT_IMPLICIT_WORK_TREE exposed to let scripts cache the result of the
search for .git.  Maybe something like "GIT_BARE=(arbitrary value)"
would be a good interface.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

diff --git a/cache.h b/cache.h
index 59e5b53..8f92b6d 100644
--- a/cache.h
+++ b/cache.h
@@ -377,7 +377,7 @@ static inline enum object_type object_type(unsigned int mode)
  * of this, but we use it internally to communicate to sub-processes that we
  * are in a bare repo. If not set, defaults to true.
  */
-#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
+#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_INTERNAL_IMPLICIT_WORK_TREE"
 
 /*
  * Repository-local GIT_* environment variables; these will be cleared

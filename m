From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Sat, 30 Mar 2013 08:40:24 +0700
Message-ID: <20130330014024.GA9025@lanh>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
 <20130329120539.GA20711@sigill.intra.peff.net>
 <20130329130230.GA25861@lanh>
 <7vli96p34f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 02:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULkmo-0001gN-2N
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 02:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483Ab3C3BkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 21:40:21 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:54143 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab3C3BkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 21:40:20 -0400
Received: by mail-pb0-f54.google.com with SMTP id rq13so431515pbb.41
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RXIHsZjUsH2PpbcptdxTqFtfCo4aY/BSuE9I5POgvhE=;
        b=HIvOjaRRm4Afj31EipQ2Yl0I06sdq/ljASfUdF6oRk3VBBX9cHflCAV3tR73Un+xtQ
         AG2oH8CoF24QDO27TguZp87KT5cs7N+8iz46Tt6BOH1Y7fwPfNVS6WWRvt4vn3ciTb+r
         HR6/nN8E/PxLXvD7gc9Rl7oLdw3hqZ2aoCLJ5UNxV5im3sOgZFzO5+b//UYkZncnVWCR
         VWCXouKWocG+fEAoyWIMO2BqO7zIcotq4ITGJhXemPxw7lZoYDlW3h9UZ/wmtTNwKdLi
         1JzG6RsRhBdFnvZw7h1RRJoWPyZNE1yPu3Isxykxeost8zTC2bEEqCWscWIx1v6tX5aC
         EPZQ==
X-Received: by 10.68.136.197 with SMTP id qc5mr6520460pbb.28.1364607619686;
        Fri, 29 Mar 2013 18:40:19 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id ef3sm5363292pad.20.2013.03.29.18.40.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Mar 2013 18:40:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 08:40:24 +0700
Content-Disposition: inline
In-Reply-To: <7vli96p34f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219548>

On Fri, Mar 29, 2013 at 09:44:32AM -0700, Junio C Hamano wrote:
> I tend to think in the longer term it may be a good idea to build
> with USE_WILDMATCH unconditionally (we can lose compat/fnmatch), so
> in the end this may not matter that much

I was thinking about that yesterday. After all, it's the purpose of
USE_WILDMATCH and nd/retire-fnmatch series. So how about this patch to
enable USE_WILDMATCH for a wider audience? I think it could get merged
down to master. If wildmatch's bug history is messy by the time we
enter rc cycles, we could revert the patch and cut new releases with
fnmatch. If not, after 1.9 is released, I'll submit a patch to remove
fnmatch compatiblity later and we will be on wildmatch only.

-- 8< --
diff --git a/Makefile b/Makefile
index 598d631..8a740f8 100644
--- a/Makefile
+++ b/Makefile
@@ -106,7 +106,7 @@ all::
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
 # FNM_CASEFOLD GNU extension.
 #
-# Define USE_WILDMATCH if you want to use Git's wildmatch
+# Define NO_USE_WILDMATCH if you do not want to use Git's wildmatch
 # implementation as fnmatch
 #
 # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
@@ -1255,7 +1255,7 @@ ifdef NO_FNMATCH_CASEFOLD
 	COMPAT_OBJS += compat/fnmatch/fnmatch.o
 endif
 endif
-ifdef USE_WILDMATCH
+ifndef NO_USE_WILDMATCH
 	COMPAT_CFLAGS += -DUSE_WILDMATCH
 endif
 ifdef NO_SETENV
-- 8< --

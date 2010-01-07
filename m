From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] Makefile: clear list of default rules
Date: Thu, 7 Jan 2010 01:18:25 -0600
Message-ID: <20100107071824.GC11777@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20100101090550.6117@nanako3.lavabit.com>
 <20100107071305.GA11777@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 08:18:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSmdZ-0007tw-3v
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 08:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab0AGHSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 02:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391Ab0AGHSY
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 02:18:24 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:54177 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab0AGHSX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 02:18:23 -0500
Received: by iwn32 with SMTP id 32so2175172iwn.33
        for <multiple recipients>; Wed, 06 Jan 2010 23:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=f1PmYm3e18ruI/Gp5Nrz3uMqRtaR5oXdzLQ+8Kz3938=;
        b=uJUSn31gIRUlnjqy0uvd7CK54TNJMYIvO+iMc1krEnaWQkM/xWqSuz71Qj1DBqRVsB
         fdZJM1YxqymfAF5b7jwZlLuDhzkvmFik8fWHFazjaNRGXenRjTb6FHAbGdNW9TNqPxIL
         S1HKHpH3DsxNA6aO9His6U4ROOpkwTmnLdQeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QbHqCST5ayV8cvkA7Sl5E/Zno0hEnEQt00kgSU2ORsAK67Cd2zYlfhWfq/aUfjl67N
         RnxuZWWFKUdy5xpAb/twwONiAbaxsaysTRQLl+AgQu/kQZAnH4mrbwBeizIUZVcj3m69
         2wf3ctqFobQd/3ODhIQUa3q07L7Bit0GXWqUE=
Received: by 10.231.125.13 with SMTP id w13mr8338ibr.32.1262848702661;
        Wed, 06 Jan 2010 23:18:22 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm20302156iwn.8.2010.01.06.23.18.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 23:18:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100107071305.GA11777@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136329>

The git makefile never uses any default implicit rules.  If a
prerequisite for one of the intended rules is missing, a default
rule can be used in its place:

	$ make var.s
	    CC var.s
	$ rm var.c
	$ make var.o
	    as   -o var.o var.s

Avoiding the default rules increases performance and avoids
hard-to-debug behaviour.  Especially, once the scope of the
%.o: %.c pattern rule is restricted, we should not fall back
to the default %.o: %.c pattern rule.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
'make -d' reveals that GNU make still ponders the default rules with
this patch applied, though at least it does not use them any more.  Is
it possible to set something like the make '-r' option from within a
makefile?

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index fa08535..9a5d897 100644
--- a/Makefile
+++ b/Makefile
@@ -1635,6 +1635,8 @@ GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) git.o http.o http-walker.o \
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 
+.SUFFIXES:
+
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
-- 
1.6.6.rc2

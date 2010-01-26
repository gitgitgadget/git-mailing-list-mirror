From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/12] Makefile: disable default implicit rules
Date: Tue, 26 Jan 2010 09:51:24 -0600
Message-ID: <20100126155124.GI4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnhX-0003UT-5T
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab0AZPvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840Ab0AZPva
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:51:30 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35049 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab0AZPva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:51:30 -0500
Received: by yxe17 with SMTP id 17so3738302yxe.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0yFLCYvKZq114eKd0MDghgGXevERFW7ztHCxNgixX4o=;
        b=i2M9ynMOZUbr/GrNrn5n9b/9A9/YAy/Q/eYPji+4nbMnIt5jCyMVUGWFLYiKZz3LFE
         zKlaP+Rhz3jTOtqX8M2i+VAeS9y2G/ZIQH+XeNyGTGmS5lST365VEDw8Qd9+QTWBhBUw
         UqmMMEShIGD4glTjoewctbKLO3raLfE4XvTaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kqbjD2IRQK7H+OFgmSBvZtshjGpqGrae1hpkb5Bdn+kKCWV3jdJKr0yzZfVilGwEY/
         UgsuZbgaNPjxvM20BfzM0HHaOZ9IwaUOYoXpFYHNOKGZLQgm/Wfl9i+TTXIrseee0DdF
         USQ1mqQl9ZlBJD7ZVYiHQkqhTYTg7MnviREok=
Received: by 10.150.46.30 with SMTP id t30mr6994973ybt.286.1264521082344;
        Tue, 26 Jan 2010 07:51:22 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm6141173iwn.8.2010.01.26.07.51.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:51:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138048>

The git makefile never uses any default implicit rules.
Unfortunately, if a prerequisite for one of the intended rules is
missing, a default rule can be used in its place:

	$ make var.s
	    CC var.s
	$ rm var.c
	$ make var.o
	    as   -o var.o var.s

Avoiding the default rules avoids this hard-to-debug behavior.
It also should speed things up a little in the normal case.

Future patches may restrict the scope of the %.o: %.c pattern.
This patch would then ensure that for targets not listed, we do
not fall back to the default rule.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sadly, this does not really speed things up in the normal case.
I am not sure why, but make needs the -r option to avoid
considering the default rules, even though clearing the .SUFFIXES:
guarantees it will never use them.

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 84ce137..60ef711 100644
--- a/Makefile
+++ b/Makefile
@@ -1672,6 +1672,8 @@ GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(TEST_OBJS) \
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 
+.SUFFIXES:
+
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
-- 
1.6.6

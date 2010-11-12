From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 20:16:02 -0600
Message-ID: <20101112021602.GA10765@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
 <20101111190508.GA3038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 12 03:17:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGjCX-0000lv-OE
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 03:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab0KLCQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 21:16:33 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37181 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab0KLCQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 21:16:33 -0500
Received: by qwi4 with SMTP id 4so544146qwi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 18:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8J6/80M6YE4ikhyiprPk59Y5y2s1u8n/u7CQP4hcbrY=;
        b=Y0u2SKD91qrQQwg3lyzN0Yyy6zkANKQP/bCTtqFOsI5jKcPjb2kWV8rDsSDRxRKWN+
         Grd65k1ruD9moPSk5NynYIT86x1t4/hHPWJBfUa+uTqm5gDUqdH1r48Rj5dRNWC124LK
         vKjEdGBxG6gf9Y4t6Yu62BstWYK+Wgnk7+uJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tSuTEPLV9347pYPgrnsX+o8btcLLwS0buddoafWUHcuRonS/eS77XEVwAOOijZskE4
         qzu6PiNtZd7gosa8iZMwGYWj5XGHhLWuhhD4arWDEqaRypsV6VlVsk3dUWOBzFzKdFjP
         G30eqWEzGbaxRbe5Q276oEODVsMJHHjXwJ2cA=
Received: by 10.229.246.73 with SMTP id lx9mr1376128qcb.231.1289528192258;
        Thu, 11 Nov 2010 18:16:32 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm2553196qcb.39.2010.11.11.18.16.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 18:16:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101111190508.GA3038@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161317>

Jeff King wrote:

> I don't think your patch is the right solution, but FWIW, sigchain was
> explicitly intended to be able to take SIG_DFL and SIG_IGN. Probably
> sigchain_fun should be removed and we should just use sighandler_t
> explicitly

Sorry, that was lazy of me.  The name sighandler_t is a GNU extension[1].

The following addresses my confusion but I doubt it's worth the
syntactic ugliness.

-- 8< --
Subject: sigchain: hide sigchain_fun type

Signal handlers that might be passed to signal() must be pointers to
function with the prototype

	void handler(int signum);

In glibc this type is called sighandler_t; in the sigchain lib,
sigchain_fun.

These really represent the same type in all respects: even special
values like SIG_IGN and SIG_DFL are perfectly reasonable arguments
for a function accepting values of one of the two types.  Avoid
confusion by eliminating the sigchain_fun name from sigchain.h.

It would be nice to instead use sighandler_t everywhere, but
unfortunately that name is a GNU extension.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 [1] http://www.delorie.com/gnu/docs/glibc/libc_481.html

 sigchain.c |    2 ++
 sigchain.h |    6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sigchain.h b/sigchain.h
index 618083b..571d148 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -1,11 +1,9 @@
 #ifndef SIGCHAIN_H
 #define SIGCHAIN_H
 
-typedef void (*sigchain_fun)(int);
-
-int sigchain_push(int sig, sigchain_fun f);
+int sigchain_push(int sig, void (*f)(int));
 int sigchain_pop(int sig);
 
-void sigchain_push_common(sigchain_fun f);
+void sigchain_push_common(void (*f)(int));
 
 #endif /* SIGCHAIN_H */
diff --git a/sigchain.c b/sigchain.c
index 1118b99..f837f61 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -3,6 +3,8 @@
 
 #define SIGCHAIN_MAX_SIGNALS 32
 
+typedef void (*sigchain_fun)(int);
+
 struct sigchain_signal {
 	sigchain_fun *old;
 	int n;

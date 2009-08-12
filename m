From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH 2/6] transport_get(): Don't SEGFAULT on missing url
Date: Thu, 13 Aug 2009 01:39:10 +0200
Message-ID: <200908130139.10876.johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
 <1249985426-13726-3-git-send-email-johan@herland.net>
 <7vab24wtzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	benji@silverinsanity.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 01:39:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbNPp-0003Wz-1A
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 01:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZHLXjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 19:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbZHLXjO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 19:39:14 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55053 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750934AbZHLXjO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 19:39:14 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA00404F1DET30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 01:39:13 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA00BHVF1BF1A0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 01:39:13 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.12.232716
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <7vab24wtzo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125757>

On Thursday 13 August 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Signed-off-by: Johan Herland <johan@herland.net>
>
> How does url end up to be NULL?  At the beginning of transport_get(), you
> do this:
>
> 	ret->remote = remote;
> 	if (!url && remote && remote->url)
> 		url = remote->url[0];
> 	ret->url = url;
> 	if (remote && remote->foreign_vcs) {
> 		transport_helper_init(ret);
> 		return ret;
> 	}
>
> and the case where remote.$name.vcs is defined, we do not need
> remote.$name.url.
>
> When (!url && remote && remote->url), is remote->url[0] allowed to be
> NULL?  I am guessing it would be a bug in whoever prepared the remote,
> and if that is indeed the case, the patch shifts the symptoms without
> fixing the cause.
>
> When (remote && remote->foreign_vcs) does not hold, iow, if no remote is
> defined or the remote is defined but lacks remote.$name.url, you will go
> to the last else clause in the function that sets up a git_transport_data
> for the native transport, but it has ret->url == NULL.
>
> Whom does that transport talk with?  Is such a transport of any use, or
> does it cause a segfault downstream in the call chain?
>
> In other words, I am wondering if this patch should just diagnose the
> case as an error, instead of pretending all is well.

You are right. Instead of pushing the segfault downstream, we should verify 
that the url is non-NULL before returning it as part of ret (modulo the 
foreign case, of course).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

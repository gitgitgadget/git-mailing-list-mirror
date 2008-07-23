From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 15:40:22 +0400
Message-ID: <20080723114022.GP2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcj4-0004de-7g
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYGWLka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 07:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbYGWLka
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:40:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:62528 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYGWLk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:40:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1106181fgg.17
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TaSyej6DcxqP/haCR1rMkIdrUAu+Ra58Lh4Q5BqbYbM=;
        b=uYdAKT0HzW+Ic33ElRkhyZhbU3qinoYczna21OQ0lDSWFYpKIRhq5HEF2iSlsdu3uQ
         QkBENIeViTDyObm/PruGPWTDBYeWwGju8AL8P5gZVoU9fLSe/m4E6+WC0YCStpWOA0Kz
         pGNBQQ5yldK/T8qoGbT5W35S2zDnoDFfiHK5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J+A5K57Yn0MGKvJgclemOZFWphnW+YTFb9uoAmDG1psYMziE1zXYdvbI8Zh/EpiNvJ
         tr4wfx3ZIMrUcTe2UxeHnfxSjxyQd5w/liE8XDMjz0APjfwgyEdHxpJTYveDJJEuB6kx
         L1C4F6ul63Szcrg30XG36+onAStsJnjcVZu+U=
Received: by 10.103.215.17 with SMTP id s17mr4481723muq.61.1216813226103;
        Wed, 23 Jul 2008 04:40:26 -0700 (PDT)
Received: from localhost ( [85.140.170.138])
        by mx.google.com with ESMTPS id y2sm52461172mug.1.2008.07.23.04.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 04:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89633>

On Wed, Jul 23, 2008 at 07:49:20AM +0200, Steffen Prohaska wrote:
> 
> On Jul 23, 2008, at 3:31 AM, Johannes Schindelin wrote:
> 
> >
> >-	if ((action == CRLF_BINARY) || !auto_crlf || !len)
> >+	if ((action == CRLF_BINARY) || (!auto_crlf && action < 0) || !len)
> 
> I think we should strictly follow the documentation, so this should read
> 
> +       if ((action == CRLF_BINARY) || (!auto_crlf && action !=  
> CRLF_INPUT) || !len)

Well, your expression is correct if we choose to strictly follow to what
the current documentation says, but it is not well written in this place,
and, more importantly, I don't see any use case where you would want to
set crlf=input in .gitattributes, because it is shared among users on
different platforms. What you want to specify in it is whether a file is
text or binary. If crlf is set, it means a text file; if unset, it is a
binary file. Regardless of what autocrlf value, I don't see why a text
file should be checked in with CRs. So, Dscho's patch makes more sense
to me.  This requires correction to the documentation though:

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d7b4114..448857b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -99,9 +99,9 @@ This attribute controls the line-ending convention.
 Set::
 
 	Setting the `crlf` attribute on a path is meant to mark
-	the path as a "text" file.  'core.autocrlf' conversion
-	takes place without guessing the content type by
-	inspection.
+	the path as a "text" file. Line endings in a text file
+	are converted to LF upon checkin, and if 'core.autocrlf'
+	is true then to CRLF upon checkout.
 
 Unset::
 

Dmitry

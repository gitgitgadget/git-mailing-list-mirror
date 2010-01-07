From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/5] Lazily generate header dependencies
Date: Thu, 7 Jan 2010 01:13:05 -0600
Message-ID: <20100107071305.GA11777@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20100101090550.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 08:13:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSmYc-0006FE-9i
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 08:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab0AGHNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 02:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755997Ab0AGHNL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 02:13:11 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55992 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab0AGHNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 02:13:08 -0500
Received: by ywh6 with SMTP id 6so18230861ywh.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C/RVPIKWqQ9LibqJ9a21oPlXssm89TSKfNVhWGOPv1M=;
        b=NXfWL2GuMz8hdDjOYdINTZqIAACSs42ksuOgc/uwkAiv0tN6g4buVjMeO0pDsXSKJb
         JGEVLpNPaJvJ5Zy+ZOl9AZaK3h9vDa67AaHT1naoC9ggEeD9kAaco3zkjwoCjLecvRGX
         KypWKk9sVqfh8Fnl62uIxYTapAOCuXXmnhlNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pL4P42i+994bPiYuBYxhjlWXwnqrnFBFR4LH3jMLOiBye3ZriBLS1d8s/kNlXsSpvv
         8iXCVUCwYGjD4/Z1iSXeo+/D9pYCMhL6BA23UUtgXgjF3XxOqcSTaQFrzeeH7qFlHOhb
         xjGOGUvDJpHbAqsZkqDGzCjNWBAOdaafr7AjI=
Received: by 10.150.164.20 with SMTP id m20mr1415286ybe.273.1262848386830;
        Wed, 06 Jan 2010 23:13:06 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm20110773iwn.7.2010.01.06.23.13.05
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 23:13:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100101090550.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136327>

Nanako Shiraishi wrote:
> Junio, could you tell us what happened to this thread?
> 
> Makefile improvements.  No discussion.

My bad.  The previous version was very rough because I was not sure
yet how this could help in making the header dependency rules more
maintainable.  If all compilers worth using support something like
gcc's -MD option (does MSVC?), we could switch over completely;
otherwise, we need some way to use the generated dependencies to
check the static ones, or the static ones will go stale.

That is, maybe something like this.  With these patches applied,
running

	echo COMPUTE_HEADER_DEPENDENCIES=YesPlease >> config.mak
	make clean
	make
	make CHECK_HEADER_DEPENDENCIES=YesPlease

will fail unless the dependency rules in the Makefile account for
all #includes gcc noticed with the current configuration.

Patch 5 is a little rough around the edges, but I am hoping it
will convey the idea.

Enjoy,
Jonathan Nieder (5):
  Makefile: rearrange dependency rules
  Makefile: clear list of default rules
  Makefile: list generated object files in OBJECTS macro
  Makefile: lazily compute header dependencies
  Teach Makefile to check header dependencies

 .gitignore |    1 +
 Makefile   |  158 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 130 insertions(+), 29 deletions(-)

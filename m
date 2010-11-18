From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [PATCH 2/2] A loose object is not corrupt if it cannot be read
 due to EMFILE
Date: Thu, 18 Nov 2010 13:23:59 -0500
Message-ID: <20101118182358.GQ355@fearengine.rdu.redhat.com>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com>
 <1288299210-27092-2-git-send-email-gitster@pobox.com>
 <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
 <4CE55794.7050201@viscovery.net>
 <AANLkTikns0Rm5znC7FOa72qZXKpQzazKiYsPe-oDNMAk@mail.gmail.com>
 <20101118172920.GC16610@burratino>
 <AANLkTi=rrcc5tia03K-Rtqs3vyjOv9P1NArnmbYhCQ27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 19:25:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9AJ-0007Zh-Fo
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 19:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab0KRSYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 13:24:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab0KRSYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 13:24:54 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oAIIO1KB031017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 18 Nov 2010 13:24:01 -0500
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oAIINx8v007859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 18 Nov 2010 13:24:00 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=rrcc5tia03K-Rtqs3vyjOv9P1NArnmbYhCQ27@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161700>

On Thu, Nov 18, 2010 at 07:18:37PM +0100, Erik Faye-Lund wrote:
> On Thu, Nov 18, 2010 at 6:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Erik Faye-Lund wrote:
> >
> >> I was wondering about the same thing, I don't think this approach is
> >> very easy to follow. But either way I think we should make sure
> >> opendir/closedir/readdir doesn't mess with errno.
> >
> > Other platforms and are allowed to (and do) clobber errno in many
> > non-error situations, so the main effect would be to work around/hide
> > some git bugs.
> 
> I don't think that's the case; K&R (section B1.7) says "In addition,
> the integer expression errno (declared in <errno.h>) may contain an
> error number that contains information about the most recent error.".
> A non-error condition would not be information about the most recent
> error. I interpret the use of the word "may" to mean "some functions
> does not update errno, so errno could also have information about
> older errors" not as "some functions can clear errno", but other might
> disagree with me.
> 
> POSIX (which defines opendir) says "No function in this volume of IEEE
> Std 1003.1-2001 shall set errno to 0", so I think it's clear cut in
> this case. (see
> http://www.opengroup.org/onlinepubs/009695399/functions/errno.html for
> the full text)
> 
> We also seem to depend quite heavily on errno being preserved on
> non-errors some places around in the code.

Errno can be clobbered if some subset of the operation in question
failed but the operation itself succeeded. For example suppose opendir
did a memory allocation that failed, but was able to recover from it and
return successfully. Errno might contain ENOMEM at the exit.

tl;dr - errno can be clobbered when functions that succeed call
functions that fail while progressing.

--CJD

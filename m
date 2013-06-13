From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 4/4] resolve_ref_unsafe(): close race condition reading loose refs
Date: Thu, 13 Jun 2013 10:22:37 +0200
Message-ID: <87d2rqs9ma.fsf@linux-k42r.v.cablecom.net>
References: <20130507023802.GA22940@sigill.intra.peff.net>
	<1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
	<1370960780-1055-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Johan Herland" <johan@herland.net>, <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 13 10:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un2o9-0005iQ-FE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 10:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318Ab3FMIW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 04:22:57 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:13644 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758246Ab3FMIWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 04:22:55 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 13 Jun
 2013 10:22:52 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 13 Jun 2013 10:22:52 +0200
In-Reply-To: <1370960780-1055-5-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 11 Jun 2013 16:26:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227705>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> One race is still possible and undetected: another process could
> change the file from a regular file into a symlink between the call to
> lstat and the call to open().  The open() call would silently follow
> the symlink and not know that something is wrong.  I don't see a way
> to detect this situation without the use of the O_NOFOLLOW option,
> which is not portable and is not used elsewhere in our code base.
>
> However, we don't use symlinks anymore, so this situation is unlikely.
> And it doesn't appear that treating a symlink as a regular file would
> have grave consequences; after all, this is exactly how the code
> handles non-relative symlinks.

You could fstat() the fd you got from open(), and verify that it is
still the same inode/device.  That's wasting one syscall per ref for
pretty much everyone, but perhaps if we really cared about this (and I
gather from the above that we don't), we could conditionally use
O_NOFOLLOW if available, otherwise do that fstat().

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

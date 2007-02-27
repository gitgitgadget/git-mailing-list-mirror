From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] Use git-update-ref to update a ref during commit in git-cvsserver
Date: Wed, 28 Feb 2007 12:37:32 +1300
Message-ID: <45E4C0BC.5090506@catalyst.net.nz>
References: <200702200857.02779.andyparkins@gmail.com>	<200702202010.02128.andyparkins@gmail.com> <7vmz38t5r4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:37:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBtN-0003ci-UU
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbXB0Xhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXB0Xhu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:37:50 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:39970 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbXB0Xht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:37:49 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HMBt7-0006Lm-8G; Wed, 28 Feb 2007 12:37:42 +1300
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <7vmz38t5r4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40847>

Hi Junio, Andy,

sorry for the long delay, I'm catching up with a sizable backlog at work
and in my foss projects.

I like Junio's patch -- it fixes cvsserver to work with packed refs
(which needed to be done!) and does things lockless, which is a great bonus.

The meat of the matter is

Junio C Hamano wrote:
> -    print LOCKFILE $commithash;
> +    if (system(qw(git update-ref -m), "cvsserver ci",
> +	       "refs/heads/$state->{module}", $commithash, $parenthash)) {
> +	    $log->warn("update-ref for $state->{module} failed.");
> +	    print "error 1 Cannot commit -- update first\n";
> +	    exit;
> +    }
>
>      $updater->update();

Running the commit lockless makes it a little bit more likely that we'll
fail the commit after all files have been sent. Some older CVS clients
have broken error handling in the late stages of the commit, but we
cannot really fix that - and such cvs clients are so broken that they
probably don't deserve our attention.

The other area I checked is that we don't get a nasty race condition
between the update-ref and calling $updater->update() - but it is safe.

So ack from this corner and thanks for the patch!

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------

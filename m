From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Thu, 10 Jul 2008 16:24:22 -0700
Message-ID: <7v7ibtnx09.fsf@gitster.siamese.dyndns.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org>
 <200807102126.37567.chriscool@tuxfamily.org>
 <7vd4llpkxq.fsf@gitster.siamese.dyndns.org>
 <200807110036.17504.chriscool@tuxfamily.org>
 <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5Wo-0006Ne-21
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592AbYGJXYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756584AbYGJXYj
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:24:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbYGJXYj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:24:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B71EF257E1;
	Thu, 10 Jul 2008 19:24:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CD781257E0; Thu, 10 Jul 2008 19:24:29 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness> (Johannes
 Schindelin's message of "Fri, 11 Jul 2008 00:38:10 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D11D926-4ED7-11DD-BA80-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88054>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You are opening a can of worms here, and I doubt that this is a good idea.
>
> git-bisect as-is has very precise, and _simple_ semantics, and users 
> should really know what they are doing (i.e. not marking something as 
> "good" which is on a branch containing a fix).
>
> Trying to be too clever here might just make the whole tool rather 
> useless.

Have you read the original thread yet?  I do not think this is trying to
be clever at all, but trying to be helpful.

As you explained, bisection *requires* that Good is ancestor of Bad.

     ---o---?---?---?---x
        Good            Bad

But in real life, things are more like "Today's master does not work, but
I am sure it used to work at 1.5.6.2".  I happen to always merge all of
'maint' to 'master' before pushing them out, so a good topology is
guaranteed, but not everybody does this (it takes careful planning what to
apply to 'maint' and where to fork topics from, and maintainers are not
perfect):

              Good
          ?---o (maint)
         /
     ---?---?---?---?---x (master)
        MB              Bad

People _will_ face such a topology.  If the users Know Better, they will
test MB=$(merge-base master maint) first to see if it is broken, and then
the world will have two possibilities:

    (1)       Good
          ?---o (maint)
         /
     ---o---?---?---?---x (master)
        Good            Bad

    (2)       Good
          ?---o (maint)
         /
     ---x---?---?---?---x (master)
        Bad             Bad


If (1), you go ahead with the usual bisection.  If (2), you cannot even
bisect.  Instead, you flip good and bad to find the "fix" in the side
branch (the answer has to be either the tip of maint or one previous in
the picture) to forward port to, either by merging 'maint' to 'master' or
cherry-picking.

The idea to check merge-base first is about automating this process (I
admit I still haven't looked at Christian's patch text yet).

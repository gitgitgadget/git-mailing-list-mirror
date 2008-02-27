From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix premature call to git_config() causing
 t1020-subdirectory to fail
Date: Wed, 27 Feb 2008 12:09:08 -0800
Message-ID: <7vy796rwkb.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net>
 <alpine.LNX.1.00.0802261709180.19665@iabervon.org>
 <alpine.LSU.1.00.0802262239200.22527@racer.site>
 <alpine.LNX.1.00.0802261742260.19665@iabervon.org>
 <7vzltn2qsd.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261933551.19665@iabervon.org>
 <7vy79718tn.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271430130.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Kristian =?utf-8?Q?H=C3=B8gsb?= =?utf-8?Q?erg?= 
	<krh@redhat.com>, Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:10:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSbR-000602-LI
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 21:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403AbYB0UJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 15:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbYB0UJc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 15:09:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864AbYB0UJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 15:09:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69EC92C65;
	Wed, 27 Feb 2008 15:09:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B63A72C61; Wed, 27 Feb 2008 15:09:17 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802271430130.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 27 Feb 2008 14:47:39 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75299>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Since it sets GIT_DIR, it also could simply unset GIT_CONFIG, and then 
> everything would just write to the config file for the new GIT_DIR. On the 
> other hand, if you have GIT_CONFIG exported in your environment, and you 
> set up a repository with "git clone", and clone unsets or overrides 
> GIT_CONFIG, then your new repository will immediately be unusable, because 
> clone will set up the config file inside the new repository, but nothing 
> you run after that will look in the new repository, since everything else 
> obeys the GIT_CONFIG you still have set.

Yes, I think an interactive environment that has GIT_CONFIG is
simply misconfigured.

But on the other hand, I could well imagine a script that does
this:

	#!/bin/sh
	GIT_CONFIG=$elsewhere; export GIT_CONFIG
        do things to the $elsewhere file via git-config
        git clone $something $new
        talk about the $new in the $elsewhere file via git-config
	(
        	unset GIT_CONFIG ;# I am writing the script carefully!
		cd $new
                do something inside the clone
	)
        talk more about the $new in the $elsewhere file via git-config
	exit
        
> On the other hand, I don't see why any git command other than "git config" 
> (run my the user directly) has any business looking at GIT_CONFIG, since 
> it's only mentioned in the man page for git-config, and not in general for 
> configuration, the wrapper, or other programs.

I think reading from the configuration file is done by
everybody, and GIT_CONFIG affects where the information is read
from.  Maybe it was a misfeature.  I dunno.

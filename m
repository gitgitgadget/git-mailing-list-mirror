From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix premature call to git_config() causing
 t1020-subdirectory to fail
Date: Tue, 26 Feb 2008 16:20:50 -0800
Message-ID: <7vzltn2qsd.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net>
 <alpine.LNX.1.00.0802261709180.19665@iabervon.org>
 <alpine.LSU.1.00.0802262239200.22527@racer.site>
 <alpine.LNX.1.00.0802261742260.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Kristian =?utf-8?Q?H=C3=B8gsb?= =?utf-8?Q?erg?= 
	<krh@redhat.com>, Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 01:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUA3P-0006Cs-Gi
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 01:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYB0AVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 19:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbYB0AVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 19:21:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYB0AVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 19:21:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A0382F5F;
	Tue, 26 Feb 2008 19:21:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 109E02F5B; Tue, 26 Feb 2008 19:20:55 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802261742260.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 26 Feb 2008 17:49:29 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75195>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 26 Feb 2008, Johannes Schindelin wrote:
>
>> Hi,
>> 
>> On Tue, 26 Feb 2008, Daniel Barkalow wrote:
>> 
>> > Actually, I think I'll be leaving CONFIG_ENVIRONMENT alone entirely; I 
>> > was only using it to override the setting that t5505 uses, but t5505 is 
>> > just wrong to set it. So this is the right placement of git_config(), 
>> > and the setenv and unsetenv aren't needed.
>> 
>> Well, existing git-clone.sh sets GIT_CONFIG.  So we have to unset any 
>> existing GIT_CONFIG at least.
>
> As far as I can tell, that's a flaw in git-clone.sh; if the user has set 
> GIT_CONFIG, it shouldn't be the case that every program other than 
> git-clone obeys it while git-clone ignores it. (On the other hand, 
> possibly every program other than git-config should ignore it, since it's 
> only documented as affecting git-config.) git-clone.sh only sets it, I 
> think, because it runs programs from the wrong context for them to do the 
> right thing by default, not because it's specifically trying to override a 
> user-provided setting.

When cloning locally, there are two repositories involved, and
GIT_CONFIG if exists in the environment talks about the original
one that gets cloned.  Without setting GIT_CONFIG explicitly how
would you set the configuration that is about the new repository
clone creates?

And to be consistent, if cloning remotely, we should do the
same, which means GIT_CONFIG should be reset to point at the
configuration file inside the new repository, be it .git/config
or $repo/config (if bare).

I think that is the reason behind it.

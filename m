From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 21:41:09 +0200
Message-ID: <4FE0D5D5.3020408@web.de>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com> <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com> <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 21:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4Ni-0001hh-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 21:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab2FSTq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 15:46:28 -0400
Received: from mout.web.de ([212.227.15.4]:61049 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719Ab2FSTqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 15:46:24 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2012 15:46:24 EDT
Received: from [192.168.178.48] ([91.3.162.199]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MAMTy-1Sb41h2qh0-00Bwdg; Tue, 19 Jun 2012 21:41:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <4FE08797.50509@xiplink.com>
X-Provags-ID: V02:K0:WCX1j+Drcw3mvxJW3VI5fI5LDxnxeQtstskhddIkPNZ
 XdtfZbrKcf4jDAYaKp1ksBrNGRxM8VWnn+1jB2k41PF8SLzRqe
 OpkwLXl1Q53g1bVeewJn15OcIuOG+VGkhtd6/yvH6kjQKc3riB
 40FHLgFdWqNLgK8YqHdsJnKpP3ndSufBTLtjt79ub9jbts7nK6
 TXU4javv6VNc2PW/2msJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200230>

Am 19.06.2012 16:07, schrieb Marc Branchaud:
> On 12-06-18 06:12 PM, Junio C Hamano wrote:
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>> That would be bad for our situation.  As I said, our automated build system
>>> uses detached HEADs a lot.  Erroring-out in this case would break us.  It's
>>> really only the near-ubiquity of the name "origin" that has kept things
>>> working so far.

And the "submodule add" documentation clearly talks about relative
submodule URLs being relative to the superproject's origin.

Your buildbot could also check if an origin is configured and use the
magic in your patch to configure one to the URL of the first remote it
finds if it isn't before initializing the submodules.

>> That reliance of "origin" is what made me think that "not guessing
>> and blindly assuming" a wrong thing to do.
> 
> I think git can do better than erroring out, though.

Hmm, but guessing and using the first remote it finds (which might or
might not be the one used in the initial clone) doesn't sound like a
terribly good idea.

> Sure, but I feel it did that already when it cloned.  It seems reasonable for
> the submodules to default to using the remote specified when the super-repo
> was cloned.

Is there a way to reliably tell that remote without relying e.g. on
the implementation details of git config (e.g. it could sort remotes
alphabetically some day)? What happens if someone changes the config
later? A lot of ambiguity here ...

And I think origin should always be the second choice if it exists,
the first being the remote configured for the checked out branch.
This gives the user the opportunity to say "Oh, I screwed up using
'git clone -o', let's set origin to the upstream repo". But should we
try to guess the remote the superproject was cloned from as third
option? I am not convinced.

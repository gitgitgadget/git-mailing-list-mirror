From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git gc and kernel.org
Date: Wed, 21 Oct 2009 10:05:47 +0200
Message-ID: <4ADEC0DB.4000104@viscovery.net>
References: <4ADD6026.8070203@zytor.com> <7veioyqzeo.fsf@alter.siamese.dyndns.org> <200910201054.48315.johan@herland.net> <alpine.LFD.2.00.0910201442480.21460@xanadu.home> <7v63a9n5i6.fsf@alter.siamese.dyndns.org> <4ADEA93E.7060907@viscovery.net> <7vzl7l8b1y.fsf@alter.siamese.dyndns.org> <7vaazl8acd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 10:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0WCr-0004aM-Aj
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 10:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZJUIFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 04:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbZJUIFs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 04:05:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64191 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZJUIFr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 04:05:47 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N0WCa-0000YE-1m; Wed, 21 Oct 2009 10:05:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BAF4D6D9; Wed, 21 Oct 2009 10:05:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vaazl8acd.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130897>

Junio C Hamano schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Junio C Hamano schrieb:
>>>> +		if (auto_gc) {
>>>> +			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
>>>> +			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>>> Am I correct that this will produce progress output? If git-daemon runs
>>> receive-pack, then this output will go to the syslog. Do we care?
>> We do, and we don't want that.  Thanks for spotting.
>>
>> Would adding "--quiet" to the mix be enough?
> 
> Actually I don't know.  This originally came from "we _could_ add gc and
> update-server-info to hundreds of post-receive hooks, but any repository
> hosting site that holds many central repositories will exactly have the
> same issue, so why not do this internally", so it may make sense to do
> exactly the same thing as what we do to the output from hooks.  What do we
> do to them now?  stdout-to-stderr?

Yes.

I'm slightly in favor of adding "--quiet", because even with this option
we see some output:

$ git gc --auto --quiet
Auto packing your repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.

A compromise would be to reduce this message to the first sentence if
--quiet was given. This way users who push via ssh or locally get a short
explanation why "git push" does not finish immediately[*]; and git-daemon
logs only a one-liner in the syslog, which might be useful, too.

[*] Skipping the hint to "run git gc manually" would even be good in this
case, because the hint pertains the remote repository, not the one from
which "git push" was issued.

-- Hannes

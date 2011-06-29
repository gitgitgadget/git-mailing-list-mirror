From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Wed, 29 Jun 2011 13:29:34 -0400
Message-ID: <4E0B60FE.1050000@xiplink.com>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com> <1309112987-3185-3-git-send-email-iveqy@iveqy.com> <4E0A506B.6040407@xiplink.com> <4E0A568E.3040202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	gitster@pobox.com, hvoigt@hvoigt.net
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 29 19:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbyaX-0004TJ-Cr
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 19:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751Ab1F2R36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 13:29:58 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:41415 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376Ab1F2R3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 13:29:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp47.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id A966B3A8245;
	Wed, 29 Jun 2011 13:29:54 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp47.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 60BAC3A828B;
	Wed, 29 Jun 2011 13:29:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Thunderbird/3.1.10
In-Reply-To: <4E0A568E.3040202@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176450>

On 11-06-28 06:32 PM, Jens Lehmann wrote:
> Am 29.06.2011 00:06, schrieb Marc Branchaud:
>> First, I expect performance will be terrible in repositories with large
>> and/or many submodules.  I'd go so far as to say that it's pretty much a
>> show-stopper for our repository.
> 
> Large submodules won't be the problem here, but many submodules and/or
> many commits might cause some performance degradations here. But please
> notice that there is no communication with the upstream of the submodules,
> we only check the refs present locally. Do you still think doing some
> "git rev-list" invocations in your submodules will be a problem? Then
> please say so.

Yes, that's exactly what I'm saying.  I'm concerned about rev-list's
performance, particularly when my system's disk cache is empty (or already
full with something else).  When I saw the patch I tried a quick
	git rev-list X --not --remotes -n 1
in a Linux kernel submodule where X was a non-existent ref, and watched my
disk whirl for a few minutes.

Admittedly that's nothing like what the patch does -- mea culpa.  I see now
that the check looks for refs in the submodule's recent history, so the scan
is likely to be pretty short.

Also, as you say below and Fredrik said in his reply, the patch only checks
submodules affected by a super-repo ref that is being pushed.  So I agree
that the performance hit is likely to be minimal even with large submodules.

(Fredrik, FYI my super-repo itself is large enough to make "git status" take
up a good part of the disk cache.  This repo has several submodules,
including a few (different) Linux kernel repos.  I already get bogged down a
bit when I have to status the main repo and one of the Linux submodules.  So
anything that adds extra submodule inspection makes me nervous.)

>> Second, there are many times where I'm working in a submodule on branch
>> "TopicA" but not in branch "TopicB".  If I've made submodule changes in
>> TopicA then try to push up TopicB, won't I have have to tell push to "-f"?
>> But that turns off other checks that I'd rather keep.
> 
> Nope, this patch only checks the refs to be pushed, not any others. So it
> will only check that all submodule commits on branch "TopicB" are pushed.

Thanks for pointing that out!

>> I'd feel a lot better about this patch if the check was *off* by default and
>> there was a config setting / command-line option to turn it on.
> 
> I have no objections against making that configurable, although I tend
> towards making this check default "on". But please feel free to test this
> feature and tell us if it really hinders you in your work or does cause
> performance degradation, we'll really appreciate the feedback!

Well I'm less concerned about it being configurable now.  I did a few more
tests and the rev-list performance looked fine.

		M.

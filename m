From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 03:19:16 +0100
Message-ID: <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	<git@vger.kernel.org>, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 04:19:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R96Dc-0008IZ-6M
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 04:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab1I2CTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 22:19:19 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:40657 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753724Ab1I2CTS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 22:19:18 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 97105C060D;
	Thu, 29 Sep 2011 03:19:17 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 756E236A82E;
	Thu, 29 Sep 2011 03:19:17 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id g9OAeumADL0N; Thu, 29 Sep 2011 03:19:16 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 5FCFF36A4BE;
	Thu, 29 Sep 2011 03:19:16 +0100 (BST)
In-Reply-To: <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182383>

On Wed, 28 Sep 2011 19:37:18 -0600, Martin Fick wrote:
> On Wednesday 28 September 2011 18:59:09 Martin Fick wrote:
>> Julian Phillips <julian@quantumfyre.co.uk> wrote:
-- snip --
>> I've created a test repo with ~100k refs/changes/... style refs, and
>> ~40000 refs/heads/... style refs, and checkout can walk the list of
>> ~140k refs seven times in 85ms user time including doing whatever 
>> other
>> processing is needed for checkout. The real time is only 114ms - but
>> then my test repo has no real data in.
>
> If I understand what you are saying, it sounds like you do not have a
> very good test case. The amount of time it takes for checkout depends
> on how long it takes to find a ref with the sha1 that you are on. If
> that sha1 is so early in the list of refs that it only took you 7
> traversals to find it, then that is not a very good testcase. I think
> that you should probably try making an orphaned ref (checkout a
> detached head, commit to it), that is probably the worst testcase
> since it should then have to search all 140K refs to eventually give
> up.
>
> Again, if I understand what you are saying, if it took 85ms for 7
> traversals, then it takes approximately 10ms per traversal, that's
> only 100/s! If you have to traverse it 140K times, that should work
> out to 1400s ~ 23mins.

Well, it's no more than 10ms per traversal - since the rest of the work 
presumably takes some time too ...

However, I had forgotten to make the orphaned commit as you suggest - 
and then _bang_ 7N^2, it tries seven different variants of each ref 
(which is silly as they are all fully qualified), and with packed refs 
it has to search for them each time, all to turn names into hashes that 
we already know to start with.

So, yes - it is that list traversal.

Does the following help?

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5e356a6..f0f4ca1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -605,7 +605,7 @@ static int add_one_ref_to_rev_list_arg(const char 
*refname,
                                        int flags,
                                        void *cb_data)
  {
-       add_one_rev_list_arg(cb_data, refname);
+       add_one_rev_list_arg(cb_data, strdup(sha1_to_hex(sha1)));
         return 0;
  }

-- 
Julian

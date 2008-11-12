From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in "git checkout" behaviour between 1.6.0.2 and 1.6.0.3
Date: Wed, 12 Nov 2008 11:15:37 -0800
Message-ID: <7vprl0oiw6.fsf@gitster.siamese.dyndns.org>
References: <80wsf9ovsp.fsf@tiny.isode.net>
 <491B131D.2050501@drmicha.warpmail.net> <80r65gon3m.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0LDU-0000as-Kn
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYKLTQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYKLTQN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:16:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYKLTQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:16:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91A6516881;
	Wed, 12 Nov 2008 14:16:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AE8FE16883; Wed, 12 Nov 2008 14:15:38 -0500 (EST)
In-Reply-To: <80r65gon3m.fsf@tiny.isode.net> (Bruce Stephens's message of
 "Wed, 12 Nov 2008 17:44:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5CC0DD72-B0EE-11DD-B25B-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100804>

Bruce Stephens <bruce.stephens@isode.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
> [...]
>
>> Bisecting gives:
>>
>>
>> 5521883490e85f4d973141972cf16f89a79f1979 is first bad commit
>> commit 5521883490e85f4d973141972cf16f89a79f1979
>> Author: Junio C Hamano <gitster@pobox.com>
>> Date:   Sun Sep 7 19:49:25 2008 -0700
>>
>>     checkout: do not lose staged removal
>
> I got the same, which is reassuring.
>
> Looks like a deliberate change with (what seems to me to be) an
> unfortunate interaction with "git clone -n"

Yeah, it was meant to allow:

	git clone -n $there $here
        cd $here
        git checkout

and was not taking care of the case to switch branches when the initial
checkout is made.

Perhaps this would help.

 builtin-checkout.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git c/builtin-checkout.c w/builtin-checkout.c
index 05eee4e..d2265df 100644
--- c/builtin-checkout.c
+++ w/builtin-checkout.c
@@ -269,8 +269,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		}
 
 		/* 2-way merge to the new branch */
-		topts.initial_checkout = (!active_nr &&
-					  (old->commit == new->commit));
+		topts.initial_checkout = !active_nr;
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge;

        

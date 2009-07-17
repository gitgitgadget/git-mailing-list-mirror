From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 01:27:46 -0700
Message-ID: <7vk52767el.fsf@alter.siamese.dyndns.org>
References: <20090716230031.GM7503@vinegar-pot.mit.edu>
 <4A601C59.8040108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Price <price@ksplice.com>, git@vger.kernel.org,
	Junio Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 10:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRinX-000200-OR
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 10:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934228AbZGQI2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 04:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934181AbZGQI2A
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 04:28:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934179AbZGQI17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 04:27:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6EF5C6078;
	Fri, 17 Jul 2009 04:27:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6AB3C6075; Fri, 17 Jul 2009
 04:27:48 -0400 (EDT)
In-Reply-To: <4A601C59.8040108@viscovery.net> (Johannes Sixt's message of
 "Fri\, 17 Jul 2009 08\:38\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAA7D1F0-72AB-11DE-A02D-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123448>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Greg Price schrieb:
>> In a rebase with --onto, the correct test for whether we can skip
>> rewriting a commit is if it is already on top of $ONTO, not $UPSTREAM.
>> Without --onto, this distinction does not exist and the behavior does
>> not change.
>> 
>> 
>> In the situation
>> 
>>  X---o---o---o---M
>>   \             /
>>    x---x---x---x
>> 
>>  Y
>> ...
>> The command `git rebase -p --onto Y X M` moves only the
>> first-parent chain, like so:
>> 
>>  X
>>   \
>>    x---x---x---x
>>                 \
>>  Y---o'--o'--o'--M'
>> 
>> because it mistakenly drops the other branch(es) x---x---x---x from
>> the TODO file.  This tests and fixes this behavior.
>
> I think the current behavior is by design. There is nothing to fix.
>
> The purpose of rebase -p is to leave non-first children alone and rebase
> only the first child parenthood chain. It is not the purpose to reseat an
> entire history DAG.

Hmm, if the original history were

 .---X---o---o---o---M
  \                 /
   x---x---x---x---x

     Y

and the rebase is about moving history leading to M since X on top of Y,
I would actually have agreed that this

 .---X---o---o---o---M
  \                 /
   x---x---x---x---x
                    \
     Y---o'--o'--o'--M'

would be the right thing to do (IOW, I would agree with you).

Can the current code distinguish the two cases?  More generally, can we
always tell these two cases apart, or is it fundamentally not possible to
differentiate the two cases and we should simplify the problem space by
limiting ourselves by treating the first parent in a special way?

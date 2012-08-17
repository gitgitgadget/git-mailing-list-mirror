From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash data loss
Date: Thu, 16 Aug 2012 20:30:48 -0700
Message-ID: <7vy5lew5xz.fsf@alter.siamese.dyndns.org>
References: <55831343358368@web1e.yandex.ru>
 <20120727132953.GA8263@sigill.intra.peff.net>
 <20120727135051.GA10303@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aleksandr Pryimak <tramsmm-mirror@yandex.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 05:31:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2DH4-0008Vw-7X
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 05:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030691Ab2HQDay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 23:30:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030676Ab2HQDav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 23:30:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B543E8299;
	Thu, 16 Aug 2012 23:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a2rOeo+b7rxODxUBTZfTn2mAG/Y=; b=rzURPN
	2C2AzIScmJYOzdKqvhdGXzGOZOGwSVCKMSPWVitt4kQCOfzLu+MJBSy7K6/x/lTZ
	7/WJGVZC4XMhSdkxPAJ/vdzK7b/fDKz+/2gVFMkqgrwlwBfbnQ9YMfJ8kfdsRM9w
	nMPjH3NmOqRpNB6OfmeNcoPX7dU2aoFl/Ar/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rzaynlr6cztCHzo+orkJ0wX+Q96eg+Q2
	PA6C3qYSg34IEL3lidV+I+jou+5AeBlC/6dGahU9rtfvrskFhlK2wN7a9QjQxCYB
	W3dm8ouG6ZtIuN4KB5ywQ02IJ0k0jTbD9MoTQLhrpamzmEOMFd0fYwEI1MG4twej
	7JHQJITIrwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A28E78298;
	Thu, 16 Aug 2012 23:30:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AAF88297; Thu, 16 Aug 2012
 23:30:49 -0400 (EDT)
In-Reply-To: <20120727135051.GA10303@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 27 Jul 2012 09:50:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0DBB456-E81B-11E1-B929-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 27, 2012 at 09:29:53AM -0400, Jeff King wrote:
>
>> If we put actual files inside "x", which git does track, then they would
>> be part of the stash, and should be properly retained. But they're not:
>> 
>>   $ rm x && mkdir x && echo foo >x/file
>> 
>> Now we have some precious contents in the form of "x/file". They are
>> untracked by git, but git should be careful about removing them.
>> 
>>   $ git stash
>>   Saved working directory and index state WIP on master: 2d32d3a initial
>>   HEAD is now at 2d32d3a initial
>>   $ ls -l x
>>   -rw-r--r-- 1 peff peff 0 Jul 27 09:19 x
>>   $ git stash show --raw
>>   :100644 000000 e69de29... 0000000... D  x
>> 
>> Now this _is_ data loss. Stash blows away untracked files inside the
>> directory, but does not record them in the resulting stash. And that
>> should be fixed.
>
> Hrm. The problem is that after creating the stash, we then run "git
> reset --hard" to drop the changes that we just stashed. But that is not
> always accurate. It will not usually touch untracked files, but it might
> if they have D/F conflicts with tracked files. So we need to replace
> that "git reset --hard" with some safer command that will notice we are
> about to overwrite untracked files. But I am not sure what that command
> would be.

Is this something we still want to keep track of?

As readers can probably guess, I am trying to come up with a list of
loose ends for the next cycle.  This may be one of the low-hanging
ones.

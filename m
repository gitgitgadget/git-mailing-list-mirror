From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 16:45:17 -0800
Message-ID: <7v636vj7c2.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
 <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7eV-0001XI-CG
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196Ab0AVAp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113Ab0AVAp1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:45:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0AVAp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:45:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12A0A935F4;
	Thu, 21 Jan 2010 19:45:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xFgIAjCZ8yY8YXu7sxXsHZMu0yo=; b=vVG+BH
	uDiCAMVYcUyRThec2sQEVhI1GFIfxdONCsxlt3suvxByEf5J0P31pI+4sMc99ev2
	dvQuQzaEO39HJiWHzhHy+A07jUz1mXhrxGzUPCSA7mop2tRtDUaomNJaR53fN8u0
	Q7gfIfn9BSSOihmdOAAYOeW4e263X0XUA7/BI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QZaDMPyFKGtajA5FGoWVE+YQPPZltBTm
	5KYE2TBoUTKbDJUOvydNvgeV4neJ/tajKylTklYeJEjaZiOgi2Idp8B8laXlti1E
	4Gg5QGYMWRvg4aylWOxK/mpaZ75VlHVy9VTFwjdjZmYTXJvg+kE/OhSuZ5GHK1ve
	9X/3mV0NhKw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D39DB935ED;
	Thu, 21 Jan 2010 19:45:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 098B9935E8; Thu, 21 Jan
 2010 19:45:18 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 21 Jan 2010 15\:25\:19 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C4D01FA-06EF-11DF-849B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137708>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 21 Jan 2010, Linus Torvalds wrote:
>> 
>> We could fix it a few ways
>> 
>>  - ignore it. Most git programs will get the pack handling functions 
>>    anyway, since they want to get object reading.
>
> In fact, we should probably remove git-show-index. It may have some 
> historical significance as a pack-file index debugger, but it has no 
> actual redeeming features now, considering that the binary is a megabyte 
> of useless crud with debugging info.
>
> However, we do actually use it in t/t5302-pack-index.sh. So in the 
> meantime, how about this hacky patch to simply just avoid xmalloc, and 
> separating out the trivial hex functions into "hex.o".
>
> This results in
>
>   [torvalds@nehalem git]$ size git-show-index 
>        text    data     bss     dec     hex filename
>      222818    2276  112688  337782   52776 git-show-index (before)
>        5696     624    1264    7584    1da0 git-show-index (after)
>
> which is a whole lot better, no?
>
> (Or make it a built-in, if we actually think we want to carry it along in 
> the long run)

We tend to not remove things unless we are absolutely certain nobody uses
it, so probably making it built-in would be preferrable.  I don't think
show-index is used very often if ever, but scripts that use hash-object
would use it really often and would do so via its --stdin interface if it
knows that it is creating more than a dozen objects, so start-up time
required to map the whole git is probably not an issue.

By the way, do you think anybody still uses "git merge-trees"?

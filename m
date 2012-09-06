From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: validate & reconfirm interactive responses
Date: Wed, 05 Sep 2012 20:29:14 -0700
Message-ID: <7vsjav6d85.fsf@alter.siamese.dyndns.org>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com>
 <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:29:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9SmS-00055x-CU
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 05:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab2IFD3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 23:29:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab2IFD3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 23:29:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59CAD8FE3;
	Wed,  5 Sep 2012 23:29:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jOsRT/qybgTOT24PiE/iB34ubBY=; b=fa9hqd
	dVKaytyL918/2n3y4yqqhsEA8BwfqoTnwVGfVfNNNELkNfi0UVAUoi8i5X9JFZJI
	1O4fv5W6NWDMpoHu8Raw+6WwtkTvL8xkuXwO6CKsXxmlJQZ5T2eaTRfyWbvuYs/i
	bzU3zbqKrls0WQSIj12xldueO7/s4vxQjcaHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7Ffp+BEc0z3Aq5l5EtVTpAkgVsv3UUn
	gBLbmrUvOQPs9V0ylo3BDy9k4bK+Y6bRH9G4Tmk25x0hC9gii1LS3wSMD48Xr795
	FojQXrGV2AOiAOKAAOGhv6cbPtWc2uZcka8beNFe6pNr7KapnIDxMpp9qQ7cFYO8
	E8++I31N6OA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 454D68FE2;
	Wed,  5 Sep 2012 23:29:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E44E8FE0; Wed,  5 Sep 2012
 23:29:15 -0400 (EDT)
In-Reply-To: <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com> (Stephen
 Boyd's message of "Wed, 5 Sep 2012 12:24:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08DB2502-F7D3-11E1-BDEE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204857>

Stephen Boyd <bebarino@gmail.com> writes:

> On Tue, Aug 14, 2012 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -745,13 +752,15 @@ sub file_declares_8bit_cte {
>>  if (!defined $sender) {
>>         $sender = $repoauthor || $repocommitter || '';
>>         $sender = ask("Who should the emails appear to be from? [$sender] ",
>> -                     default => $sender);
>> +                     default => $sender,
>> +                     valid_re => qr/\@.*\./, confirm_only => 1);
>
> This is now bugging me if I just hit enter and don't want to specify
> anything for
> these headers (I want the defaults or what's in the files already).
> Can we allow
> the empty string to be valid as well so I don't have to go through
> these prompts?

That indeed was the intention, and if it is not behaving, you found
a bug.

The relevant code in "sub ask" does this:

		...
                $resp = $term->readline($prompt);
                if (!defined $resp) { # EOF
                        print "\n";
                        return defined $default ? $default : undef;
                }
                if ($resp eq '' and defined $default) {
                        return $default;
                }
                if (!defined $valid_re or $resp =~ /$valid_re/) {
                        return $resp;
                }

I am scratching my head wondering why your "just hit enter" does not
trigger the "if response is empty and we have default, just return it"
codepath we can see above.  It shouldn't even trigger the regexp
based validation codepath in the first place.

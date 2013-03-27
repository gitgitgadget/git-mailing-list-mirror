From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] add test for streaming corrupt blobs
Date: Wed, 27 Mar 2013 13:35:03 -0700
Message-ID: <7vhajwlgy0.fsf@alter.siamese.dyndns.org>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202134.GE16019@sigill.intra.peff.net>
 <20130327202705.GA5145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:35:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKx4M-00024p-J3
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473Ab3C0UfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:35:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218Ab3C0UfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:35:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3B58A78B;
	Wed, 27 Mar 2013 16:35:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XIoGDmIHtFtIjUgIxxQQHR0EQPo=; b=hwmgMm
	SFZWG4ozbZ9Ka9Vop6bbsl/2GXNpJBHjV+GU1W2qtmYGQ/Zj4WSL86qgSwMRzfLh
	0IOoRD7NKpuUdv5aODwNIlFxbvs//Bvb7O1HHfo0/qKSQxIZAjvVzcBMEqWw2J8D
	1S70YWYEXLLvfS/SgcniYnL5LERFunFbZQMPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=STLKxX7mcM/BO40i1H6w613u061cFYkl
	epTC5tshVzFAlMSrAZXRXcEjOVzXvh+XwdPAZZ+nA8jj8BiSXYh6prw93ramcV+j
	vOetOWhenH5Q+4riAocLXqAwh1LzKJWV/vfCMUEF0Pi2+5pUY5eaemNUnYF14sD+
	6QuO9KUc76k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A839DA78A;
	Wed, 27 Mar 2013 16:35:06 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1031CA787; Wed, 27 Mar 2013
 16:35:05 -0400 (EDT)
In-Reply-To: <20130327202705.GA5145@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 27 Mar 2013 16:27:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF34EB36-971D-11E2-8594-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219326>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 25, 2013 at 04:21:34PM -0400, Jeff King wrote:
>
>> +# Convert byte at offset "$2" of object "$1" into '\0'
>> +corrupt_byte() {
>> +	obj_file=$(obj_to_file "$1") &&
>> +	chmod +w "$obj_file" &&
>> +	printf '\0' | dd of="$obj_file" bs=1 seek="$2"
>> +}
>
> Hmm, this last line should probably be:
>
> diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
> index a84deb1..3f87051 100755
> --- a/t/t1060-object-corruption.sh
> +++ b/t/t1060-object-corruption.sh
> @@ -12,7 +12,7 @@ corrupt_byte() {
>  corrupt_byte() {
>  	obj_file=$(obj_to_file "$1") &&
>  	chmod +w "$obj_file" &&
> -	printf '\0' | dd of="$obj_file" bs=1 seek="$2"
> +	printf '\0' | dd of="$obj_file" bs=1 seek="$2" conv=notrunc
>  }
>  
>  test_expect_success 'setup corrupt repo' '
>
> The intent was to change a single byte, not truncate the file (though on
> the plus side, that truncation is what found the other bugs).

;-).  Thanks, I missed that.

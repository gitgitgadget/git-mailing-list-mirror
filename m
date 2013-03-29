From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: preallocate object hash table in --all
 --objects
Date: Fri, 29 Mar 2013 09:04:12 -0700
Message-ID: <7vsj3ep4zn.fsf@alter.siamese.dyndns.org>
References: <1364563210-28813-1-git-send-email-pclouds@gmail.com>
 <20130329151208.GA22744@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 17:04:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULbnI-00068O-GW
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 17:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab3C2QEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 12:04:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab3C2QEP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 12:04:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33418EF46;
	Fri, 29 Mar 2013 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3GF33p+y7pLL3D5P4sOIMLjTVYQ=; b=CWU8/G
	X2bvYh5u+/yTAeDKSfOxjXiRV4dCly3TRl+/0NByZiekC8ba+7fi2hbfUXNrDeXZ
	Qg2AmA7xuxb3HcT8pXtnu7wkrOjC9rbiCygI5RMhEJZ3Bj7baYk6zcFfrce69gCh
	07j56+NQDMXGO553MO9Uk/NYBmkpEx54vpngE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O+PuEZlhIHT8ESXHY8JoNkMEQDD/788B
	qvpKl2HD3It6UmCEIjz8jhmlF0CHHlB6vIhxi3HrVfCW/3VJ6tU71xQ5A8xQl1eb
	lFau00G67JcOMSTrEiowx8hBfOXxR2J3RMaVRKOjZ82Sn73ae0D+Un19nbFeMMBk
	Xz9pEgFWmFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27AF9EF45;
	Fri, 29 Mar 2013 16:04:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A16E5EF43; Fri, 29 Mar 2013
 16:04:13 +0000 (UTC)
In-Reply-To: <20130329151208.GA22744@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Mar 2013 11:12:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CD897F0-988A-11E2-91A3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219504>

Jeff King <peff@peff.net> writes:

> This feels weirdly specific, and like we should just be tuning our hash
> table growth better. You show a 3.2% speedup here. I was able to get a
> 2.8% speedup just by doing this:
>
> diff --git a/object.c b/object.c
> index 20703f5..8e5e12c 100644
> --- a/object.c
> +++ b/object.c
> @@ -91,7 +91,7 @@ static void grow_object_hash(void)
>  static void grow_object_hash(void)
>  {
>  	int i;
> -	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
> +	int new_hash_size = obj_hash_size < 32 ? 32 : 3 * obj_hash_size;
>  	struct object **new_hash;
>  
>  	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
>
> It might be worth trying to figure out what the optimium growth rate is
> first, which would help this use case and others. With less fragile
> code.

I agree with the general principle to avoid heuristics that is too
specific to the use case.  Thanks.

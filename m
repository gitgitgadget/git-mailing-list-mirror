From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] sha1_file: improve directories comparison method
Date: Tue, 06 Sep 2011 09:32:21 -0700
Message-ID: <7vliu1aay2.fsf@alter.siamese.dyndns.org>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-4-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <tali@admingilde.org>
To: Wang Hui <Hui.Wang@windriver.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 18:32:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0yZb-0007FX-3j
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab1IFQc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:32:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab1IFQcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 12:32:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF370448D;
	Tue,  6 Sep 2011 12:32:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+IaGwzXpxhgcScsk/s2AW351eD8=; b=x796RG
	AYKtQjtw/j0OZfgp3Gs+x2D5DWWXXzNtaWeDho0vuyhGN1ct1MsuVkdvpj2ED+sw
	yvi97kuxGmCGtpdSydwmDIZ+4r1YMGNc10dzofETNTzl82n9VNJmt2gLZ67m2yXe
	dW+fcU0vbQl5KQ1DiIMIlPa2Om9PFKbqMSU+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x+adKiZxfQRtPYxKF52yk6SF1ktOQaP4
	XzK46ZTo78XIj/fcYkAbN1AJTLsD3m3cX8VhS9AvZyDsSfs9eLssPwvk0XKcs9CW
	rkg7wev9KGn/vRNZq7tysSL3mdn6EnyHkF87WUU0+ZeDnmlnc6xbj0/SZNtMr8UC
	HY2ijxvkzHE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5154448C;
	Tue,  6 Sep 2011 12:32:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61CFA448A; Tue,  6 Sep 2011
 12:32:23 -0400 (EDT)
In-Reply-To: <1315304645-12009-4-git-send-email-Hui.Wang@windriver.com> (Wang
 Hui's message of "Tue, 6 Sep 2011 18:24:03 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC8D04BE-D8A5-11E0-8106-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180813>

Wang Hui <Hui.Wang@windriver.com> writes:

> From: Hui Wang <Hui.Wang@windriver.com>
>
> In the past, to check if two directory paths are same, we use memcmp()
> to directly compare their path strings, this method can't get an
> accurate result if paths include ".." or "." or redundant slash, e.g.
> current dir is /, "/a/b/c", "/a/b//c/d/e/../.." and "./a/b/f/../c"
> should be the same dir, but current method will identify they are
> different.
>
> Now add a global function is_same_directory() to replace the old
> memcmp() method, this function will change two input paths to real
> path first, then normalized them and compare them.

I do not like this patch _at all_. While it may result in correct result
if you _always_ make it absolute before comparing two entities, if you
will be storing the normalized result after running the comparison anyway,
and if you are comparing against the existing and supposedly already
normalized entities with a new candidate, why would anybody sane would
want to keep paying for the normalization cost at such a low level?

IOW, you are proposing to do:

	given a new candidate;
	for existing entities:
		normalize existing
                normalize candiate
                compare the above two
                if they are equal:
                	ignore
	if no match found
        	add the normalized candidate to the list

Wouldn't it make much more sense to do this:

	given a new candidate;
        normalize it
	for existing entities:
                compare existing and normalized candidate
		there is no point in normalizing the existing one!
                if they are equal:
                	ignore
	if no match found
        	add the normalized candidate to the list

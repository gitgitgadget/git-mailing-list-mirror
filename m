From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach checkout the -n|--dry-run option
Date: Sun, 08 May 2011 14:30:22 -0700
Message-ID: <7vwri0ric1.fsf@alter.siamese.dyndns.org>
References: <4DC47242.6060205@web.de>
 <7vhb97xx5g.fsf@alter.siamese.dyndns.org>
 <7vfwoqwby5.fsf@alter.siamese.dyndns.org> <4DC67CF4.80901@web.de>
 <4DC70200.1080201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun May 08 23:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJBYp-0004Ai-Rf
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 23:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab1EHVad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 17:30:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab1EHVac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 17:30:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B919D5D74;
	Sun,  8 May 2011 17:32:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nYh9cPBh3VQEZI+EIGFKAyIVgy8=; b=q8B4F+
	OhbZzESuziB00giw3iynC9uf7nehBOPKioPk7Y13l8kihSxGV7rdTFD2ZssgpCK2
	UocZwLwU7bhD2MAHbq+jnhgx706kKAm0prJYD00+YB1jdEKsTagbOti/HWUDNQZe
	emHQUFgvLN5L0svzWsaRvAYAzbIilDVYT72Io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aDNDFCs0W1BRajztt3DypC7Xv7swaRfs
	Y8waFkFVjsFXElIMgLMvzLMfbDxb6EdETF/WycZx6FDOSEBwRo+gQoGmt1kwg3aS
	QBW3HFP3Ct/tKSka0yve5eg+23+qS9LuXd/fkPyqP+ZIsVH+fW0SkLXLDntzyP26
	9aUNefAKSs8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BC9B5D73;
	Sun,  8 May 2011 17:32:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 448D85D72; Sun,  8 May 2011
 17:32:29 -0400 (EDT)
In-Reply-To: <4DC70200.1080201@web.de> (Jens Lehmann's message of "Sun, 08
 May 2011 22:50:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF54CEA8-79BA-11E0-B56C-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173182>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
> index ca8a409..bcfb5e6 100755
> --- a/t/t1000-read-tree-m-3way.sh
> +++ b/t/t1000-read-tree-m-3way.sh
> @@ -259,6 +259,8 @@ test_expect_success \
>      "rm -f .git/index AA &&
>       cp .orig-A/AA AA &&
>       git update-index --add AA &&
> +     git read-tree -n -m $tree_O $tree_A $tree_B &&
> +     test_must_fail check_result &&

That's a rather sloppy way to test that the command did not do anything to
compare one possible outcome, instead of verifying that the result is
identical to the original condition, no?

How about

	...
	git update_index --add AA &&
        git ls-files -s >pre-dry-run &&
        git read-tree -n -m $tree_O $tree_A $tree_B &&
        git ls-files -s >post-dry-run &&
        test_cmp pre-dry-run post-dry-run &&
        ...

We also should be checking that the command reports it is going to fail
when it should as well.  Always remember to check both sides of the coin.

>       git read-tree -m $tree_O $tree_A $tree_B &&
>       check_result"

I suspect that it would make sense to replace

	git read-tree $args && check_result

with
        
	read_tree_must_succeed $args

and

	test_must_fail git read-tree $args

with

	read_tree_must_fail $args

and implement two shell wrappers, perhaps like this.

read_tree_must_succeed () {
	git ls-files -s >pre-dry-run &&
	git read-tree -n "$@" &&
        git ls-files -s >post-dry-run &&
        test_cmp pre-dry-run post-dry-run &&
        git read-tree "$@"
}

read_tree_must_fail () {
	git ls-files -s >pre-dry-run &&
	test_must_fail git read-tree -n "$@" &&
        git ls-files -s >post-dry-run &&
	test_must_fail git read-tree "$@"
}

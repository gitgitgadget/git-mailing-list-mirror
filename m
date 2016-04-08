From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 05/18] Add testcase for --index-only merges needing the recursive strategy
Date: Fri, 08 Apr 2016 12:37:33 -0700
Message-ID: <xmqqzit3vqma.fsf@gitster.mtv.corp.google.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<1460098726-5958-6-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:37:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aocDu-0004BT-SU
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 21:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbcDHThh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 15:37:37 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750908AbcDHThg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 15:37:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B4A3520A0;
	Fri,  8 Apr 2016 15:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qOkQ0Eb49seHfzt8Eb4j+Yt+ew8=; b=VJWd/E
	C9m8aTXDZHsNFdh+W3dWvUa/LpnyDIuTfQjOPkhlHsbgsPwbWzorkoQeCh747nJw
	lDldjgd6ByKcti5O1J+9r+3Ta1JABuax0wePkAb5CIHdZ6TSNG31Ii+ZBreENrKa
	RggVkA0trMO/6Ry4qVWEPE0sbiooGb6gd/ke0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E3kebt/ZNkhEHtBi7Nq6Bu57cc7RdzMQ
	qWNy79IjLcHdvGmf4RZRV6bhJ8U5PAK5g5AffRIA9l2yQaVwtuOjrdhLI/Lmbaxg
	Mgp8c/MYdFtvr8p4bJhkj10POftQ35Q0jOXlz2FA0UJGlticQpsjK3ygaHNV/h8R
	rY+KwrPWTlo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 626C65209F;
	Fri,  8 Apr 2016 15:37:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7C1675209E;
	Fri,  8 Apr 2016 15:37:34 -0400 (EDT)
In-Reply-To: <1460098726-5958-6-git-send-email-newren@gmail.com> (Elijah
	Newren's message of "Thu, 7 Apr 2016 23:58:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 579ECDCC-FDC1-11E5-889E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291058>

Elijah Newren <newren@gmail.com> writes:

> +test_expect_failure '--index-only with rename/modify works in non-bare-clone' '
> +	git checkout B^0 &&
> +
> +	git merge --index-only -s recursive C^0 &&
> +
> +	echo "Making sure the working copy was not updated" &&
> +	test ! -f b &&
> +	test -f a &&
> +	test $(git rev-parse B:a) = $(git hash-object a) &&
> +
> +	echo "Making sure the index was updated" &&
> +	test 1 -eq $(git ls-files -s | wc -l) &&
> +	test $(git rev-parse B:a) = $(git rev-parse :b)

The most crucial test that is missing (hence prevents reviewers from
judging if --index-only is a good idea at all) is the test on HEAD.
Does it record a merge between B and C and move HEAD there, i.e.

	test $(git rev-parse HEAD^1) = $(git rev-parse B) &&
	test $(git rev-parse HEAD^2) = $(git rev-parse C)

or does it make a merge but does not advance HEAD, i.e.

	test $(git rev-parse HEAD) = $(git rev-parse B)

I fear that it may give a great headache to end users if you move
HEAD in a repository with a working tree to point at the merge
result--how do they reconcile the difference between the working
tree (which was based on B) and the index and HEAD (which is now
based on the result of the merge)?  The next "git commit -a" would
appear that it would revert the changes brought in by this merge,
wouldn't it?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix refspec on "--single-branch" option
Date: Thu, 13 Sep 2012 23:48:17 -0700
Message-ID: <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
References: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
 <1347599357-15533-1-git-send-email-ralf.thielow@gmail.com>
 <7vr4q56uae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 08:48:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCPhW-0006Fw-1j
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 08:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab2INGsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 02:48:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2INGsV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 02:48:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 328627062;
	Fri, 14 Sep 2012 02:48:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iqzVq+5PYF/SUtqkf5ZdoElVsvs=; b=ozBIb8
	wJFxG40f9WIqjixMz+56n7DGYnGbkb9RTM8H2uc6Kk4qhq8+Bz73oyx8lOvYpCWk
	saSM+dIQbYYB1AyefN1I9E6GfBdbl/7avXctrhLkALQ4QQh5aWtrAO9dPNtRHYJe
	lqPuKH8eaoMMLFlzOrgcu/fP1AUWHGPLbk7vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pZHXuJkhkF/DshFj+JxeuXyyCIF7qIce
	8ONAMtFRbiSjsIg2ruagEq0yPKyUi9J/4gMUGXXYi5qvy1iEoHiobWAixzzu/n0S
	CqG0q1+PeCEJngmqUm+wTm68q8KyWdCQ1W4pTrc6WdRfFjF/EVzAwGV9noTJiCJt
	govsqSHPO34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2207061;
	Fri, 14 Sep 2012 02:48:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70DDE7060; Fri, 14 Sep 2012
 02:48:19 -0400 (EDT)
In-Reply-To: <7vr4q56uae.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Sep 2012 22:35:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B3A95AE-FE38-11E1-84E2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205458>

Junio C Hamano <gitster@pobox.com> writes:

> Who guarantees at this point in the codepath that option_branch is
> set when option_single_branch is non-zero?  Until we talk with the
> remote, "clone --single-branch" without an explicit "--branch" will
> not learn which branch at the remote we are going to fetch (it will
> be their HEAD).
>
> I wonder if this should be more like this:
>
> 	if (option_single_branch) {
> 		if (option_branch)
> 			Your patch "+refs/heads/foo:refs/remotes/origin/foo";
> 		else
> 			"HEAD";
>         } else {
>         	Original "+refs/heads/*:refs/remotes/origin/*";
> 	}
>
> That is, "clone --single-branch" will continue fetching from and
> integrating with their HEAD without storing any remote tracking
> branch.

Alternatively, if you can move the logic to set up this
configuration further down so that it happens after we talked to the
other side and figured out remote_head_points_at, you could instead
set it up to keep a single remote tracking branch.

Even if you did so, guess_remote_head() may not find any branch when
the other repository's HEAD is detached, so you would need to decide
what to do in such a case, and "fetch and integrate their HEAD
without using any remote tracking branch" may be a reasonable thing
to do in such a case.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Thu, 28 Apr 2016 19:51:34 -0700
Message-ID: <xmqqd1p92kll.fsf@gitster.mtv.corp.google.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
	<xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew J <andj2223@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 04:51:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avyWt-0000GI-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 04:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbcD2Cvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 22:51:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752723AbcD2Cvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 22:51:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2935317A9A;
	Thu, 28 Apr 2016 22:51:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IWEpSe9+2Kf6U+a09Q43lvzpZbM=; b=a2KUIE
	s4MrjDFQeu9frwlfq3cc5zxGuFFcIt7NX2ylZ/kBEyaM/QKc7yNj9DsP3RlwiAWf
	1fXrHbJcj+FLkLtupwAF1KBK8DAdd7SqAmXAfHbt6nAtH3PvjsSt2zo/d5qAZKjE
	IREa333XRuVaPt74Gr0KI45hFrNeu+rOcEY0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKIhIJg3nW8IKpuIktYl9KziNtYu9pIJ
	dPjQsZqzckrriL6gpf/5r52uOuLFhUqUZdIhlGisPPLdKdW+9C/BJrt0M+e1q+L5
	ZU5VfR1AQSCJiT6z19NuHZuCRc6fuHVIrVarhN/1YxjO0d29kIMmgOq7vZZniGgp
	Av4SB95V7bU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FD3D17A99;
	Thu, 28 Apr 2016 22:51:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8485B17A98;
	Thu, 28 Apr 2016 22:51:36 -0400 (EDT)
In-Reply-To: <xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Apr 2016 09:39:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A24CE4A-0DB5-11E6-A9C6-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292967>

Junio C Hamano <gitster@pobox.com> writes:

> My undertanding of what _should_ happen in the world order as
> currently defined (not necessarily implemented) is:
>
>  * "git add -- A B" must work the same way as "git add -- B A" and
>    "git add -- A; git add -- B"
>
>  * "git add -- path/to/subdir/file", when any of path/, path/to/,
>    path/to/subdir/ is a Git repository that is different from the
>    current Git repository, must fail.
>
> IOW, if 'path' is a repository (whether it is known as a submodule
> to the repository whose working tree contains it, or it is an
> untracked directory from the containing repository's point of view),
> the index of the containing repository cannot get path/$anything in
> it.  If you managed to do so, you found a bug [*1*].
>
> path/.git/index can of course have "to/subdir/file" in it, and from
> that point of view, "git -C path/to/subdir add file" may one day
> become an improved world order.  It is just we haven't discussed
> that possibility or reached concensus that it is a good idea.

A cursory bisection suggests that this used to work up to at least
v2.7.4; this must be a recent regression.

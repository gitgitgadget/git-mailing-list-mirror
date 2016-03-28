From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git rev-parse --git-common-dir executed from a sub dir of the main worktree is wrong
Date: Mon, 28 Mar 2016 12:57:52 -0700
Message-ID: <xmqqk2kmxtmn.fsf@gitster.mtv.corp.google.com>
References: <CANoM8SU4ZWA=f1TSmNbHDBut7ox6cCVoi3K37GEmjHvygw1odg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= 
	<pclouds@gmail.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:58:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akdIZ-0008SN-BM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 21:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbcC1T55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 15:57:57 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751593AbcC1T5z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 15:57:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 616D64F7CF;
	Mon, 28 Mar 2016 15:57:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0JszY3mk39HMKcNcNcKEW+yOr7I=; b=kX9rRM
	vAqef7GzDka2x2aZ6LXRMxpFbpMMEwTJ6IKaJIo+YDJoR1vWGm8TAshTdpGSJiGA
	2KHsT/WgpM1PxkdtvInUmHRYJF4lMtdGffRP+hAF+ExHw4M7zy2IQLLmEVlolhwX
	KKKZHZknYR3dOpZZ2TPexoZut9t608N3trnog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RA+SteHUv+Gbc95gPjZa7EW6UIs5njvE
	TvQKC1CvTr0eBStK7Hdp7w8d3mud4S3QHEe5Uk4NMzBwfaIw2dGS9wLWwEyLtmo1
	J0rbP9Yck0idfajhKld87490hIk9dBwHktcxOMO+BtyYyWHxwNmXAFhv/IWGkjy0
	WZFpCODbZcA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5951B4F7CE;
	Mon, 28 Mar 2016 15:57:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 87A624F7CD;
	Mon, 28 Mar 2016 15:57:53 -0400 (EDT)
In-Reply-To: <CANoM8SU4ZWA=f1TSmNbHDBut7ox6cCVoi3K37GEmjHvygw1odg@mail.gmail.com>
	(Mike Rappazzo's message of "Mon, 28 Mar 2016 15:43:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5BAFC9DE-F51F-11E5-A09E-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290061>

Mike Rappazzo <rappazzo@gmail.com> writes:

> I found a case where it seems that the result of `git rev-parse
> --git-common-dir` is incorrect.  If you execute the command from
> within a subdirectory in the main worktree, it returns the path from
> the root of the worktree to the current dir + "/.git".  (As a
> refresher, running this command from the root of the worktree returns
> ".git").
>
> I wrote a quick test to demonstrate the problem:
>
>
> +test_expect_success 'git-common-dir inside sub-dir' '
> +   (
> + mkdir -p path/to/child &&
> + cd path/to/child &&
> + echo "$(git rev-parse --show-toplevel)/.git" >expected &&

... or

    "$(git rev-parse --show-cdup).git >expect

i.e. to use relative path, just like the case where you start from
the top.

> + git rev-parse --git-common-dir >actual &&
> + test_cmp expected actual
> + )
> +'
> +
>
> I suggest that we change the result of this call to _always_ return an
> absolute path.

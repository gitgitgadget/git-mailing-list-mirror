From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6302: drop unnecessary GPG requirement
Date: Mon, 01 Feb 2016 10:58:30 -0800
Message-ID: <xmqq4mdsw949.fsf@gitster.mtv.corp.google.com>
References: <1454271562-24291-1-git-send-email-sunshine@sunshineco.com>
	<xmqq4mdtxjxf.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1602010759480.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:58:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQJgM-0008EJ-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 19:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcBAS6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 13:58:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752380AbcBAS6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 13:58:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A011A40568;
	Mon,  1 Feb 2016 13:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N8QX4Kig4xGc/5T4Z8XZURWsCzc=; b=Abcsl+
	fu59HFCb3qh37jIR1u0msxs2Hj19iAPKvBj8weKcTMuuO93j47jAmL8ZZFO2wR7m
	BykHrF1tp1t5XlE2PngaKWvZJpdYOJEoFfcoaLagkaq/n7VfHPmtTewa31cqZX+/
	ZY+vnTQw9JNR4bGSuUvkdk0q/yC7lAMmX1MYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAfsds24fzuPaRmIyEO37bjXJddS0FHo
	QEdTUe0CU0sD8QexqcCGsMJaBs7xcCvdox/nw9DNvrhvqGhXeK5ufITv51PYr3F3
	x/hCLFK7fvIjGijTRb8YN4Hy5UT77MSuK4mj70c3mMQyRTBJYykH9O1WLQnY/GJl
	ztZp+9Zm3BQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 887FC40567;
	Mon,  1 Feb 2016 13:58:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB45A40565;
	Mon,  1 Feb 2016 13:58:31 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1602010759480.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 1 Feb 2016 08:24:34 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9B84702-C915-11E5-8E46-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285208>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> An even easier solution might be to *not* set up the signed tags in the
> 'setup' part, but only in the respective test case, and delete them right
> away after said test case?

After reading your patch, I do not find it an "easier solution", at
least with the definition of the word "solution" I would use.  It
stops testing signed or doubly signed tags everywhere, assuming that
future regressions can ever break only --points-at tests and no
other tests around signed tags.  The easiest solution along that
same line of thought taken to the extreme would be to say test_done
without having any test ;-)

The "filter entries about signed tags from the expected output"
approach I suggested would not work if the expected output files are
not line oriented and lines that would appear only when signed tags
are tested cannot be easily filtered out (like with the sed script
in the message you are responding to), but I think for the existing
test cases (with or without additions of annotated but unsigned
tags) it would work.

> Something like this (I even tested this with and without the GPG prereq):
> ...
> -test_expect_success 'check signed tags with --points-at' '
> +test_expect_success GPG 'check signed tags with --points-at' '
> +	git tag -s -m "A signed tag message" signed-tag side &&
> +	git tag -s -m "Annonated doubly" double-tag signed-tag &&
> +	test_when_finished git tag -d signed-tag &&

Interestingly, double-tag is not removed here.

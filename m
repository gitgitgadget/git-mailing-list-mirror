From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] format-patch: add an option to suppress commit hash
Date: Mon, 14 Dec 2015 13:43:15 -0800
Message-ID: <xmqq6100iu4s.fsf@gitster.mtv.corp.google.com>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
	<1450027638-788102-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:43:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8au1-0003xo-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbbLNVnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:43:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932088AbbLNVnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:43:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AFA033B9E;
	Mon, 14 Dec 2015 16:43:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pte1w9D85++66/lVpE4dbTqO1pg=; b=SOPHEq
	Ug7jXJApRqbUkpIltpPJIhbPdjCWMTr9uB3p8l4XS2q0PFQb7jmR7IPM+XaactN4
	pfdGlTwcXSWxkD69VO2bL1l+OYCMzmBgUhynm9bzCb+JyJ3+xE86Uzsa8qJjp3uw
	UQ7VJU3otW/iv9Vgmu3/WGfuVBsPFjGqUHahc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E9iRCAWCT9UHs68WaoV8H0FuvWQ5F1ir
	s8cgdUtSRw3AbSazOXEfC9RkZuy2QDP1uzWiWa5Lv37/0dQw1p5n5K+jEN+uoRQe
	5iou7S8XTm7iqkvTlM/oBwuMaKDTveLPTlJWEUqx5pWiFJ3D6NreCVIyEywfUBNd
	EeHxo/z8e6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41C4333B9D;
	Mon, 14 Dec 2015 16:43:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A6B4433B8F;
	Mon, 14 Dec 2015 16:43:23 -0500 (EST)
In-Reply-To: <1450027638-788102-3-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 13 Dec 2015 17:27:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B35CBAAA-A2AB-11E5-B403-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282425>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_expect_success 'format-patch --zero-commit' '
> +	git format-patch --zero-commit --stdout v2..v1 >patch2 &&
> +	cnt=$(egrep "^From 0{40} Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&
> +	test $cnt = 3
> +'

This test is not wrong per-se, but it makes the test as a whole
somewhat brittle.  People cannot add new commits in the history
being tested, which would add to the number of patches, without
adjusting this test, even though all this test cares about is that
all the mbox "From " lines record the zeroed commit object name.

    git format-patch --zero-commit --stdout v2..v1 |
    grep "^From " | sort | uniq >actual &&
    echo "From $_z40 Mon Sep 17 00:00:00 2001" >expect &&
    test_cmp expect actual

or something like that instead?

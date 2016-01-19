From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 19 Jan 2016 14:53:00 -0800
Message-ID: <xmqqio2p89mb.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 19 23:53:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLf9A-0007ri-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 23:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992AbcASWxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 17:53:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757916AbcASWxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 17:53:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 88C483D1CC;
	Tue, 19 Jan 2016 17:53:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+YkVYZbRC6wFoPhRhyLAR5xq0QM=; b=CoFH65
	5LDcq9QohH/pKo3bqYVuBlibW6i3kc3iUowtxp6c9JvFfZytFtcgtZ7iTmnpBpoo
	3UaPQaoLhteNMSH1uQ4+7E8oIHP6lUyaUY4RR8fPuvbPx07mGs+gMi42pLBRV1KR
	pWEXejziWb1Qna7c3pOlUN6OrhZ0uBizfe0eY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LrjxezInUXOmXVAlLYWq4NeNbuT2EOLe
	mUxmRj1iW2RD097Jwcod0H1We4mDat4tczvB7MH/k9RJUt4wKkUM3jCY2WLxcSt+
	mwfX09WSBwYFZjR3trJFBUGbibdsX0kzT03P35x9Sd+n9ePVwptT91MMxQqohF84
	QnIahpG6bWU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75B2D3D1CB;
	Tue, 19 Jan 2016 17:53:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EBA7C3D1CA;
	Tue, 19 Jan 2016 17:53:01 -0500 (EST)
In-Reply-To: <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Jan 2016 12:00:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64AEED5E-BEFF-11E5-8ABD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284391>

Junio C Hamano <gitster@pobox.com> writes:

> This is cute, but isn't it useful even outside Travis's context?  I
> am not suggesting to touch anything other than .travis.yml file in
> this patch, but if I wanted to get the benefit from the idea in this
> patch when I run my tests manually, I can just tell prove to use the
> cached states, no?

It seems that exporting something like

    GIT_PROVE_OPTS="--timer --state=slow,save -j8" 

when running "make DEFAULT_TEST_TARGET=prove test" does give me the
same benefit by leaving the stats from the previous run in t/.prove
when making the test scheduling decisions.

One thing I noticed but didn't dig further to fix was that this
"prove --state" business did not seem to work well together with

    make T="...list of tests..." test

that limits the set of tests to perform.  For example:

    $ rm -f t/.prove
    $ make -j4 GIT_PROVE_OPTS="--timer --state=slow,save -j8" \
	   T="$( cd t && echo t0???-*.sh)" \
           DEFAULT_TEST_TARGET=prove test

runs all test in 0xxx series and populates t/.prove with them.  And
immediately after that, with t/.prove still there:

    $ make -j4 GIT_PROVE_OPTS="--timer --state=slow,save -j8" \
         DEFAULT_TEST_TARGET=prove \
         T=t0000-basic.sh test

does not limit the test to only 0000, but ends up running all the
others recorded in t/.prove file, it seems.

I would imagine that this would not affect your use case negatively,
as it is unlikely that your automated tests are skipping different
set of tests in each run.

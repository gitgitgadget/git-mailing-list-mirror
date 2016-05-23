From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/3] travis-ci: run Git bisect on failed tests
Date: Sun, 22 May 2016 18:22:02 -0700
Message-ID: <xmqq1t4tbmbp.fsf@gitster.mtv.corp.google.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
	<1463914856-64745-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon May 23 03:22:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4eZP-0002RX-ET
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 03:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbcEWBWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 21:22:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752694AbcEWBWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 21:22:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D40831CFD4;
	Sun, 22 May 2016 21:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E7VAxfmJjGO/2r7o297wPCsnpj4=; b=i3PwR/
	gIWgpHX6zHwwgD6lcveWdjH8cpZOua9bCEuxMkckZoKHGOHKXchi9XAY1im78lC1
	g3m1nZh+4XKf98E2UPOmcSado5togQLDT/LqLVJdcQBc4kVqHfsWDPDRJnLRerKJ
	QrHT6aBEIJCr/LlkVuuydt2CjBRYUyO9hIlME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8fEOBKVgxpza1gmmTvdfEoo43nk7NiD
	6UsOUeWKvSMbaL6uSqMM0kKd0FVRmWAkcna9L26+UcdGL30T7eUnHOH/r2IgHXhT
	xjyVifgAD8XNZHun2E3GVfGvUk568U8nFQ6NepmWWwLmno5cxh6rS1s4Ed0SRiPN
	jfP9CPpZkB8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA3DC1CFD3;
	Sun, 22 May 2016 21:22:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44CC51CFD1;
	Sun, 22 May 2016 21:22:04 -0400 (EDT)
In-Reply-To: <1463914856-64745-4-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 22 May 2016 13:00:56
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1F0E1A2-2084-11E6-994E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295299>

larsxschneider@gmail.com writes:

> Junio usually pushes many commits at once to the public "pu"/"next"/
> "master" branches. If a test fails then it is not obvious what commit
> caused the failure. Therefore we run Git bisect with the merge base
> between the failing rev and its more stable branch ("next" for "pu",
> "master" for "next", and "maint" for "master") as good ref to find the
> offending commit. This is only enabled on "github.com/git/git" because
> there we can assume that all relevant branches are up to date.

Just FYI, 'git log next..pu' is not a very interesting range unless
you also use the "--no-merges" option.

Is there a good way to tell the CI that, instead of testing 'pu' (or
a specific branch in general), test all new commits that appear on
the first-parent chain between 'master'..'pu'?

It would be ideal if CI can do this every time 'master' and 'pu'
gets updated.

 - Find all commits that appear on the first-parent chain between
   'master..pu'.

 - For each of them:

   - Test it.  This tests the merge result and can catch breakages
     introduced by mismerging.

   - Also test its second parent if it is a merge.  This tests the
     tip of each topic branch in isolation.  CI gets a bonus point
     if it can remember that the tip of the topic did not move and
     the commit already passed the test to skip it ;-)

 - Optionally, for those topics that failed the "tip of the topic
   branch" test, "bisect master..$topic" to see where it breaks.

The thing is, "bisect" works only when you have a _single_ cause of
breakage, but because 'pu' is a pile of unsorted raw material yet to
be sifted into dirt and gem, once you see a failure at the tip of
'pu', mechanical 'bisect run' may not be a very useful tool, as you
do not know if there is only one breakage you are looking for.

Because the unit of integration we use is a topic branch (not an
individual commit on a topic branch), "this topic is broken", and
"this topic itself may be good, but merging it breaks 'pu'" are far
more interesting and relevant piece of information than "this commit
is what broke 'pu'".

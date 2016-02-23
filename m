From: Junio C Hamano <gitster@pobox.com>
Subject: Re: whither merge-tree?
Date: Mon, 22 Feb 2016 22:35:34 -0800
Message-ID: <xmqqr3g42atl.fsf@gitster.mtv.corp.google.com>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
	<20160222221209.GA18522@sigill.intra.peff.net>
	<xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
	<20160223050210.GA17767@sigill.intra.peff.net>
	<20160223051402.GA23375@sigill.intra.peff.net>
	<20160223060338.GA2912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:35:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY6ZR-0005Tp-DM
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbcBWGfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:35:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750704AbcBWGfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:35:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 767063DD98;
	Tue, 23 Feb 2016 01:35:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=68PZdia26XIatxrNjfoUtPuWuIU=; b=jZSUAY
	gz1t9SzcFWAknYkaHgFH1bFjR0FIcAsDGz1G0Rf5t4UbjI4l3WYrKmF6I6SRUGC/
	xCJ/NVWuBkMjH5IPJTvj/vKLl/0EENCqtVE0h/ELr57ztj4xrvtaIp7ANZt5Qia5
	MigqcF5Uq23/WpaB1A6ZaM4vsxlm00STSiei0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J7stuIz47U/LaTQPSWDDL4jvE2fAlOvF
	nSbnlRKWBHM6w7gpL+h8ddX0nT2PrfDwns8TWcVokgHbl6TMJeLUjUPjR1jCHfX+
	NLqjOAiSt/BHgNFjUNOpL/GxUvksQc47eL4pUXeGQa19gUnzzwx7P2xp8jtU3mKu
	2Bn7VZaYwyQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B3A43DD97;
	Tue, 23 Feb 2016 01:35:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C7AC53DD94;
	Tue, 23 Feb 2016 01:35:35 -0500 (EST)
In-Reply-To: <20160223060338.GA2912@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 23 Feb 2016 01:03:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A550943A-D9F7-11E5-8949-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287024>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 23, 2016 at 12:14:02AM -0500, Jeff King wrote:
>
>> I dug this all the way down to your cb93c19 (merge-one-file: use common
>> as base, instead of emptiness., 2005-11-09), which states that the goal
>> is just to get:
>> 
>> 	common file contents...
>> 	<<<<<< FILENAME
>> 	version from our branch...
>> 	======
>> 	version from their branch...
>> 	>>>>>> .merge_file_XXXXXX
>> 	more common file contents...
>> 
>> But that seems to be what we produce now. Did all of this simply predate
>> xdl_merge, and the crappy rcs merge did not bother minimizing the diff?
>> That certainly seems to be the case in my tests.
>> 
>> If that is the case, I think we can get rid of the complex
>> create_virtual_base(), as well.
>
> So here is what I would propose:
>
>   [1/3]: merge-one-file: use empty blob for add/add base
>   [2/3]: merge-tree: drop generate_common strategy
>   [3/3]: xdiff: drop XDL_EMIT_COMMON
>
> I briefly wondered if there were any bugs in merge-one-file around this
> "no newline at end of file" issue. But there shouldn't be. It generates
> the common file by applying the diff to the first file with "--no-add",
> which should do the right thing, I think.
>
> I stopped short of dropping the create_virtual_base function in the
> first patch, for reasons explained there. But if we were to do so, I
> suspect we could deprecated and eventually drop "apply --no-add", too.

Thanks.  I think the "virtual" stuff started its life outside
sh-setup but later was moved there for p4merge.  The log message for
4549162e (mergetools/p4merge: create a base if none available,
2013-03-13) seems to indicate that using an empty file does not work
well over there as you suspected, so unfortunately we cannot lose it
just yet.

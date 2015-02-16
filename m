From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 10:43:47 -0800
Message-ID: <xmqq1tlp7l3w.fsf@gitster.dls.corp.google.com>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
	<alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz>
	<20150216150305.GA8279@peff.net>
	<alpine.DEB.2.02.1502160727480.23770@nftneq.ynat.uz>
	<20150216154745.GA10120@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Lang <david@lang.hm>,
	Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:43:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNQeC-0001bv-0W
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 19:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbbBPSnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 13:43:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752933AbbBPSnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 13:43:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A55937FB2;
	Mon, 16 Feb 2015 13:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqcoZHzLar61OvXrs3hVWTSjNS8=; b=AmpBpW
	8lbREsDEuR4okeeZ+jUwkXhv8IvAK+cYectfFZio0HTPNcdvZP0udvP8PhcFenrY
	AN7wDwIeTt3nr4OYlcw5xLFqVjKECBdb6TWc3NwoVYcaVwnGraeS+mLWRuZJJvL3
	qskGZzacmlT375qYh9PCqMGDY2QLiK423HVxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PkCXpcCqfThMZMG6Kr2eQJaYrYhEs/Iu
	DJUY05odr5bPZtyw1liJn9TEL1u8BqpwsfSPR1TKu+3Tdti/YWdu5l52quOzqfMp
	OZ0XIYNWocSdolqL12CSYunwiKHpKLU+A4f0NVzWMy7MKXrY2/feLD9Z+DF9FVHs
	HxSNj8v8lpo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F46C37FB1;
	Mon, 16 Feb 2015 13:43:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8B9A37FAF;
	Mon, 16 Feb 2015 13:43:48 -0500 (EST)
In-Reply-To: <20150216154745.GA10120@peff.net> (Jeff King's message of "Mon,
	16 Feb 2015 10:47:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BEBE3726-B60B-11E4-B343-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263912>

Jeff King <peff@peff.net> writes:

> ... And the whole output is checksummed by a single sha1
> over the whole stream that comes at the end.
>
> I think the most feasible thing would be to quickly spool it to a
> server on the LAN, and then use an existing fetch-in-parallel tool
> to grab it from there over the WAN.

One possibility would be for the server to prepare a static bundle
file to bootstrap all the "clone" clients with and publish it on a
CDN.  A protocol extension would tell the client where to download
the bundle from, the client can then grab the bundle to clone from
it to become "slightly stale but mostly up to date", and then do a
usual incremental update with the server after that to be complete.

The server would update the bundle used to bootstrap clone clients
periodically in order to keep the incrementals to the minimum, and
would make sure their bitmap is anchored at the tips of bundles to
minimize the object counting load during the incremental phase.

I think "repo" used by folks who do AOSP does something similar to
that by scripting around "git clone".  I'd imagine that they would
be happy to see if "git clone" did all that inside.

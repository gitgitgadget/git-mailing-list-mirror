From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Tue, 29 Jan 2013 14:26:50 -0800
Message-ID: <7vmwvrocb9.fsf@alter.siamese.dyndns.org>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <7vlibfxhit.fsf@alter.siamese.dyndns.org>
 <20130129082939.GB6396@sigill.intra.peff.net>
 <7vwquwrng6.fsf@alter.siamese.dyndns.org>
 <20130129211932.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Je9-0007Lo-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 23:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab3A2W04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 17:26:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab3A2W0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 17:26:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB770BB50;
	Tue, 29 Jan 2013 17:26:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bcsl30u9W8XnfAyTuBU9bzgI1G8=; b=s0zmYF
	3UtrdtlwPBjYccAZmDfvafs4yMTw+iJ6cNC4lupuFMKm+rqaDMtI/pSxU2OyADbv
	Obt4dLTrQby9n30OJHS1X0B4aE1jLZGqvjleaKPMKbQ1GTfz/1WFD4YcZ6gzJT3U
	DfiGX/kQQxmYottyEuxUMmudGpxQRIL3EvTq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FXNmZ+kXKOrPay+uZzLZD332Ay1lKQJ8
	3dW8TpizPok2vsysKkQjYjMonXZMfDVuQYXkF4soMq3o0GMGHpf33QqIdoBURMK6
	qeQpHsq4kka3NYWAyGRsCdTwBdzafMTwpI1YG7LAVzzna8F9tjbamcErDz0GKwqm
	TA7DFMCYJjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A159ABB4F;
	Tue, 29 Jan 2013 17:26:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37B0DBB4D; Tue, 29 Jan 2013
 17:26:52 -0500 (EST)
In-Reply-To: <20130129211932.GA17377@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Jan 2013 16:19:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAD85774-6A62-11E2-BDC7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214975>

Jeff King <peff@peff.net> writes:

>> > But how do these somewhat mediocre concatenated packs get turned into
>> > real packs?
>> 
>> How do they get processed in a fetch-only repositories that
>> sometimes run "gc --auto" today?  By runninng "repack -a -d -f"
>> occasionally, perhaps?
>
> Do we run "repack -adf" regularly? The usual "git gc" procedure will not
> use "-f", and without that, we will not even consider making deltas
> between objects that were formerly in different packs (but now are in
> the same pack).

Correct.  It is not a new problem, and while I think it would need
some solution, the "coalesce 50 small young packs into one" is not
an attempt to address it.

> So you are avoiding doing medium-effort packs ("repack -ad") in favor of
> doing potentially quick packs, but occasionally doing a big-effort pack
> ("repack -adf").

So I think "but occasionally" part is not correct.  In either way,
the packs use suboptimal delta, and you have to eventually pack with
"-f", whether you coalesce 50 packs into 1 often or keep paying the
cost of having 50 packs longer.

The trade-off is purely between "one potentially quick coalescing
per fetch in fetch-only repository" vs "any use of the data in the
fetch-only repository (what do they do?  build?  serving gitweb
locally?) has to deal with 25 packs on average, and we still need to
pay medium repack cost every 50 fetches".

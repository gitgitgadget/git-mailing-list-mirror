From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Thu, 14 Apr 2016 11:37:32 -0700
Message-ID: <xmqqpotsf34j.fsf@gitster.mtv.corp.google.com>
References: <20160414180709.28968-1-gitster@pobox.com>
	<20160414180709.28968-2-gitster@pobox.com>
	<20160414182102.GB22068@sigill.intra.peff.net>
	<20160414182544.GC22068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqm9D-0004Lz-TT
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbcDNShh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:37:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932220AbcDNShg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:37:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FDBD138CA;
	Thu, 14 Apr 2016 14:37:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lvdQigaUe2GLNR7NxnlAcIj/uDs=; b=e8lECn
	YlMTKRTt/8UQA2aQ8s9sFy665v4OhIRcCf8LgCr8OINMnoUL9APZBoAsjNNBLLxA
	jFbaJrlJWNmE9/bANKWF3ORRI8W04PkTAOauNPUUBTEP3qS4P0oBe4NNLT5ARe20
	9OMbtJ7yJ8R3s5Vc7SaS/MH9zDAt9+I/nS/JE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tXM2ZqRs9iOs0lehPKSE2JmlRRLrpekn
	DIex18DXYOWS/FA9x+to0QY9tRJacGQwYawhz3t9hO6awMLIEZTNCN3wb2A1760t
	+i48mhZe8qv7CYNsb7AvDQT1K2ZNPDeD3i10Rsv14RTefoYlhRzMBRAoymyO1zIs
	XmoOAuaW/wE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67073138C9;
	Thu, 14 Apr 2016 14:37:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6EB6138C7;
	Thu, 14 Apr 2016 14:37:33 -0400 (EDT)
In-Reply-To: <20160414182544.GC22068@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Apr 2016 14:25:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3EB7F60-026F-11E6-9505-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291556>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 14, 2016 at 02:21:03PM -0400, Jeff King wrote:
>
>> So yet another alternative would be to include this check in
>> verify_headers(). It would parse to the end of the headers as now, and
>> then from there additionally look for a NUL in the body.
>
> Hmm. Looking at verify_headers(), I think it has another bug.
>
> It wants to "return report(...)" as soon as it sees a problem, and stops
> looking for other ones. But the new model for reporting errors is that
> report() might ignore a problem if configured to do so.

Yup, it should be doing the "do not return early unless report says
it is questionable", at least.  Accumulating the error with err |=
report() is an improvement, but even without that, doing the usual

	case '\0':
        	err = report(...);
                return err if err;

would be a real bugfix.

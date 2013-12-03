From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ideas to speed up repacking
Date: Tue, 03 Dec 2013 09:50:07 -0800
Message-ID: <xmqqhaapq0xc.fsf@gitster.dls.corp.google.com>
References: <201312021630.45767.mfick@codeaurora.org>
	<xmqqpppepxuu.fsf@gitster.dls.corp.google.com>
	<CACsJy8DJU2YTE1iNdb=fvo0fVOgLUK2mKXUhjcoJh8Ac0wW_EA@mail.gmail.com>
	<xmqqli02pfnf.fsf@gitster.dls.corp.google.com>
	<CACsJy8CBOp_5nwm=WWBG_AZ+h6M7L6WpdX4ACeJxwuJ0kqu0Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 18:50:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnu74-0003OS-DT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 18:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab3LCRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 12:50:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab3LCRuO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 12:50:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3401553CF2;
	Tue,  3 Dec 2013 12:50:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YeG0pdKmTdFazzoK1hrsYo78x/s=; b=DwdQqb
	gL6Isc4wI/uU1zIZ3Swmg5IBtjh0fLlOJDEOcpPg6lushq5r4pww4QDNtmOzrcoD
	XCP1lwpiKyXw7wFx8fx8s7zFj5f4VOeoGDgLmNerz8nPJRazQMXK/WFQnndszw8f
	yFc2TN1CmfQy2DU6AUzjvXizm1X+/iFH8jq4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mF9wTg239PpEsbpCnvEqbe0gRbO7gzAX
	qv2Xwod624EH70JKs1dTASpsSPe07hG+rVAW+e10zehaEYV14XlnCJypgin2ncOI
	2vZHP5ce5QboxgQKcus2bGzVSEknMwbeuPQgTejHleHo0xHZtMEDywmYOeBpgDPj
	vSQHQGFykCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C1753CF1;
	Tue,  3 Dec 2013 12:50:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D0F153CEE;
	Tue,  3 Dec 2013 12:50:12 -0500 (EST)
In-Reply-To: <CACsJy8CBOp_5nwm=WWBG_AZ+h6M7L6WpdX4ACeJxwuJ0kqu0Gw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 3 Dec 2013 17:17:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BC1C6C4-5C43-11E3-9F5E-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238702>

Duy Nguyen <pclouds@gmail.com> writes:

> Reading Martin's mail again I wonder how we just
> "grab all objects and skip history traversal". Who will decide object
> order in the new pack if we don't traverse history and collect path
> information.

I vaguely recall raising a related topic for "quick repack, assuming
everything in existing packfiles are reachable, that only removes
loose cruft" several weeks ago.  Once you decide that your quick
repack do not care about ejecting objects from existing packs, like
how I suspect Martin's outline will lead us to, we can repack the
reachable loose ones on the recent surface of the history and then
concatenate the contents of existing packs, excluding duplicates and
possibly adjusting the delta base offsets for some entries, without
traversing the bulk of the history.

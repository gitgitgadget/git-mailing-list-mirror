From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Tue, 24 Feb 2015 21:00:20 -0800
Message-ID: <xmqq8ufmpouz.fsf@gitster.dls.corp.google.com>
References: <20150224214311.GA8622@peff.net>
	<xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
	<20150224224918.GA24749@peff.net>
	<xmqqd24yq517.fsf@gitster.dls.corp.google.com>
	<20150224234737.GA8370@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 06:00:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQU5M-0008G8-Sw
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 06:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbbBYFAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 00:00:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750702AbbBYFAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 00:00:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DA8D3C7B2;
	Wed, 25 Feb 2015 00:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OXrtTBpc26oqIXzdN2pyO+73SLo=; b=sd8vSC
	da0Z6hf4JDlMCGOQo4pIgi7QSFEUy98pq5YOmR9+LRRIpYcAaMqknl3lCDjFyVfp
	eNo3poVFBD9+sXd0aX50GdaALTjnLdtFfbOWFV1HDVC9ZpC5egoqFhzlVXDpe+cs
	ENBySMaV+U/gMSLyijhIk3xX9WHioTTDc4J5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NmtYuVBg7UjzSwB/oeJDxu7TjeT7I2mz
	hJ3GV0cvW+IqlUgTc/wm8oSoKKh94kSlOf+JhSok2RXKecCmVPltB7eDR7zEKWVj
	pt8nU35V0DdUzcETpaiamtgu1xhgaWq4nQ3hTj3GbZtajicx6nHAhdSf54h1vm+K
	Atlp03TmImo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9528E3C7B1;
	Wed, 25 Feb 2015 00:00:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68FA23C7A0;
	Wed, 25 Feb 2015 00:00:21 -0500 (EST)
In-Reply-To: <20150224234737.GA8370@peff.net> (Jeff King's message of "Tue, 24
	Feb 2015 18:47:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3351D8B8-BCAB-11E4-81CD-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264366>

Jeff King <peff@peff.net> writes:

>   3. The sort order check is wrong. :-/ It needs to take into account
>      git's magic "if it's a tree, pretend it has '/' after it" rule.
>      That's not too hard for a single tree (fsck.c:verify_ordered does
>      it). But for filepairs, I'm not sure what to do. Most cases
>      have a single mode/name pair. But what about a D/F typechange? If
>      "foo" becomes "foo/", which do I use to sort?

I think diff-index populates the diff queue in a wrong order and
then calls diffcore_fix_diff_index() to fix it up.

I am a bit worried about the effect this stricter input check might
have to "diff --no-index" codepath, though.

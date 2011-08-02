From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: allow partial commits with relative paths
Date: Tue, 02 Aug 2011 14:31:47 -0700
Message-ID: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <20110729133551.GA8707@toss.lan> <4E343534.8000604@drmicha.warpmail.net> <20110730170045.GA9900@toss.lan> <4E34399C.2080109@drmicha.warpmail.net> <20110730171347.GA10432@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Reuben Thomas <rrt@sc3d.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 23:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoMZ8-0000JV-TI
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 23:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab1HBVbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 17:31:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367Ab1HBVbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 17:31:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2954957;
	Tue,  2 Aug 2011 17:31:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jjHijl7r0NZRiVFyWRkeNyLVDUo=; b=C8HRuc
	moPCe9oglUyeei5lxGy1gLy/Nh2Io44CxmG0JGPSsiZToTwQNBHAOWoPlX3pLAcf
	nw+LpMYVueGwVDMpzeChAubAF6X+It/F05ItDPeQo60I39pqgnYd4E51Zm5PwUIA
	C5XmcIQNxRtlq8HKqelu3pwXMUcrXHzd+RSlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKeyf3YVvj/BMvw12XNFK8jKocNikYJP
	xAZdQG1ZXEe3tcB4F3jGf6Vn9B27sIT/gryX1VhyioPWte93l0dXvEvwTfpF23DD
	ncpoZN1nAOnQdAU3mP+sC0TvwZJK0VkcD9qbGv+jd2v+TYtHgl27j3bDytr82OP3
	yuDUYCKCM5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 540E44955;
	Tue,  2 Aug 2011 17:31:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCB874954; Tue,  2 Aug 2011
 17:31:48 -0400 (EDT)
In-Reply-To: <20110730171347.GA10432@toss.lan> (Clemens Buchacher's message
 of "Sat, 30 Jul 2011 19:13:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D45E2456-BD4E-11E0-ACA9-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178512>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/setup.c b/setup.c
> index 5ea5502..2c51a9a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -264,6 +264,38 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
>  	return pathspec;
>  }
>  
> +const char *pathspec_prefix(const char *prefix, const char **pathspec)
> +{

As a public function, this sorely needs a comment that describes what it
does. More importantly, when I tried to come up with an example
description, it became very clear that this neither prefixes anything to
pathspec, nor prefixes pathspec to anything else.

As an internal helper in ls-files implementation it was perfectly
fine that the function was slightly misnamed, but if you are making it
into a public API, we should get its name right.

Perhaps "common_prefix()"?

Don't you also want to consolidate dir.c:common_prefix() with this?

What happens when pathspec has the recently introduced magic elements,
e.g. ':/' that widens the match to the whole tree?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] show: turn on rename detection progress reporting
Date: Thu, 24 Mar 2011 16:35:37 -0700
Message-ID: <7vzkok6qie.fsf@alter.siamese.dyndns.org>
References: <20110324174556.GA30661@sigill.intra.peff.net>
 <20110324174916.GC30685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:35:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2u4J-0006tL-On
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 00:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934373Ab1CXXfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 19:35:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934337Ab1CXXft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 19:35:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 799DF4FF9;
	Thu, 24 Mar 2011 19:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OX/ImXbN2qQkGsJwAQr5XgywUBs=; b=x+D7x5
	FDaYDBHoZwKSO3RtEYP4eLDhSe2AMWQt8oksd4XppgL40ocTl/bl6csLKWpxDhEx
	GIdmVrnw6Vi5Lv85dxDvaTISdVn8rlxU1e+Hm1Y+/HKn6n5GsnX8tsNvTTdBq4Me
	kXKCn7/xmZHB/L83ub+NZenYAgW+g3QQJblgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y4/3b9g2CRjz1rA7OZJd26eskmVx6EM6
	yObT5bje5IEed0/s+dxgX9DY0nfxeeVOfylf2vKKcqW4NRTis85mmmqVqc6VN/sQ
	Fc3gQUMpN5qGWh6EcEWtibibCjhw3Ey3AsCk+bO863Pfd7B3FdIJwxUOxdy7LunH
	IuIsCpO7d04=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 582524FF6;
	Thu, 24 Mar 2011 19:37:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 491884FF5; Thu, 24 Mar 2011
 19:37:21 -0400 (EDT)
In-Reply-To: <20110324174916.GC30685@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Mar 2011 13:49:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC46E692-566F-11E0-9781-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169954>

Jeff King <peff@peff.net> writes:

>  	while ((commit = get_revision(rev)) != NULL) {
> -		if (!log_tree_commit(rev, commit) &&
> +		int showed = log_tree_commit(rev, commit);
> +		if (showed &&
>  		    rev->max_count >= 0)
>  			/*
>  			 * We decremented max_count in get_revision,
>  			 * but we didn't actually show the commit.
>  			 */
>  			rev->max_count++;
> +		/* Once we have output, progress will clutter the terminal. */
> +		if (showed)
> +			rev->diffopt.show_rename_progress = 0;

After looking at the implementation of log_tree_commit(), shouldn't this
part be more like this?

	int shown = log_tree_commit(rev, commit);
        if (!shown && rev->max_count >=0)
        	rev->max_count++;
	if (shown)
        	rev->diffopt.show_rename_progress = 0;

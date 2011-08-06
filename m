From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Add AUTH LOGIN support
Date: Fri, 05 Aug 2011 21:54:53 -0700
Message-ID: <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
References: <c1be0c3bd05779897fdc92907fe65d84c88ac72b.1312591104.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 06:58:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpYy6-0008BV-Ip
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 06:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010Ab1HFEy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 00:54:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab1HFEy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 00:54:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAC8C5BAB;
	Sat,  6 Aug 2011 00:54:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QAOSam4DY2WR4I+TgtKc7cU/gjA=; b=eQGY/j
	QYAgN62PYjeb/gsGKDAgfE6iFzrMnOEm2WZA3/ALL9C7UBYpHO0vZl/lTeVPd5GL
	7ELoP70uYDB9Yi2Fo/gPgK4IsVplu+IjvXAUsfj/5oMG1pXl7PfC/poB87IZcw76
	cI1ztekp/Bh+310SXQAa56XysXR2dajDZfgyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TdAyyGUrUnb28K6bDt4EAu/XdUSANlhd
	7wRrcyZofY31DoUQ2R7T5LINr1KiW2WP5D8xyRVR/eF/WRmw7obKjKE93tSHiypz
	3qb4UdLLYygs/ZdNdpYHyLGVSadeDfnldlQV5hWAd2qKpCB/XaMBnWeo4cxsWrdb
	AZa0YHEtyNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D25765BAA;
	Sat,  6 Aug 2011 00:54:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 643DC5BA9; Sat,  6 Aug 2011
 00:54:55 -0400 (EDT)
In-Reply-To: <c1be0c3bd05779897fdc92907fe65d84c88ac72b.1312591104.git.joe@perches.com>
 (Joe Perches's message of "Fri, 5 Aug 2011 17:40:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A662DB6-BFE8-11E0-A9EE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178824>

Joe Perches <joe@perches.com> writes:

> The current perl Net::SMTP support will not use AUTH LOGIN
> when other authentication options are available.

Even after reading this excuse,...

> +			if (defined $smtp_auth && $smtp_auth =~ /^login$/i) {
> +
> +			    $smtp->datasend("AUTH LOGIN\n");
> +			    $smtp->response();
> +			    $smtp->datasend(encode_base64("$smtp_authuser"));
> +			    $smtp->response();
> +			    $smtp->datasend(encode_base64("$smtp_authpass"));
> +			    $smtp->response();
> +
> +			} else {
> +
> +			    $auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> +			}

... this makes me feel dirty X-(. Not the desire to force "AUTH LOGIN",
but the implementation to hand-roll the protocol exchange.

I'd rather want to know _why_ Net::SMTP does not support it in the first
place, and what it does for "other authentication options" that are
available. Does it try them in turn until it finds the one that works? Why
doesn't it fall back on "AUTH LOGIN" then?

Specifically, if there is a reason to avoid this plaintext authentication
method when other options are _available_ (which presumably would be the
reason why Net::SMTP chooses not to support it), and if there is a reason
on the user's side to _force_ this method even when people who wrote
Net::SMTP does not recommend it be used, wouldn't it be natural to expect
that there should be a way to configure the connection to use it, without
resorting to coding the protocol exchange by hand line this?

It probably is not as simple as installing Authen::SASL::*::LOGIN, but
still...

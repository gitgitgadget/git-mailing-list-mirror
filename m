From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Wed, 21 Mar 2012 21:09:36 -0700
Message-ID: <7viphxz37j.fsf@alter.siamese.dyndns.org>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
 <1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 05:09:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAZLN-0002Bd-G6
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 05:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab2CVEJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 00:09:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2CVEJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 00:09:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E98476E7;
	Thu, 22 Mar 2012 00:09:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OVFH4hVxYESPzSHaRqoE7uZw0dg=; b=X+m1V8
	iG83b2uxGKrB0oF9HTFhoJyjX2DqDz6euCcYV4bFyjuOWUq6rupy1zMWeQZrq+8z
	4Wtl7bmjsIOyibXN4EF9xyUmAWFJmyIdBUL8a/erGlElhFpclyad9TnVUJjDe4SU
	iXg3V+yE83IPhcSMo/hvraKR+H0Tt2ihkmMIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s8iu7gBP/T92q+sdKfwroIx+H3SA9TeC
	hGz9FFmnTwi5aV+CaN+p0e/JU8ClCUcI7dbMKlHvKxp/cv/ZDj832FoF4Swk3RIT
	tutJoMRqWfqFM2o0FDOhLOSfQmVnH/xpV+wAj/3/Kx+6P4Pcs5iuMTBSsV6WXq9v
	I3lfro4vjYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8512C76E6;
	Thu, 22 Mar 2012 00:09:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B98E76E5; Thu, 22 Mar 2012
 00:09:38 -0400 (EDT)
In-Reply-To: <1332381236-16004-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Wed, 21 Mar 2012 21:53:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D75C64DC-73D4-11E1-97A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193633>

Tim Henigan <tim.henigan@gmail.com> writes:

> +# the '--prompt' and '--no-prompt' options require special treatment
> +# because they may be specified more than once...the last one "wins".
> +for (@ARGV) {
> +	if (($_ eq "-y") or ($_ eq "--no-prompt")) {
> +		$prompt = 0;
> +	} elsif ($_ eq "--prompt") {
> +		$prompt = 1;
> +	} else {
> +		push(@diffargs, $_);
> +	}
> +}

I really do not like the direction in which this series is going.  We do
not have a similar --no-gui option to defeat --gui option that may appear
earlier on the command line, but when we fix that bug (isn't it a bug?),
we would have to teach this loop about that option, wouldn't we?

In the end, won't you end up resurrecting the argument parsing loop that
you got rid of with the first patch in your series?  Isn't this working
around the problem introduced only because you are using Getopt::Long and
hitting its limitations?

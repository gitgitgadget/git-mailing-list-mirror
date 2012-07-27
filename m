From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Fri, 27 Jul 2012 01:19:37 -0700
Message-ID: <50124F19.1050502@pobox.com>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-2-git-send-email-schwern@pobox.com>
 <7vobn13hps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 10:19:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sufm0-0003Cf-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 10:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab2G0ITm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 04:19:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab2G0ITk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 04:19:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 910AE57A1;
	Fri, 27 Jul 2012 04:19:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=zt2yCbO82zAZ
	HEGJgREY7u6dGZc=; b=EG4T7BZ1GWxIXUypRAu0UEYS1VYdHw+SF5QQseZqHy6B
	4d7hfAUTWSVAWbFwabz9iACCZ757IxVVmBO6Uol7exkHmHlspD8VS5iFgqvn18rP
	emF0MZhSCqP2DNyLgu0eVHVOVXPCgtlLZGH4FwHh4anHcpDpwyZvr+17FwN8jag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dXVt+T
	v1/RaptK8+t8VvLGA3dIsB0Cy6AnwCjltviYSUdeCaqPaA/y3+J12NvJTZRpyDx5
	GP9+bsIdQ9CLZEpcVj5Rh+0F+u1x76064B0eOYJuOVHIJeziUkbGjDAzMtPRh2vC
	+7f5yLWOhdZ07m8VpJGHRuVZmeq9el/zmiWHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E52857A0;
	Fri, 27 Jul 2012 04:19:39 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CBA1579E; Fri, 27 Jul
 2012 04:19:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vobn13hps.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: CF26CFD4-D7C3-11E1-9431-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202345>

On 2012.7.26 10:18 PM, Junio C Hamano wrote:
>> +# Note: not certain why this is in use instead of die.  Probably because
>> +# the exit code of die is 255?  Doesn't appear to be used consistently.
>> +sub fatal (@) { print STDERR "@_\n"; exit 1 }
> 
> Very true.  Also I do not think the line-noise prototype buys us
> anything (other than making the code look mysterious to non Perl
> programmers); we are not emulating any Perl's builtin with this
> function, and I do not see a reason why we want to force list
> context to its arguments, either.  But removal of it is not part of
> this step anyway, so I wouldn't complain.

The prototype does absolutely nothing since @ is the default prototype.  But
yes, I'm doing a very rote refactoring here.


>> +sub can_compress {
>> +    return $can_compress if defined $can_compress;
>> +
>> +    return $can_compress = eval { require Compress::Zlib; } ? 1 : 0;
>> +}
> 
> The original said "eval { require Compress::Zlib; 1; }"; presumably,
> when require does succeed, the value inside is the "1;" that has to
> be at the end of Compress::Zlib, so the difference should not matter.

Yes.  In other situations where you cannot guarantee that the statement in the
eval will return true it makes sense, but here it's redundant.


-- 
Being faith-based doesn't trump reality.
	-- Bruce Sterling

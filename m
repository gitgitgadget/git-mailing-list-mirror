From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Mon, 30 Jul 2012 14:10:10 -0700
Message-ID: <5016F832.7030604@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:10:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvxEK-00014s-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 23:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab2G3VKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 17:10:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab2G3VKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 17:10:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6339690CF;
	Mon, 30 Jul 2012 17:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=L6XtBwXfkmag
	LbYH6pbD2io9Dn8=; b=NQneJzi9L0of+OVjKDGhWz4BZtGgnYXLkFyskVVxFoZL
	7t1dBzlMKu3bgsutF9sSRLbp/2Y+ZEMAeyr9uN1hQ17lAf9wIXlzADrQx0J7SDeU
	d/N7s7vPX8MZ29uYbCnx+2QNOTwB/OUzk0wKpzghv3YH+FSLme9Fks0dbwnZARA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w/fIe6
	mJhbUEIvhgQ8dB0LnSAuJx25cYCLjbuuEZU2rHjQu9Hsdq/tsGtLDKoG//5FBMfN
	RNy3c2BJmSu3yz353CWk+irk6CJFQPHOevBWtq4lpvJ5VgthdBz9WAawDIAkhdSh
	JcXftQZA7PxS7MDQaByd5azfKEPXNuzwscYkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FBEB90CE;
	Mon, 30 Jul 2012 17:10:13 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5047D90CC; Mon, 30 Jul
 2012 17:10:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120730203844.GA23892@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: F3374DC6-DA8A-11E1-AC4F-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202616>

On 2012.7.30 1:38 PM, Eric Wong wrote:
>> A better solution would be to have path and URL objects which overload
>> the eq operator and automatically stringify canonicalized and escaped.
> 
> Perhaps we can depend on the URI.pm module?  It seems to be
> widely-available and not be a significant barrier to installation.  On
> the other hand, I don't know its history, either (especially since we're
> now dealing with SVN changes...).

If you want to go down the road of having CPAN dependencies, then it should
definitely be used rather than rolling our own and generating our own bugs.
It's a very commonly needed Perl module.

You'd make a subclass and put any special work arounds for SVN in there.


> Anyways, I don't like relying on operator overloading, it makes code
> harder to read and review.

Right now, canonicalization is a bug generator.  Paths and URLs have to be in
the same form when they're compared.  This requires meticulous care on the
part of the coder and reviewer to check every comparison.  It scatters the
logic for proper comparison all over the code.  Redundant logic scattered
around the code is a Bad Thing.  It makes it more likely a coder will forget
the logic, or get it wrong, and a human reviewer must be far more vigilant.

Right now I'm pretty sure there's still a ton of bugs.

It also slows things down.  As strings, URLs and paths have to be
canonicalized every time they're used or compared.  An object representing the
URI or path can cache the canonicalization.

With string comparison overloaded, you'd no longer have to meticulously check
that URLs and paths are always in the same form when they're compared.  It
just does it.  The logic is in one place.  We don't even have to care if one
of them is a string (or which one), it works even if only one half of the
comparison is an object.  A new coder to the project doesn't need to know
anything special about URIs and paths, they just treat them as strings.
Finally, they can be slipped into existing code without having to rewrite
everything.

Overloaded comparison and stringification can even be used as a tool to find
all the places in the code where URLs and paths are being used, where they're
being turned into strings, and where URL and path manipulation is being done
ad-hoc.  For example, if comparison sees one of its arguments as a string, or
if concatenation is used.

The only downside is when chasing down a bug related to canonicalization one
might have to realize that eq is overloaded.  But we'd have far less bugs due
to canonicalization.  So worth it.


-- 
Being faith-based doesn't trump reality.
	-- Bruce Sterling

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: modernize and standardize external tool
 calling
Date: Sun, 17 Jan 2010 11:15:47 -0800
Message-ID: <7v8wbwzgnw.fsf@alter.siamese.dyndns.org>
References: <1263700523-2111-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1263749749-3939-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:16:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWabP-00027P-KA
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab0AQTPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552Ab0AQTPz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:15:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab0AQTPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:15:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB00A91A2A;
	Sun, 17 Jan 2010 14:15:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mUOjKUHh+LZZdI0TrUHd0Doppt4=; b=q37fV+
	aKShlv+cAVU5jRp2GxeIuvEzIe6KHl1zXhB2iFgYVWeABk9sfDy3XJ0BqOBVFXQF
	AOA0JuFv+oW1XMkihAmaSeO2bBTDxky9jTsZEmb0r+meg0HPCU7OaF7znW65lT06
	nEyBwCf/jzBm1tILbdFvOFgDc6/Di8M2mUSso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JZKH+krvMuKZInG5/0as1qu6krqkJuhW
	iOVe98x9NwBffA47rBmKDsZ+jXNDtqrUbzvGcDpe7URjKte+ZBu+M/nkNdaIxDy0
	kh+W6B8H9MaIaK4erxeFWPHNKNMqO2JEv0ZewDC2hiljsQW88CDUOC1C26t/Br1s
	wzK/iz31+e0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 981FD91A28;
	Sun, 17 Jan 2010 14:15:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E421A91A27; Sun, 17 Jan
 2010 14:15:48 -0500 (EST)
In-Reply-To: <1263749749-3939-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sun\, 17 Jan 2010 12\:35\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA110D9C-039C-11DF-816E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137310>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> The cvsimport module was mixing old (git-foo) and new (git foo)
> conventions when calling git tools.  This patch standardizes the
> calling conventions used in system(), open(), exec() and backticks.
>
> Reported-by: Alexander Maier <amaier@opencsw.org>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
> This takes into account the feedback from Junio.

Hmph...

> -	open(my $fh, '|-', qw(git-update-index -z --index-info))
> -		or die "unable to open git-update-index: $!";
> +	open(my $fh, '|-', 'git update-index -z --index-info')
> +		or die "unable to open git update-index: $!";

I think this change is backwards (and there probably are others).

It used to use a shell-less one-element-per-argument list form to spawn
the process that reads from the pipe, but now you are passing a single
string to be split by the shell.

How about doing this as a two (perhaps three?) patch series instead?

 (1) s/git-foo/git foo/ and _nothing else_;
 (2) s/open fh, '|-', 'string'/open fh, '|-', qw(string)/ and
     s/system 'string'/system qw(string)/.

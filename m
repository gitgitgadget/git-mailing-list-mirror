From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix error when highlight is enabled
Date: Wed, 26 Dec 2012 01:55:46 -0800
Message-ID: <7vpq1xp271.fsf@alter.siamese.dyndns.org>
References: <1356508456-17454-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 10:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnnih-0001bh-V6
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 10:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab2LZJzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 04:55:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821Ab2LZJzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 04:55:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DB917A04;
	Wed, 26 Dec 2012 04:55:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cFyf/VFAFl53tEO+CbQI9usl1Ow=; b=W28FQx
	OfhB07UIna4lihp8RhTMJvB/s7YrV+hHNBWK+VcG9SLTQ2LuvgkQQ9wGXldCahDO
	AOfB4l5R4Yp6bElJyeLLAhbb2qfiW0yB7lqzMjtP7MB8yFT+sE+yaeMfCAsWONDv
	pAg2M2AjQSdx/577YLz1w/2oTwExbuPC83zYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GewIJyWj/t2VNV1aQ7shubEM8djVVlZp
	40TPPXavFw7mVX7QNixzpvWN8NN58oYZb30IXujBcN7WLIPkpB8aWovq+kx9B8mS
	B+L/g3TpR90dg4Mu9wjm6nV8eXs2SgxLINkALwgFul6sJnijp7wZskI9Xcv8HIcd
	tKR1dhkmj4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE7A7A03;
	Wed, 26 Dec 2012 04:55:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ECFD7A01; Wed, 26 Dec 2012
 04:55:48 -0500 (EST)
In-Reply-To: <1356508456-17454-1-git-send-email-orgads@gmail.com> (Orgad
 Shaneh's message of "Wed, 26 Dec 2012 09:54:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CBC988C-4F42-11E2-B1DB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212132>

Orgad Shaneh <orgads@gmail.com> writes:

> Use of uninitialized value in substitution iterator at gitweb.cgi line 1560

This is not just about squelching an error message, but more
importantly, attempting to fix an information lossage, no?

The statement captures each control character in the string to $1,
then matches a class of known/safe control chars against that
control character we just have seen. If matches, it just wants to
use that control character, otherwise it wants to apply quot_cec()
on that control character.  It forgets that "$1" is reset
immediately when =~ matches with the class of known/safe control
chars, and your version attempts to fix it by recapturing it.

What if you are looking at a non-safe control, say "\001"?  It is
matched and is captured by ([[;cntrl:]]), making $1 -eq "\001", and
then the replacement side of s///e operator, tries to match and
capture it with ([\t\n\r]), but it does *not* match.

What does that "$1" you are feeding quot_cec() contain at that
point?  I _think_ "$1" is left intact when the inner match fails and
you are correctly feeding "\001" to quot_cec(), but it is not
immediately obvious.  Perl regexp, especially s///e, is a yucky
language X-<.

I wonder if there is a better way to express what goes inside the
replacement side of this s///e construct in a more obvious way. The
updated one may be correct but it looks too subtle to my taste..

> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0f207f2..862b9cd 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1556,7 +1556,7 @@ sub sanitize {
>  	return undef unless defined $str;
>  
>  	$str = to_utf8($str);
> -	$str =~ s|([[:cntrl:]])|($1 =~ /[\t\n\r]/ ? $1 : quot_cec($1))|eg;
> +	$str =~ s|([[:cntrl:]])|($1 =~ /([\t\n\r])/ ? $1 : quot_cec($1))|eg;
>  	return $str;
>  }

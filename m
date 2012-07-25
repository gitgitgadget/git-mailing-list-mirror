From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Wed, 25 Jul 2012 00:14:33 -0700
Message-ID: <7v1uk0e2hy.fsf@alter.siamese.dyndns.org>
References: <500F17A3.60307@pobox.com> <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com> <20120724233128.GD16333@burratino>
 <7va9yoenb2.fsf@alter.siamese.dyndns.org> <500F4530.7030207@pobox.com>
 <20120725045327.GD3055@burratino> <500F85F7.8050304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 09:14:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stvnu-0001ma-FP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 09:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab2GYHOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 03:14:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab2GYHOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 03:14:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06DB259EA;
	Wed, 25 Jul 2012 03:14:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yfTUPHT5C64f0lK8jEuw5JhP+js=; b=kRWslS
	Amgcp9VpoDGhJH9+XhvKouqt/HEUV3AtXLXMHgIdHNeUjnbY8VwK8suxR/pVJjQu
	RinKUw2eRTaemqezhlYU0M+BHIqc+3JLygk5jNDVMNOIxLHfCEZ34u0LfF2ifiER
	dc4vn+bDgLH9dcEHi43I4wnKc1LEyqAp4LJhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udkthVaPpMZ7nMTHxJqfmDbOKN6DJbbp
	cptCF0Qlx2nr/cb6cT210LKILMZI0G5yJl8ep1s6lcEdrf8QEeUpfWGhoZ5Mx5C1
	CWAfCYH0G1FUYzbjs9L5NSvoR8Lah9ogumctxvFhpdFp8SBO3xrEFfCOEGHty7oA
	BHIiDT+IwCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0A7F59E9;
	Wed, 25 Jul 2012 03:14:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AC2159E8; Wed, 25 Jul 2012
 03:14:35 -0400 (EDT)
In-Reply-To: <500F85F7.8050304@pobox.com> (Michael G. Schwern's message of
 "Tue, 24 Jul 2012 22:36:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63800AE4-D628-11E1-ADF7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202133>

Michael G Schwern <schwern@pobox.com> writes:

> On 2012.7.24 9:53 PM, Jonathan Nieder wrote:
>> Michael G Schwern wrote:
>> 
>>> No, now it's just canonicalizing as early as possible.  Preferably within the
>>> object accessor rather than at the point of use.  So in the code below,
>>> $full_url is already escaped/canonicalized.
>> 
>> Let's start with this.
>> 
>> Is svn_path_canonicalize() idempotent?  What does it do when it
>> encounters a percent-sign?
>
> Nothing, because paths are not URI escaped. :)
>
> You probably meant svn_uri_canonicalize().  And no, it does not double escape,
> so its safe to escape as early as possible.

Are you saying that the function assumes that a local pathname would
not have '%' in it, returns its input as-is when it sees one, and if
the caller really needs to express a path with '%' in it, it is the
responsibility of the caller to escape it?

That makes it even more confusing....

>    my $uri = "http://www.example.com/ foo";
>
>     print SVN::_Core::svn_uri_canonicalize(
>         SVN::_Core::svn_uri_canonicalize($uri)
>     );
>
> That produces "http://www.example.com/%20foo".

In other words, if your DocumentRoot was /var/www and you have a
directory /var/www/per%cent you want to expose to the outside world,
you have to say "http://www.example.com/per%25cent" yourself and the
"canonicalize" function will be an identity function?

I have this vague suspicion that Jonathan was asking about what your
Git::SVN::Utils::canonicalize_path() sub does, so all of the above
might be moot, though...

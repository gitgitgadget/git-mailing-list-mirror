From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Gitweb: Avoid warnings when a repo does not have a valid
 HEAD
Date: Thu, 15 Dec 2011 14:02:19 -0800
Message-ID: <7v62hhmr2s.fsf@alter.siamese.dyndns.org>
References: <1323982737-19065-1-git-send-email-jratt0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 23:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJNj-0000yj-5Z
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 23:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759531Ab1LOWCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 17:02:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759491Ab1LOWCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 17:02:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 737726D3B;
	Thu, 15 Dec 2011 17:02:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A2kGeIyl/+zB39DjWwcv0ejnvEQ=; b=hxhzFa
	CkdNe0jIVRdfgK4NQkc8blVJKMycKktYQzLytwR/OtnD5+la3HkHr8hve0Kzg0V+
	lWLSF4XhY22bVtcuRcWGdpXXFZv/VXH6HmVgkn16Msr+Ji5i5ASchNEnal/wr6zD
	nY9DqnxyXSigEvU5ftqFyipqabD3AW7yzIit0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xg3PfTVxl/g3HnKFCNNngJDWKEdCu8FR
	h03uO+y4OPNzwUbGfba2IwvhlArmlXxl4ppl6XD2bQMB0DrjUn0ZL090xnAYAl6E
	7jVHi3ALj5kr99LXiCR3Hc4EwhylkX82o0GR/yJDDzxE3gqtwhuLsNVHkdObXAVf
	QSttD5ORp2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6831B6D3A;
	Thu, 15 Dec 2011 17:02:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F09646D39; Thu, 15 Dec 2011
 17:02:20 -0500 (EST)
In-Reply-To: <1323982737-19065-1-git-send-email-jratt0@gmail.com> (Joe
 Ratterman's message of "Thu, 15 Dec 2011 14:58:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7623C3E4-2768-11E1-A467-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187246>

Joe Ratterman <jratt0@gmail.com> writes:

> It is possible that the HEAD reference does not point to an existing
> branch.  When viewing such a repository in gitweb, a message like this
> one was sent to the error log:
>
>   gitweb.cgi: Use of uninitialized value in string eq at /usr/src/git/gitweb/gitweb.cgi line 5115.
>
> Signed-off-by: Joe Ratterman <jratt0@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..5af06d6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5440,7 +5440,7 @@ sub git_heads_body {
>  	for (my $i = $from; $i <= $to; $i++) {
>  		my $entry = $headlist->[$i];
>  		my %ref = %$entry;
> -		my $curr = $ref{'id'} eq $head;
> +		my $curr = $head ? ($ref{'id'} eq $head) : 0;

Makes one wonder if $head could be '0', but I presume this is about the
case where (!defined $head) holds true. Also makes one wonder if a similar
issue exists on the $ref{"id"} side. I suspect that won't be true unless
you have a very screwed-up repository, but in that case a repository with
a HEAD that points at an unborn branch _and_ have other refs that do point
at existing commit is already screwed-up, so if we want to be extremely
pedantic then perhaps ...

    my $curr = ((defined $head && exists $ref{"id"} && defined $ref{"id"})
		? ($ref{"id"} eq $head)
                : 0);

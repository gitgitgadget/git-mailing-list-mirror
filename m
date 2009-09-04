From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not scramble password read from .cvspass
Date: Fri, 04 Sep 2009 09:21:36 -0700
Message-ID: <7vvdjyn0j3.fsf@alter.siamese.dyndns.org>
References: <4AA100E8.9030806@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, pascal@obry.net
To: Dirk Hoerner <dirker@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjbYj-0006q5-Vu
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 18:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225AbZIDQVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 12:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbZIDQVp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 12:21:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855AbZIDQVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 12:21:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4028143C21;
	Fri,  4 Sep 2009 12:21:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2RdyGaM8wD4+FPhhPRZsO0l8MSA=; b=LJWdRB
	RTi+sp52LP8S/eXy4FLVGDCQrJ/JHKCaDQNchFmqWVfdafHblRjaKoUpTcuqiPhS
	EKFdp9EoHCC/zs0zgcfbU0kbSLT5rj8AhdHMRy6xq/cUPly77cc/mY2Ul2GUnIyB
	bD3gzdIvU67HrkzR2LLJuLayH6jueRvednyMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LcE593rH1mCCvzPhnAxw+/b3SLUW1WiN
	d0Ptp6R+swxQeGDye1G7pXoEmWCDWBqstwsoqdv2Z23rPVFx6qThQL/xJb5zUPhI
	WNcv5ugFlL845w7yCFwbwKmTFQjFtbhmOsUzFg6fQYSF79D0CNYC0T049MxD44MT
	lbdQyUkHsyQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14E7343C1C;
	Fri,  4 Sep 2009 12:21:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C3DC43C1A; Fri,  4 Sep 2009
 12:21:38 -0400 (EDT)
In-Reply-To: <4AA100E8.9030806@obry.net> (Pascal Obry's message of "Fri\, 04
 Sep 2009 13\:58\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 087A0E72-996F-11DE-BE0E-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127740>

Pascal Obry <pascal@obry.net> writes:

> Passwords stored in .cvspass are already scrambled, we do not
> want to scramble them twice. Only passwords read from the
> command line are scrambled.
>
> This fixes a regression introduced by:
> b2139dbd72d16e40eddfd5b9ad1314703b39fe65
>
> Signed-off-by: Pascal Obry <pascal@obry.net>
> ---

Thanks, Pascal.  This bug is not in any tagged release yet, and I am happy
you caught it before -rc0 ;-)

Dirk, does the patch look Ok to you?

>  git-cvsimport.perl |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 593832d..c5cdcae 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -238,7 +238,10 @@ sub conn {
>                 }
>                 my $rr = ":pserver:$user\@$serv:$port$repo";
>
> -               unless ($pass) {
> +               if ($pass) {
> +                   $pass = $self->_scramble($pass);
> +               } else
> +               {
>                         open(H,$ENV{'HOME'}."/.cvspass") and do {
>                                 #
> :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
>                                 while (<H>) {
> @@ -253,8 +256,6 @@ sub conn {
>                         };
>                 }
>
> -               $pass = $self->_scramble($pass);
> -
>                 my ($s, $rep);
>                 if ($proxyhost) {
>
> --
> 1.6.4.2.253.g0b1fac

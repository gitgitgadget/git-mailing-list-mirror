From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add a remote helper to interact with mediawiki (fetch
 & push)
Date: Wed, 31 Aug 2011 17:24:05 -0700
Message-ID: <7vobz5xg7u.fsf@alter.siamese.dyndns.org>
References: <1314381329-8989-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314809708-8177-1-git-send-email-Matthieu.Moy@imag.fr>
 <CAGdFq_gu=SyjUnUS1bcjPrcPPtKVt+UjDBvBmZqosk+OuDFDHw@mail.gmail.com>
 <vpq7h5tbia6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 02:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyv4p-0005os-Mr
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 02:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294Ab1IAAYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 20:24:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755985Ab1IAAYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 20:24:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDAB15420;
	Wed, 31 Aug 2011 20:24:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYOONUZ9dz3KE/NP+3NVIzdXhlE=; b=h0jPJC
	+R/FlG/YHanW2z5ppRYvhLcO6p9e22LoD1REzWhlovzMgDVuGhAnJC2SX0/SzE9L
	8veGEghgN5B1plPuuQJx9KS8zphk5D/m+ZM1TfzCeXLRT0AtV01CyeHf1oFmgdIT
	Xr6JxL5Px6YSE/6auLoWn3QRAicbmD1OsPyJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KekDrHphQNmbepyVhVFToSmBJFOECkWZ
	sF3Vl6UBnos8Ix8EXm6CAsdJQ6EJgR1w4bBi2LVrd0VE0Hgidda8q2+OdSTspSXP
	C4+GaVJPOd1pKERCk/8CTXX1SoWpXHDdQaSUp2EMjk4oRsOvPCPJY1WqAvaovHSm
	b/pImSkYPHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D527D541F;
	Wed, 31 Aug 2011 20:24:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F380541E; Wed, 31 Aug 2011
 20:24:07 -0400 (EDT)
In-Reply-To: <vpq7h5tbia6.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 31 Aug 2011 19:30:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B498B9D0-D430-11E0-A5DF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180512>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Here:
>
> +	for my $refspec (@refsspecs) {
> +		unless ($refspec =~ m/^(\+?)([^:]*):([^:]*)$/) {
> +			die("Invalid refspec for push. Expected <src>:<dst> or +<src>:<dst>");
> +		}
> +		my ($force, $local, $remote) = ($1 eq "+", $2, $3);
>
> At this point, $force is a boolean saying whether there were a +, and
> $local and $remote are as you can guess.

It may be slightly more Perl-ish to hoist the "0-or-1" outside the group
and rely on $1 becoming undef, like this:

        my ($force, $local, $remote) = $refspec =~ /^(\+)?([^:]*):([^:]*)$/
		or die(...);

Even though it largely is a matter of taste, I think.

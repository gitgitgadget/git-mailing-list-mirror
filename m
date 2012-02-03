From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 03 Feb 2012 12:32:15 -0800
Message-ID: <7v7h03odyo.fsf@alter.siamese.dyndns.org>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
 <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
 <20120203120657.GB31441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:32:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtPo0-0005te-1b
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 21:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808Ab2BCUcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 15:32:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754Ab2BCUcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 15:32:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88DD4700A;
	Fri,  3 Feb 2012 15:32:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkDXCD22RnI9pdfzY0p7WuTZVQI=; b=rIP1oC
	TdrW2z5izRLtYkSiGFSkq6KFIJroHlUlv/GDPV9LYYHl2PYNKSsy5Uwip6gaCfr8
	kFfPORLAMFTrOs9f8rPMoCCq82Go07ZkKS/hhJ4G0j/in4Z81LHC/znMVtx6Y53z
	pFJXOGx7+M7WDupDSWUX01P5odcuMiyjnaAVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FRloHUQ0/eUKyc6gYZsHXyhv/R0HkLJe
	4bj8/oW+Tfv4VDM6V1xfotDPlQkTwJbI/IdbeenpCd3dIrKm3mXpdneCJI2DhoM0
	a2IF3LujBEXH2fqTn+XSVtgYE7aS+/xbGVYOSmngmFs3VFqv6LMTXNorQltmVPlu
	ymnZv9vzUHE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EE717009;
	Fri,  3 Feb 2012 15:32:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EC9D6FFD; Fri,  3 Feb 2012
 15:32:16 -0500 (EST)
In-Reply-To: <20120203120657.GB31441@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Feb 2012 07:06:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29CDFD06-4EA6-11E1-8F36-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189800>

Jeff King <peff@peff.net> writes:

>   cat >foo.sh <<\EOF
>   #!/bin/sh
>   echo my arguments are "$@"
>   EOF
>
> cannot have the mechanical replace you mentioned above. It would need:
>
>   cat >foo.sh <<EOF
>   #!$SHELL_PATH
>   echo my arguments are "\$@"
>   EOF
>
> or:
>
>   {
>     echo "#!$SHELL_PATH" &&
>     cat <<EOF
>     echo my arguments are "$@"
>     EOF
>   } >foo.sh
>
> When I have hard-coded "#!/bin/sh", my thinking is usually "this is less
> cumbersome to type and to read, and this script-let is so small that
> even Solaris will get it right".

I am toying with the pros-and-cons of

	write_script () {
		echo "#!$1"
		shift
                cat
	}

so that the above can become

	write_script "$SHELL_PATH" >foo.sh <<-EOF
        echo my arguments are "\$@"
	EOF

without requiring the brain-cycle to waste on the "Is this simple enough
for even Solaris to grok?" guess game.  This should also be reusable for
other stuff like $PERL_PATH, I would think.

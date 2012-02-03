From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 03 Feb 2012 13:50:33 -0800
Message-ID: <7vr4ybmvrq.fsf@alter.siamese.dyndns.org>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
 <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
 <20120203120657.GB31441@sigill.intra.peff.net>
 <7v7h03odyo.fsf@alter.siamese.dyndns.org>
 <20120203212604.GA1890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtR1l-0003Yk-Km
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757949Ab2BCVuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 16:50:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314Ab2BCVug (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:50:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A95127DF8;
	Fri,  3 Feb 2012 16:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f80qNISrXlxjqSAm6hDqrm6BkNs=; b=ASUV7K
	jqyR8J8HuIzayo8RGJ7NpB3Gpof7DikFG4okcneDE9y0488IfX14gyW89LBTWIil
	lzSqnKGc6+XyLzCFKjy95ISAkoSI873Y3Nx+mqUjvvytKaSspzzVH2GhQ8pqyRM7
	imkO1Qw9XpAxvm4fnMTJEKw2FrSW/b0fKByH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QmcOI1qDE3KNspfR48TD3jdR1Ak51uHo
	mZLIh7j9aQZEuYKn2gmRn5NOFW8gOFO36bLJxvTm8B++OwDnjelpPNwVnUWdpRHM
	VYlJY02b+atmuq1RHHfzhUmdPRgJ+RG6sKbcSItIjIGUkd7+3r66PwlLF+CpBILj
	IDM9kVOI/Jw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A18717DF7;
	Fri,  3 Feb 2012 16:50:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 272357DF6; Fri,  3 Feb 2012
 16:50:35 -0500 (EST)
In-Reply-To: <20120203212604.GA1890@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Feb 2012 16:26:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A1703F2-4EB1-11E1-AC68-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189809>

Jeff King <peff@peff.net> writes:

>> without requiring the brain-cycle to waste on the "Is this simple enough
>> for even Solaris to grok?" guess game.  This should also be reusable for
>> other stuff like $PERL_PATH, I would think.
>
> I like it. Even better would be:
>
>   write_script() {
>         echo "#!$2" >"$1" &&
>         cat >>"$1" &&
>         chmod +x "$1"
>   }
>
>   write_script foo.sh "$SHELL_PATH" <<-\EOF
>     echo my arguments are "$@"
>   EOF

I first thought that the order of parameters were unusual, but with that
order, you could even go something fancier like:

	write_script () {
		case "$#" in
		1)	case "$1" in
			*.perl | *.pl) echo "#!$PERL_PATH" ;;
			*) echo "#!$SHELL_PATH" ;;
			esac
                2)	echo "#!$2" ;;
		*)	BUG ;;
                esac >"$1" &&
                cat >>"$1" &&
                chmod +x "$1"
	}

	write_script foo.sh
        write_script bar.perl
        write_script pre-receive /no/frobnication/today

The tongue-in-cheek comment aside, I think ${2-"$SHELL_PATH"} or some form
of fallback would be a good idea in any case, as 99% of the time what we
write in the test scripts is a shell script.

Also "chmod +x" is a very good idea.

        

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for
 correctly-failing conversion program
Date: Mon, 27 Sep 2010 11:23:35 -0700
Message-ID: <7vsk0vyriw.fsf@alter.siamese.dyndns.org>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
 <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Mon Sep 27 20:24:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0IMu-0001gO-F4
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 20:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933184Ab0I0SX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 14:23:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759971Ab0I0SXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 14:23:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA19FD9A97;
	Mon, 27 Sep 2010 14:23:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vfj0loPD7dVABv8AcIUxSOeORI8=; b=Y+iarz
	qC/+U9YK2GVMJdsKsacMy5eXm0VeUY0Y/GJq9xtqAA77XDN4p9+3+J9qPqUhum9b
	sRmlRO6O3AixQi+tVCCvzjG0CC/Ws6RvLsMVArQSUXCjsRZgrTxowG3XqAtoTeel
	brg9zhrWZTRUOyVUzJ6/uiE9JquS1Esu24fcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G6dcEb8urm3dTZCrVgaHaDoGgDt5epF9
	OgZ/CfOBz1wK2S4EeUY8SK1nN5Cqg+HUCn8NBjdwYAOFe51fWjnQXvZ+rkXYplYX
	uS8z+FqGz5aQuV1f7vDGdzh5pmyMxQTDnc/55+j5hSezth53eaHi1SyLFxALiyGZ
	NPqEq5R7wy0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28B5DD9A83;
	Mon, 27 Sep 2010 14:23:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58F76D9A7C; Mon, 27 Sep
 2010 14:23:37 -0400 (EDT)
In-Reply-To: <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Fri\, 24 Sep 2010 22\:24\:08 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5DAA665E-CA64-11DF-BAB0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157361>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
> index 91f8198..7668099 100755
> --- a/t/t4042-diff-textconv-caching.sh
> +++ b/t/t4042-diff-textconv-caching.sh
> @@ -5,18 +5,19 @@ test_description='test textconv caching'
>  
>  cat >helper <<'EOF'
>  #!/bin/sh
> -sed 's/^/converted: /' "$@" >helper.out
> +grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; exit 1; }

You are not feeding arguments you think you are to the above "echo":

        $ cat >/var/tmp/j.sh <<\EOF
        #!/bin/sh
        e () {
                i=0
                for s
                do
                        i=$(( $i + 1 ))
                        echo "$i: $s"
                done
        }
        f () {
                e "E: $@ is not binary"
        }
        f 1 "2 3" 4
        EOF
        $ sh /var/tmp/j.sh
        1: E: 1
        2: 2 3
        3: 4 is not binary

Granted, echo is forgiving and will concatenate the arguments it gets with
a space in between, but you would either want to either:

 (1) make it more explicit that helper gets only one argument, by saying
     "$1" instead of "$@", in all places in the helper script; or

 (2) if you are planning to make 'helper' capable of handling multiple
     input files, show the error message for the ones that are not binary
     (you would probably need a loop for that).

I think (1) would be sufficient in this case.

> +sed 's/^bin:/converted:/' "$@" >helper.out

Minor nit: this is inconsistent with the check done with grep above that
insists that the colon is followed by a SP.

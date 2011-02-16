From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Wed, 16 Feb 2011 11:51:13 -0800
Message-ID: <7v62sjkbbi.fsf@alter.siamese.dyndns.org>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Wed Feb 16 20:51:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpnPO-0008Ad-Ut
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 20:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab1BPTv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 14:51:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab1BPTvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 14:51:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF0D43783;
	Wed, 16 Feb 2011 14:52:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ob00UHedZM11IqaAIyUKkrbBFw=; b=COSMPf
	UcRr8wNNqOSCG/dC+x038Di3WFsxBtS8qmZnblpq4dimBfWltxldNaa68kUoNnkF
	PSqHO57v9iWyWkdaf8IBJblB7JOBIWI44gG5AwyKC42qkdK/93BQwOIFzUVCIyci
	Su2iFWRF2aFsGud4opcl+2HnY7ncEbK1b1LdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lKwDmeHnM7DpC4GHp6J2wA1+azRdHBw9
	ZaPTyJqNIertIjBqYNk1Ld6RUMm5iEI4/sagySe01Depyj7uXKqcl5mng4sMwgj8
	ECTV8kdAPXVquC3mluqE9zFFKaRdRGqlWcMHHa1XpQQczfp4oZouOz5CSTq7+c0A
	hbfwjT3v6P4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B7A83780;
	Wed, 16 Feb 2011 14:52:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 53349377D; Wed, 16 Feb 2011
 14:52:20 -0500 (EST)
In-Reply-To: <1297860417-21895-1-git-send-email-olsonse@umich.edu> (Spencer
 E. Olson's message of "Wed\, 16 Feb 2011 05\:46\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 46F6E178-3A06-11E0-92D6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166994>

"Spencer E. Olson" <olsonse@umich.edu> writes:

> Previously, when a submodule was cloned in the same command execution, --rebase
> or --merge would attempt to run (instead of and) before a checkout, resulting in
> an empty working directory.  This patch ignores --rebase or --merge for a
> particular submodule when that submodule is newly cloned and instead simply
> checks out the appropriate revision.

Sorry, but I cannot parse the problem description, "(instead of and)" part.

Why is it a better thing to do to ignore these options, instead of
detecting the situation and error it out, saying "you are initially
cloning, don't say --rebase"?

> +# Test whether an element of the $3(=IFS) separated list $2 matches $1
> +#
> +str_contains()
> +{
> +	if test -n "$3"
> +	then
> +		local IFS="$3"
> +	fi
> +	for i in $2
> +	do
> +		if test "$i" = "$1"
> +		then
> +			echo "yes"
> +			return
> +		fi
> +	done
> +	echo "no"
> +	return
> +}

We don't allow bash-ism outside POSIX shell in our primary Porcelain set
(the rule is looser for stuff in contrib/), so "local" is out.

Here is how to write the above more concisely, efficiently and portably.

	case "$2;" in
        *";$1;"*)
        	echo yes ;;
        *)
        	echo no ;;
	esac

The trailing ';' takes care of the case where cloned_modules has only one
element, in which case you have ";name" in "$2".  No need for a loop.

> +	cloned_modules=
> ...
>  	while read mode sha1 stage path
>  	do
> @@ -442,6 +464,7 @@ cmd_update()
>  		if ! test -d "$path"/.git -o -f "$path"/.git
>  		then
>  			module_clone "$path" "$url" "$reference"|| exit
> +			cloned_modules="$cloned_modules;$name"
>  			subsha1=

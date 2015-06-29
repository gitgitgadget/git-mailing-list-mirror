From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 06/10] bisect: don't mix option parsing and non-trivial code
Date: Mon, 29 Jun 2015 13:28:36 -0700
Message-ID: <xmqqbnfy9s3v.fsf@gitster.dls.corp.google.com>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435592435-27914-7-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:28:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9ffZ-0004d5-M3
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbbF2U2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:28:41 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35064 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbF2U2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:28:39 -0400
Received: by igblr2 with SMTP id lr2so60983288igb.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NdjiUpQ2CaNah2MUlW5ABsTgsmajCGwbLyVZpSN+HUs=;
        b=UaBGBUE4GhEeL6y07ipYju9ai5THBSSpxSNWScq+sRi7z9hECqigiMDBGcLPyb6cTd
         RlJX5NDCdvMEiUl2TZuUw/eq5VmPMLj7anoP20B08EuCsPXc/K2Yqi6BAAIiz+/nfgYC
         51cglg2xGeq0wI8Hjmjy2unEPCf4dIM/SMJgQ9T2TlicIKOU5EQz/3DN5g61weVyzawr
         oftVRAplijd8Uaa60Y8VsXUq3p3+DmWF8j2D68OTiZNaTRqscPcBlQ5IM56ORNwkuSur
         Okou9OENxHCJ2Wn7B2r2Q67I5MUdmYpDrMT2NS78Ru0aTTa1eWFWFCkF6YeLh6uOKHUE
         W1rQ==
X-Received: by 10.107.38.139 with SMTP id m133mr23171695iom.51.1435609719191;
        Mon, 29 Jun 2015 13:28:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id i7sm6200700igt.18.2015.06.29.13.28.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 13:28:38 -0700 (PDT)
In-Reply-To: <1435592435-27914-7-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 29 Jun 2015 17:40:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273013>

Matthieu, are you allowing your editor to corrupt the number of
lines in the hunk on the @@ ... @@ hunk header?  "diff" mode in
Emacs does that, and there may be other editors that has the same
bug, but please be careful---they make the patch unapplicable.

Count the preimage lines in the hunk below.  I count 24 but somebody
is lying there.

> @@ -102,25 +103,27 @@ bisect_start() {
>  				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
>  				break
>  			}
> -
> -			# The user ran "git bisect start <sha1>
> -			# <sha1>", hence did not explicitly specify
> -			# the terms, but we are already starting to
> -			# set references named with the default terms,
> -			# and won't be able to change afterwards.
> -			must_write_terms=1
> -
> -			case $bad_seen in
> -			0) state=$TERM_BAD ; bad_seen=1 ;;
> -			*) state=$TERM_GOOD ;;
> -			esac
> -			eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
> +			revs="$revs $rev"
>  			shift
>  			;;
>  		esac
>  	done
>  
> +	for rev in $revs
> +	do
> +		# The user ran "git bisect start <sha1>
> +		# <sha1>", hence did not explicitly specify
> +		# the terms, but we are already starting to
> +		# set references named with the default terms,
> +		# and won't be able to change afterwards.
> +		must_write_terms=1
> +
> +		case $bad_seen in
> +		0) state=$TERM_BAD ; bad_seen=1 ;;
> +		*) state=$TERM_GOOD ;;
> +		esac
> +		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
> +	done
>  	#
>  	# Verify HEAD.
>  	#
> -- 
> 2.5.0.rc0.10.gd2bff5d

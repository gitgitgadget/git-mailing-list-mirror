From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-am: add --message-id/--no-message-id
Date: Tue, 25 Nov 2014 15:34:02 -0800
Message-ID: <xmqqbnnusvmd.fsf@gitster.dls.corp.google.com>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
	<1416924056-29993-3-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 00:34:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtPca-0005JR-92
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 00:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbaKYXeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 18:34:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751869AbaKYXeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 18:34:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A52F20D20;
	Tue, 25 Nov 2014 18:34:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PodZL9AHhCyl88sEpLuYQlll3m0=; b=PCqQ3R
	y+pyh56YgQpiwWvmYZwdfTJxmaULQLJKkHGe5ES02QnM6xsz8bS0o7eX9xeNxD/5
	dpIiagdqQYLn9Q8pSuHKB5vphNR9hGn1L2sHh7YHBZxm4gRjYjO+0J0iO4u/wSOb
	hM0svcsr964hzmJPEqtSO9Hnt3/u5sZjalCm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AvBKz+dX/rH5ui+ZPIaEuSTJ7Pg+NprD
	aU2i+bEVOXHGhEexFFXXUevsjST4feNURGT13vc7y3c9w8OhxGXlggZZIKBGDkke
	ewmD6NvLrizEF9OTuvfwiTikFy3SftdDW96jwnsJRS8o9cD3wrT98q81jOoO91gW
	wm84MBXqVrk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 41A3620D1F;
	Tue, 25 Nov 2014 18:34:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97AB820D1E;
	Tue, 25 Nov 2014 18:34:03 -0500 (EST)
In-Reply-To: <1416924056-29993-3-git-send-email-bonzini@gnu.org> (Paolo
	Bonzini's message of "Tue, 25 Nov 2014 15:00:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A721CF4-74FB-11E4-97AC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260251>

Paolo Bonzini <bonzini@gnu.org> writes:

> @@ -371,13 +372,18 @@ split_patches () {
>  prec=4
>  dotest="$GIT_DIR/rebase-apply"
>  sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
> -resolvemsg= resume= scissors= no_inbody_headers=
> +messageid= resolvemsg= resume= scissors= no_inbody_headers=

It is somewhat irritating to read a diff that adds new things to the
beginning of anything (a line, or a block of lines) that lists
things in no particular order, as it just adds cognitive burden.

>  git_apply_opt=
>  committer_date_is_author_date=
>  ignore_date=
>  allow_rerere_autoupdate=
>  gpg_sign_opt=
>  
> +if test "$(git config --bool --get am.messageid)" = true
> +then
> +    messageid=t
> +fi
> +
>  if test "$(git config --bool --get am.keepcr)" = true
>  then
>      keepcr=t
> @@ -400,6 +406,10 @@ it will be removed. Please do not use it anymore."
>  		utf8=t ;; # this is now default
>  	--no-utf8)
>  		utf8= ;;
> +	-m|--message-id)
> +		messageid=t ;;
> +	--no-message-id)
> +		messageid=f ;;

This one, taken together with these two hunks ...

>  	-k|--keep)
>  		keep=t ;;
>  	--keep-non-patch)
> @@ -567,6 +577,7 @@ Use \"git am --abort\" to remove it.")"
>  	echo "$sign" >"$dotest/sign"
>  	echo "$utf8" >"$dotest/utf8"
>  	echo "$keep" >"$dotest/keep"
> +	echo "$messageid" >"$dotest/messageid"
>  	echo "$scissors" >"$dotest/scissors"
>  	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
>  	echo "$GIT_QUIET" >"$dotest/quiet"
> @@ -621,6 +632,12 @@ b)
>  *)
>  	keep= ;;
>  esac
> +case "$(cat "$dotest/messageid")" in
> +t)
> +	messageid=-m ;;
> +f)
> +	messageid= ;;
> +esac

... makes the result look questionable.  The variable is initialized
to empty; when it is written out to $dotest/messageid and later read
back here, that empty value is not covered by this case statement.

Perhaps clearing messageid= upon seeing "--no-message-id" and using
"'t' or empty" makes the code a bit easier to follow?  I dunno.

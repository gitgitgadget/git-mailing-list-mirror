From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] refs.c: optimize check_refname_component()
Date: Tue, 03 Jun 2014 11:08:24 -0700
Message-ID: <xmqqzjhtx3vr.fsf@gitster.dls.corp.google.com>
References: <1401690015-19191-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:08:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrt8a-0001tF-Qs
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 20:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbaFCSIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 14:08:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53891 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371AbaFCSIf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 14:08:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF6FA1CD41;
	Tue,  3 Jun 2014 14:08:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UXnG/ZqfRrHJN2UaETogNAhKL2Y=; b=bJsnol
	Dn9+givhxXihAZ8I+/2hHXybRKPcPI7C97jCduNacSmpU4aVSgagHjDRlzcoiNet
	ENLpgXMng+V5uEta5dnkQVXWpLEp6nl9EO+b4QzKIVnXyIPGkEogSMgkImZTu0he
	43eJGrCNx9hP3kGRldiCnmgQ9R0ZJLz6TvzgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e0o2n8VecsaOy7mYUexeUGuolo9pShGD
	I07/WcaJbkktcjNJV6ovSFaKiYh+UJ8PSFo3uW6aDwvnWF0Dc/wEF1l8ZIACCNRv
	4Hcy8c/hM8B1bfWIpnmR/JvOynqQPSkoacoyUjoe6vGI+BT4Gsq4Aj7ZoGXBvJhc
	76BXCYgp9/Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4B621CD3F;
	Tue,  3 Jun 2014 14:08:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 317B11CD3E;
	Tue,  3 Jun 2014 14:08:26 -0400 (EDT)
In-Reply-To: <1401690015-19191-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 2 Jun 2014 02:20:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0EF2C212-EB4A-11E3-A325-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250633>

David Turner <dturner@twopensource.com> writes:

>  static int check_refname_component(const char *refname, int flags)
>  {
>  	const char *cp;
>  	char last = '\0';
>  
>  	for (cp = refname; ; cp++) {
> -		char ch = *cp;
> -		if (ch == '\0' || ch == '/')
> +		unsigned char ch = (unsigned char) *cp;

Hmph, this cast bothers me.  I am fine with either of these two, though.

	int ch = *cp & 0377;
        unsigned char ch = *((unsigned char *)cp);

> +		unsigned char disp = refname_disposition[ch];
> +		switch(disp) {
> +		case 1:
> +			goto out;
> +		case 2:
> +			if (last == '.')
> +				return -1; /* Refname contains "..". */
> +			break;
> +		case 3:
> +			if (last == '@')
> +				return -1; /* Refname contains "@{". */
>  			break;
> -		if (bad_ref_char(ch))
> -			return -1; /* Illegal character in refname. */
> -		if (last == '.' && ch == '.')
> -			return -1; /* Refname contains "..". */
> -		if (last == '@' && ch == '{')
> -			return -1; /* Refname contains "@{". */
> +		case 4:
> +			return -1;
> +		}
>  		last = ch;
>  	}
> +out:
>  	if (cp == refname)
>  		return 0; /* Component has zero length. */
>  	if (refname[0] == '.') {
> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
> index c289322..1571176 100755
> --- a/t/t5511-refspec.sh
> +++ b/t/t5511-refspec.sh
> @@ -5,7 +5,6 @@ test_description='refspec parsing'
>  . ./test-lib.sh
>  
>  test_refspec () {
> -
>  	kind=$1 refspec=$2 expect=$3
>  	git config remote.frotz.url "." &&
>  	git config --remove-section remote.frotz &&
> @@ -84,4 +83,9 @@ test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>  test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
>  test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
>  
> +good=$(echo -n '\0377')

I think we avoid "echo -n" and use "printf" to be portable across
different echo implementations.

Use of \0377, which most likely to be just half-a-character, does
not feel a particularly good example, by the way.

> +test_refspec fetch "refs/heads/${good}"
> +bad=$(echo -n '\011')

Likewise.

> +test_refspec fetch "refs/heads/${bad}"				invalid
> +
>  test_done

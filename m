From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/32] files-backend: break out ref reading
Date: Wed, 24 Feb 2016 16:21:10 -0800
Message-ID: <xmqqr3g1r66h.fsf@gitster.mtv.corp.google.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	<1456354744-8022-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:21:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjgE-0002nV-4k
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbcBYAVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:21:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753429AbcBYAVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:21:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B73E486EC;
	Wed, 24 Feb 2016 19:21:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cgI0oo1YAVtDSYeBOI0gga039Go=; b=wtCyNH
	/5HdgssbD9yv9pey7eAMdGpoqVx5OZvaQZKMMiY6iAGuC5k8YmEx8AhFSHR2VL+3
	ls15azAP5lMLhxHNyARvXIj7QLvwfMsK+yiLLZo0oP9dyMwOsiKu9hStNT1hu6xd
	/JtiPaQq54oRNxcJKG7Kn8tS3zTGe0QmfeET0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lqFeVlxGgWEVwlcFImwfJsnCM1Wyyrpz
	Ac4bk5FElS/ZrNmkJS1cYr9bZMuchRDVOz0DP+v9r3MSujrpWlbQJlD1t0Uxcxk3
	HPANX9jLTULF615v3k9VfzXbP/HSAwTs5VjYzmdA9pLl39svEz7H8gbiN2+kEhkw
	rDN+x/XT+ks=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03100486EB;
	Wed, 24 Feb 2016 19:21:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 77178486E9;
	Wed, 24 Feb 2016 19:21:11 -0500 (EST)
In-Reply-To: <1456354744-8022-4-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Feb 2016 17:58:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC5AD24A-DB55-11E5-8CD7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287291>

David Turner <dturner@twopensource.com> writes:

> Refactor resolve_ref_1 in terms of a new function read_raw_ref, which
> is responsible for reading ref data from the ref storage.
>
> Later, we will make read_raw_ref a pluggable backend function, and make
> resolve_ref_unsafe common.
>
> Testing done: Hacked in code to run both old and new version of
> resolve_ref_1 and compare all outputs, failing dramatically if outputs
> differed.  Ran test suite.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 265 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 159 insertions(+), 106 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index fd664d6..ef5f28d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1377,10 +1377,9 @@ static struct ref_entry *get_packed_ref(const char *refname)
>  
>  /*
>   * A loose ref file doesn't exist; check for a packed ref.  The
> - * options are forwarded from resolve_safe_unsafe().
> + * options are forwarded from resolve_ref_unsafe().
>   */
>  static int resolve_missing_loose_ref(const char *refname,
> -				     int resolve_flags,
>  				     unsigned char *sha1,
>  				     int *flags)

The last parameter must be made "unsigned int *flags" ...

> +static int read_raw_ref(const char *refname, unsigned char *sha1,
> +			struct strbuf *symref, struct strbuf *sb_path,
> +			unsigned int *flags)
>  {

... because the last parameter here is "unsigned int *flags", and
you later pass the same variable to both.

> -	for (;;) {
> -		const char *path;
> +	for(;;) {

This is an unwelcome change.

> +				break;
> +			if (resolve_missing_loose_ref(refname, sha1, flags)) 

This line has a trailing whitespace.

> +	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
> +		int read_flags = 0;

... and this must be "unsigned read_flags = 0".

You can of course standardize on signed int, but because this is a
collection of flag bits, there is no reason not to choose unsigned.

I _think_ I can fix everything up before pushing out, so please
check what will appear on 'pu' before rerolling.

Thanks.

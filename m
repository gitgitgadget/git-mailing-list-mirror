From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/23] pack v4: add commit object parsing
Date: Tue, 27 Aug 2013 08:26:08 -0700
Message-ID: <xmqq7gf7f94f.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-6-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:26:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEL9v-0000AU-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab3H0P0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:26:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344Ab3H0P0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:26:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 674703C14E;
	Tue, 27 Aug 2013 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B5pzHWQRk+pwkEo7yyecvxtL6QI=; b=g5qTyw
	lykOsrTdrZ1TEYHtR6gTsXV3MXe7JD76vfwDa9MNbTbX7YYvCBMDucUE9KdjZKxz
	DsIAybpQQcwBpXR9ROfuOxztYv7SIqIXop5zgS42oh1+E+BDRL/OPY0Bv8xT5jJa
	4RbEhw0nDYwwSBCp7yKleWqRVT5hBuwXfvDec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rDrXOySBhbPrUc1JKM56oLj33Fc4bKVR
	U8I9DM5R2OWWEbth49fuapKKSfvd2Gfv+hHx6Tx8wP+8folmB6jFrhsAjs8Sm+o4
	3//mmJqutE9ySiDssQtqI2QWCj8by6Wel5csOBY09z4jTgM2VzEz3eCfsEhCxn8h
	cdPbW7yvXp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3593C14D;
	Tue, 27 Aug 2013 15:26:14 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8FC03C147;
	Tue, 27 Aug 2013 15:26:11 +0000 (UTC)
In-Reply-To: <1377577567-27655-6-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 01400DA4-0F2D-11E3-9B3C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233101>

Nicolas Pitre <nico@fluxnic.net> writes:

> Let's create another dictionary table to hold the author and committer
> entries.  We use the same table format used for tree entries where the
> 16 bit data prefix is conveniently used to store the timezone value.
>
> In order to copy straight from a commit object buffer, dict_add_entry()
> is modified to get the string length as the provided string pointer is
> not always be null terminated.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
> @@ -135,8 +136,73 @@ static void sort_dict_entries_by_hits(struct dict_table *t)
>  	rehash_entries(t);
>  }
>  
> +static struct dict_table *commit_name_table;
>  static struct dict_table *tree_path_table;
>  
> +/*
> + * Parse the author/committer line from a canonical commit object.
> + * The 'from' argument points right after the "author " or "committer "
> + * string.  The time zone is parsed and stored in *tz_val.  The returned
> + * pointer is right after the end of the email address which is also just
> + * before the time value, or NULL if a parsing error is encountered.
> + */
> +static char *get_nameend_and_tz(char *from, int *tz_val)
> +{
> +	char *end, *tz;
> +
> +	tz = strchr(from, '\n');
> +	/* let's assume the smallest possible string to be "x <x> 0 +0000\n" */
> +	if (!tz || tz - from < 13)
> +		return NULL;
> +	tz -= 4;
> +	end = tz - 4;
> +	while (end - from > 5 && *end != ' ')
> +		end--;
> +	if (end[-1] != '>' || end[0] != ' ' || tz[-2] != ' ')
> +		return NULL;
> +	*tz_val = (tz[0] - '0') * 1000 +
> +		  (tz[1] - '0') * 100 +
> +		  (tz[2] - '0') * 10 +
> +		  (tz[3] - '0');
> +	switch (tz[-1]) {
> +	default:	return NULL;
> +	case '+':	break;
> +	case '-':	*tz_val = -*tz_val;
> +	}
> +	return end;
> +}

This may want to share code with ident.c::split_ident_line(), as we
have been trying to reduce the number of ident-line parsers.

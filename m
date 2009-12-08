From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH 5/8] Support taking over transports
Date: Tue, 08 Dec 2009 15:37:06 -0800
Message-ID: <7vljhd597h.fsf@alter.siamese.dyndns.org>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-6-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI9cO-00060e-9E
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 00:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbZLHXhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 18:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbZLHXhI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 18:37:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965250AbZLHXhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 18:37:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8AAFA52CA;
	Tue,  8 Dec 2009 18:37:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rGfSc2bPMjob5s7tIwHynwawXeA=; b=tkOfLLyY2R3b73ClVN94Ojc
	LKSi5BkCIbgk9fsKwVip8Tq8SJkR4DxET8qmzk1GhgGc3wBvtTjHCOrqYBxUnAnr
	wyfaS7z2LKZiLaPGMuo+sKWDSk/+8Yq2E1JeNO4hi/itBIzmSfJsfep81o21nYMs
	weZ1okIW6Om4ul+wwMeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tcVGRYT0APOvSWytPdpLH2maNXqk6PajHOf3RHK9kiJiUPTwO
	4qeal4KrNRB2mK7kyWav/L18MmRWAqq8W0ZkzzdY3regPhKyZmsx88IcLQJRKi7A
	xaSB7wtmRYKXmMKD7UE2qoiNEeBT9MKMYZWUYKoUgH9flgo0jeM8j8Tyqo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87B76A52C9;
	Tue,  8 Dec 2009 18:37:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 58ECFA52C8; Tue,  8 Dec 2009
 18:37:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B81FBE8-E452-11DE-9AC5-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134924>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> diff --git a/transport-helper.c b/transport-helper.c
> index 0e82553..3b7340c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -22,6 +22,7 @@ struct helper_data
>  	/* These go from remote name (as in "list") to private name */
>  	struct refspec *refspecs;
>  	int refspec_nr;
> +	struct git_transport_options gitoptions;
>  };

Will we ever have another 'xxxoptions' field in this structure that is not
so git-ish?  'gitoptions' somehow doesn't feel right, unless you plan to
later add scm specific options like 'hgoptions', 'bzroptions' in this
field you need to distinguish "git" one from them.

I know you needed to name the new field to store the transport option
under a different name from the existing 'option' field, but for that
purpose, 'transport_options' might be a more appropriate name.

> @@ -109,9 +111,19 @@ static struct child_process *get_helper(struct transport *transport)
>  		die("Unable to run helper: git %s", helper->argv[0]);
>  	data->helper = helper;
>  
> +	/*
> +	 * Open the output as FILE* so strbuf_getline() can be used.
> +	 * Do this with duped fd because fclose() will close the fd,
> +	 * and stuff like taking over will require the fd to remain.
> +	 *
> +	 */
> +	duped = dup(helper->out);
> +	if (duped < 0)
> +		die_errno("Can't dup helper output fd");
> +	data->out = xfdopen(duped, "r");
> +

Neat hack (the kind I often love), but it makes something deep inside me
cringe.  This looks fragile and possibly wrong.

Who guarantees that reading from the (FILE *)data->out by strbuf_getline()
that eventually calls into fgetc() does not cause more data be read in the
buffer assiciated with the (FILE *) than we will consume?  The other FILE*
you will make out of helper->out won't be able to read what data->out has
already slurped in to its stdio buffer.

The call sequence, after [6/8] is applied as I understand it is:

    - _process_connect()
      - get_helper()
        - start_command() that gives a pipe to read from the helper in
          helper->out;
        - the above dup dance makes (FILE *)data->out out of a copied fd;
        - read from data->out, potentially reading a lot more than
          the loop consumes into the stdio buffer of data->out;
      - dup dance again to make (FILE *)input;
      - read from input, unbuffered.

But if "capabilities" exchange has read past the capability response from
the helper into helper->out inside get_helper(), wouldn't it make the dup
dance to make an extra "input" to read the rest unbuffered moot, as
"input" won't be even reading from the beginning of "the rest"?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] safe_create_leading_directories: fix race that could
 give a false negative
Date: Sat, 16 Mar 2013 23:26:23 -0700
Message-ID: <7v7gl6sfsg.fsf@alter.siamese.dyndns.org>
References: <1363462256-5823-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 07:26:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH73V-0007XH-1O
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 07:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab3CQG00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 02:26:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab3CQG0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 02:26:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 548ACAA64;
	Sun, 17 Mar 2013 02:26:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+WN/roZ48YRiF6QqwFJxbahJA0=; b=MeyNWT
	RFNNvfLgKKSz9l20sQkWuCEGhyqYVuonGcS0P/EtfrQs3if/cMQOzdBDX1/jzrOY
	1NXog8QSFy5z0yQ8yo7LcvGBxoDCA0m2pkO/Cy+hcaqjmSnZPB/khfX8lq+vz03Z
	eaBIFqMjSK00EMCHRI+iq/U/bRsn+Fxd9Pulw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ltu0+G2tQLAaML30LC7C3vhyiw6atox2
	cKHed4bf36Rl+23Q47lhYcqaW78YXjWgMzcXRCm+LJzdXJVYAC3z0zwfMFhzD1PQ
	ZTuAqvGn8j22YE2/2uUULN8s6fYHyFD3W32HQbQwfCEhYRuB6VbwHcivPAAtZU0z
	+8p7S+yFWT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48C90AA63;
	Sun, 17 Mar 2013 02:26:25 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0B74AA61; Sun, 17 Mar 2013
 02:26:24 -0400 (EDT)
In-Reply-To: <1363462256-5823-1-git-send-email-stevenrwalter@gmail.com>
 (Steven Walter's message of "Sat, 16 Mar 2013 15:30:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 978D3710-8ECB-11E2-A95A-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218343>

Steven Walter <stevenrwalter@gmail.com> writes:

> If two processes are racing to create the same directory tree, they will
> both see that the directory doesn't exist, both try to mkdir(), and one
> of them will fail.  This is okay, as we only care that the directory
> gets created.  So, we add a check for EEXIST from mkdir, and continue if
> the directory now exists.
> ---

Thanks.  Please sign-off your patch.

>  sha1_file.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 40b2329..c7b7fec 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -123,6 +123,13 @@ int safe_create_leading_directories(char *path)
>  			}
>  		}
>  		else if (mkdir(path, 0777)) {
> +			if (errno == EEXIST) {
> +				/* We could be racing with another process to
> +				 * create the directory.  As long as the
> +				 * directory gets created, we don't care. */
> +				if (stat(path, &st) && S_ISDIR(st.st_mode))
> +					continue;

	/*
         * Nice explanation, but we try to format our
         * multi-line comments like this, slash-asterisk
         * and nothing else on the opening line, and
         * asterisk-slash and nothing else on the closing
         * line.
         */

Thanks.

> +			}
>  			*pos = '/';
>  			return -1;
>  		}

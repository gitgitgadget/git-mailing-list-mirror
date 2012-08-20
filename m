From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] for-each-ref: Fix sort with multiple keys
Date: Sun, 19 Aug 2012 17:41:05 -0700
Message-ID: <7vfw7io0ny.fsf@alter.siamese.dyndns.org>
References: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org> <2b3624458d79a1ec0b1437172437fbd78b3a0537.1345410836.git.draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 02:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3G3P-0007Gf-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 02:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab2HTAlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 20:41:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab2HTAlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 20:41:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 421C59347;
	Sun, 19 Aug 2012 20:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BOL7UnscBj0CztGmJSEDHM8FS4M=; b=XwY0hF
	Aj3yqmbtgdEBdYq7rs3Sq+3Syh1q9VzzhA3TFgbdcLyZyPgwOyV91JpJk/+Ar4lv
	/QHcE4i4DgK6G7N/WhSzhKKYkr4jvdWZPJnIW2PvytF3mfrijk924BYQTlE5t4nz
	RCv0SM+p7ZQqviWnvk2+GljihDS51113IMeWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I00zePuaD7RfvSH1hI4ve7OMKi3aHdpC
	z+VRoAZmzhlyt0YsueQNJwriboYjlJQ5VMXT3DKboK21NxvWftsluRuLRlGnfxkq
	2xQWcRdYSCz7Os4yAOzm+C7fGKDWaf+1ZpV0pdctEpa6RXEEKj0sTZeVWu9/FuuN
	yKJgbaDJqgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECC49346;
	Sun, 19 Aug 2012 20:41:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8841D9343; Sun, 19 Aug 2012
 20:41:07 -0400 (EDT)
In-Reply-To: <2b3624458d79a1ec0b1437172437fbd78b3a0537.1345410836.git.draenog@pld-linux.org> (Kacper Kornet's message of "Sun, 19 Aug 2012 23:15:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BADCDD08-EA5F-11E1-9665-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203746>

Kacper Kornet <draenog@pld-linux.org> writes:

> The linked list describing sort options was not correctly set up in
> opt_parse_sort. In the result, contrary to the documentation. only the
> last of multiple --sort options to git-for-each-ref was taken into
> account. This commit fixes it.
>
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>  builtin/for-each-ref.c  | 4 +++-
>  t/t6300-for-each-ref.sh | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index b01d76a..0c5294e 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -962,7 +962,9 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
>  	if (!arg) /* should --no-sort void the list ? */
>  		return -1;
>  
> -	*sort_tail = s = xcalloc(1, sizeof(*s));
> +	s = xcalloc(1, sizeof(*s));
> +	s->next = *sort_tail;
> +	*sort_tail = s;

This fix looks correct.  

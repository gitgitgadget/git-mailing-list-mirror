From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/15] merge-recursive: fix memleaks
Date: Fri, 20 Mar 2015 20:48:14 -0700
Message-ID: <xmqqoannau4h.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:48:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZAOg-0005qu-FS
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 04:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbbCUDsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:48:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751561AbbCUDsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:48:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 119DA42AC1;
	Fri, 20 Mar 2015 23:48:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sinsQJ1/1Hw5LD+kxBV6wyLWl0w=; b=UHYieH
	NfpL7ZWCr2YaTe39HfEIdnyevBWbGGOBzOngNcqojDRXP/LjrPIZ6jeBwDobvSDH
	x5X8R/ofE2pXUXrhCwdbrDtRuuws8VCfqEn/Y84D5Q0Aut+m0LYSpjvidQ/Aik8v
	hxztvAm2mx+AhcITQxguAcz1MuXP4un64qmPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcU1c44pAJsmx5z4AGK/O16m5fipORiK
	7DCsCkhiaS8OVi9O8HG5jVq2E8+aLagUbqarMR8gTYfejZDRMyghyS5RJF7NWwux
	WsWrZCYLHexotU4XeValCQ/dsnxUrT8l05dn2jqc56YXimZoEogrqJvWwVnqBowL
	6MWUlCaY828=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0836F42ABF;
	Fri, 20 Mar 2015 23:48:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 816A042ABE;
	Fri, 20 Mar 2015 23:48:15 -0400 (EDT)
In-Reply-To: <1426897692-18322-8-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:28:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1ACC4596-CF7D-11E4-9B06-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266004>

Stefan Beller <sbeller@google.com> writes:

> Usually when using string lists it looks like:
>     struct string_list a = STRING_LIST_INIT_NODUP;
>     // do stuff with a such as
>     string_list_insert(&a, "test string");
>     print_string_list(&a, "test prefix");
>     // Cleaning up works on everything inside the struct, not on the
>     // struct itself:
>     string_list_clear(&a);
>
> But as we deal with the pointers to the string lists directly, we also
> need to free the actual struct.

In other words, these two were allocated for the sole use of this
fuction by get_renames(), so this function is responsible for
freeing it?

Sounds sensible.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  merge-recursive.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 771f5e2..1c9c30d 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1858,6 +1858,9 @@ int merge_trees(struct merge_options *o,
>  		string_list_clear(re_head, 0);
>  		string_list_clear(entries, 1);
>  
> +		free(re_merge);
> +		free(re_head);
> +		free(entries);
>  	}
>  	else
>  		clean = 1;

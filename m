From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] apply.c: reject patch without --(ex,in)clude and
 path outside.
Date: Wed, 09 Nov 2011 15:07:15 -0800
Message-ID: <7vipmsuc7w.fsf@alter.siamese.dyndns.org>
References: <1320878942-9811-1-git-send-email-bruce.e.robertson@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bruce E. Robertson" <bruce.e.robertson@intel.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 00:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROHEq-0007bt-79
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 00:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802Ab1KIXHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 18:07:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531Ab1KIXHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 18:07:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 022D95C79;
	Wed,  9 Nov 2011 18:07:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BY/aDHoB++DZ80HCbmV8kzluEUc=; b=CFM4T0
	k8M7FKZ7FNCCbxDXRRh7M/A8AYY+eg/wFS/6tNTe5y649L1VjOrLbkLY7mZd+1Mq
	Av4TfVQ/E3sDTlpv8ucNcUwycNG+mnvzLjB6RJxqreH047ZGqGNflp6iYPYgrUXt
	47vQOzn6E7j0C3ZaxHM6QaSCDl5HqYwlZPuqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hfX72TixjIcPDCJZGJkgvUaHSstxxml5
	6RM3409sbCWwc35qb2WR4nylLWt/z/hXL9T0A8OgcRZiNo5QztYUdmC8UtRVlDpe
	1LWiAl4RmMYn63Fffkw6cVkSUOj62P13qtLv4wJijyZP5AE0ZLdgjj4HCm7/ymBj
	vW1rEljJ4vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE5A5C78;
	Wed,  9 Nov 2011 18:07:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74B4E5C77; Wed,  9 Nov 2011
 18:07:16 -0500 (EST)
In-Reply-To: <1320878942-9811-1-git-send-email-bruce.e.robertson@intel.com>
 (Bruce E. Robertson's message of "Wed, 9 Nov 2011 14:49:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9129A490-0B27-11E1-B5B4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185177>

"Bruce E. Robertson" <bruce.e.robertson@intel.com> writes:

> From: "Bruce E. Robertson" <bruce.e.robertson@intel.com>
>
> Patches are silently ignored when applied with neither --include nor
> --exclude options when the current working dir is not on patch's
> path. This contravenes the principle of least surprise.

I do not necessarily agree but if you think so perhaps the user should be
told about which paths are rejected. In other words, I think it is wrong
to change the exit code to 1 when you are applying a patch that touches
outside your area, but I think it is not wrong if the program warned about
it.

Does your patch behave like that?

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 84a8a0b..162e2aa 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3619,6 +3619,7 @@ static struct lock_file lock_file;
>  
>  static struct string_list limit_by_name;
>  static int has_include;
> +static int has_exclude;
>  static void add_name_limit(const char *name, int exclude)
>  {
>  	struct string_list_item *it;
> @@ -3717,9 +3718,13 @@ static int apply_patch(int fd, const char *filename, int options)
>  			listp = &patch->next;
>  		}
>  		else {
> -			/* perhaps free it a bit better? */
> -			free(patch);
> -			skipped_patch++;
> +			if ( !has_exclude && !has_include ) {

Style; extra SP inside ().

I am not convinced that the logic here is correct, either.  If you have
exclude but not include, and the patch records a path outside your area,
the path will be rejected even if it does not match any of the exclude
patterns. Shouldn't you be treating that case exactly the same as the case
without any exclude patterns?

> +				patch->rejected = 1;

Doesn't it trigger "errs" to be set in write_out_results()?  This patch is
not free()'ed, but it is not on the "list" either. Where does it go, and
how is that unfreed patch used later in the program?

> +			} else {
> +				/* perhaps free it a bit better? */
> +				free(patch);
> +				skipped_patch++;
> +			}
>  		}
>  		offset += nr;
>  	}
> @@ -3773,6 +3778,7 @@ static int option_parse_exclude(const struct option *opt,
>  				const char *arg, int unset)
>  {
>  	add_name_limit(arg, 1);
> +	has_exclude = 1;
>  	return 0;
>  }

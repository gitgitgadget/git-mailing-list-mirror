From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Thu, 21 Jan 2010 22:24:19 -0800
Message-ID: <7vd412ac8c.fsf@alter.siamese.dyndns.org>
References: <718290.769818367-sendEmail@darysmbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "David Rydh" <dary@math.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Jan 22 07:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYCwc-0007rd-NT
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 07:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab0AVGYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 01:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417Ab0AVGYa
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 01:24:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0AVGY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 01:24:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A354693BF2;
	Fri, 22 Jan 2010 01:24:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJkp8+1Pdn+tftNhCXiDQW2Bgh4=; b=GZVOG0
	cK+3CCsLNNqO3K1ZyEzGodvXATio84W1A9vS4X1tVXQY8n6MKpychpqdZ4NSaLhV
	qfZ4Dtg+1Zvfd2EpUs0PgsJepc3CM+8UKnlL5Jtf1WLnh6Uf7AJcJuiCN8vjG3QR
	zP2ejI3Av+Whswe70Ce/2pDP/NCVfYdFQLhZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KC7fNcO8YjQzB7k48yohtvRkZSkh4YPk
	r+W5LSbNj2x+eklZaA5dEAWwOTAT9hpzrRBzo7W+I4ZtI2jdsHVj0UmS85pofBf1
	/ADAtdbJeAWd3rOUjRDtZ3MGq9VhEGyQVI3up9547JbI6+n7vI7A2kEdVzWCAJQG
	UaHdaTqKE7U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A68893BF1;
	Fri, 22 Jan 2010 01:24:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 748DE93BEF; Fri, 22 Jan
 2010 01:24:20 -0500 (EST)
In-Reply-To: <718290.769818367-sendEmail@darysmbp> (David Rydh's message of
 "Thu\, 21 Jan 2010 12\:39\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8CAA0E8-071E-11DF-B043-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137742>

"David Rydh" <dary@math.berkeley.edu> writes:

> diff --git a/builtin-mv.c b/builtin-mv.c
> index 8247186..1c1f8be 100644
> --- a/builtin-mv.c
> +++ b/builtin-mv.c
> @@ -27,7 +27,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
>  		if (length > 0 && is_dir_sep(result[i][length - 1]))
>  			result[i] = xmemdupz(result[i], length - 1);
>  		if (base_name)
> -			result[i] = basename((char *)result[i]);
> +			result[i] = xstrdup(basename((char *)result[i]));
>  	}
>  	return get_pathspec(prefix, result);
>  }

Given that basename(3) is allowed to modify its parameter, I think the
above code is still not portable.  casting constness away and feeding
result[i], especially when we didn't obtain our own copy by calling
xmemdupz(), is especially problematic.

Perhaps something ugly like this?

	for (i = 0; i < count; i++) {
		int length = strlen(result[i]);
		int to_copy = length;
                while (to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
			to_copy--;
		if (to_copy != length || basename) {
                	char *it = xmemdupz(result[i], to_copy);
                        result[i] = base_name ? strdup(basename(it)) : it;
		}
	}

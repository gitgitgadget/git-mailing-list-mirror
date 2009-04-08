From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] for-each-ref: refactor refname handling
Date: Tue, 07 Apr 2009 23:22:51 -0700
Message-ID: <7vprfnr7es.fsf@gitster.siamese.dyndns.org>
References: <20090407070254.GA2870@coredump.intra.peff.net>
 <20090407070651.GB2924@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRE2-0002SV-BW
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbZDHGXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762350AbZDHGXD
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:23:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762381AbZDHGXB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:23:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 577F4A8222;
	Wed,  8 Apr 2009 02:22:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E9AC1A8220; Wed,
  8 Apr 2009 02:22:53 -0400 (EDT)
In-Reply-To: <20090407070651.GB2924@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 7 Apr 2009 03:06:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B42330B2-2405-11DE-BB8C-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116042>

Jeff King <peff@peff.net> writes:

> This code handles some special magic like *-deref and the
> :short formatting specifier. The next patch will add another
> field which outputs a ref and wants to use the same code.
>
> This patch splits the "which ref are we outputting" from the
> actual formatting. There should be no behavioral change.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The diff is scary, but it is mostly reindentation.

... and an introduction of a bug ;-)

>  builtin-for-each-ref.c |   47 ++++++++++++++++++++++++++---------------------
>  1 files changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 4aaf75c..b50c93b 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -672,32 +672,37 @@ static void populate_value(struct refinfo *ref)
> ...
> +		/* look for "short" refname format */
> +		if (formatp) {
> +			formatp++;
> +			if (!strcmp(formatp, "short"))
> +				refname = get_short_ref(refname);
> +			else
> +				die("unknown %.*s format %s",
> +					formatp - name, name, formatp);

				die("unknown %.*s format %s",
                                    (int)(formatp - name), name, formatp);

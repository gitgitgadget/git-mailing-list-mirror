From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] add special "matching refs" refspec
Date: Wed, 30 Apr 2008 02:23:53 -0700
Message-ID: <7vfxt31ys6.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:25:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr8Ye-0005eL-FN
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 11:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbYD3JYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 05:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756726AbYD3JYM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 05:24:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYD3JYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 05:24:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 55E903994;
	Wed, 30 Apr 2008 05:24:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 56CDD3993; Wed, 30 Apr 2008 05:24:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 30AB6C6C-1697-11DD-98F5-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80818>

Paolo Bonzini <bonzini@gnu.org> writes:

> @@ -937,13 +945,23 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
>  						 const struct ref *src)
>  {
>  	int i;
> +	int matching_refs = -1;
>  	for (i = 0; i < rs_nr; i++) {
> +		if (rs[i].matching &&
> +		    (matching_refs == -1 || rs[i].force)) {
> +			matching_refs = i;
> +			continue;
> +		}
> +
>  		if (rs[i].pattern &&
>  		    !prefixcmp(src->name, rs[i].src) &&
>  		    src->name[strlen(rs[i].src)] == '/')
>  			return rs + i;
>  	}
> -	return NULL;
> +	if (matching_refs != -1)
> +		return rs + matching_refs;
> +	else
> +		return NULL;
>  }

It is probably better to document that you would force if you have both
"+:" and ":" for the same remote, even though I am not sure if allowing
that (instead of diagnosing it as an error) is the right thing to do.

Is it an error to have both ":" and "some:other" refspecs for the same
remote?  If so who makes the check?

Otherwise this patch seems to be very cleanly done.  Especially I like how
the updated match_refs() looks.

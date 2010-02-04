From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Wed, 03 Feb 2010 18:01:01 -0800
Message-ID: <7v7hqtzrmq.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
 <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
 <20100129183705.GB22101@spearce.org>
 <7vockc45ut.fsf@alter.siamese.dyndns.org>
 <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
 <7v3a1oyrkp.fsf@alter.siamese.dyndns.org> <20100201152826.GE8916@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncr26-0005Zm-SF
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab0BDCBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:01:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab0BDCBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:01:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88D0896350;
	Wed,  3 Feb 2010 21:01:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ua7UKiDeWDpdNjTM6n49SVQY8ek=; b=Ac/7I2
	li6MqyUoNDDPQUQC9KfN3Wj+jYLBcsTKL6AcgI1v1Mm8jXbJOfUBuURem0EZDXhL
	yNdsaGXi/XBU48abNqMzyx/bEDXm0z/0V1bOQ/4EiT45nopw8F2qJknLsFSYIzFJ
	1iw4RU2cqRdHazDHaSNV7pRD/T3Kkg3Lro/Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GP03V39rl3PQtTagsCoKIUBaxvQUrWgY
	CwQx61N9xt8poC+OaCtl5sEB8Jq1I0e+G9b/pkZovCMC3DR/QOJzbC15Jv68SUBS
	d1qWsCSJVL05kOnNP5e8Qks6y1+C+gSojsoaOjPco8RG+FDW++jFTB6RaDyjpyvO
	cMDCDfEcfJA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D5BD9634F;
	Wed,  3 Feb 2010 21:01:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10CF49634A; Wed,  3 Feb
 2010 21:01:02 -0500 (EST)
In-Reply-To: <20100201152826.GE8916@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 1 Feb 2010 07\:28\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2987B472-1131-11DF-BE51-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138931>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The strtoumax call got messed up.  Squash this into your merge:
>
> diff --git a/fast-import.c b/fast-import.c
> index e6ebcf6..9c65a24 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2800,7 +2800,7 @@ static int parse_one_option(const char *option)
>  	if (!prefixcmp(option, "max-pack-size=")) {
>  		option_max_pack_size(option + 14);
>  	} else if (!prefixcmp(option, "big-file-threshold=")) {
> -		big_file_threshold = strtoumax(option + 21, NULL, 0) * 1024 * 1024;
> +		big_file_threshold = strtoumax(option + 19, NULL, 0) * 1024 * 1024;
>  	} else if (!prefixcmp(option, "depth=")) {
>  		option_depth(option + 6);
>  	} else if (!prefixcmp(option, "active-branches=")) {
>  
>> You may want to add the new option to the output from "cmd -h" and
>> probably description of the configuration in the doc before any of this
>> gets official.
>
> I'll send an additional patch in a minute with these documentation
> related updates.

Well, well, well....

The documentation says this is counted in bytes, but somehow neither of us
found the above " * 1024 * 1024" suspicious.

Shouldn't it be at least like this?  It would probably be a good idea to
use git_parse_ulong() or somesuch while we are at it.

 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ca21082..ea1ac0f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2800,7 +2800,7 @@ static int parse_one_option(const char *option)
 	if (!prefixcmp(option, "max-pack-size=")) {
 		option_max_pack_size(option + 14);
 	} else if (!prefixcmp(option, "big-file-threshold=")) {
-		big_file_threshold = strtoumax(option + 19, NULL, 0) * 1024 * 1024;
+		big_file_threshold = strtoumax(option + 19, NULL, 0);
 	} else if (!prefixcmp(option, "depth=")) {
 		option_depth(option + 6);
 	} else if (!prefixcmp(option, "active-branches=")) {

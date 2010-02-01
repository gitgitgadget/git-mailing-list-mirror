From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Mon, 01 Feb 2010 12:14:00 -0800
Message-ID: <7v8wbcyarb.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Mon Feb 01 21:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc2fB-0001UJ-Fo
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 21:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab0BAUOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 15:14:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab0BAUOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 15:14:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F9196D16;
	Mon,  1 Feb 2010 15:14:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbqW9fVJLubxqqY4Z94nP84Pkh8=; b=q6JFY5
	7vQyiDNBlrsml3C8UCmE+B6rgCwFVrPlYkKFE1Sm9UykLI/UVtRBSnkh7ITPQqBm
	ZQnieHqjZLg0Dq3hSffH0gudubjxoDNtMlw18KSb+fVB17KjRzre666EQbHOHRJi
	aZLtllrOnSB8MM9D9kHWths76GKKQdEYGGIl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xg/iDtciHwKYU6ypmTMklzcFWj3V+6iP
	Qs+FktJL4v/bLUS5wtoXex7e5rSCjvORNjVg15Qd3nC39yXLDNIAfxIcoDFHBDTb
	aoQzEBrHwLorJ9WY9g199LioWq7DG89CqNl97PmHUkTNtVgafZ9sX3qnP2/vxaoH
	SNqQ+XcAG00=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D3796D0E;
	Mon,  1 Feb 2010 15:14:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDD2096D05; Mon,  1 Feb
 2010 15:14:01 -0500 (EST)
In-Reply-To: <20100201152826.GE8916@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 1 Feb 2010 07\:28\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A2FB620-0F6E-11DF-8AF0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138644>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> I'll queued this with a result of my conflict resolution to 'pu' for now
>> but please double check after I push it out.
>
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

Ah, of course.  Sorry for not being careful and thanks for pointing it
out.

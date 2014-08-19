From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/18] receive-pack: parse feature request a bit earlier
Date: Tue, 19 Aug 2014 15:31:31 -0700
Message-ID: <xmqqbnrgun5o.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:31:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrwP-0000xI-EX
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbaHSWbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:31:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56564 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaHSWbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65E8C33A10;
	Tue, 19 Aug 2014 18:31:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DsMp44kljozVbGy4/K/2tMzEAb0=; b=H+8yEx
	NJ5T6dnPQSng1pe5RTXUfQM+MBv/X7JHgE00o4Pl/CBYK/xA2W007t6+5EDmwRld
	PuC6/wPeKokVGefNTp/0XkNFMgp4QOFuiSZzVs9EsEEyqkusJjLZtId91N0ca7VC
	6mSVgadscdG8xh+5QP0wSu0DIi8/UqL2xJ9z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iRuLicxfaH1XeQZtIIi960NcyDNAuhdn
	ihP29647vxYj1xZ/oBf49oP2YJXg3a3gAQvM9M0D3M64VLpAvOL8SnTGbbSkbJ51
	XpQUa+fikgHJ9egkgfSH6AvKoftVKwY2onlWPjNGL0en2VKyr1JSk4AySJGSyoMK
	UjMqWTmqZhI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C5DF33A0F;
	Tue, 19 Aug 2014 18:31:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 08AEB33A0A;
	Tue, 19 Aug 2014 18:31:32 -0400 (EDT)
In-Reply-To: <1408485987-3590-3-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Tue, 19 Aug 2014 15:06:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9270C890-27F0-11E4-A02F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255541>

Junio C Hamano <gitster@pobox.com> writes:

> Ideally, we should have also allowed the first "shallow" to carry
> the feature request trailer, but that is water under the bridge
> now.  This makes the next step to factor out the queuing of commands
> easier to review.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> ...
> @@ -853,7 +853,18 @@ static struct command *read_head_info(struct sha1_array *shallow)
>  			continue;
>  		}
>  
> -		if (len < 83 ||
> +		linelen = strlen(line);
> +		if (linelen < len) {
> +			const char *feature_list = line + linelen + 1;
> +			if (parse_feature_request(feature_list, "report-status"))
> +				report_status = 1;
> +			if (parse_feature_request(feature_list, "side-band-64k"))
> +				use_sideband = LARGE_PACKET_MAX;
> +			if (parse_feature_request(feature_list, "quiet"))
> +				quiet = 1;
> +		}
> +
> +		if (linelen < 83 ||
>  		    line[40] != ' ' ||
>  		    line[81] != ' ' ||
>  		    get_sha1_hex(line, old_sha1) ||
> @@ -863,15 +874,6 @@ static struct command *read_head_info(struct sha1_array *shallow)
>  
>  		refname = line + 82;
>  		reflen = strlen(refname);

A later patch updates this to "reflen = linelen - 82" while moving
this code to a helper function, but it may be better to do that in
this patch.

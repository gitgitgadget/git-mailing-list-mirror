From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Share color list between graph and show-branch
Date: Sun, 03 Apr 2011 12:12:28 -0700
Message-ID: <7v7hbbcfoj.fsf@alter.siamese.dyndns.org>
References: <1301535506-1166-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6SjG-0007PG-8p
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab1DCTMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:12:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab1DCTMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:12:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E720B4208;
	Sun,  3 Apr 2011 15:14:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5KmMcEyvB/D4omjdkwxgbvMFrwM=; b=qtFxnmRQl+TR/YeH3K0e
	UICkPpL1s/Jr90IAqfbtbyALy/wAomJVQ2TvzBD3pKjjmJDEed0zEWUuzK9T5Byy
	uCL2vjgK/WaebkUES71tuJOIEXT2eLh4JYGDA370JaEwIBXhrvCxDKAaS3MmHmi7
	D9lV81jXPMBT/SRUBC/l4hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EZg2dZhs1TS6UPwGwpntY+Ca0pxRbmrQWffH1/pxP0NUsg
	HdspcH7qqYsGAQF3eelrO5/XvieOnTxH8clU2kbdz0SEw5PifnlXOOxRAN8pqnVk
	OUwWgzJpADWQk8ddraWFOSLdX00xKUmjUuJswxUEl87nZXxMvlfvYl+ZPXGcA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C53F24202;
	Sun,  3 Apr 2011 15:14:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DAFC441FF; Sun,  3 Apr 2011
 15:14:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96747938-5E26-11E0-8CD2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170773>

Dan McGee <dpmcgee@gmail.com> writes:

> diff --git a/color.h b/color.h
> index c0528cf..a7da793 100644
> --- a/color.h
> +++ b/color.h
> @@ -53,6 +53,10 @@ struct strbuf;
>   */
>  extern int git_use_color_default;
>  
> +extern const char *column_colors_ansi[13];
> +
> +/* Ignore the RESET at the end when giving the size */
> +#define COLUMN_COLORS_ANSI_MAX (ARRAY_SIZE(column_colors_ansi) - 1)

Sneaky.

I first went "Huh? -- this array-size macro cannot work", expecting that
the array is not decleared with a fixed size in the header.

It may make sense to unify these two palettes whose slot assignment does
not have any meaning, but it feels that the above change totally goes
against the spirit of using ARRAY_SIZE() macro, the point of which is to
liberate programmers from having to count and adjust the size when adding
the contents to the array.

Wouldn't it make more sense to do something like

    >>> in the header <<<
    extern const char *custom_colors_ansi[];
    extern const int CUSTOM_COLORS_ANSI_MAX;

    >>> in the code <<<
    const char *custom_colors_ansi[] = {
            ... as before ...
    };
    /* Does not count the last element "RESET" */
    const int CUSTOM_COLORS_ANSI_MAX = ARRAY_SIZE(custom_colors_ansi) - 1;

to avoid mistakes?

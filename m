From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Tue, 15 Oct 2013 16:57:39 -0700
Message-ID: <20131015235739.GI9464@google.com>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <20131015231427.GF9464@google.com>
 <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWEUk-0003QR-NI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933856Ab3JOX5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:57:43 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39342 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933729Ab3JOX5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:57:42 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so172662pad.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5sp+qk0JdDmXwtKeFq/MZHGAu4Knd0X4fGi/cnSHpcI=;
        b=XdKPsmmDwCKRMaIeng0jn57FxTnP2qlazdYhvrzhakbUdHuqrb7VQbmeweizgp6LZr
         DYFEZdghDZphXBIfHO7xT/NE/rTH4ZiNQ719KCPNs0g9kix6PrI+JH0h+88xqHMmT9I4
         0ccJC/L7QViCC/YGREn1PYxyWXdSRiPBoWjR9CP0/o78tPzbXeCNj8rEEM6QVZP9O1mS
         SpvBgphKInb5nmBMz64FXsBTccSABD6gYDaAXM3Jum+uxdzOmJrCRR3o8A81wU6UtkEF
         xNYT/+huZjYcHIcwHSzNGtMhsCftaKypSROqWwM+I9eygApgpqRpydm00m5/My0L/0Iw
         LrrQ==
X-Received: by 10.67.1.228 with SMTP id bj4mr382296pad.157.1381881461852;
        Tue, 15 Oct 2013 16:57:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ok2sm19322002pbb.24.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 16:57:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236223>

Junio C Hamano wrote:

> You just made these two that the user clearly meant to express two
> different things indistinguishable.
>
> 	opt.sh -S
>       opt.sh -S ''
[...]
> And that is exactly why gitcli.txt tells users to use the 'sticked'
> form, and ends the bullet point with:
>
>    An option that takes optional option-argument must be written in
>    the 'sticked' form.

Yes, another possibility in that vein would be to teach rev-parse
--parseopt an OPTIONS_LONG_STICKED output format, and then parse with

	while :
	do
		case $1 in
		--gpg-sign)
			... no keyid ...
			;;
		--gpg-sign=*)
			keyid=${1#--gpg-sign=}
			...
			;;
		esac
		shift
	done

This still leaves

	opt.sh -S
	
and

	opt.sh -S''

indistinguishable.  Given what the shell passes to execve, I think
that's ok.

The analagous method without preferring long options could work almost
as well:

	while :
	do
		case $1 in
		-S)
			... no keyid ...
			;;
		-S?*)
			keyid=${1#-S}
			...
			;;
		esac
		shift
	done

but it mishandles "--gpg-sign=" with empty argument.

Jonathan

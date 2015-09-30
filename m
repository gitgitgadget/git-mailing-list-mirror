From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Fixed sending of many/huge changes/patches
Date: Wed, 30 Sep 2015 10:51:25 -0700
Message-ID: <xmqqr3lf94o2.fsf@gitster.mtv.corp.google.com>
References: <1443597969-3962-1-git-send-email-polynomial-c@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, juston.h.li@gmail.com,
	Stefan Agner <stefan@agner.ch>
To: Lars Wendler <polynomial-c@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 30 19:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhLXj-0001vn-01
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbbI3Rvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 13:51:47 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35767 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610AbbI3Rva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 13:51:30 -0400
Received: by pacfv12 with SMTP id fv12so48011773pac.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tp32tNhA+5yNz8zSvaw4GPFqt/k6h9CriHT99Dax+wg=;
        b=nTtAiQ2ZW7uVapXcR6eTWGCIPAIwK/Z1pxeGAYf/eLe6ENYrtscFPwRHPv/2o6q6fd
         QBf9cRlmft5kP0nUXMFS2w4klVTwFrEoq5okJXHBlP7Uq9yf9Q4vUmCrBRhvboFbwnSI
         7kDRrbzyR7PzsU2VRtpnnMLHEX9/TadFG6L0/cDDWlu+nwMJv3V6XH2sjdifGnmp5KHo
         k8larV2ldYx7ITvKMQLWkOKoBgfboOSxmP3LOGFraNtizS+/y/cY7icandPgVp3I9JQQ
         DWB0lu/LL/WO/kjLr9194S0gVVt8dc+hoYTldI30LNHaP8TcIfrv6KfrdFEdjVvmfDKj
         ATBw==
X-Received: by 10.68.237.196 with SMTP id ve4mr6351390pbc.98.1443635490192;
        Wed, 30 Sep 2015 10:51:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id uq5sm1411379pac.19.2015.09.30.10.51.28
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 30 Sep 2015 10:51:28 -0700 (PDT)
In-Reply-To: <1443597969-3962-1-git-send-email-polynomial-c@gentoo.org> (Lars
	Wendler's message of "Wed, 30 Sep 2015 09:26:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278848>

Lars Wendler <polynomial-c@gentoo.org> writes:

> It seems to me that there is a size limit, after cutting down the patch
> to ~16K, sending started to work. I cut it twice, once by removing lines
> from the head and once from the bottom, in both cases at the size of
> around 16K I could send the patch.
>
> See also original report:
> http://permalink.gmane.org/gmane.comp.version-control.git/274569
>
> Reported-by: Juston Li <juston.h.li@gmail.com>
> Tested-by: Markos Chandras <hwoarang@gentoo.org>
> Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
> ---
>  git-send-email.perl | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e3ff44b..e907e0ea 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1365,7 +1365,11 @@ Message-Id: $message_id
>  		$smtp->mail( $raw_from ) or die $smtp->message;
>  		$smtp->to( @recipients ) or die $smtp->message;
>  		$smtp->data or die $smtp->message;
> -		$smtp->datasend("$header\n$message") or die $smtp->message;
> +		$smtp->datasend("$header\n") or die $smtp->message;
> +		my @lines = split /^/, $message;
> +		foreach my $line (@lines) {
> +			$smtp->datasend("$line") or die $smtp->message;
> +		}

Thanks.  One and a half comments.

 * If 16k is the limit, and smtp payload line limit is much much
   shorter than that, is it sensible to send data line by line?

 * Has this been reported to Net::Cmd::datasend() upstream?

>  		$smtp->dataend() or die $smtp->message;
>  		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
>  	}

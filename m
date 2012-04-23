From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 8/9] difftool: teach difftool to handle directory diffs
Date: Mon, 23 Apr 2012 12:04:04 -0700
Message-ID: <xmqq1unejmmz.fsf@junio.mtv.corp.google.com>
References: <1335205421-19295-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 21:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMOYW-0003mp-C1
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 21:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab2DWTEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 15:04:07 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:55313 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab2DWTEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 15:04:06 -0400
Received: by qcsp5 with SMTP id p5so1377898qcs.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 12:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=DqHXG49L+h6ohU5C0/gAJAM5ax8YIMeMrNJlzVoIgnQ=;
        b=USflDNuhCTV5YifcWcT6gtwfxvH11u+CYh962JDHsqifAeI+/4SnoxSo9jCOOdZJIo
         yZ24ToZwJdrhFii4xntFH4mpzjCreypechMj1KtyrZSvuPH/h6kwGhKx5n1OrF+eoSOc
         1aUbwToUV5CmAudMAI5R5g1dPmt/htJdq1bK89q2wElqVLzQagsvdNQ8xIGY2swv7/BM
         rZd+0yV0b86wcjg1us/th/7lNWauBVtrB1aM6pJxCzHCYb8tIOpPpw4Md2HHVIQ+Dg8d
         zx+jOADCNyDeqV59Y6HQ3Z5LmLGYWAJgPzz6kvW0joPKR+yj4Dh7B0ZiUAphkGd/jLGj
         ZWJw==
Received: by 10.236.180.33 with SMTP id i21mr20971476yhm.1.1335207845294;
        Mon, 23 Apr 2012 12:04:05 -0700 (PDT)
Received: by 10.236.180.33 with SMTP id i21mr20971452yhm.1.1335207845210;
        Mon, 23 Apr 2012 12:04:05 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si15699153yhn.7.2012.04.23.12.04.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 12:04:05 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 1E7AF10004D;
	Mon, 23 Apr 2012 12:04:05 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id BE78FE120A; Mon, 23 Apr 2012 12:04:04 -0700 (PDT)
In-Reply-To: <1335205421-19295-1-git-send-email-tim.henigan@gmail.com> (Tim
	Henigan's message of "Mon, 23 Apr 2012 14:23:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnXVlzBKlkE4dVscC+7gYzbzKnnsPe1qkmbIAWx6YPMkHBy2cWaAwsiffByVdQht9Iw92/9qmGh2lgB2lbcMjgQNYBOBDGomDSXEhsCrPDeOZv/hhDZj+blyx+PmZag+nzx+W0BMXRXyd5a5IDo6COudiYqpDmof43PiluEMBAJwu9ax0M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196159>

Tim Henigan <tim.henigan@gmail.com> writes:

> +	while ($i < $#rawdiff) {
> +		if ($rawdiff[$i] =~ /^::/) {
> +			print "Combined diff formats ('-c' and '--cc') are not supported in directory diff mode.\n";
> +			exit(1);
> +		}
> +
> +		my ($lmode, $rmode, $lsha1, $rsha1, $status) = split(' ', substr($rawdiff[$i], 1));
> +		my $src_path = $rawdiff[$i + 1];
> +		my $dst_path;
> +
> +		if ($status =~ /^[CR]/) {
> +			$dst_path = $rawdiff[$i + 2];
> +			$i += 3;
> +		} else {
> +			$dst_path = $src_path;
> +			$i += 2;
> +		}

The update to this part looks good to me ;-)

Thanks.  Will replace what is queued.

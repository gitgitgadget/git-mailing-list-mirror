From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 17:11:17 -0700
Message-ID: <20121031001117.GA29486@elie.Belkin>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTLuF-0000wV-FD
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 01:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab2JaAL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 20:11:26 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37611 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab2JaAL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 20:11:26 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so540590pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TJwYSfYqxyOTOElJviPYOt5sOH3RFQkHkHsbvTQ5yAE=;
        b=eA97baVI6/ds5JI1mWckQJORouhaS6rMSD/Ja4G4l+y5RSlKuG72hbTgz0kfNi+gkw
         +yyD/B8HXl+XncL7lkmq7h6uEJBVGMBl45S08WyBN7rp1qNp1l6ksAxe15q7V/+VsnBQ
         9ML+LIJrm55PrW1NYG+SSkmcRt/LhPYpcIpuAbU0LT9jvT473XqmMuoU2uDz1Odt7Mgb
         WQfs2YiNbU6jLmz31bS4mJGVFv5cNr20Qib0+ZFOXHAlNLuC9rRDTRMS0oA6TRxDvOUh
         1JaXLz8KlSz5qWK5b6Q4UEcz+GXyjmSBPWcNyY/7S5k+M/FJ4GFV97IQz2qzV2F5wtnA
         XdHw==
Received: by 10.68.200.193 with SMTP id ju1mr49573770pbc.53.1351642285511;
        Tue, 30 Oct 2012 17:11:25 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id bc8sm1166926pab.5.2012.10.30.17.11.24
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 17:11:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208772>

(cc-ing the git list)
Felipe Contreras wrote:

> When an object has already been exported (and thus is in the marks) it
> is flagged as SHOWN, so it will not be exported again, even if this time
> it's exported through a different ref.
>
> We don't need the object to be exported again, but we want the ref
> updated

Yes, makes perfect sense.

For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> --- a/t/t5800-remote-helpers.sh
> +++ b/t/t5800-remote-helpers.sh
> @@ -145,4 +145,15 @@ test_expect_failure 'push new branch with old:new refspec' '
>  	compare_refs clone HEAD server refs/heads/new-refspec
>  '
>  
> +test_expect_success 'push ref with existing object' '
> +	(cd localclone &&
> +	git branch point-to-master master &&
> +	git push origin point-to-master
> +	) &&
> +
> +	(cd server &&
> +	git show-ref refs/heads/point-to-master
> +	)

Style: if you indent like this, the test becomes clearer:

	(
		cd localclone &&
		git branch point-to-master master &&
		git push origin point-to-master
	) &&
	(
		cd server &&
		git rev-parse --verify refs/heads/point-to-master
	)

[...]
> +test_expect_success 'refs are updated even if no commits need to be exported' '
> +	git fast-export --import-marks=tmp-marks \
> +		--export-marks=tmp-marks master > /dev/null &&

The redirect just makes the test log with "-v" less informative, so
I'd drop it.

> +	git fast-export --import-marks=tmp-marks \
> +		--export-marks=tmp-marks master > actual &&
> +	test_cmp expected actual

Redirections in git shell scripts are generally spelled as
"do_something >actual", without a space between the operator and
filename.

Hope that helps,
Jonathan

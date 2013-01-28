From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 09/11] t4014: more tests about appending s-o-b lines
Date: Sun, 27 Jan 2013 19:31:46 -0800
Message-ID: <20130128033146.GM8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-10-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:32:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzfSA-0006Ky-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 04:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab3A1Dbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 22:31:53 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55864 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3A1Dbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 22:31:52 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so1195981pbc.8
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 19:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bf5BszL32HIW1mmaKFj0b5eOb5TaDxQKvzprq23B7fU=;
        b=styGNwQgLEsQZju4t7lIPRuLatWYQxD8RRkIRfFF4xOtBz27FQWA8UXn2JJdHXuLCW
         Ydsoi2mMG4GFi7UnptMQKnmO1EhWKZIswpFRR23ON/7O5ni4/sOZ8hf1SOHGd1axdZFw
         0pNYoL0swd+7Rqwj1t1y4r/yaXikRjDYx4/0wbuoTcFZ08CO7h/gsrEKI0NGDzdwfb9R
         fVNmYMGcWDtIgr+xpHQ8Qcy2EknwnxNREOX9DNx/OGgxecbSkRlve8ArNTHoAIyPohOc
         22yEN3gsqwolrr/vTKN1p2Xqw0ROOoJf/Z9OjVhAllG4kl3726/85WyYKhoo5xnTyAkY
         o1Gg==
X-Received: by 10.68.244.6 with SMTP id xc6mr34339720pbc.94.1359343912051;
        Sun, 27 Jan 2013 19:31:52 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id gv9sm5421662pbc.21.2013.01.27.19.31.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 19:31:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-10-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214797>

Brandon Casey wrote:

[...]
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1021,4 +1021,246 @@ test_expect_success 'cover letter using branch description (6)' '
>  	grep hello actual >/dev/null
>  '
>  
> +append_signoff()
> +{
> +	C=`git commit-tree HEAD^^{tree} -p HEAD` &&
> +	git format-patch --stdout --signoff ${C}^..${C} |
> +		tee append_signoff.patch |
> +		sed -n "1,/^---$/p" |
> +		grep -n -E "^Subject|Sign|^$"
> +}

Is "grep -n" portable?  I didn't find any uses of it elsewhere in the
testsuite.

Style: checking exit status from format-patch, avoiding sed|grep pipeline:

	C=$(git commit-tree HEAD^ -p HEAD) &&
	git format-patch --stdout --signoff $C^..$C >append_signoff.patch &&
	awk '
		/^---$/ { exit; }
		/^Subject/ || /^Sign/ || /^$/ { print NR ":" $0 }
	' <append_signoff.patch >actual

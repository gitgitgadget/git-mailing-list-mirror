From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] submodule: prevent warning in summary output
Date: Mon, 19 Aug 2013 20:13:30 +1200
Message-ID: <5211D3AA.6060403@gmail.com>
References: <1376847095-767956-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Aug 19 10:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKZl-0001fW-3L
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773Ab3HSIM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 04:12:28 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:34298 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3HSIM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 04:12:27 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so4658132pbb.24
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qAewoFApLI+mvy1qyRJexoymWk8/1eQbyCpSPvCU6B4=;
        b=moyzbhNU+uRqGNKmXA5kTTF443HOYTlI9ii5+uKp52/vSYp5R7Ayg+xD+GtUz40hvu
         sdO7PXL6vXjMx2nUXF1gv8sINsiZWUpQcEc4VCA7hTMU0AfH3ZZEd1Lz+5DOUwkot9zP
         GN+YfGu7dhH7PIsyUAGtXCBm81osofMei+yZu4I5PAnCzMeisdfB+1J6L6M44nt7WLmv
         /90YXwlhc4JvCR10WlVG5sQOrGR/Io9NwuCYPr5b3CeOiQ4D410D03LBSWGnEOwBIsmy
         CtLeLqzMnvKFqF4MflsrCpei4ebclqKSocOK6QNClMnLuP74mW8Q4+BbDqqqK8wZvnHO
         Kj0g==
X-Received: by 10.67.14.231 with SMTP id fj7mr11199443pad.115.1376899946623;
        Mon, 19 Aug 2013 01:12:26 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id xe9sm13584768pbc.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 01:12:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <1376847095-767956-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232532>

Hi Brian,
On 19/08/13 05:31, brian m. carlson wrote:
> When git submodule summary is run and there is a deleted submodule, there is an
> warning from git rev-parse:
> 
>   fatal: Not a git repository: '.vim/pathogen/.git'
> 
> Silence this warning, since it is fully expected that a deleted submodule will
> not be a git repository.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..66ee621 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1071,7 +1071,7 @@ cmd_summary() {
>  		missing_dst=
>  
>  		test $mod_src = 160000 &&
> -		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
> +		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null 2>&1 &&
>  		missing_src=t
>  
>  		test $mod_dst = 160000 &&
> 

I wonder if there are other useful errors this will silence
unintentionally. Perhaps this would be better (untested)

 test $mod_src = 160000 &&
 test -e "$name/.git" &&
 ! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 /dev/null &&
  missing_src=t

Having said that there are precedents for both in git-submodule.sh. If
there aren't any errors worth catching here then your way is probably
cleaner than mine.

- C

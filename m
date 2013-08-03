From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] submodule: don't print status output with ignore=all
Date: Sat, 3 Aug 2013 11:24:20 -0700
Message-ID: <20130803182420.GG2893@elie.Belkin>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Aug 03 20:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5gVQ-0001bP-Bt
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 20:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab3HCSY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 14:24:26 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56758 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab3HCSYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 14:24:25 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so1840673pbc.3
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xk+fsRb05j3VtyCGO/XMrrGKD1BFgNaLmJ+hVrbP/7E=;
        b=F1nLb2WKamB6elWqqhF02b+VB9rkTDLsnnsgbwkDhuZNltvsvr+SR2hmMueIpIStRR
         270/JsZWKQIyU347N/syBdYkmvLKgZp4b5kdUZC5lc7WSi93FjhmzsbuC3jY4ce98ywL
         zjZ18yleEJRwcrfPXtghN3rDW+4yx6qXMtRI7mbV4yf3TBoN7IumWrUU7Ab92sNrQsQA
         geqRSxDNrst2LOGWB40l7AUJ2wgsEo3ui1niUarZQhMymEe+FfvZX1MwikzRj4vnBY6o
         98wn9pMz5iKenC5xj9hzU/7Vl6T+r1mb9Ndas+F6C9M0nzcj6kGDMe2pfdSJu1k2SIgI
         UQNA==
X-Received: by 10.66.222.138 with SMTP id qm10mr16991957pac.101.1375554264748;
        Sat, 03 Aug 2013 11:24:24 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id dg3sm17451845pbc.24.2013.08.03.11.24.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 11:24:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231614>

brian m. carlson wrote:

> git status prints information for submodules, but it should ignore the status of
> those which have submodule.<name>.ignore set to all.  Fix it so that it does
> properly ignore those which have that setting either in .git/config or in
> .gitmodules.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-submodule.sh  | 2 ++
>  t/t7508-status.sh | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Thanks.  Cc-ing Jens, who wrote that test and knows this code much
better than I do. :)

[...]
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1034,6 +1034,8 @@ cmd_summary() {
>  		sane_egrep '^:([0-7]* )?160000' |
>  		while read mod_src mod_dst sha1_src sha1_dst status path
>  		do
> +			name=$(module_name "$path")
> +			test $(get_submodule_config "$name" ignore none) = all && continue
>  			# Always show modules deleted or type-changed (blob<->module)
>  			test $status = D -o $status = T && echo "$path" && continue

I'm not sure what the exact semantics should be here, though that's
mostly because of my unfamiliarity with submodules in general.

If I have '[submodule "favorite"] ignore = all' and I then replace
that submodule with a blob, should "git submodule status" not mention
that path?

If I just renamed a submodule, will 'module_name "$path"' do the right
thing with the old path?

(rest of the patch kept unsnipped for reference)
>  			# Also show added or modified modules which are checked out
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index ac3d0fe..fb89fb9 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1316,7 +1316,7 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
>  	test_i18ncmp expect output
>  '
>  
> -test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
> +test_expect_success '.gitmodules ignore=all suppresses submodule summary' '
>  	git config --add -f .gitmodules submodule.subname.ignore all &&
>  	git config --add -f .gitmodules submodule.subname.path sm &&
>  	git status > output &&
> @@ -1324,7 +1324,7 @@ test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
>  	git config -f .gitmodules  --remove-section submodule.subname
>  '
>  
> -test_expect_failure '.git/config ignore=all suppresses submodule summary' '
> +test_expect_success '.git/config ignore=all suppresses submodule summary' '
>  	git config --add -f .gitmodules submodule.subname.ignore none &&
>  	git config --add -f .gitmodules submodule.subname.path sm &&
>  	git config --add submodule.subname.ignore all &&
> -- 
> 1.8.4.rc1

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Test the interaction of --bool and --get-regexp on a
 key with no explicit value
Date: Thu, 26 Aug 2010 22:15:11 -0500
Message-ID: <20100827031511.GC23924@burratino>
References: <1282844716-30591-1-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Fri Aug 27 05:17:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OopR8-0002RF-Ko
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 05:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab0H0DQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 23:16:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60502 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab0H0DQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 23:16:56 -0400
Received: by yxg6 with SMTP id 6so928775yxg.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2ECHGJ0Xmsh7cTDymWlg8znxh2Qn9WGitZhqqMn1bTU=;
        b=GkEtJHnc4q7/X19xq0iiVh4MmWrWBPZCEseFKrqBj9jhmU9HuaHVjFIxS7mQaWKZ4L
         GBOOluSY7HSh/3LuoBrSJVwSj3bFlfrX1/U7ed/z/zGVEGjYp2HfsXp0qpCc0SUyI0Do
         DUvB/1IFlSJ9ROHJ9C105M9xmNcEhgV28KmIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YUsK62+VsTqmVFHt6mw8fxscgpN4Ewl8x0UzJKtg55178jFpjWDUmpeWXFIzLjyd7I
         NHx3MTAhUOkU3AJ7JJHuA8O5S0EsVhJpO7Q/VOGdAwK26B7+HSH4rwAg7r+LZLsYS6H5
         4UPr8zl7GBr+Tj6L1RGWuOftwcX16vw+XsApM=
Received: by 10.151.100.10 with SMTP id c10mr1039627ybm.425.1282879015333;
        Thu, 26 Aug 2010 20:16:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q21sm8298282ybk.3.2010.08.26.20.16.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 20:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282844716-30591-1-git-send-email-alex@chmrr.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154578>

Alex Vandiver wrote:

> Signed-off-by: Alex Vandiver <alex@chmrr.net>
> ---
> 
> This test currently fails -- I don't have time to track down the fix,
> but I figured that at least I could provide a failing test.  Note that
> --null isn't necessary for the failure; without it, one gets
> "section.sub=section.val5true", with no spacing between the key and
> value.

This is useful info (the motivation!) for the log mesage I think,
though it might be even better to squash the patch with the fix. :)

> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -816,6 +816,16 @@ echo >>result
>  
>  test_expect_success '--null --get-regexp' 'cmp result expect'
>  
> +cat > expect <<\EOF
> +section.sub=section.val5
> +trueQ
> +EOF
> +
> +git config --null --bool --get-regexp 'val5' | perl -pe 'y/\000/Q/' > result
> +echo >>result
> +
> +test_expect_success '--null --get-regexp --bool' 'cmp result expect'

Style nitpicks (based on the "Do's, don'ts &" c section of t/README):

 - setup code (cat >expect) belongs in the body of tests.
   That way, it is clearer when each test begins and ends, and
   unexpected failures and output from setup code will be
   automatically noticed and suppressed, respectively.

 - there is no public nul_to_q () function but I still think it
   is clearer to use one;

 - test_cmp is guaranteed to work just as well as cmp and produces
   nicer output when tests run with "-v" fail.

So maybe:

 test_expect_failure '--get-regexp --bool still separates key and value' '
	echo 'section.sub=section.val5 true' >expected &&
	git config --bool --get-regexp val5 >actual &&
	test_cmp expected acutal
 '

 test_expect_failure '--get-regexp --bool --null' '
	printf "%s\n%s\0" "section.sub=section.val5" "true" >expected &&
	git config -z --bool --get-regexp val5 >actual &&
	test_cmp expected actual
 '

Thanks for reporting.

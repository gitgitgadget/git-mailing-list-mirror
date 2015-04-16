From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 20:27:43 +0200
Message-ID: <1429208863.3097.19.camel@elego.de>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
	 <xmqqsic0hyk4.fsf@gitster.dls.corp.google.com>
	 <20150416155558.GA10390@peff.net>
	 <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 20:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YioVy-0000bp-CG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbbDPS1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:27:46 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:41062 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbbDPS1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:27:45 -0400
Received: from centaur.local (p57A97B07.dip0.t-ipconnect.de [87.169.123.7])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 0636CDE72E;
	Thu, 16 Apr 2015 20:27:43 +0200 (CEST)
In-Reply-To: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.9-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267321>

On Thu, 2015-04-16 at 10:16 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Apr 16, 2015 at 08:39:55AM -0700, Junio C Hamano wrote:
> >
> >> >  test_expect_success 'status untracked directory with --ignored' '
> >> >  	echo "ignored" >.gitignore &&
> >> > +	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
> >> > +	mv .gitignore.new .gitignore &&
> >> 
> >> Is this "write literal in \xHEX on the replacement side of sed
> >> substitution" potable?  In any case, replacing the above three with
> >> something like:
> >> 
> >> 	printf "<bom>ignored\n" >.gitignore
> >> 
> >> may be more sensible, no?
> >
> > I'm not sure about sed, but I agree it is suspect. And note that printf
> > with hex codes is not portable, either You have to use octal:
> >
> >   printf '\357\273\277ignored\n' >.gitignore
> >
> > Also, as a nit, I'd much rather see this in its own test rather than
> > crammed into another test_expect_success. It's much easier to diagnose
> > failures if the test description mentions the goal, and it is not tied
> > up with testing other parts that might fail.
> 
> Yeah, I totally agree.
> 
> Carlos, something like this squashed in, perhaps?
> 
>  t/t7061-wtstatus-ignore.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index 0a06fbf..cdc0747 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -13,8 +13,6 @@ EOF
>  
>  test_expect_success 'status untracked directory with --ignored' '
>  	echo "ignored" >.gitignore &&
> -	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
> -	mv .gitignore.new .gitignore &&
>  	mkdir untracked &&
>  	: >untracked/ignored &&
>  	: >untracked/uncommitted &&
> @@ -22,6 +20,15 @@ test_expect_success 'status untracked directory with --ignored' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'same with gitignore starting with BOM' '
> +	printf "\357\273\277ignored\n" >.gitignore &&
> +	mkdir -p untracked &&
> +	: >untracked/ignored &&
> +	: >untracked/uncommitted &&
> +	git status --porcelain --ignored >actual &&
> +	test_cmp expected actual
> +'
> +
>  cat >expected <<\EOF
>  ?? .gitignore
>  ?? actual
> 

Yeah, that makes sense. I had something similar in my patch at one point
before going with modifying the current one.

   cmn

From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: local clone performance
Date: Thu, 27 Jul 2006 14:36:19 -0400
Message-ID: <9e4733910607271136n55545959y3dbff97b1e5efe31@mail.gmail.com>
References: <9e4733910607261637w75c99a2ehcb25b6c81449d298@mail.gmail.com>
	 <20060727181554.GD13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 20:36:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Aij-0003Rp-3B
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 20:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWG0Sg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 14:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWG0Sg0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 14:36:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59546 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751788AbWG0SgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 14:36:25 -0400
Received: by ug-out-1314.google.com with SMTP id m3so418391ugc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 11:36:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jD9Apy+wqG/MVyc2DD3B+XDvPA0zbqRP4NUu7JzUnCd6mQEiEIQpfqnQk8Yb8IesD7kEQlCoz8C1bLmoP1xlfNqKfj2aXtkiUVhUzYS4sI/UGHa1yAT89oqxO6UI4wvELhbTRxD/CK8Gi8Gtp8qEJZ1vsJqzFV4gdHWGD65dl2g=
Received: by 10.78.120.6 with SMTP id s6mr20047huc;
        Thu, 27 Jul 2006 11:36:24 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Thu, 27 Jul 2006 11:36:19 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060727181554.GD13776@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24328>

On 7/27/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Jul 27, 2006 at 01:38:00AM CEST, I got a letter
> where Jon Smirl <jonsmirl@gmail.com> said that...
> > Comparing git-clone to cg-clone
> >
> > [jonsmirl@jonsmirl apps]$ time git-clone git foo
> > ......
> > real    0m5.755s
> > user    0m4.548s
> > sys     0m0.512s
> >
> > [jonsmirl@jonsmirl apps]$ time cg-clone git foo
> > ....
> > real    0m18.970s
> > user    0m10.737s
> > sys     0m1.392s
> >
> > Why does it take cg clone so long to set up the missing tags?
> > git-clone is over 3x faster.
>
>   How many tags do you have?

I am cloning the git source tree. It looks to have about 40 tags.

>   It's true that cg-clone does not scale very well with big amounts of
> tags, because it won't fetch tagged objects you wouldn't get otherwise
> (so if you tagged some random huge blob or a history line which is not
> part of any branch you have, cg-clone won't grab it all). This
> unfortunately costs us one special fetch invocation per tag; I will look
> into hacking git-local-fetch to accept multiple commit ids at once, that
> should speed it up considerably.
>
>   That said, with cg-clone -a I will be able to cut that difference
> entirely and blindly take everything from the other repository.
>
>   Could you please try the patch below and check if it has at least
> any measurable impact on the performance at all? Thanks.

New timings
real    0m11.259s
user    0m9.977s
sys     0m1.280s

That's a 40% improvement.

> diff --git a/cg-fetch b/cg-fetch
> index a6e6959..23e0e77 100755
> --- a/cg-fetch
> +++ b/cg-fetch
> @@ -54,7 +54,6 @@ _git_wc_unneeded=1
>
>  fetch_progress()
>  {
> -       [ $verbose -ge 2 ] && exec cat
>         if [ -t 1 ]; then
>                 exec "${COGITO_LIB}"cg-Xfetchprogress "$_git_objects"
>         else
> @@ -166,7 +165,11 @@ fetch_http()
>  {
>         whead=
>         [ "$3" ] && whead="-w $3"
> -       (git-http-fetch -a -v $whead $recovery "$1" "$2/" 2>&1 /dev/null) | fetch_progress
> +       if [ $verbose -ge 2 ]; then
> +               git-http-fetch -a -v $whead $recovery "$1" "$2/"
> +       else
> +               (git-http-fetch -a -v $whead $recovery "$1" "$2/" 2>&1 /dev/null) | fetch_progress
> +       fi
>         return ${PIPESTATUS[0]}
>  }
>
> @@ -197,7 +200,11 @@ fetch_local()
>  {
>         whead=
>         [ "$3" ] && whead="-w $3"
> -       (git-local-fetch -a -l -v $whead $recovery "$1" "$2" 2>&1 /dev/null) | fetch_progress
> +       if [ $verbose -ge 2 ]; then
> +               git-local-fetch -a -l -v $whead $recovery "$1" "$2"
> +       else
> +               (git-local-fetch -a -l -v $whead $recovery "$1" "$2" 2>&1 /dev/null) | fetch_progress
> +       fi
>         return ${PIPESTATUS[0]}
>  }
>
> @@ -230,6 +237,7 @@ fetch_tags()
>                         # if so, fetch the tag -- which should be
>                         # a cheap operation -- to complete the chain.
>                         echo -n "Missing tag ${tagname#tags/}... "
> +                       local verbose=2
>                         if $fetch "$tagname" "$uri" "$tagname" 2>/dev/null >&2; then
>                                 echo "retrieved"
>                         else
>
>
> --
>                                 Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> Snow falling on Perl. White noise covering line noise.
> Hides all the bugs too. -- J. Putnam
>


-- 
Jon Smirl
jonsmirl@gmail.com

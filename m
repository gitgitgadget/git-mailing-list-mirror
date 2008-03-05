From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2] git-submodule: Don't die when command fails for one submodule
Date: Thu, 6 Mar 2008 01:20:39 +0800
Message-ID: <46dff0320803050920l4483d436of9b938936b47bfb4@mail.gmail.com>
References: <1204730478-22027-1-git-send-email-pkufranky@gmail.com>
	 <alpine.LSU.1.00.0803051742290.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:22:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWxJL-0005j5-Nk
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 18:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbYCERUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 12:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756548AbYCERUo
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 12:20:44 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:49311 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643AbYCERUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 12:20:43 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2017332tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 09:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ifYcaTi+qFvk4gSzHbtIdwScBU/k5DBfYqO8f+FOW04=;
        b=uTbESJzAiwnLWghTno0a6xESVCHX2DOxqBt6flg0azxvAeo1B1Xu6RoaKPuskCeKZ3gvzq/KH4gah1tFVB5aY1Xgpiw2n7dk0cjXO8YRym/EeSlD+3HPMRNXY9jVttT9KCKeKz7KrFdDTdyS+L9gODW8NUN+lA1hEU9qBgSu16g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O8k/bCZfN+cuZLVdSFu9FC847JdzN3oK3/TBqPPeSRYeTwKWQBJvoq9qSRjR7mxmqTQRuIioeQCoQ0GFvqnSoZ4jo0Heix+tU+DdGR3QHSI5u6uZBdFNqds1K5HS6s3eueKrQuy9aVHybSa5rCJCL6TUbAIxSRiuO3WTWryKDEE=
Received: by 10.150.152.17 with SMTP id z17mr1331684ybd.37.1204737639933;
        Wed, 05 Mar 2008 09:20:39 -0800 (PST)
Received: by 10.150.218.21 with HTTP; Wed, 5 Mar 2008 09:20:39 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803051742290.15786@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76246>

On Thu, Mar 6, 2008 at 12:48 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Wed, 5 Mar 2008, Ping Yin wrote:
>
>  > @@ -221,29 +229,40 @@ cmd_init()
>  >       done
>  >
>  >       git ls-files --stage -- "$@" | grep -e '^160000 ' |
>  > +     {
>  > +     total=0
>  > +     success=0
>  >       while read mode sha1 stage path
>  >       do
>  > +             total=$(( $total + 1 ))
>  >               # Skip already registered paths
>  > -             name=$(module_name "$path") || exit
>  > +             name=$(module_name "$path") || continue
>
>  What about this case?  Was the comment misleading?
>
>
>  >               url=$(git config submodule."$name".url)
>  > -             test -z "$url" || continue
>  > +             test -n "$url" && success=$(( $success + 1 )) && continue
>
>  Why counting?  Why not just 'status=0 && continue'?
>
>
>  >
>  > -             git config submodule."$name".url "$url" ||
>  > -             die "Failed to register url for submodule path '$path'"
>  > -
>  > -             say "Submodule '$name' ($url) registered for path '$path'"
>  > +             if git config submodule."$name".url "$url"
>  > +             then
>  > +                     say "Submodule '$name' ($url) registered for path '$path'"
>  > +             else
>  > +                     say "Failed to register url for submodule path '$path'"
>  > +                     continue
>  > +             fi
>  > +             success=$(( $success + 1 ))
>  >       done
>  > +     test $success = $total
>  > +     }
>  >  }
>  >
>  >  #
>
>  Note: I have not even begun to audit if one of your returns should not
>  have been a "status=0 && continue" instead.
>
>
>  > @@ -358,9 +392,11 @@ cmd_status()
>  >       done
>  >
>  >       git ls-files --stage -- "$@" | grep -e '^160000 ' |
>  > +     {
>  > +     exit_status=0
>  >       while read mode sha1 stage path
>  >       do
>  > -             name=$(module_name "$path") || exit
>  > +             ! name=$(module_name "$path") && exit_status=1 && continue
>  >               url=$(git config submodule."$name".url)
>  >               if test -z "$url" || ! test -d "$path"/.git
>  >               then
>  > @@ -380,6 +416,8 @@ cmd_status()
>  >                       say "+$sha1 $path$revname"
>  >               fi
>  >       done
>  > +     exit $exit_status
>  > +     }
>  >  }
>
>  But here you use the simpler paradigm of setting exit_status?  Why that
>  complicated and ugly "total" and "success" counting before?
>
>  Ciao,
>  Dscho
>
>

'total' and 'success' is a trick which i think is simpler than
exit_status=1/exit_status=0 in cmd_update and cmd_init.

In the while loop of these two functions, there are many tests which
will continue the loop after a failure. By using exit_stauts, i have
to replace 'cmd || continue' as '! cmd && exit_status=1 && continue".
I don't want so many exit_status in the while loop. So i use 'total'
and 'sucess' which count the total number of loops and the number of
successful loops separately to simplify this. The trick is as follows:

'total' will plus 1 when at the beginning of a loop and success will
plus 1 at the end of loop. If  a loop succeeds and continues in the
middle of a loop, success also plus 1. Failed loops never reach the
loop end so success will not plus 1.

After leaving all loops,  $sucess=$total means all loops succeed and
exit status should be 0, or exit status should be 1.

In cmd_status, the 'cmd || continue' only exists in one place, so i
use exit_status instead of 'success' and 'total'.





-- 
Ping Yin

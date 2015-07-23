From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Thu, 23 Jul 2015 10:18:35 -0700
Message-ID: <CA+P7+xq1BYg6xE3pWJbXadEPbm2tcyRhOoy9-Scsx7Bj2krJqw@mail.gmail.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
 <1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
 <xmqqio9brgrj.fsf@gitster.dls.corp.google.com> <CA+P7+xo4xYVsoitBk7SJhQtHU9_dXFiOpWefUr_8M96GqX8W1w@mail.gmail.com>
 <xmqqa8umrfge.fsf@gitster.dls.corp.google.com> <xmqq1tfyre46.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIK98-0004rT-2A
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbbGWRS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:18:57 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36753 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbGWRSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:18:55 -0400
Received: by oibn4 with SMTP id n4so170432769oib.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+7bijLfz0oxYB7oBF12RwV47xprdtHx4J1OMjpV70rY=;
        b=vQsuh0kliEc6zjur7sMewkNOVgrqAjPgpp4ZTZeIa4XdehxlohssUYnQh9dVs2m8Uo
         6ffdk/VYaw271nn0LgTD5gkipTJ/HEmpszIMPnTPExxum6yU7diOwKwem7k2AUT8uwXG
         upRtGvF6GiW/fKarURbxUckFIEotvLckficLjsFdcA0ekEcaL52oABuIR4qS++5DZiNA
         gl4nCxkD43fFi+9gf7H6Avc/wDnCkVMbksf3SBUe0uyXYA+1OxDtXWPJSTUCBB/s+GiS
         jne3Khefbd7EVk22OWwWzXWwiZCNNTYYoMSQebqkLf1O+R59xUPLfbnN37NUBUzJqK2W
         uNWg==
X-Received: by 10.202.86.215 with SMTP id k206mr9363808oib.13.1437671934932;
 Thu, 23 Jul 2015 10:18:54 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 23 Jul 2015 10:18:35 -0700 (PDT)
In-Reply-To: <xmqq1tfyre46.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274508>

On Thu, Jul 23, 2015 at 10:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> That was whitespace damaged, so I had to hand-tweak the file in
> place.  While at it, I noticed that we do not check a case where
> multiple asterisks appear in a single component (which is rejected
> for a reason different from having multiple components with an
> asterisk in them), which also deserves its own test.
>

Oops. Sorry about that..

> I'll squash in the following instead.
>
> There is a slightly related tangent I noticed while doing so.
>
> I wonder if there is an obvious and unambiguous interpretation of
> what this command line wants to do:
>
>     $ git fetch origin refs/heads/*g*/for-linus:refs/remotes/i-*/mine
>

Personally, I do think this is "obvious" but I don't think that our
parser is at all smart enough to handle it. The  advantage with the
current code, is that the match parser already handles it perfectly.
It was just the rules up front which limited how much we could do. I
don't think the added complexity is that valuable here.. For most
common cases it's just prefixes or suffixes that matter.

> We _might_ want to allow one (and only one) component with more than
> one asterisk on the LHS of a refspec, while requiring only one
> asterisk on the RHS to allow "this '*g*' is just like '*' but
> excluding things that do not have 'g' in it".
>

As above, I think it's obvious the intended meaning, but... the actual
interpretation could be a variety of things. It's not guaranteed to be
interpreted in that way, and while we could document it, I don't think
that it is worth the complexity unless someone actually needs this
behavior.

> Or it may not be worth the additional complexity.
>

Below diff looks fine, thanks!

Regards,
Jake

>
>  t/t5511-refspec.sh | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
> index de6db86..f541f30 100755
> --- a/t/t5511-refspec.sh
> +++ b/t/t5511-refspec.sh
> @@ -71,15 +71,18 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
>  test_refspec push ':refs/remotes/frotz/delete me'              invalid
>  test_refspec fetch ':refs/remotes/frotz/HEAD to me'            invalid
>
> -test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
> -test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
> +test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
> +test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
>
> -test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
> -test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
> +test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*'
> +test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*'
>
>  test_refspec fetch 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>  test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>
> +test_refspec fetch 'refs/heads/*g*/for-linus:refs/remotes/mine/*' invalid
> +test_refspec push 'refs/heads/*g*/for-linus:refs/remotes/mine/*' invalid
> +
>  test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
>  test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
>

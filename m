From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/9] t3510 (cherry-pick-sequencer): use exit status
Date: Fri, 9 Dec 2011 14:21:49 -0600
Message-ID: <20111209202149.GH20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:22:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6xH-0000D3-7p
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab1LIUVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:21:55 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44485 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab1LIUVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:21:55 -0500
Received: by yenm11 with SMTP id m11so2398658yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EzF10Uxd7PEEzrmBnBdvzD12PCCGljBvHcAqHQBsWhM=;
        b=q5vlftMGXIcSKxLKRggccyFpP9+7vIZM5GfXweEDz4gqEo7PP2mzUJ9sfr8DF1V5jH
         kU7wl2b4TteXOb5qlzg/+/sTIcahqnNCsXuuSMXWIAMEkClq7+EJYiKCnqTc74WV5nt7
         fyBo+V0XGzE+shdiy6taEHK5piMLg7QE8ZMbs=
Received: by 10.236.131.82 with SMTP id l58mr14333227yhi.36.1323462114369;
        Fri, 09 Dec 2011 12:21:54 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o50sm16775113yhl.9.2011.12.09.12.21.52
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 12:21:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186681>

Ramkumar Ramachandra wrote:

> Since cf3e2486 (revert: Propagate errors upwards from do_pick_commit,
> 2011-08-04), 'git cherry-pick' has three different ways of failing:
>
> 1. die() with the exit status 128.
> 3. error() out with exit status -1.
> 2. exit with positive exit status to indicate a conflict.

I think your list-item counter is showing a little jitter. :)

error() does not produce exit status -1, and any situation other than
propagating exit status from a user-defined script in which git exits
with status 255 is a bug (yes, I know there are a couple, though none
I know of in cherry-pick code paths).

Hasn't cherry-pick had two ways to exit with failing status like "git
merge" does (conflicts versus error that didn't even allow us to
start) since the very beginning?

[...]
>                   So, replace all instances of 'test_must_fail' with
> 'test_expect_code' to check the exit status explicitly.

Sounds like a sensible idea.  Probably this one sentence, plus a quick
note on the user-visible exit status convention, would suffice for
explaining it.

> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
[...]
> @@ -53,7 +53,7 @@ test_expect_success 'cherry-pick persists data on failure' '
>  
>  test_expect_success 'cherry-pick persists opts correctly' '
>  	pristine_detach initial &&
> -	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
> +	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
>  	test_path_is_dir .git/sequencer &&

Encountered conflicts, preserving options, but the exit is with status
128?  Smells like a bug.

[...]
> @@ -88,12 +88,12 @@ test_expect_success '--quit does not complain when no cherry-pick is in progress
>  
>  test_expect_success '--abort requires cherry-pick in progress' '
>  	pristine_detach initial &&
> -	test_must_fail git cherry-pick --abort
> +	test_expect_code 128 git cherry-pick --abort

I don't think the exit status is important for this one.  (I.e., I can
imagine some future version of cherry-pick using different small
positive integers to refer to different reasons for --abort to fail,
and I don't think that would be a problem or break anything.)

[...]
> @@ -179,9 +179,9 @@ test_expect_success '--abort keeps unrelated change, easy case' '
>  test_expect_success '--abort refuses to clobber unrelated change, harder case' '
>  	pristine_detach initial &&
>  	echo changed >expect &&
> -	test_must_fail git cherry-pick base..anotherpick &&
> +	test_expect_code 1 git cherry-pick base..anotherpick &&
>  	echo changed >unrelated &&
> -	test_must_fail git cherry-pick --abort &&
> +	test_expect_code 128 git cherry-pick --abort &&

Likewise here.

Except as noted above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

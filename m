From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Fri, 14 Nov 2014 13:57:47 -0800
Message-ID: <20141114215746.GB93845@gmail.com>
References: <1416000835-79274-1-git-send-email-davvid@gmail.com>
 <xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpOsJ-0001xv-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 22:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161942AbaKNV5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 16:57:48 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35857 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbaKNV5r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 16:57:47 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so17316512pdb.25
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 13:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m0qJEnZ+Dek2lVoiodZndNGQW/cZEe/CDxinW7+QR+c=;
        b=hys2ryZhULEoL+ROlN9KyV7TjsA6KB4EhTW5MgF0S5aiGyODba3ZorqN8o0FcLGRld
         txi0BqAtDV826Lq2lTG6UmS5c7oePWvdKHcPNq3rwBA30qzhZHYPt8tE25jkKtWQNEJA
         gfBjJtLOSrXD5ETb3BftN/wxp/iz2sKfiIBESUqs1FkisUsxlq0mRMWMB9FT9SB1S/X2
         v1PIBKcrBm3TvH0HePSe8onTl4nJ8Lp3DWZnEanbFESC1BuReaftuX2iFFDsSnNk9tR2
         3S2nYC8lYq9j0M6ak+y4KGXTNDGtsy6rFoHg8hJRFFFS8azeqJQNGPnFf8UT1PB4cHuM
         JYpg==
X-Received: by 10.66.222.100 with SMTP id ql4mr12850308pac.123.1416002266661;
        Fri, 14 Nov 2014 13:57:46 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id j5sm28508164pdp.9.2014.11.14.13.57.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 13:57:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 01:51:39PM -0800, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > run_merge_tool() was not setting $status, which prevented the
> > exit code for builtin tools from being forwarded to the caller.
> >
> > Capture the exit status and add a test to guarantee the behavior.
> >
> > Reported-by: Adria Farres <14farresa@gmail.com>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> >  git-mergetool--lib.sh | 1 +
> >  t/t7800-difftool.sh   | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > index a40d3df..2b66351 100644
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -221,6 +221,7 @@ run_merge_tool () {
> >  	else
> >  		run_diff_cmd "$1"
> >  	fi
> > +	status=$?
> >  	return $status
> >  }
> 
> Thanks for a quick turn-around.  As a hot-fix for what is already in
> -rc I am fine with this fix but the patch makes me wonder if $status
> as a global shell variable has any significance.
> 
> I see that this shell function in its early part does this:
> 
> 	status=0
>         setup_tool "$1" || return 1
> 
> which means that the caller of this function, instead of checking
> what is returned as the return value of the function like:
> 
> 	if run_merge_tool ...
>         then
> 		...
> 
> relies on the value of $status in its later part of the code like:
> 
> 	run_merge_tool ...
> 	...
> 	if test "$status" = 0
> 	then
> 		...
> 
> then we are already in trouble.  And the latter form, if we had such
> a flow in the code, is simply a bad taste.
> 
> A cleaner fix might be to get rid of the extra $status variable from
> this function and let the function return the result of its last
> command, either run_merge_cmd or run_diff_cmd, by either explicitly
> having "return $?" at the end, or not having that "return $status"
> line.  But that relies on us not having any caller that relies on
> the $status carried as a global variable around, so it will be more
> work to convince ourselves that such a fix is correctly done.  From
> my cursory look, what I suggested above should be safe and correct,
> but I do not want to risk an unnecessary and silly breakage this
> late in the cycle.
> 
> So I'll queue this patch as-is for upcoming 2.2, but I think we
> would want to revisit this issue after the release is done.


Thanks for the sug, I totally agree with that.
I'll put a $status audit/rework for mergetool+difftool on my
todo list.

cheers,
-- 
David

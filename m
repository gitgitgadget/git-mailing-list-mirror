From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Re: [PATCH] use lockfile.c routines in git_commit_set_multivar()
Date: Fri, 27 Jul 2007 14:24:34 -0400
Message-ID: <f158199e0707271124t7a8e449dld5a7bb8af98151ac@mail.gmail.com>
References: <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
	 <Pine.LNX.4.64.0707261926590.14781@racer.site>
	 <f158199e0707261148r29419a39h7d83fc7bd0ea7df1@mail.gmail.com>
	 <7vfy3a5uzv.fsf@assigned-by-dhcp.cox.net>
	 <7v7iom5twd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 20:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEUUT-0004XV-U4
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049AbXG0SYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756600AbXG0SYh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:24:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:61586 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbXG0SYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:24:37 -0400
Received: by ug-out-1314.google.com with SMTP id j3so752141ugf
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 11:24:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=So/pCuTmolnM6VdgQxZE3jnpPV0hcMGAOq76gPdDj/OEfNl1cNce1WfMpa7WxWiowPvZUyVikutghNxPbW6SQjMMyEvVGT6+SijBIGpFiekIMTWkYIIg3rjlFfNW4pxfVo2oIq2UGdZBVxLBWpbObn9grUlHJOJhD3rpAsaaJn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RwSTj2NHHCeP1dJe3hF8/v9vvuMdgjO3VOakvNNpJby4zJLh6sWtbXSUcTzP4aT1MoX0nqXl2csSZK5cPUfc3MWxqDToZsfFpT7hX1ms5GVHXLFt3tjl4c3m9S/gRnOan3QMBPKjXKRZf+wzJEogDFp1GKREpTPi6JmPofqMZh4=
Received: by 10.82.189.6 with SMTP id m6mr2923912buf.1185560674910;
        Fri, 27 Jul 2007 11:24:34 -0700 (PDT)
Received: by 10.82.191.19 with HTTP; Fri, 27 Jul 2007 11:24:34 -0700 (PDT)
In-Reply-To: <7v7iom5twd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53938>

That's great!

I've added this patch to my local branch and confirmed that all tests,
including the new ones, run successfully.

Thanks!

Bradford

On 7/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Bradford Smith" <bradford.carl.smith@gmail.com> writes:
> >
> >> FWIW, I have successfully run 'make test' and also verified that it
> >> behaves as I expect with my ~/.gitconfig symlink (in conjunction with
> >> the my other patch for resolving symlinks).
> >
> > Existing "make test" testsuite is not an appropriate thing to
> > say this patch is safe, as we do not have much symlinking in the
> > test git repository there.  Care to add a new test or two?
>
> How about this?  On top of your "lockfile to keep symlink" and
> "set-multivar to use lockfile protocol" patches.
>
> ---
>
>  t/t1300-repo-config.sh |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 1c43cc3..187ca2d 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -595,4 +595,19 @@ echo >>result
>
>  test_expect_success '--null --get-regexp' 'cmp result expect'
>
> +test_expect_success 'symlinked configuration' '
> +
> +       ln -s notyet myconfig &&
> +       GIT_CONFIG=myconfig git config test.frotz nitfol &&
> +       test -h myconfig &&
> +       test -f notyet &&
> +       test "z$(GIT_CONFIG=notyet git config test.frotz)" = znitfol &&
> +       GIT_CONFIG=myconfig git config test.xyzzy rezrov &&
> +       test -h myconfig &&
> +       test -f notyet &&
> +       test "z$(GIT_CONFIG=notyet git config test.frotz)" = znitfol &&
> +       test "z$(GIT_CONFIG=notyet git config test.xyzzy)" = zrezrov
> +
> +'
> +
>  test_done
>
>

From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn connections
Date: Fri, 6 Sep 2013 05:44:20 -0700
Message-ID: <E8831080-6FD3-4276-BE80-F0E9BAC65AA3@gmail.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106> <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Uli Heller <uli.heller@daemons-point.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 14:44:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHvOs-0002IA-2D
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 14:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab3IFMoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 08:44:24 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37826 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3IFMoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 08:44:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so3313370pad.33
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=0VU+nvocE4bEO8mLsdjZjT6RcPAgtC3glpgdWaHL98o=;
        b=zyCn9XdDgWcP9K+OEYahXHwk/fT5RDekBbOACE9ovYUp9uYklIdAg7O4aO/l+BepQu
         vB2k8qRJj+E+C2A79Z+mGItCRREE4k5njL6GD3KmWN1BK2Rc8VuqKpJGqOSGLzFNld4P
         NpribPbF63aSRYciU2j5Y468RlWj92E+8giC96DRr+oOVjh/manI2xqskzW+gxcMhrvW
         dCMe/zSJE0Pw8a6v7AvRSHjsqcP63yzOWQemTRbJ0+Nn9eqtaItcG2oOgTQ73Fsbjh0f
         Q3dyx8nQfds7BJe0h0wmd+Tyvc1kZNWXrt9VHNM1u6k3TkIqLYPsjDyH3D9vdfT4mZNN
         8mBQ==
X-Received: by 10.66.169.172 with SMTP id af12mr3789124pac.23.1378471462238;
        Fri, 06 Sep 2013 05:44:22 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id bu4sm3696530pbc.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 05:44:21 -0700 (PDT)
In-Reply-To: <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234044>

On Sep 5, 2013, at 11:48, Junio C Hamano wrote:
> I am Cc'ing Kyle McKay who apparently had some experience working
> with git-svn with newer svn that can only use serf, hoping that we
> can get an independent opinion/test just to be sure.

On Sep 3, 2013, at 00:35, Uli Heller wrote:
> When using git-svn in combination with serf-1.2.1 core dumps are
> created on termination. This is caused by a bug in serf, a fix for
> the bug exists (see https://code.google.com/p/serf/source/detail?r=2146) 
> .
> Nevertheless, I think it makes sense to fix the issue within the
> git perl module Ra.pm, too. The change frees the private copy of
> the remote access object on termination which prevents the error
> from happening.
>
> Note: Since subversion-1.8.0 and later do require serf-1.2.1 or later,
> the core dumps typically do show up when upgrading to a recent version
> of subversion.
>
> Credits: Jonathan Lambrechts for proposing a fix to Ra.pm.
> Evgeny Kotkov and Ivan Zhakov for fixing the issue in serf and
> pointing me to that fix.
> ---

In addition to the needed 'Signed-off-by:' a mention should be made  
here of the need to use 'https:' to reproduce the problem.

> perl/Git/SVN/Ra.pm | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 75ecc42..78dd346 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -32,6 +32,11 @@ BEGIN {
> 	}
> }
>
> +END {
> +	$RA = undef;
> +	$ra_invalid = 1;
> +}
> +
> sub _auth_providers () {
> 	my @rv = (
> 	  SVN::Client::get_simple_provider(),
> -- 
> 1.8.4

Tested-by: Kyle J. McKay <mackyle@gmail.com>

I was able to reproduce the core dumps using subversion 1.8.3 (the  
most recent subversion release) with serf 1.3.1 (the most recent serf  
release) and verify that this patch eliminates the core dump at git- 
svn termination time.

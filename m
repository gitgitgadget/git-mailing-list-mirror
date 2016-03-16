From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t9117: test specifying full url to git svn init -T
Date: Wed, 16 Mar 2016 19:34:07 +0000
Message-ID: <20160316193407.GA3781@dcvr.yhbt.net>
References: <20160316190954.GR29016@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael G. Schwern" <schwern@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:34:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHCx-00054Z-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbcCPTeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:34:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36524 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcCPTeI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:34:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F6E633808;
	Wed, 16 Mar 2016 19:34:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160316190954.GR29016@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289022>

Adam Dinwoodie <adam@dinwoodie.org> wrote:
> According to the documentation, full URLs can be specified in the `-T`
> argument to `git svn init`.  However, the canonicalization of such
> arguments squashes together consecutive "/"s, which unsurprisingly
> breaks http://, svn://, etc URLs.  Add a failing test case to provide
> evidence of that.
> 
> On systems where Subversion provides svn_path_canonicalize but not
> svn_dirent_canonicalize (Subversion 1.6 and earlier?), this test passes,
> as svn_path_canonicalize doesn't mangle the consecutive "/"s.
> 
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>

Thanks, I was just working on a patch to fix this problem
when I got this patch :)

Signed-off-by: Eric Wong <normalperson@yhbt.net>

> ---
> 
> I think the bug here is in using perl/Git/SVN/Utils.pm's
> `canonicalize_path` on the `-T` argument.  If it's available, that
> function calls Subversion's `svn_dirent_canonicalize`.  The Subversion
> code[0] makes it clear that this function is fine for relative and
> absolute local paths, and for UNC paths on Windows, but it isn't
> suitable for use on URLs.
> 
> [0]: https://svn.apache.org/repos/asf/subversion/trunk/subversion/include/svn_dirent_uri.h

Yep, we should be using canonicalize_url for URLs.  I was able
to reproduce this on Debian jessie (GNU/Linux), too.

> It occurs to me that the correct "fix" here may simply be to stop
> claiming support for specifying URLs as arguments to -T, and mandate
> users use the `git svn init $url -T $dirent` syntax instead,

Nope, we should never stop supporting existing behavior without
very good reason and adequate deprecation warnings.

> --- a/t/t9117-git-svn-init-clone.sh
> +++ b/t/t9117-git-svn-init-clone.sh
> @@ -119,4 +119,10 @@ test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
>         rm -f warning
>         '

For future reference, your mail editor is expanding tabs to
spaces and munging your patches.  mutt won't do that itself
(at least not with my config), so I guess it's your editor.

Manually fixing up the whitespaces damage on my end.

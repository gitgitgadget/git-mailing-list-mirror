From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/rfc] git-svn.perl: workaround assertions in svn library 1.5.0
Date: Mon, 7 Jul 2008 02:06:05 -0700
Message-ID: <20080707090605.GA20731@untitled>
References: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 11:07:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFmgd-0008HT-0z
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 11:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbYGGJGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 05:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYGGJGI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 05:06:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56909 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbYGGJGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 05:06:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 3C4112DC095;
	Mon,  7 Jul 2008 02:06:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87595>

Gerrit Pape <pape@smarden.org> wrote:
> With subversion 1.5.0 (C and perl libraries) the git-svn selftest
> t9101-git-svn-props.sh fails at test 25 and 26.  The following commands
> cause assertions in the svn library
> 
>  $ cd deeply
>  $ git-svn propget svn:ignore .
>  perl: /build/buildd/subversion-1.5.0dfsg1/subversion/libsvn_ra/ra_loader.c:674: svn_ra_get_dir: Assertion `*path != '/'' failed.
>  Aborted
> 
>  $ git-svn propget svn:ignore ..
>  perl: /build/buildd/subversion-1.5.0dfsg1/subversion/libsvn_subr/path.c:120: svn_path_join: Assertion `is_canonical(component, clen)' failed.
> 
> With this commit, git-svn makes sure the path doesn't start with a
> slash, and is not a dot, working around these assertions.
> 
> The breakage was reported by Lucas Nussbaum through
>  http://bugs.debian.org/489108
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>

Thanks Gerrit,

This works with svn 1.4.3 here

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> I ran into this on Debian/unstable.  With svn 1.5.0 the selftest fails
> without the patch, with svn 1.4.6 it succeeds with and without the
> patch.  I'm not familar with the svn interfaces, not sure whether this
> is a regression in subversion, or a bug in git-svn.
> 
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index f789a6e..a366c89 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -643,6 +643,8 @@ sub canonicalize_path {
>  	$path =~ s#/[^/]+/\.\.##g;
>  	$path =~ s#/$##g;
>  	$path =~ s#^\./## if $dot_slash_added;
> +	$path =~ s#^/##;
> +	$path =~ s#^\.$##;
>  	return $path;
>  }
>  
> -- 
> 1.5.6

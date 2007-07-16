From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn fetch
Date: Sun, 15 Jul 2007 20:30:50 -0700
Message-ID: <20070716033050.GA29521@muzzle>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:30:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAHIU-0000Q9-P0
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759823AbXGPDaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759923AbXGPDaw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:30:52 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42446 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759701AbXGPDav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:30:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id AF0A82DC08D;
	Sun, 15 Jul 2007 20:30:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070715130548.GA6144@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52630>

martin f krafft <madduck@madduck.net> wrote:
> Hi,
> 
> I am trying to track/convert the Debian pkg-mdadm repository with
> git-svn:
> 
>   svn://svn.debian.org/svn/pkg-mdadm/mdadm/trunk
> 
> My problem is that the fetching fails:
> 
>   fatal: refs/remotes/tags/2.6.1-1~exp.1: cannot lock the ref
>   update-ref -m r311 refs/remotes/tags/2.6.1-1~exp.1
>   c6e351ea25dc90714048e33693099595c2d5dab8: command returned error:
>   128
> 
> This is because the ~ character is an invalid character for
> a refname (it's used to specify the nth parent).
> 
> So I figured that the best way to deal with this is to introduce
> a conversion filter to git-svn, but I cannot figure out where it has
> to go. My perl is rusty and even after an hour now with the code,
> I could not find the right spot.
> 
> The following patch works, but I can't really explain why. Moreover,
> it does not change the STDERR output, so you'll still get stuff like 
> 
>   r340 = 0dc5693471af9dfdb712c1342071ba1040af8963
>   (tags/2.6.1-1~exp.3)
> 
> which makes me think that it's translating the refname too late.
> However, the end result looks sane.
> 
> Comments welcome,

The major issue with this is that it doesn't handle odd cases
where a refname is sanitized into something
(say "1234~2" sanitizes to "1234=2"), and then another branch
is created named "1234=2".

git-svn should at least keep track of what it got sanitized to, to
avoid clobbering branches.

I started working on this a while back but haven't gotten around
to revisiting it:
http://thread.gmane.org/gmane.comp.version-control.git/45651

> ---
> git-check-ref-format(1) documents which characters may be contained in
> a refname. Since Subversion has different rules, an import can result in
> problems, such as:
> 
>   fatal: refs/remotes/tags/2.6.1-1~exp.1: cannot lock the ref
>   update-ref -m r311 refs/remotes/tags/2.6.1-1~exp.1
>   c6e351ea25dc90714048e33693099595c2d5dab8: command returned error: 128
> 
> This patch translates bad characters to valid substitutes to enable imports of
> tags/branches/whatever using characters that git does not allow in refnames.
> 
> Signed-off-by: martin f. krafft <madduck@piper.oerlikon.madduck.net>
> ---
>  git-svn.perl |   24 +++++++++++++++++++++++-
>  1 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 299b40f..de43697 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1239,7 +1239,29 @@ sub new {
>  	$self;
>  }
>  
> -sub refname { "refs/remotes/$_[0]->{ref_id}" }
> +sub refname {
> +	my ($refname) = $_[0]->{ref_id};
> +	## transform the refname as per rules in git-check-ref-format(1):
> +	# no slash-separated omponent can begin with a dot .
> +	# /.* becomes /,*
> +	$refname =~ s|/\.|/,|g;
> +	# It cannot have two consecutive dots .. anywhere
> +	# .. becomes ,,
> +	$refname =~ s|\.\.|,,|g;
> +	# It cannot have ASCII control character space, tilde ~, caret ^,
> +	# colon :, question-mark ?, asterisk *, or open bracket[ anywhere
> +	# <space> becomes _
> +	# ~ becomes =
> +	# ^ becomes @
> +	# : becomes %
> +	# ? becomes $
> +	# * becomes +
> +	# [ becomes (
> +	$refname =~ y| ~^:?*[|_=@%\$+(|;
> +	# It cannot end with a slash /
> +	$refname =~ s|/$||g;
> +	"refs/remotes/$refname";
> +}
>  
>  sub svm_uuid {
>  	my ($self) = @_;
> -- 

-- 
Eric Wong

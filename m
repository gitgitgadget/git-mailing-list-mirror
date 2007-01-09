From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Fix git_patchset_body not closing <div class="patch">
Date: Tue, 9 Jan 2007 15:35:31 -0800 (PST)
Message-ID: <189181.35429.qm@web31811.mail.mud.yahoo.com>
References: <11683840631010-git-send-email-jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 10 00:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QVD-0003eZ-Gy
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbXAIXfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbXAIXfc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:35:32 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:33238 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932538AbXAIXfc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 18:35:32 -0500
Received: (qmail 36392 invoked by uid 60001); 9 Jan 2007 23:35:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=aVNl0loIKa7Ke9u/o/BevU3mDf3NPbZDDgGtEgqEI+YZKvU8mJsfu8+h2Q9/h42L70FMFSJZJjiZFHksXhDzPn8z5LAkkl+QVP7rBQTzt1zMNuvYYMXyEi4c+8hR6mWBL6xdptez6uVFeQvQ6wcNLlBgTALiIuGCYQFafaw+5mU=;
X-YMail-OSG: 8616Dx8VM1mpF_G3lo_O_leiK5OUn0thc7u9B9CgtMDUJkgSYqUUakH30GFipfe1aWHy8vBFSDF5MYz0PsCnruf.cQoARsg0d341s5nqkBJ62CjDvgD1WdO8g50p0D34gSjQFdb3R8o-
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Tue, 09 Jan 2007 15:35:31 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <11683840631010-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36423>

--- Jakub Narebski <jnareb@gmail.com> wrote:

> Fix case when git_patchset_body didn't close <div class="patch">,
> for patchsets with last patch empty.
> 
> perlsyn(1):
>   The "last" command immediately exits the loop in question.
>   The "continue" block, if any, is not executed.
> 
> Remove some commented out code in git_patchset_body.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Acked-by: Luben Tuikov <ltuikov@yahoo.com>

This patch fixes it.

    Luben


> ---
> 
> Luben Tuikov wrote:
> > --- Jakub Narebski <jnareb@gmail.com> wrote:
> >> Jakub Narebski wrote:
> >>> Luben Tuikov wrote:
> >>> 
> >>>> Ok, I see that Junio has committed the fixes to "next" -- thanks!
> >>>> That saved me time having to manually apply them.
> >>>> 
> >>>> Now, the results are that I see the same bug.
> >>>  
> >>> (The same bug = no closing div).
> >>> 
> >>> I'll try to reproduce this.
> >> 
> >> I failed to reproduce this error.
> >> 
> >> Could you apply the following patch, and report the result of
> >>   grep "</div>\|<div" | grep -v "<div.*</div>
> >> (find all opening and closing <div> elements, but omitting
> >> those which are opened and closed in the same line)?
> 
> [...] 
> > <div class="patchset">
> > <div class="patch" id="patch1">
> > <div class="diff extended_header">
> > </div><!-- diff extended_header -->
> > </div><!-- patch 0 -->
> > <div class="patch" id="patch2">
> > <div class="diff extended_header">
> > </div><!-- diff extended_header -->
> > </div><!-- patchset -->
> [...] 
> > The bug is clear.
> 
> Oops. I'm bit new to Perl.
> 
> This should fix it.
> 
>  gitweb/gitweb.perl |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 25e5079..88af2e6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2412,7 +2412,6 @@ sub git_patchset_body {
>  
>  			push @diff_header, $patch_line;
>  		}
> -		#last PATCH unless $patch_line;
>  		my $last_patch_line = $patch_line;
>  
>  		# check if current patch belong to current raw line
> @@ -2522,7 +2521,10 @@ sub git_patchset_body {
>  
>  		# from-file/to-file diff header
>  		$patch_line = $last_patch_line;
> -		last PATCH unless $patch_line;
> +		if (! $patch_line) {
> +			print "</div>\n"; # class="patch"
> +			last PATCH;
> +		}
>  		next PATCH if ($patch_line =~ m/^diff /);
>  		#assert($patch_line =~ m/^---/) if DEBUG;
>  		if ($from{'href'} && $patch_line =~ m!^--- "?a/!) {
> @@ -2533,7 +2535,6 @@ sub git_patchset_body {
>  		print "<div class=\"diff from_file\">$patch_line</div>\n";
>  
>  		$patch_line = <$fd>;
> -		#last PATCH unless $patch_line;
>  		chomp $patch_line;
>  
>  		#assert($patch_line =~ m/^+++/) if DEBUG;
> -- 
> 1.4.4.3
> 
> 

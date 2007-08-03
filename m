From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Provide RSS feeds for file history
Date: Fri, 3 Aug 2007 11:10:55 +0200
Message-ID: <200708031110.55969.jnareb@gmail.com>
References: <20070803020555.GB8593@dervierte>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 11:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGtBc-0003RL-5E
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 11:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbXHCJLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 05:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbXHCJLE
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 05:11:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:23668 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbXHCJLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 05:11:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so205374nfb
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 02:11:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m1JKjzUnK9AEK16woY0ortZXDvQBHHP6RMheg1a7O4p4xog3znf/79mWrQOFDbGPU4UNswrIAW/XbSd7Sjm6OhRwWPbUSjMD9+AbQGXr/Us20o3UiDw9gSUr8hQ6WJr1KbXudX7n6FDRKMcZuLIFQAVryOJrjsoZkUR/vMzFjNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WzXZ552wsu0akMc3UddOOIYKdQF15miafq/NnnHpoknim2a0PYcBQXJy0NLq4uJIV3lhFrCi+OSeRMFguQq7nAobkcdhlt3jKYiPG0EggpsWTjtFOV8fhpkwiNTx1Z+zCsXUw1HIupG8UKlihJENz4/lsFaSgDrs90huUuhkC98=
Received: by 10.86.28.5 with SMTP id b5mr2108227fgb.1186132259534;
        Fri, 03 Aug 2007 02:10:59 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 28sm5869447fkx.2007.08.03.02.10.57
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 02:10:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070803020555.GB8593@dervierte>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54697>

Steven Walter wrote:

Nak. Explanation below. Corrected patch will follow.

> If git_feed is provided a file name, it ought to show only the history
> affecting that file.  The title was already being set correctly, but all
> commits from history were being shown anyway.

This is a bug introduced while changing gitweb (among others git_feed
subroutine) to use parse_commits, in commit b6093a5c. Earlier it worked.
So the explanation (in commit message) is not full.

By the way it affects not only RSS but also Atom feeds.

Documentation/SubmittingPatches:

  Checklist (and a short version for the impatient):

        Commits:

  [...]

        - if you want your work included in git.git, add a
          "Signed-off-by: Your Name <your@email.com>" line to the
          commit message (or just use the option "-s" when
          committing) to confirm that you agree to the Developer's
          Certificate of Origin

> ---
>  gitweb/gitweb.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 498b936..26932a4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -611,6 +611,7 @@ sub href(%) {
>  	my %mapping = @mapping;
>  
>  	$params{'project'} = $project unless exists $params{'project'};
> +	$params{'file_name'} = $file_name unless exists $params{'file_name'};
>  
>  	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
>  	if ($use_pathinfo) {

This is a big, intrusive change. It makes 'file_name' default argument,
unless overriden. While it made sense for 'project' parameter, as almost
all URLs in gitweb needed it, more than half URLs does not need 'file_name'
parameter. And some of those URLs are present in a views which do use
'file_name'.

If you wanted alternative URLs for a feed preserve 'file_name' parameter,
do it explicitely.

> @@ -5365,7 +5366,7 @@ sub git_feed {
>  
>  	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
>  	my $head = $hash || 'HEAD';
> -	my @commitlist = parse_commits($head, 150);
> +	my @commitlist = parse_commits($head, 150, 0, "--full-history", $file_name);
>  
>  	my %latest_commit;
>  	my %latest_date;

I'd rather not use "--full-history" for feeds. We use it in the 'history'
view for backward compatibility reasons; I'd rather leave it for extra
options in the feed.

-- 
Jakub Narebski
Poland

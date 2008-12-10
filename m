From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Tue, 9 Dec 2008 22:20:33 -0800 (PST)
Message-ID: <182871.96175.qm@web31804.mail.mud.yahoo.com>
References: <20081209224622.28106.89325.stgit@localhost.localdomain>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 07:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAISG-0004PY-NS
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 07:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYLJGUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 01:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbYLJGUf
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 01:20:35 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:46822 "HELO
	web31804.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751141AbYLJGUe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 01:20:34 -0500
Received: (qmail 7382 invoked by uid 60001); 10 Dec 2008 06:20:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:X-Mailer:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type;
  b=qqKryPCzoq3MwYdWV000b6GdgNKbu4MZ/DFhAJpdkeoMoe+s9jbbpz8OYLZOmLJ8mcB5OJdiCmgFTTKdDa6HX0dGxwEAlaAHh+bin4CHE01qVSL3Tecxc0f972obljqFwuMid+YhnwKjTD49//hdRFJoozZlOafTX4gPFxysEPs=  ;
Received: from [71.132.209.19] by web31804.mail.mud.yahoo.com via HTTP; Tue, 09 Dec 2008 22:20:33 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081209224622.28106.89325.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102667>


--- On Tue, 12/9/08, Jakub Narebski <jnareb@gmail.com> wrote:
> From: Jakub Narebski <jnareb@gmail.com>
> Subject: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
> To: git@vger.kernel.org
> Cc: "Luben Tuikov" <ltuikov@yahoo.com>, "Jakub Narebski" <jnareb@gmail.com>
> Date: Tuesday, December 9, 2008, 2:48 PM
> Luben Tuikov changed 'lineno' link from leading to
> commit which lead
> to current version of given block of lines, to leading to
> parent of
> this commit in 244a70e (Blame "linenr" link jumps
> to previous state at
> "orig_lineno").  This supposedly made data mining
> possible (or just
> better).

Before 244a70e, clicking on linenr links would display
the same commit id as displayed to the left, which is no
different than the block of lines displayed, thus data
mining was impossible, i.e. I had to manually (commands)
go back in history to see how this line or block of lines
developed and/or changed.

244a70e didn't make data mining perfect, just possible.

> This patch attempts to migitate issue a bit by caching
> $parent_commit
> info in %metainfo, which makes gitweb to call git-rev-parse
> only once
> per unique commit in blame output.

Have you tested this patch that it gives the same commit chain
as before it?

   Luben


> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> That is what I have noticed during browsing git_blame()
> code.

What?

> We can change it to even more effective implementation
> (like the ones
> proposed above in the commit message) later.

Where?

> 
> Indenting is cause for artifically large diff
> 
>  gitweb/gitweb.perl |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1b800f4..916396a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4657,11 +4657,17 @@ HTML
>  			              esc_html($rev));
>  			print "</td>\n";
>  		}
> -		open (my $dd, "-|", git_cmd(),
> "rev-parse", "$full_rev^")
> -			or die_error(500, "Open git-rev-parse
> failed");
> -		my $parent_commit = <$dd>;
> -		close $dd;
> -		chomp($parent_commit);
> +		my $parent_commit;
> +		if (!exists $meta->{'parent'}) {
> +			open (my $dd, "-|", git_cmd(),
> "rev-parse", "$full_rev^")
> +				or die_error(500, "Open git-rev-parse
> failed");
> +			$parent_commit = <$dd>;
> +			close $dd;
> +			chomp($parent_commit);
> +			$meta->{'parent'} = $parent_commit;
> +		} else {
> +			$parent_commit = $meta->{'parent'};
> +		}
>  		my $blamed = href(action => 'blame',
>  		                  file_name =>
> $meta->{'filename'},
>  		                  hash_base => $parent_commit);

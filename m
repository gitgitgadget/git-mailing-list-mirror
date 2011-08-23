From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Mon, 22 Aug 2011 21:27:17 -0500
Message-ID: <20110823022717.GA4623@elie.gateway.2wire.net>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jason Gross <jgross@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Aug 23 04:27:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvgiH-0000BU-Kq
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 04:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab1HWC10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 22:27:26 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48102 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab1HWC1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 22:27:25 -0400
Received: by qyk34 with SMTP id 34so2574812qyk.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 19:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6rM9UuucOuvDMC6HoxDtekF0hNYRjAe1Dfwaf6mJWIc=;
        b=w05KEGN7lWmFISZjjRnw9DCopQQndZZTfHzq3+YoJQZWiVl/jdpu1+S90u/p87iJR1
         1L4JXbU+vrqT69JAYS3Z3jmt8wukRShrGnn9SiLvZlc+Ed3/kxuFFdKiqoYu9rHzvZtg
         Nd1QrA1nKy3fJCmYQA8/kpjSboRcsgOmGQO/4=
Received: by 10.224.113.9 with SMTP id y9mr2128533qap.226.1314066444902;
        Mon, 22 Aug 2011 19:27:24 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-27.dsl.chcgil.sbcglobal.net [68.255.106.27])
        by mx.google.com with ESMTPS id gl6sm10389995qab.6.2011.08.22.19.27.22
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 19:27:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313979422-21286-1-git-send-email-jgross@mit.edu>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179913>

(+cc: Eric Wong)
Hi Jason,

Jason Gross wrote:

[This patch teaches "git svn" to invalidate caches when they
 fail to load, for example because the endianness or size of
 some type changed, which is common in the perl 5.6 -> 5.8
 upgrade.]

> http://lists.debian.org/debian-perl/2011/05/msg00023.html and
> http://lists.debian.org/debian-perl/2011/05/msg00026.html).
[...]
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1680,7 +1680,7 @@ use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
>              $_use_svnsync_props $no_reuse_existing $_minimize_url
>  	    $_use_log_author $_add_author_from $_localtime/;
>  use Carp qw/croak/;
> -use File::Path qw/mkpath/;
> +use File::Path qw/mkpath rmtree/;
>  use File::Copy qw/copy/;
>  use IPC::Open3;
>  use Memoize;  # core since 5.8.0, Jul 2002
> @@ -3198,28 +3198,41 @@ sub has_no_changes {
>  		$memoized = 1;
>  
>  		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
> -		mkpath([$cache_path]) unless -d $cache_path;
> -
> -		tie my %lookup_svn_merge_cache => 'Memoize::Storable',
[...]
> -		;
> +		my $do_memoization = sub {
> +			mkpath([$cache_path]) unless -d $cache_path;
[...]
> +			;
> +		};
> +
> +		if (not eval {
> +			$do_memoization->();
> +			1;
> +		}) {
> +			my $err = $@ || "Zombie error"; # "Zombie error" to catch clobbered $@ in buggy destructors
> +			die $err unless -d $cache_path;
> +			print STDERR "Discarding cache and trying again ($@)\n";
> +			rmtree([$cache_path]);
> +			$do_memoization->();
> +		}

Thank you thank you thank you.

Okay, time for nitpicks:

 1) Would it be possible to lift this do_memoization() to a toplevel sub?
    I suspect that could make the code a little easier to read.

 2) Is it important to discard the cache for _all_ errors, instead
    of just corruption and "is not compatible" errors?  Rebuilding the
    cache is not cheap, and I am afraid of effects like repeatedly
    discarding the cache only to rebuild it again due to a typo in
    git-svn.perl or an out-of-memory condition.

 3) The line with "Zombie error" is very long --- I guess putting the
    comment on the line before would help.

 4) The series would be clearer imho as a single patch that includes
    both the fix and tests.

Eric, what do you think?

Thanks again, :)
Jonathan

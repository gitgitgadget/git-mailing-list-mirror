From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Thu, 26 Jul 2012 22:18:24 -0700
Message-ID: <7vhast3hpb.fsf@alter.siamese.dyndns.org>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sucwg-0002oZ-4W
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 07:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab2G0FS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 01:18:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab2G0FS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 01:18:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4803167F6;
	Fri, 27 Jul 2012 01:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=HEoSu9/62HpUL9Fb/W44TLQ1NQ4=; b=btbJ9yIRPs6v1RI+oJuP
	u1PPU1aGGYaQgFzBJDeJM8JuHqQhxbyYCMovZqxKxlBz7WwjXUpmgRfedUF6NgNA
	FV+AyjzuYxdX5+2ImjEiWI5hfj3U4Y8UHUMBlXutPM0pz5NFFj1seKjkWweOggl0
	iuUyrYA0g9ppECuhGRoQPx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=E/x/rBRn27KY9yzVRg07XzktgIaKQ1YVyXfyn+GH2k1pBL
	3Ly9TA5CFEGOZ3zyhqKxkcxH4+Bp8fy3tQRctP9K6IJ2t+rcy4Hnf9B0ooexGnGw
	A+/+oCvB3AbQvF0heBsLP2+4w1gBA3BElkBH356c4mlpxnbjlYvS2d0FH8qws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 350FD67F5;
	Fri, 27 Jul 2012 01:18:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 639D267F4; Fri, 27 Jul 2012
 01:18:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DE15694-D7AA-11E1-907C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202335>

"Michael G. Schwern" <schwern@pobox.com> writes:

> From: "Michael G. Schwern" <schwern@pobox.com>
>
> Also it can compile on its own now, yay!

Hmmm.

If you swap the order of steps 3/4 and 4/4 by creating Git/SVN.pm
that only has these variable definitions (i.e. "our $X" and "use
vars $X") and make git-svn.perl use them from Git::SVN in the first
step, and then do the bulk-moving (equivalent of your 3/4) in the
second step, would it free you from having to say "it's doubtful it
will compile by itself"?

In short:

 - I didn't see anything questionable in 1/4;

 - Calling up ::opt_prefix() from module in 2/4 looked ugly to me
   but I suspect it should be easy to fix;

 - 3/4 was a straight move and I didn't see anything questionable in
   it, but I think it would be nicer if intermediate steps can be
   made to still work by making 4/4 come first or something
   similarly simple.

If the issues in 2/4 and 3/4 are easily fixable by going the route I
handwaved above, the result of doing so based on this round is ready
to be applied, I think.

Eric, Jonathan, what do you think?

> ---
>  git-svn.perl          | 4 ----
>  perl/Git/SVN.pm       | 9 +++++++--
>  t/Git-SVN/00compile.t | 3 ++-
>  3 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 4c77f69..ef10f6f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -20,10 +20,7 @@ my $cmd_dir_prefix = eval {
>  
>  my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
>  $ENV{GIT_DIR} ||= '.git';
> -$Git::SVN::default_repo_id = 'svn';
> -$Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
>  $Git::SVN::Ra::_log_window_size = 100;
> -$Git::SVN::_minimize_url = 'unset';
>  
>  if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
>  	$ENV{SVN_SSH} = $ENV{GIT_SSH};
> @@ -114,7 +111,6 @@ my ($_stdin, $_help, $_edit,
>  # This is a refactoring artifact so Git::SVN can get at this git-svn switch.
>  sub opt_prefix { return $_prefix || '' }
>  
> -$Git::SVN::_follow_parent = 1;
>  $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
>  $_q ||= 0;
>  my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index c71c041..2e0d7f0 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -3,9 +3,9 @@ use strict;
>  use warnings;
>  use Fcntl qw/:DEFAULT :seek/;
>  use constant rev_map_fmt => 'NH40';
> -use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
> +use vars qw/$_no_metadata
>              $_repack $_repack_flags $_use_svm_props $_head
> -            $_use_svnsync_props $no_reuse_existing $_minimize_url
> +            $_use_svnsync_props $no_reuse_existing
>  	    $_use_log_author $_add_author_from $_localtime/;
>  use Carp qw/croak/;
>  use File::Path qw/mkpath/;
> @@ -30,6 +30,11 @@ BEGIN {
>  	$can_use_yaml = eval { require Git::SVN::Memoize::YAML; 1};
>  }
>  
> +our $_follow_parent  = 1;
> +our $_minimize_url   = 'unset';
> +our $default_repo_id = 'svn';
> +our $default_ref_id  = $ENV{GIT_SVN_ID} || 'git-svn';
> +
>  my ($_gc_nr, $_gc_period);
>  
>  # properties that we do not log:
> diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
> index a7aa85a..97475d9 100644
> --- a/t/Git-SVN/00compile.t
> +++ b/t/Git-SVN/00compile.t
> @@ -3,6 +3,7 @@
>  use strict;
>  use warnings;
>  
> -use Test::More tests => 1;
> +use Test::More tests => 2;
>  
>  require_ok 'Git::SVN::Utils';
> +require_ok 'Git::SVN';

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Mon, 21 Sep 2015 11:25:13 -0700
Message-ID: <xmqqeghraauu.fsf@gitster.mtv.corp.google.com>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 20:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze5mI-0005eq-0M
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 20:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbbIUSZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 14:25:20 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35679 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbbIUSZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 14:25:16 -0400
Received: by pacfv12 with SMTP id fv12so125817760pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xrr2k00mrHG7NwCMuR0G89bjEfvVaBE6k9NjB+gXJGA=;
        b=E2Es6eCSctC/mjt9izFKR6Jsv3r9mDJHlNv1QwhNUKnfwtwl64Zzp8FhN/gQfwhIGe
         bG2xKcldpy4T+AZ4ZahXHl73uRPZDCaNL2fOc/lW8E541s29wDKCas116aDZtO7wp2p7
         3MaF0PuSMM19+kB3KugDpAeRrraSzhkTkuN65VsLwhbQfh6Cl26Oeci4WIPsgPesfRhY
         MiLm75tsU1HZ3heRQUSTKnDIkowtzJG6Q5tB7HpoKrN1owEuggpJcoMO9Ym1sFd71D9k
         slz/2sOcY+nABBc/576P5Bkvck5fZJQJkuW5/hp//8JlKEsqbW1jgT1YWrjSCNEkNIwN
         9iTg==
X-Received: by 10.68.242.42 with SMTP id wn10mr26549682pbc.77.1442859915564;
        Mon, 21 Sep 2015 11:25:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id zc4sm25199308pbb.24.2015.09.21.11.25.14
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 11:25:14 -0700 (PDT)
In-Reply-To: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
	(Victor Leschuk's message of "Mon, 21 Sep 2015 16:51:38 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278324>

Victor Leschuk <vleschuk@gmail.com> writes:

> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---

Before the S-o-b line is a good place to explain why this is a good
change to have.  Please use it.

>  git-svn.perl |  1 +
>  perl/Git.pm  | 41 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 36f7240..b793c26 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -139,6 +139,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		'use-log-author' => \$Git::SVN::_use_log_author,
>  		'add-author-from' => \$Git::SVN::_add_author_from,
>  		'localtime' => \$Git::SVN::_localtime,
> +		'no-cat-file-batch' => sub { $Git::no_cat_file_batch = 1; },

An option whose name begins with no- looks somewhat strange.  You
can even say --no-no-cat-file-batch from the command line, I
suspect.

Why not give an option 'cat-file-batch' that sets the variable
$Git::cat_file_batch to false, and initialize the variable to true
to keep existing users who do not pass the option happy?

>  		%remote_opts );
>  
>  my ($_trunk, @_tags, @_branches, $_stdlayout);
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 19ef081..69e5293 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -107,6 +107,7 @@ use Fcntl qw(SEEK_SET SEEK_CUR);
>  use Time::Local qw(timegm);
>  }
>  
> +our $no_cat_file_batch = 0;
>  
>  =head1 CONSTRUCTORS
>  
> @@ -1012,6 +1013,10 @@ returns the number of bytes printed.
>  =cut
>  
>  sub cat_blob {
> +	(1 == $no_cat_file_batch) ? _cat_blob_cmd(@_) : _cat_blob_batch(@_);

Discard "1 ==" here.  You are clearly using the variable as a
boolean, so writing this as

	$cat_file_batch ? _cat_blob_batch(@_) : _cat_blob_cmd(@_);

or better yet

	if ($cat_file_batch) {
        	_cat_blob_batch(@_);
	} else {
        	_cat_blob_cmd(@_);
	}

would be more natural.

> +}
> +
> +sub _cat_blob_batch {
>  	my ($self, $sha1, $fh) = @_;
>  
>  	$self->_open_cat_blob_if_needed();
> @@ -1072,7 +1077,7 @@ sub cat_blob {
>  sub _open_cat_blob_if_needed {
>  	my ($self) = @_;
>  
> -	return if defined($self->{cat_blob_pid});
> +	return if ( defined($self->{cat_blob_pid}) || 1 == $no_cat_file_batch );

Likewise.

	return if (!$cat_file_batch);
	return if defined($self->{cat_blob_pid});

> +sub _cat_blob_cmd {
> +	my ($self, $sha1, $fh) = @_;
> +...

The biggest thing that is missing from this patch is the explanation
of why this is a good thing to do.  The batch interface was invented
because people found that it was wasteful to spawn a new cat-file
process every time the contents of a blob is needed and wanted to
avoid it, and this new feature gives the user a way to tell Git to
do things in a "wasteful" way, so there must be a reason why the
user would want to use the "wasteful" way, perhaps work around some
other issue.  Without explaining that in the documentation what that
issue is, i.e. telling users who reads "git svn --help" when and why
the option might help them, nobody would use the feature to benefit
from it.

I wonder if "cat-file --batch" is leaky and bloats after running for
a while.  If that is the case, I have to wonder if "never do batch"
like this patch does is a sensible way forward.  Instead, "recycle
and renew the process after running it for N requests" (and ideally
auto-adjust that N without being told by the user) might be a better
way to do what you are trying to achieve, but as I already said, I
cannot read the motivation behind this change that is not explained,
so...

Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A54C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 03:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8998720CC7
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 03:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbgFXDQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:16:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48466 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgFXDQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 23:16:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F12631F5AE;
        Wed, 24 Jun 2020 03:16:46 +0000 (UTC)
Date:   Wed, 24 Jun 2020 03:16:46 +0000
From:   Eric Wong <e@80x24.org>
To:     Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH]v2 GitSVN: Multi line support of ignore-path,
 include-paths and skiping of empty commits
Message-ID: <20200624031646.GA24950@dcvr>
References: <9e582571-4b82-a46f-5eb2-14d80a4c865e@lpl-mind.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e582571-4b82-a46f-5eb2-14d80a4c865e@lpl-mind.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de> wrote:
> Hi Eric,
> 
> I used the ignore-paths option to ignore a lot of stuff I don’t need. The
> ignore pattern works well, but it could and up in empty commits. So just the
> message without any modifications / changes. The patch below skip a commit
> if all changes are ignored by the ignore-paths option. In order to use this
> feature I includes the option to read configuration for ignore-path,
> include-paths in several lines. So that the user is not limited by the max.
> char. per line definition.
> In Addition this patch includes the optimizations which are mansion from
> your side.

Hi Lukas, sorry for the delay.

The above is not a proper commit message.  Please see
Documentation/SubmittingPatches and git.git history
for some examples.  I or someone else here can help you
write it if you need help.

Comments inline.

> Signed-off-by: Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>

I'm skipping the whitespace damaged inline version and
reviewing the the attachment.

> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 4b28b87784..fa87687306 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1188,6 +1188,22 @@ sub find_parent_branch {
>  	return undef;
>  }
>  
> +############################################################
> +
> +=item do_fetch()
> +
> +Fetch an Commit and returns a log entry
> +
> +Input:  $path - array of strings (Paths) in a commit
> +		$rev - Revision number
> +
> +Output: $log_entry if successfull
> +		null if skipped
> +		(die) on fetch error
> +
> +=cut
> +
> +############################################################

Documentation is good, but the above takes up more than half my
terminal.  A single line is more than sufficient.
(I have poor eyesight and need very big fonts).

>  sub do_fetch {
>  	my ($self, $paths, $rev) = @_;
>  	my $ed;
> @@ -1212,6 +1228,11 @@ sub do_fetch {
>  		}
>  		$ed = Git::SVN::Fetcher->new($self);
>  	}
> +	my $skip = $ed->is_empty_commit($paths);
> +	if ($skip){
> +		print "skip commit $rev\n";

I think "skipping" is a better word to use, here (I'm not an
English expert, either).  To be unambiguous, we prefix SVN
revision numbers with "r" (just like SVN does):

		print "skipping commit r$rev\n";

> +		return;
> +	}
>  	unless ($self->ra->gs_do_update($last_rev, $rev, $self, $ed)) {
>  		die "SVN connection failed somewhere...\n";
>  	}
> diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
> index 64e900a0e9..c414aa879f 100644
> --- a/perl/Git/SVN/Fetcher.pm
> +++ b/perl/Git/SVN/Fetcher.pm
> @@ -31,15 +31,17 @@ sub new {
>  	# override options set in an [svn-remote "..."] section
>  	$repo_id = $git_svn->{repo_id};
>  	my $k = "svn-remote.$repo_id.ignore-paths";
> -	my $v = eval { command_oneline('config', '--get', $k) };
> -	$self->{ignore_regex} = $v;
> +	my @config = eval { command('config', '--get-all', $k) };
> +	chomp(@config); # Replace all \n\r on the end
> +	$self->{ignore_regex} = join('', @config);

That join() doesn't make a correct regexp with multiple values
in @config.  I think you would need the following to make
a proper regexp:

	$self->{ignore_regex} = '(?:'.join('|', @config).')';

	(totally untested, please test with multiple values)

>  	$k = "svn-remote.$repo_id.include-paths";
> -	$v = eval { command_oneline('config', '--get', $k) };
> -	$self->{include_regex} = $v;
> +	@config = eval { command_oneline('config', '--get-all', $k) };
> +	chomp(@config); # Replace all \n\r on the end
> +	$self->{include_regex} = join('', @config);

Same comment as above w.r.t multi-value @config

>  	$k = "svn-remote.$repo_id.preserve-empty-dirs";
> -	$v = eval { command_oneline('config', '--get', '--bool', $k) };
> +	my $v = eval { command_oneline('config', '--get', '--bool', $k) };
>  	if ($v && $v eq 'true') {
>  		$_preserve_empty_dirs = 1;
>  		$k = "svn-remote.$repo_id.placeholder-filename";
> @@ -137,6 +139,37 @@ sub is_path_ignored {
>  	return 0;
>  }
>  
> +############################################################
> +
> +=item is_empty_commit()
> +
> +Return 1 if all given $paths are ignored, so that this commit end up in an empty commit
> +
> +Input:  $path - array of strings (Paths) in a commit
> +
> +Output: { 1 if true, 0 if false }
> +
> +=cut
> +
> +############################################################

Same comment w.r.t. excessive screen space for comments.

> +sub is_empty_commit{
> +	my ($self, $paths) = @_;
> +	my $path = "";

Don't need to initialize $path, here...

> +	unless (defined($self->{include_regex})){
> +		return 0;
> +	}
> +
> +	foreach $path (keys %$paths){

Instead, localize variables within the loop:

    foreach my $path (keys %$paths) {

Also, both our Perl and C code prefer a space in-between "){",
so ") {", everywhere, and no need to have " )" when ")" will
do (same goes for the rest of the codebase).

> +		unless (defined $path && -d $path ){

It's been a while since I looked at this code; but
Git::SVN::Fetcher should NEVER be comparing paths
from SVN vs paths from the filesystem via `-d' or
similar stat() ops.

In other words, "git svn fetch" never touches the
git working tree, it should work on bare git repos.

Can the just next 4 lines work w/o the unless wrapping it?

> +			my $ignored = $self->is_path_ignored($path);
> +			if (!$ignored){
> +				return 0;
> +			}
> +		}
> +	}
> +	return 1;
> +}
> +
>  sub set_path_strip {
>  	my ($self, $path) = @_;
>  	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 56ad9870bc..63be69dc12 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -475,6 +475,8 @@ sub gs_fetch_loop_common {
>  				my $log_entry = $gs->do_fetch($paths, $r);
>  				if ($log_entry) {
>  					$gs->do_git_commit($log_entry);
> +				}else{

Again, in both C and Perl, we write "} else {"

> +					next;
>  				}
>  				$Git::SVN::INDEX_FILES{$gs->{index}} = 1;
>  			}

Thanks.

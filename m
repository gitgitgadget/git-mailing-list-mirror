Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B782C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 12:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BEC619B8
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 12:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCZMtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:49:12 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30881 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhCZMsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 08:48:47 -0400
Received: from host-92-1-139-132.as43234.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lPltM-0002OA-6O; Fri, 26 Mar 2021 12:48:45 +0000
Subject: Re: [PATCH 4/5] doc lint: fix bugs in, simplify and improve lint
 script
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <a7e1bbc1-eb3e-72d0-ef65-24cc38346a04@iee.email>
Date:   Fri, 26 Mar 2021 12:48:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,
 minor naming comment.

On 26/03/2021 10:36, Ævar Arnfjörð Bjarmason wrote:
> The lint-gitlink.perl script added in ab81411ced (ci: validate
> "linkgit:" in documentation, 2016-05-04) was more complex than it
> needed to be. It:
>
>  - Was using File::Find to recursively find *.txt files in
>    Documentation/, let's instead use the Makefile as a source of truth
>    for *.txt files, and pass it down to the script.
>
>  - We now don't lint linkgit:* in RelNotes/* or technical/*, which we
>    shouldn't have been doing in the first place anyway.
>
>  - When the doc-diff script was added in beb188e22a (add a script to
>    diff rendered documentation, 2018-08-06) we started sometimes having
>    a "git worktree" under "documentation". This tree contains a full
>    checkout of git.git, as a result the "lint" script would recurse into
>    that, and lint any *.txt file found in that entire repository.
>
>    In practice the only in-tree "linkgit" outside of the
>    Documentation/ tree is contrib/contacts/git-contacts.txt and
>    contrib/subtree/git-subtree.txt, so this wouldn't emit any errors
>
> Now we instead simply trust the Makefile to give us *.txt files, and
> since the Makefile also knows what sections each page should be in we
> don't have to open the files ourselves and try to parse that out. As a
> bonus this will also catch bugs with the section line in the file
> being incorrect.
>
> The structure of the new script is mostly based on
> t/check-non-portable-shell.pl. As an added bonus it will also use
> pos() to print where the problems it finds are, e.g. given an issue
> like:
>
>     diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
>     [...]
>      and line numbers.  git-cherry therefore detects when commits have been
>     -"copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
>     -linkgit:git-rebase[1].
>     +"copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3] or
>     +linkgit:git-rebase[4].
>
> We'll now emit:
>
>     git-cherry.txt:20: error: git-cherry-pick[2]: wrong section (should be 1), shown with 'HERE' below:
>     git-cherry.txt:20:      "copied" by means of linkgit:git-cherry-pick[2]' <-- HERE
>     git-cherry.txt:20: error: git-am[3]: wrong section (should be 1), shown with 'HERE' below:
>     git-cherry.txt:20:      "copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3]' <-- HERE
>     git-cherry.txt:21: error: git-rebase[4]: wrong section (should be 1), shown with 'HERE' below:
>     git-cherry.txt:21:      linkgit:git-rebase[4]' <-- HERE
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/Makefile          |  14 ++++-
>  Documentation/lint-gitlink.perl | 108 +++++++++++++++-----------------
>  2 files changed, 65 insertions(+), 57 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 7313956d73f..6bfd8c75772 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -4,6 +4,7 @@ MAN5_TXT =
>  MAN7_TXT =
>  HOWTO_TXT =
>  INCLUDE_TARGETS_TXT =
> +ALL_TXT =

Maybe LINT_TXT would better clarify its use, rather than squatting on
the generic "ALL"?
-- 
Philip
>  TECH_DOCS =
>  ARTICLES =
>  SP_ARTICLES =
> @@ -49,6 +50,13 @@ HOWTO_TXT += $(wildcard howto/*.txt)
>  INCLUDE_TARGETS_TXT += $(wildcard *.txt)
>  INCLUDE_TARGETS_TXT += $(wildcard config/*.txt)
>  
> +# For linting
> +ALL_TXT += $(MAN1_TXT)
> +ALL_TXT += $(MAN5_TXT)
> +ALL_TXT += $(MAN7_TXT)
> +ALL_TXT += $(HOWTO_TXT)
> +ALL_TXT += $(INCLUDE_TARGETS_TXT)
> +
>  ifdef MAN_FILTER
>  MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
>  else
> @@ -477,7 +485,11 @@ print-man1:
>  	@for i in $(MAN1_TXT); do echo $$i; done
>  
>  lint-docs::
> -	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
> +	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
> +		--section=1 $(MAN1_TXT) \
> +		--section=5 $(MAN5_TXT) \
> +		--section=7 $(MAN7_TXT)	\
> +		--to-lint $(ALL_TXT)
>  
>  ifeq ($(wildcard po/Makefile),po/Makefile)
>  doc-l10n install-l10n::
> diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
> index 35230875c24..d42f154e024 100755
> --- a/Documentation/lint-gitlink.perl
> +++ b/Documentation/lint-gitlink.perl
> @@ -2,72 +2,68 @@
>  
>  use strict;
>  use warnings;
> -use File::Find;
> -use Getopt::Long;
>  
> -my $basedir = ".";
> -GetOptions("basedir=s" => \$basedir)
> -	or die("Cannot parse command line arguments\n");
> +# Parse arguments, a simple state machine for input like:
> +#
> +# --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
> +my %TXT;
> +my %SECTION;
> +my $section;
> +my $lint_these = 0;
> +for my $arg (@ARGV) {
> +	if (my ($sec) = $arg =~ /^--section=(\d+)$/s) {
> +		$section = $sec;
> +		next;
> +	} elsif ($arg eq '--to-lint') {
> +		$lint_these = 1;
> +		next;
> +	}
>  
> -my $found_errors = 0;
> +	my ($name) = $arg =~ /^(.*?)\.txt$/s;
> +	if ($lint_these) {
> +		$TXT{$name} = $arg;
> +		next;
> +	}
>  
> -sub report {
> -	my ($where, $what, $error) = @_;
> -	print "$where: $error: $what\n";
> -	$found_errors = 1;
> +	$SECTION{$name} = $section;
>  }
>  
> -sub grab_section {
> -	my ($page) = @_;
> -	open my $fh, "<", "$basedir/$page.txt";
> -	my $firstline = <$fh>;
> -	chomp $firstline;
> -	close $fh;
> -	my ($section) = ($firstline =~ /.*\((\d)\)$/);
> -	return $section;
> +my $exit_code = 0;
> +sub report {
> +	my ($pos, $line, $target, $msg) = @_;
> +	substr($line, $pos) = "' <-- HERE";
> +	$line =~ s/^\s+//;
> +	print "$ARGV:$.: error: $target: $msg, shown with 'HERE' below:\n";
> +	print "$ARGV:$.:\t$line\n";
> +	$exit_code = 1;
>  }
>  
> -sub lint {
> -	my ($file) = @_;
> -	open my $fh, "<", $file
> -		or return;
> -	while (<$fh>) {
> -		my $where = "$file:$.";
> -		while (s/linkgit:((.*?)\[(\d)\])//) {
> -			my ($target, $page, $section) = ($1, $2, $3);
> +@ARGV = sort values %TXT;
> +while (<>) {
> +	my $line = $_;
> +	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
> +		my $pos = pos $line;
> +		my ($target, $page, $section) = ($1, $2, $3);
>  
> -			# De-AsciiDoc
> -			$page =~ s/{litdd}/--/g;
> +		# De-AsciiDoc
> +		$page =~ s/{litdd}/--/g;
>  
> -			if ($page !~ /^git/) {
> -				report($where, $target, "nongit link");
> -				next;
> -			}
> -			if (! -f "$basedir/$page.txt") {
> -				report($where, $target, "no such source");
> -				next;
> -			}
> -			my $real_section = grab_section($page);
> -			if ($real_section != $section) {
> -				report($where, $target,
> -					"wrong section (should be $real_section)");
> -				next;
> -			}
> +		if (!exists $TXT{$page}) {
> +			report($pos, $line, $target, "link outside of our own docs");
> +			next;
> +		}
> +		if (!exists $SECTION{$page}) {
> +			report($pos, $line, $target, "link outside of our sectioned docs");
> +			next;
> +		}
> +		my $real_section = $SECTION{$page};
> +		if ($section != $SECTION{$page}) {
> +			report($pos, $line, $target, "wrong section (should be $real_section)");
> +			next;
>  		}
>  	}
> -	close $fh;
> -}
> -
> -sub lint_it {
> -	lint($File::Find::name) if -f && /\.txt$/;
> -}
> -
> -if (!@ARGV) {
> -	find({ wanted => \&lint_it, no_chdir => 1 }, $basedir);
> -} else {
> -	for (@ARGV) {
> -		lint($_);
> -	}
> +	# this resets our $. for each file
> +	close ARGV if eof;
>  }
>  
> -exit $found_errors;
> +exit $exit_code;


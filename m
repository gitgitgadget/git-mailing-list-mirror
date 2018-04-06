Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07681F42D
	for <e@80x24.org>; Fri,  6 Apr 2018 20:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeDFUtI (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 16:49:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60366 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeDFUtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 16:49:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2F7CD1F404;
        Fri,  6 Apr 2018 20:49:07 +0000 (UTC)
Date:   Fri, 6 Apr 2018 20:49:07 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joseph Mingrone <jrm@ftfl.ca>, garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Caradoc-Davies <ben@transient.nz>, 894997@bugs.debian.org
Subject: Re: [PATCH] git-svn: avoid warning on undef readline()
Message-ID: <20180406204906.GA27677@whir>
References: <86h8oobl36.fsf@phe.ftfl.ca>
 <20180406131514.740-1-avarab@gmail.com>
 <20180406165618.GA6367@80x24.org>
 <87y3i0yz1t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3i0yz1t.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Fri, Apr 06 2018, Eric Wong wrote:
> > Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >
> >> --- a/perl/Git.pm
> >> +++ b/perl/Git.pm
> >> @@ -554,7 +554,7 @@ sub get_record {
> >>  	my ($fh, $rs) = @_;
> >>  	local $/ = $rs;
> >>  	my $rec = <$fh>;
> >> -	chomp $rec if defined $rs;
> >> +	chomp $rec if defined $rs and defined $rec;
> >
> > I'm struggling to understand the reason for the "defined $rs"
> > check.  I think it was a braino on my part and meant to use:
> >
> > 	chomp $rec if defined $rec;
> 
> Whether this makes any sense is another question, but you seem to have
> explicitly meant this at the time. The full function definition with
> documentation:
> 
>     =item get_record ( FILEHANDLE, INPUT_RECORD_SEPARATOR )
> 
>     Read one record from FILEHANDLE delimited by INPUT_RECORD_SEPARATOR,
>     removing any trailing INPUT_RECORD_SEPARATOR.

I've always known chomp to respect the value of $/; so chomp($rec)
whould only cut out whatever $rs is, and be a no-op if $rs is undef.

> It doesn't make to remove the trailing record separator if it's not
> defined, otherwise we'd be coercing undef to "\n" while at the same time
> returning multiple records. But then of course the only user of this
> with an "undef" argument just does:
> 
>     chomp($log_entry{log} = get_record($log_fh, undef));

Subtle difference, that chomp() still sees $/ as "\n".
$/ is only undef inside get_record.

> So we could also remove that chomp(), adn not check defined $rs, but IMO
> it's cleaner & more consistent this way.

I think the chomp is necessary. In git-svn.perl /^sub get_commit_entry {:

	# <snip>
	open my $log_fh, '>', $commit_editmsg or croak $!;

	# <snip>
		$msgbuf =~ s/\s+$//s;

	# <snip>

		print $log_fh $msgbuf or croak $!;

	# <snip>
	close $log_fh or croak $!;

# Above, we ensured the contents of $commit_editmsg has no trailing newline

	if ($_edit || ($type eq 'tree')) {
		chomp(my $editor = command_oneline(qw(var GIT_EDITOR)));
		system('sh', '-c', $editor.' "$@"', $editor, $commit_editmsg);
	}

# However, $editor is likely to introduce a trailing newline

	rename $commit_editmsg, $commit_msg or croak $!;
	{
		require Encode;
		# SVN requires messages to be UTF-8 when entering the repo
		open $log_fh, '<', $commit_msg or croak $!;
		binmode $log_fh;

# chomp trailing newline introduced by $editor:

		chomp($log_entry{log} = get_record($log_fh, undef));

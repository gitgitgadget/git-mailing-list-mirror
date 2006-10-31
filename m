X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring
 another repository.
Date: Tue, 31 Oct 2006 17:42:25 +0300
Message-ID: <20061031174225.3c7c1e77.vsu@altlinux.ru>
References: <20060925044641.GB15757@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__31_Oct_2006_17_42_25_+0300_uGq+Amb/ZBrhx+EA"
NNTP-Posting-Date: Tue, 31 Oct 2006 14:43:06 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20060925044641.GB15757@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30584>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geup1-0002S6-TA for gcvg-git@gmane.org; Tue, 31 Oct
 2006 15:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423351AbWJaOmd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 09:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423438AbWJaOmd
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 09:42:33 -0500
Received: from mivlgu.ru ([81.18.140.87]:13532 "EHLO mail.mivlgu.ru") by
 vger.kernel.org with ESMTP id S1423351AbWJaOmc (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 09:42:32 -0500
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4]) by
 mail.mivlgu.ru (Postfix) with SMTP id 847C58056; Tue, 31 Oct 2006 17:42:29
 +0300 (MSK)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

--Signature=_Tue__31_Oct_2006_17_42_25_+0300_uGq+Amb/ZBrhx+EA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 25 Sep 2006 00:46:41 -0400 Shawn Pearce wrote:

> Sometimes its handy to be able to efficiently backup or mirror one
> Git repository to another Git repository by employing the native
> Git object transfer protocol.  But when mirroring or backing up a
> repository you really want:
>
>   1) Every object in the source to go to the mirror.
>   2) Every ref in the source to go to the mirror.
>   3) Any ref removed from the source to be removed from the mirror.
>   4) Automatically repack and prune the mirror when necessary.
>
> and since git-fetch doesn't do 2, 3, and 4 here's a tool that does.

Is this patch forgotten, abandoned or what?

[...]
> --- /dev/null
> +++ b/git-mirror.perl
> @@ -0,0 +1,111 @@
> +#!/usr/bin/env perl
> +# Copyright (C) 2006, Shawn Pearce <spearce@spearce.org>
> +# This file is licensed under the GPL v2, or a later version
> +# at the discretion of Linus.
> +
> +use warnings;
> +use strict;
> +use Git;
> +
> +sub ls_refs ($$);
> +
> +my $remote = shift || 'origin';
> +my $repo = Git->repository();
> +
> +# Verify its OK to execute in this repository.
> +#
> +my $mirror_ok = $repo->config('mirror.allowed') || 0;
> +unless ($mirror_ok =~ /^(?:true|t|yes|y|1)$/i) {
> +	print STDERR <<EOF;
> +error: mirror.allowed is false.
> +error:
> +error: For safety reasons please set mirror.allowed in this repository's
> +error: config before using this command.
> +error:
> +error: Unless you are using this repository ONLY for mirroring another
> +error: repository you probably don't want to do this.
> +EOF
> +	exit 1;
> +}
> +
> +# Build our list of refs.
> +#
> +my $remote_refs = ls_refs($repo, $remote);
> +my $local_refs = ls_refs($repo, $repo->repo_path());
> +my $remote_HEAD = $remote_refs->{'HEAD'};
> +delete $remote_refs->{'HEAD'};
> +delete $local_refs->{'HEAD'};
> +
> +# Delete any local refs which the server no longer contains.
> +#
> +foreach my $ref (keys %$local_refs) {
> +	next if $remote_refs->{$ref};
> +	print "removing $ref\n";
> +	my $log = "logs/$ref";
> +	unlink($repo->repo_path() . '/' . $ref);
> +	unlink($repo->repo_path() . '/' . $log);
> +	rmdir($repo->repo_path() . '/' . $ref) while $ref =~ s,/[^/]*$,,;
> +	rmdir($repo->repo_path() . '/' . $log) while $log =~ s,/[^/]*$,,;

One more instance of direct ref manipulation...

What is the current state of packed-refs implementation?  Would it be
possible to merge at least the interface part (git-update-ref -d for
deleting refs) while keeping the current ref representation, so that
other programs could use proper interfaces now?

> +}

It would be better to remove old refs after the fetch, because if
someone has renamed a branch, and you remove the old ref before the
fetch, you will fetch all commits for this branch again, even if they
were already available under a different name.  However, this may create
problems during git-fetch due to file/directory conflicts.

Another option is to rename deleted refs to something which does not
collide with other refs - git-fetch will see them irrespective of the
name.

Yet another option is to select temporary names for all fetched refs to
be passed to git-fetch, then read their SHA-1 values after git-fetch
(they might differ from the previous result of git-ls-remote), update
normal refs and delete temporary refs.

BTW, I was thinking about the possibility to save removed refs under,
e.g., refs/old/`date -I`/; maybe even non-fast-forward refs could be
saved there - this will ensure that no object will ever disappear from
the mirror, no matter what is done on the master side.  Obviously, in
this case remote refs like refs/old/* should be filtered.

> +
> +# Execute the fetch for any refs which differ from our own.
> +# We don't worry about trying to optimize for rewinds or
> +# exact branch copies as they are rather uncommon.
> +#
> +my @to_fetch;
> +while (my ($ref, $hash) = each %$remote_refs) {
> +	push(@to_fetch, "$ref:$ref")
> +		if (!$local_refs->{$ref} || $local_refs->{$ref} ne $hash);
> +}
> +if (@to_fetch) {
> +	git_cmd_try {
> +		$repo->command_noisy('fetch',
> +			'--force',
> +			'--update-head-ok',
> +			$remote, sort @to_fetch);

This will fail for repositories with large number of refs due to the
limit on command line size.

I'm not sure how to figure out the limit for splitting this to multiple
git-fetch calls.  And using xargs fed from a pipe means that we cannot
use existing Git.pm interfaces.

> +	} '%s failed w/ code %d';
> +} else {
> +	print "No changed refs.  Skipping fetch.\n";
> +}
> +
> +# See what the remote has HEAD pointing at and update our local
> +# HEAD to point at the any ref which points at the same hash.
> +#
> +my %by_hash = map {$remote_refs->{$_} => $_}
> +	grep {m,^refs/heads/,}
> +	keys %$remote_refs;
> +my $HEAD = $by_hash{$remote_HEAD} || 'refs/heads/master';
> +print "Setting HEAD to $HEAD\n";
> +print "                ($remote_HEAD)\n";
> +git_cmd_try {
> +	$repo->command_noisy('symbolic-ref', 'HEAD', $HEAD);
> +} '%s failed w/ code %d';
> +
> +# Repack if we have a large number of loose objects.
> +#
> +if (@to_fetch) {
> +	my $count_output = $repo->command('count-objects');
> +	my ($cur_loose) = ($count_output =~ /^(\d+) objects/);
> +	my $max_loose = $repo->config('mirror.maxlooseobjects') || 100;
> +	if ($cur_loose >= $max_loose) {
> +		git_cmd_try {
> +			$repo->command_noisy('repack', '-a', '-d');
> +			$repo->command_noisy('prune');

git-prune might be unsafe when used concurrently with other
operations...  This is probably not a concern for a mirror repository,
if something ensures that two mirroring processes for the same
repository cannot be started.

> +		} '%s failed w/ code %d';
> +	}
> +}
> +
> +sub ls_refs ($$) {
> +	my $repo = shift;
> +	my $name = shift;
> +	my ($fh, $c) = $repo->command_output_pipe('ls-remote', $name);
> +	my %refs;
> +	while (<$fh>) {
> +		chomp;
> +		next if /\^{}$/;
> +		my ($hash, $ref) = split(/\t/, $_, 2);
> +		$refs{$ref} = $hash if ($ref eq 'HEAD' || $ref =~ m,^refs/,);

Probably more sanity checks would be good here (to make sure that the
other end does not feed you bogus ref names or hashes).

> +	}
> +	$repo->command_close_pipe($fh, $c);
> +	\%refs;
> +}
> --
> 1.4.2.1.gde2b2-dirty
>

--Signature=_Tue__31_Oct_2006_17_42_25_+0300_uGq+Amb/ZBrhx+EA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFR2DVW82GfkQfsqIRAjUNAJ4gI8HLsqenlM1NaLV2aNBoBGACZwCfVMmA
ZKgUyYvu495X7wpgRmj6LHs=
=eEx8
-----END PGP SIGNATURE-----


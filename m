From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Mon, 25 Sep 2006 21:45:15 -0700
Message-ID: <7vpsdjtew4.fsf@assigned-by-dhcp.cox.net>
References: <20060925044641.GB15757@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 06:45:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4ov-0002xT-GP
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWIZEpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIZEpT
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:45:19 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14722 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750750AbWIZEpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:45:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926044516.INGV16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:45:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SslD1V00g1kojtg0000000
	Tue, 26 Sep 2006 00:45:14 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060925044641.GB15757@spearce.org> (Shawn Pearce's message of
	"Mon, 25 Sep 2006 00:46:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27770>

Shawn Pearce <spearce@spearce.org> writes:

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

Just a note.  I usually use git-push the other way for backups,
and I believe that is how Linus does it, too.

> diff --git a/git-mirror.perl b/git-mirror.perl
> new file mode 100755
> index 0000000..bff2003
> --- /dev/null
> +++ b/git-mirror.perl
> @@ -0,0 +1,111 @@
> +#!/usr/bin/env perl

Please don't.  "#!/usr/bin/env perl" is a disease.

> +# This file is licensed under the GPL v2, or a later version
> +# at the discretion of Linus.

Heh ;-).

> +use warnings;
> +use strict;
> +use Git;
> +
> +sub ls_refs ($$);

I wonder why people like line-noise prototypes.  Do you ever
call ls_refs with parameters that benefit from this?  Otherwise
I prefer not to see them.

> +my $remote = shift || 'origin';
> +my $repo = Git->repository();
> +
> +# Verify its OK to execute in this repository.
> +#
> +my $mirror_ok = $repo->config('mirror.allowed') || 0;
> +unless ($mirror_ok =~ /^(?:true|t|yes|y|1)$/i) {

This _is_ ugly.  Doesn't $repo->config() know how to drive
underlying "git-repo-config" with specific type argument?

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
> +}

If you do this upfront and then you lose connection while the
real fetch, next fetch may need to take a lot longer than needed
because it cannot rely on the refs you are losing here.  Ref
removal is rather a rare event, so we may not care too much
about it, though.

> +# Execute the fetch for any refs which differ from our own.
> +# We don't worry about trying to optimize for rewinds or
> +# exact branch copies as they are rather uncommon.

If we need to support only git-native protocols, all of this
optimization is not needed at all.  It's kind of sad that we
need to support commit walkers...

> +if (@to_fetch) {
> +	git_cmd_try {
> +		$repo->command_noisy('fetch',
> +			'--force',
> +			'--update-head-ok',
> +			$remote, sort @to_fetch);
> +	} '%s failed w/ code %d';

Why sort (no objection, just curious)?

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
> +		} '%s failed w/ code %d';
> +	}
> +}

If we truly have a large number of objects (in pack and loose),
you do not want to do "repack -a -d", do you?

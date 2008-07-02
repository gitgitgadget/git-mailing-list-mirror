From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Tue, 01 Jul 2008 22:39:58 -0700
Message-ID: <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
References: <20080701101114.GA6379@sigill.intra.peff.net>
 <1214912674-9443-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 02 07:41:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDv6E-0002mG-2W
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 07:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbYGBFkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 01:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYGBFkL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 01:40:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbYGBFkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 01:40:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8254E27DE8;
	Wed,  2 Jul 2008 01:40:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4EC5727DE6; Wed,  2 Jul 2008 01:40:02 -0400 (EDT)
In-Reply-To: <1214912674-9443-1-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Tue, 1 Jul 2008 13:44:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 54BEC020-47F9-11DD-A6DA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87086>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 903953e..6bb117a 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -2,6 +2,7 @@
>  
>  use strict;
>  use Git;
> +use File::Temp;

People with minimum Perl installation should still be able to use "add -i"
as long as they do not use 'e' subcommand, shouldn't they?  Shouldn't we
do something like:

	my $can_use_temp = eval {
        	require File::Temp;
                1;
	};

and disable 'e' subcommand unless $can_use_temp?

> +sub edit_hunk_manually {
> +	my ($oldtext) = @_;
> +
> +	my $t = File::Temp->new(
> +		TEMPLATE => $repo->repo_path . "/git-hunk-edit.XXXXXX",
> +		SUFFIX => '.diff'
> +	);
> +	print $t "# Manual hunk edit mode -- see bottom for a quick guide\n";
> +	print $t @$oldtext;
> +	print $t <<EOF;
> +# ---
> +# To remove '-' lines, make them ' ' lines (context).
> +# To remove '+' lines, delete them.
> +# Lines starting with # will be removed.

Don't you want to say "Do not touch lines that begin with ' '"?

> +	# Reinsert the first hunk header if the user accidentally deleted it
> +	if ($newtext[0] !~ /^@/) {
> +		unshift @newtext, $oldtext->[0];
> +	}

Hmm, perhaps not even giving the "@@ ... @@" lines to the editor would be
a more robust solution?

> +sub diff_applies {
> +	my $fh;
> +	open $fh, '| git apply --recount --cached --check';
> +	for my $h (@_) {
> +		print $fh @{$h->{TEXT}};
> +	}
> +	return close $fh;

Have to wonder where the potential error message would go, and if it would
confuse the end users...

> @@ -1002,7 +1123,8 @@ sub patch_update_file {
>  	if (@result) {
>  		my $fh;
>  
> -		open $fh, '| git apply --cached';
> +		open $fh, '| git apply --cached'
> +			. ($need_recount ? ' --recount' : '');
>  		for (@{$head->{TEXT}}, @result) {
>  			print $fh $_;
>  		}

I recall that the original "add--interactive" carefully counted numbers in
hunks it reassembles (as it can let you split and then you can choose to
use both parts, which requires it to merge overlapping hunks back), but if
you are going to use --recount anyway, perhaps we can discard that logic?
It may make the patch application less robust, though.  I dunno.

An alternative, and probably more robust, approach would be to recount
what we have in @{$mode->{TEXT}}, after letting the user edit some of
them, so that "add--interactive" still knows what it is doing after
applying your patch without having to rely on "apply --recount".

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: add 'rm' subcommand
Date: Mon, 03 Sep 2007 03:07:51 -0700
Message-ID: <7vy7fojc3s.fsf@gitster.siamese.dyndns.org>
References: <11810859232541-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 12:08:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS8qm-0006Um-4a
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 12:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbXICKH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 06:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbXICKH5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 06:07:57 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbXICKH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 06:07:56 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D306412D8E7;
	Mon,  3 Sep 2007 06:08:14 -0400 (EDT)
In-Reply-To: <11810859232541-git-send-email-jbowes@dangerouslyinc.com> (James
	Bowes's message of "Tue, 5 Jun 2007 19:25:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57462>

James Bowes <jbowes@dangerouslyinc.com> writes:

> Introduce git-remote rm <name> which will:
>  - Remove the remote config entry for <name>.
>  - Remove any config entries for tracking branches of <name>.
>  - Remove any stored remote branches of <name>.
>
> Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>

Let's continue with this in 1.5.4 cycle.  Together with Dscho's
"--mirror" patch, this will make "remote" more complete.

> If there is any interest in this, I'll follow up later with additions
> to the docs.

This is not a good thing to say here.  If even the original
author cannot be bothered to perfect it unconditionally (iow
even when other people do not realize how useful it would be
initially and nobody seem to be interested), it does not help
convincing others that it is a good thing for the community to
take the patch.

> +sub rm_remote {
> +    my ($name) = @_;
> +	if (!exists $remote->{$name}) {
> +		print STDERR "No such remote $name\n";
> +		return;
> +	}
> +
> +	$git->command('config', '--remove-section', "remote.$name");
> +
> +	eval {
> +	    my @trackers = $git->command('config', '--get-regexp',
> +			'branch.*.remote', $name);

Is this correct, or should it be '^branch\..*\.remote$'

> +		for (@trackers) {
> +			/^branch\.(.*)?\.remote/;

And this one.  Why do we have '?' there?  Perhaps...

	if (/^branch\.(.*\)\.remote /) {
		$git->config('--unset', "branch.$1.remote");
		$git->config('--unset', "branch.$1.merge");
	} else {
        	die "Gaah, why $_ is not branch.<<name>>.remote???"
	}

We seem to have another subroutine to prune remote tracking
branches, which does it slightly differently.  Maybe we would
want to share code with that codepath?

Other than that, I think the patch is sane, with your later
"documentation patch".

We would want a handful tests, including ones to check error
conditions, such as trying to remove a remote that does not
exist.

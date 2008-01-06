From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sun, 06 Jan 2008 04:32:15 -0800
Message-ID: <7vy7b33zjk.fsf@gitster.siamese.dyndns.org>
References: <7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<20080106042409.GA4843@coredump.intra.peff.net>
	<20080106042935.GB4843@coredump.intra.peff.net>
	<7vejcv5is3.fsf@gitster.siamese.dyndns.org>
	<20080106111725.GA11603@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 13:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBUgP-0004Nj-Bm
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 13:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYAFMcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 07:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbYAFMcY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 07:32:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYAFMcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 07:32:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 341EF901F;
	Sun,  6 Jan 2008 07:32:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB23901E;
	Sun,  6 Jan 2008 07:32:18 -0500 (EST)
In-Reply-To: <20080106111725.GA11603@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 6 Jan 2008 06:17:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69731>

Jeff King <peff@peff.net> writes:

> Something like this (instead of my last patch):

Yeah, I like that much better, especially the renaming of
$use_color to more descriptive (but is it really about "menu", I
wonder?).

I might consider rewriting this part

> +my $menu_use_color = $repo->get_colorbool('color.interactive');
> +my ($prompt_color, $header_color, $help_color) =
> +	$menu_use_color ? (
> +		$repo->get_color('color.interactive.prompt', 'bold blue'),
> +		$repo->get_color('color.interactive.header', 'bold'),
> +		$repo->get_color('color.interactive.help', 'red bold'),
> +	) : ();

like this:

	my ($prompt_color, $header_color, $help_color, $fraginfo_color);
        if ($colored_prompt) {
        	$prompt_color = ...;
                $header_color = ...;
        }
	if ($colored_diff) {
        	$fraginfo_color = ...;
	}

or even like this:

	my (%palette);
        if ($colored_prompt) {
		my %default = (
                	prompt => 'bold blue',
                        header => 'bold',
                        ...
		);
                while (my ($k,$v) = each %default) {
                    $palette{$k} = $repo->get_color("color.interactive.$k",$v);
		}
	}

But I realize that's going overboard.  Certainly the last one is
doing unnecessary generalization for generalization's sake.

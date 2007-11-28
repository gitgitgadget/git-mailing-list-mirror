From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] cvsimport: use show-ref to support packed refs
Date: Wed, 28 Nov 2007 14:23:13 -0800
Message-ID: <7v4pf63t7y.fsf@gitster.siamese.dyndns.org>
References: <20071128185504.GA11236@coredump.intra.peff.net>
	<20071128185611.GB11320@coredump.intra.peff.net>
	<Pine.LNX.4.64.0711281916140.27959@racer.site>
	<20071128194423.GB11396@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVJj-0005qa-Rh
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757808AbXK1WXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757673AbXK1WXU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:23:20 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34163 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620AbXK1WXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:23:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 846392F2;
	Wed, 28 Nov 2007 17:23:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EA57C99DFE;
	Wed, 28 Nov 2007 17:23:36 -0500 (EST)
In-Reply-To: <20071128194423.GB11396@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Nov 2007 14:44:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66442>

Jeff King <peff@peff.net> writes:

> Since get_headref is useful in contexts where "$remote" is not always
> prepended (see patch 3/3), I think the best solution is:

...

> +	if ($branch eq $opt_o && !$index{branch} &&
> +		!get_headref("$remote/$branch")) {
> +	my $parent = get_headref("$remote/$last_branch");
> +		if (my $sha1 = get_headref("$remote/$mparent")) {

So the definition of get_headref() is to always take everything under
but not including "refs/"?  IOW, the tip of the master branch is asked
with get_headref("heads/master")?

I think show-ref can easily be confused by its tail matching behaviour,
and is a bad command to use in a context like this.  To be safe, I think
get_headref() should be:

	sub get_headref {
        	my ($it) = (@_);
                my $r = `git-rev-parse --verify "refs/$it"`;
		return undef unless $? == 0;
		chomp $r;
		return $r;
	}

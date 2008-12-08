From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff: allow turning on textconv explicitly for
 plumbing
Date: Sun, 07 Dec 2008 22:52:39 -0800
Message-ID: <7vskoz88g8.fsf@gitster.siamese.dyndns.org>
References: <20081208025700.GB22072@coredump.intra.peff.net>
 <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org>
 <20081208045924.GA22780@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 07:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9a0J-0002Y8-AM
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 07:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbYLHGwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 01:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbYLHGwq
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 01:52:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbYLHGwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 01:52:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 60CE785B69;
	Mon,  8 Dec 2008 01:52:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 73DF985B67; Mon,
  8 Dec 2008 01:52:41 -0500 (EST)
In-Reply-To: <20081208045924.GA22780@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 7 Dec 2008 23:59:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0B918A6-C4F4-11DD-9F87-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102531>

Jeff King <peff@peff.net> writes:

>> You can certainly argue that this "textconv" feature that is grafted from
>> Porcelain into plumbing is a special case in that its output is subject to
>> change any time to help human consumption and we never strive for its
>> stability as we do for other features in the plumbing to support machine
>> readability by scripts.  You can propagate the later enhancement of
>> textconv diff output we'd make for Porcelain to the scripted users that
>> reads from the plumbing that way.
>
> Right. _If_ it's a change that won't upset any plumbing consumers. If it
> is, then it needs to be a separate option so that the plumbing consumers
> who don't mind the change can start using it.

In the above argument, you are assuming that you can have a complete
enumeration of "plumbing consumers", so that we can tell what kind of
changes to textconv output do affect them in a negative way, and what kind
of changes are safe.

Yes, you can enumerate in-tree consumers, but that misses the whole point
of having "plumbing", which can be used by any scripts out of tree and
they can rely on stable output from the plumbing.  By giving --textconv to
them to use with the plumbing, you are effecively casting textconv output
in stone.  By definition we will never know what kind of changes to the
output from the textconv filter out of tree consumers would mind.

Currently "diff" machinery uses the output of textconv filter as-is
without any further embellishment, but I think it is too early to tell if
that is really what we would want, or we may need some minimum
postprocessing on what we receive from the textconv filter before feeding
that to the textual diff machinery, because the feature has not been used
in the field at all yet.

In any case, I've applied the series for an entirely different reason.
The patch is the most natural way to allow users of Porcelain to disable
textconv with the --no-textconv option, just like --no-ext-diff can be
used to disable the external diff.

We _might_ want to add another patch to make the plumbing layer ignore (or
error out) --textconv option given from the command line before 1.6.1
ships, and after we gain confidence with the stability of the feature,
revert that patch to allow use of --textconv freely from the plumbing.

It always is easier to introduce a new feature in a more limited form and
then later loosen it, than adding it in an unrestricted form and having
later to limit it for whatever reason.

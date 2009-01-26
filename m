From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 18:30:18 -0800
Message-ID: <7v1vuqdcjp.fsf@gitster.siamese.dyndns.org>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jan 26 03:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRHGT-0008GL-Pq
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 03:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbZAZCa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 21:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbZAZCa2
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 21:30:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZAZCa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 21:30:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F341C93BFD;
	Sun, 25 Jan 2009 21:30:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5DC2493BFC; Sun,
 25 Jan 2009 21:30:20 -0500 (EST)
In-Reply-To: <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 25 Jan 2009 12:34:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4A259638-EB51-11DD-8F8D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107160>

Junio C Hamano <gitster@pobox.com> writes:

> Scriptability by definition means you do not know how scripts written by
> people around plumbing use the output; I do not think you can sensibly say
> "this should not be turned on in a machine friendly output, but this is
> safe to use".
>
> I would not be opposed to an enhancement to the plumbing that the scripts
> can use to say "I am willing to take any option (or perhaps "these
> options") given to me via diff.primer".  Some scripts may want to be just
> a pass-thru of whatever the underlying git-diff-* command outputs, and it
> may be a handy way to magically upgrade them to allow their invocation of
> lowlevel plumbing to be affected by what the end-user configured.  But
> that magic upgrade has to be an opt/in process.

I suspect it is pretty much orthogonal to the "use user's default without
being told from the command line", but it might be a worthy goal to
introduce a mechanism for the scripts to accept "safe" default options
from the end user while rejecting undesirable ones that would interfere
with the way it uses plumbing.

For example, gitk drives "git rev-list" and many options you give from the
command line (e.g. "gitk --all --simplify-merges -- drivers/") are passed
to the underlying plumbing.

This is a double edged sword.  When we add new features to git-rev-list,
(e.g. --simplify-merges or --simplify-by-decoration are fairly recent
inventions that did not exist when gitk was written originally), some of
them can be safely passed and automagically translates to a new feature in
gitk.  However, use of some options (e.g. --reverse) breaks the assumption
the tool makes on the output from the underlying plumbing and should not
be accepted from the end-user.

It would be a good addition to our toolset if scripts like gitk can
declare which options and features are safe to accept from the end user to
pass down to the plumbing tools.  "git rev-parse", which lets the script
sift between options that are meant to affect ancestry traversal and the
ones that are for other (primarily diff family) commands, does not do
anything fancy like that, but it would be a logical place to do this sort
of thing.

And it is not limited to "scripts" use.  A recent topic on rejecting
colouring options from being given to format-patch would also be helped
with such a mechanism if it is available to builtins.

Just an idle thought.

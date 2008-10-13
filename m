From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Sun, 12 Oct 2008 21:00:50 -0700
Message-ID: <7vk5cddtzh.fsf@gitster.siamese.dyndns.org>
References: <20081005214114.GA21875@coredump.intra.peff.net>
 <20081005214336.GC21925@coredump.intra.peff.net>
 <48EB7D74.40302@viscovery.net>
 <20081007153543.GA26531@coredump.intra.peff.net>
 <7vabdaidwj.fsf@gitster.siamese.dyndns.org>
 <20081013012311.GE3768@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 06:02:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpEdV-0007o3-4q
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 06:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbYJMEBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 00:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbYJMEBK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 00:01:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYJMEBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 00:01:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC3266ED2B;
	Mon, 13 Oct 2008 00:01:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 671E96ED26; Mon, 13 Oct 2008 00:00:58 -0400 (EDT)
In-Reply-To: <20081013012311.GE3768@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 12 Oct 2008 21:23:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9066BB40-98DB-11DD-94A0-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98077>

Jeff King <peff@peff.net> writes:

>> The logic behind the original behaviour was that the file ought to be
>> "diff-able" if you are setting up funcname pattern because the funcname
>> pattern only makes sense if you are doing the textual diff.  In other
>> words, "should we do textual diff?" and "what funcname pattern should we
>> use?" are _not_ orthogonal, as wanting to configure the latter does imply
>> that you do want to see the change in the textual diff format.
>
> Yeah, I don't think I can really disagree with that. I had some vague
> notion that it opens the path for adding orthogonal options later. But
> really, I'm not sure that any exist, since they are, by definition
> related to the diff. Unless we want to have diff driver options for how
> to do a binary diff.

I actually have an independent worry about this whole thing.

The textconv filter is primarily for humans to be able to view the diff,
as far as I understand it, but what would this facility do to the patch
exchange workflow?  There needs either one or both of the following:

 - A command line option to Porcelains to override textconv so that an
   applicable binary diff can be obtained upon request (or format-patch
   always disables textconv); and/or

 - You teach git-apply to use a reverse transformation of textconv, so
   that it does, upon reception of a textconv diff:

   (1) pass existing preimage through textconv;
   (2) apply the patch;
   (3) convert the result back to binary.

Even if we do not implement the latter right now in the first round, if we
want to leave the door open for later for it, we would somehow need to
mark such a patch between textconv output so that what kind of reverse
transformation needs to be applied.

I'd say that format-patch should always disable textconv so that we won't
have to worry about it for now.  If we enable textconv for format-patch,
we do need to include what textconv filter (or "diff attribute") was used
for the path in the output, so that the receiving end can pick a
corresponding reverse transformation.

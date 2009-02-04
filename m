From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Tue, 03 Feb 2009 21:43:51 -0800
Message-ID: <7v7i4692p4.fsf@gitster.siamese.dyndns.org>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu>
 <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
 <20090203071516.GC21367@sigill.intra.peff.net>
 <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Wed Feb 04 06:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUaZk-0000gw-Cl
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 06:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbZBDFoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 00:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbZBDFoA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 00:44:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZBDFn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 00:43:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5333896158;
	Wed,  4 Feb 2009 00:43:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C295496152; Wed,
  4 Feb 2009 00:43:53 -0500 (EST)
In-Reply-To: <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu> (Keith
 Cascio's message of "Tue, 3 Feb 2009 09:55:08 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D15AC7FC-F27E-11DD-861C-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108297>

Keith Cascio <keith@CS.UCLA.EDU> writes:

> I think introducing explicit dirty masks and explicit layer flattening is the 
> right way to go forward,...

I am not so sure about this claim.  I kind of like idea of "we know the
desirable value of this bit, do not touch it any further" mask, but I
think it is independent of flattening.  In fact, I do not think flattening
is a good thing.

Any codepath could call DIFF_OPT_SET()/CLR(), whether it is in response to
end user's input from the command line (e.g. "the user said --foo, so I am
flipping the foo bit on/off), or to enforce restriction to achieve sane
semantics (e.g. "it does not make any sense to run this internal diff
without --binary set, so I am using OPT_SET()").  Is it still true, or do
some bit flipping now need to be protected by "is it locked" check and
some others don't?

The latter one (i.e. in the above example, "this internal diff must run
with --binary") we may want to use "opts->mask" to lock down (I wouldn't
call it "dirty", it is more like "locked") the "binary" bit, and we may
even want to issue a warning or an error when the end user attempts to
countermand with --no-binary.  Similarly, I think you would want to lock
down what you got from the true command line so that you can leave them
untouched when you process the value you read from diff.primer.

Doesn't it suggest that you may want two layers of masks, not a flat one,
if you really want the mechanism to scale?

In any case, I think the mechanism based on the lock-down mask is worth
considering when we enhance the option parsing mechanism for the diff and
log family, and if it is done right, I think the code to parse revision
options would benefit quite a bit.  There are codepaths that initialize
the bits to the command's liking (e.g. show wants to always have diff),
let setup_revisions() to process command line flags, and then further
tweak the remaining bits (e.g. whatchanged wants to default to raw), all
interacting in quite subtle ways.

But that should probably be for later cycle, post 1.6.2.

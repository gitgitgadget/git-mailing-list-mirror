From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Fri, 06 Feb 2009 09:47:17 -0800
Message-ID: <7vocxf5ufu.fsf@gitster.siamese.dyndns.org>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
 <57518fd10902060641pa789ffbjceccbf013864e0a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 18:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVUp1-0004s2-Mp
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 18:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760377AbZBFRrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 12:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbZBFRrY
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 12:47:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbZBFRrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 12:47:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D73197948;
	Fri,  6 Feb 2009 12:47:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8FC0397943; Fri,
  6 Feb 2009 12:47:19 -0500 (EST)
In-Reply-To: <57518fd10902060641pa789ffbjceccbf013864e0a5@mail.gmail.com>
 (Jonathan del Strother's message of "Fri, 6 Feb 2009 14:41:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 351F33A6-F476-11DD-8ECB-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108764>

Jonathan del Strother <maillist@steelskies.com> writes:

> On Fri, Feb 6, 2009 at 2:32 PM, Jonathan del Strother
> <jon.delStrother@bestbefore.tv> wrote:
>> Add a "Show changes" option to each prompt in mergetool. This prints the conflicted changes on the current file, using 'git log -p --merge <file>'
>
> Just discovered that this doesn't work so well when resolving merges
> resulting from "git stash apply" - it produces "fatal: --merge without
> MERGE_HEAD".  Should git-stash be setting MERGE_HEAD in this case,

No no no, please absolutely don't.  MERGE_HEAD is an instruction to the
eventual commit to create a merge commit and use the commits recorded
there as other parents when it does so.  You do *NOT* want to end up with
a merge with random state after unstashing.  None among cherry-pick,
rebase, checkout -m (branch switching), nor am -3 should.

I'd suggest making the new action conditionally available, by using the
presense of MERGE_HEAD as a cue.

The thing is, these commands that can potentially end in conflict operate
only at the tree level, and not at the level of commit ancestry graph.
"log --merge" is all about following the commit ancestry graph, and for
conflicts left by these commands it is not a useful way to review.

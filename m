From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Mon, 28 Apr 2008 17:25:05 -0700
Message-ID: <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
 <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:26:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqdfb-0002qo-6z
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 02:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbYD2AZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 20:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755313AbYD2AZU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 20:25:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbYD2AZT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 20:25:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC2DE5A09;
	Mon, 28 Apr 2008 20:25:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 031E15A07; Mon, 28 Apr 2008 20:25:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80636>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 22 Apr 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > So I really hate the idea of introducing yet other marks when we already 
>> > have unique identifiers: the (abbreviated) commit names.
>> 
>> Didn't I give you an example why commit object names are _not_ unique
>> identifiers already?
>
> By that reasoning, rebase -i cannot work anyway: it relies on the 
> abbreviated identifiers, not on anything else, for the "pick" command.

No, read the message again and think for 5 minutes.

Picking the same commit twice does not make any sense, neither does
picking the resulting commit from an earlier operation in the same
sequencer run.  Which means that the commit object name for 'pick' can
mean _only_ the pre-rewritten commit object, not 'the result of an earlier
operation that used that commit'.  And you always pick on top of the
current (detached) HEAD.

Reset is different.  You can reset either to the named commit to start
building from a known state that existed before the sequencer run started,
or reset to the result of pick (or merge) of the named commit, and your
proposal breaks down here, because you cannot tell between the two.

To rebuild this history on top of a commit O' elsewhere:

        O---A---B
             \   \
              D---E---F---G
                         / 
                        X

you would need to:

	pick A
        pick B
        reset <<to the state after "pick A">>
        pick D
        merge <<the state after "pick B">>
        pick F
        merge X (taken from somebody else)

and the syntax proposed to express <<the above part>> can either be your
"the result of the last operation that used the named commit", which is
simple in some cases, or "named commit, be it with mark or standard sha-1
expression".

Introducing a 'mark' insn to mark the previous result you may want to go
back to is one way to solve this without ambiguity.  Then abbreviated
object name won't have to be mapped as in your proposal.

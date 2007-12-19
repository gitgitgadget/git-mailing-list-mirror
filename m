From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Wed, 19 Dec 2007 12:45:16 -0800
Message-ID: <7v8x3qv2g3.fsf@gitster.siamese.dyndns.org>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	<20071218204623.GC2875@steel.home>
	<200712182224.28152.jnareb@gmail.com>
	<alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org>
	<7vejdjy79y.fsf@gitster.siamese.dyndns.org>
	<56b7f5510712181430w798d4a65x20a24f061c5d0eb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 21:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J55nt-0003KR-M5
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 21:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbXLSUpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbXLSUpp
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 15:45:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbXLSUpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 15:45:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D1C47683A;
	Wed, 19 Dec 2007 15:45:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D57676837;
	Wed, 19 Dec 2007 15:45:23 -0500 (EST)
In-Reply-To: <56b7f5510712181430w798d4a65x20a24f061c5d0eb6@mail.gmail.com>
	(Dana How's message of "Tue, 18 Dec 2007 14:30:40 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68936>

"Dana How" <danahow@gmail.com> writes:

> How about this:
> <tree-ish>:./path -> NEW: relative

I think making "<tree>:./" mean "replace ./ with the current prefix and
retry the usual expansion" is relatively confusion free.  You have to
work hard to confuse yourself:

	d=$(git rev-parse --verify HEAD:Documentation)
        git rev-parse "$d":./howto ;# would not work
	cd Documentation && git rev-parse "$d":./howto ;# would work

> <tree-ish>:../path -> NEW: relative

I would rather avoid up (../) processing if we can, but making "<tree>:"
immediately followed by 1 or more "../" mean "take the current prefix,
strip away the same number of trailing directory components as we have
"../" there, and tuck the remainder in front of the path before trying
the usual expansion" would be a natural and relatively confusion free
extension of the above.  I think I can live with that, too.

> <tree-ish>:?pattern -> NEW: same as next (current :/ )

I'd prefer keeping :? (or some other unlikely-in-path letter other than
'?') as a special extension introducer character, i.e. leaving the door
open to:

	<tree>:?(magic)parameter

whose semantics is to be defined later, depending on "magic".

Similarly, we could do the same for

	:?(magic)parameter

> <tree-ish>:/pattern -> unchanged (sha1_name_oneline IIRC)

I do not think this is oneline.  "<commit>:/pattern" could be a natural
extension to the current ":/pattern" that instructs "dig from only this
commit, not all refs, and find a commit with the oneline," but I do not
think it is a good idea.  It is too similar to "locate this tree entry
from the given tree" syntax.

> <tree-ish>:path -> unchanged: absolute

Absolutely ;-)

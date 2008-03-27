From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -i doesn't update permissions
Date: Thu, 27 Mar 2008 09:08:03 -0700
Message-ID: <7vfxucb15o.fsf@gitster.siamese.dyndns.org>
References: <20080326102332.GA26842@alea.gnuu.de>
 <20080327055746.GA8469@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:09:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jeuet-0007hY-Uz
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 17:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbYC0QIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756892AbYC0QIO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 12:08:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799AbYC0QIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 12:08:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B6595049;
	Thu, 27 Mar 2008 12:08:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EA8335047; Thu, 27 Mar 2008 12:08:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78350>

Jeff King <peff@peff.net> writes:

> Now, if you are interested in adding the mode change of a file but _not_
> its content, I think that is a reasonable thing to ask for. And it's
> something that is not possible with "add -i" right now, I don't think.

It's worse than that.  It _theoretically_ is possible that this limitation
becomes problematic if you are in this situation:

 1. Notice a problem in the gostak script that it should distim doshes but
    it doesn't.

 2. Start working to change the gostak script.

 3. Notice that the gistak script itself needs the +x bit but it doesn't.

 4. Being a very disciplined person, you want to make sequence of commits
    that record each separate logical change as a separate commit.  You
    would want to record "Add executable bit to the gostak script" first,
    and then work further on the contents of the script to make "Enhance
    the gostak script to distim doshes" as two logically separate steps.
	
This is not something you can do with "git add" in general, although I do
not see how this can be an issue in real life.

Two already available solutions are:

 (1) git reset HEAD -- gostak ;# undo staged content changes
     git update-index --chmod=+x gostak
     git commit -m "Add executable bit to the gostak script"
     edit gostak ;# work more
     git add gostak
     git commit -m "Enhance the gostak script to distim doshes"

 (2) git stash ;# undo changes
     chmod +x gostak
     git add gostak
     git commit -m "Add executable bit to the gostak script"
     git stash pop ;# take the wip changes back
     edit gostak ;# work more
     git add gostak
     git commit -m "Enhance the gostak script to distim doshes"

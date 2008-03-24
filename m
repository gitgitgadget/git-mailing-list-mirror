From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
 merges
Date: Mon, 24 Mar 2008 16:30:57 -0700
Message-ID: <7v7ifrsnri.fsf@gitster.siamese.dyndns.org>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de>
 <alpine.LSU.1.00.0803232334130.4353@racer.site>
 <20080324111413.GA18488@alea.gnuu.de>
 <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, B.Steinbrink@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:32:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdw98-0006tO-2o
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbYCXXbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYCXXbT
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:31:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYCXXbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:31:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E3502F9F;
	Mon, 24 Mar 2008 19:31:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 39FD62F9A; Mon, 24 Mar 2008 19:31:08 -0400 (EDT)
In-Reply-To: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 24 Mar 2008 11:35:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78126>

I'll extend this topic a bit for the last time, but first a word of
caution.  What I am going to draw is probably not what the current -p
implementation does.  They illustrate what I think should happen.

Again, starting from this topology:

       o---o---o---o---o---Z
      /
     X---Y---A---B
          \       \
           C---D---M---E

and the goal is to rebase your development leading to E on top of the
updated mainline Z.

The earlier example was when you want to end up with this topology:

       o---o---o---o---o---Z---Y'--A'--B'      
      /                         \       \      
     X---Y---A---B               C'--D'--M'--E'
          \       \
           C---D---M---E

In this case, "pick M" cannot be "merge B after pick D".  It needs to
merge in the rewritten B (which is B').

But if you want to end up with this topology:

       o---o---o---o---o---Z---Y'--A'--B'
      /                                 \     
     X---Y---A---B                       M'--E'
          \       \                     /
           C---D---M---E               /
                \                     /
                 `-------------------'

redoing the merge from D when reproducing M' is the right thing to do.

Unfortunately, you cannot express that you would want to rewrite only the
Y--A--B--M--E ancestry from the command line.  We would need a syntax to
do this cleanly first if we want to pursue this.

The "first parent" hack can be used in this case (--first-parent X..E),
but it will probably meet with the same resistance at the philosophical
level (i.e. "merge parents are equal") as the --first-parent option was
criticised for.  But other than that, a sequence to pick Y A B M E in this
order can be presented in the todo list to be edited, and swapping A and M
(for example) should result in this:

       o---o---o---o---o---Z---Y'
      /                         \
     X---Y---A---B               M'--A'--B'
          \       \             /
           C---D---M---E       /
                \             /
                 `-----------'

The existing revision range arithmetic can only come close with "E ^Z ^D"
(or "^D Z..E"), but that would exclude Y as "uninteresting" (because Y is
reachable from D).  You would end up with A--B--M--E.  So even though I am
sympathetic to poeple who complained that the command line parameter to
rebase is different from the log family, using revision range syntax is
not a solution to this.

Just for completeness of the illustration, linealizing form aims to
produce the history like this:

       o---o---o---o---o---Z---Y'--A'--B'--C'--D'--E'
      /
     X---Y---A---B
          \       \
           C---D---M---E

You can freely to reorder anything in the "todo" list without additional
constraints in this form (sequence of "pick" Y, A, B, C, D and E).

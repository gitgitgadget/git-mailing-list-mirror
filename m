From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Mon, 09 Jun 2008 19:31:51 +0200
Message-ID: <200806091931.51221.johan@herland.net>
References: <200805232221.45406.trast@student.ethz.ch>
 <200806090746.22512.johan@herland.net>
 <20080609122938.GA12210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 19:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5lFI-000834-Ai
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYFIRcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 13:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbYFIRcb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 13:32:31 -0400
Received: from smtp.getmail.no ([84.208.20.33]:39532 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbYFIRca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 13:32:30 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K270000LI1WC700@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 09 Jun 2008 19:32:20 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K27007DII15MB60@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 09 Jun 2008 19:31:53 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K27008Z1I13BOC0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 09 Jun 2008 19:31:52 +0200 (CEST)
In-reply-to: <20080609122938.GA12210@sigill.intra.peff.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84405>

On Monday 09 June 2008, Jeff King wrote:
> On Mon, Jun 09, 2008 at 07:46:22AM +0200, Johan Herland wrote:
> > Is there a good reason against having *both*?
> >
> > AFAICS, there's nothing stopping us from having both a "-e"-option to
> > git-add, and an "e"-command inside git-add--interactive.
>
> I agree (and I tried to make that point in an earlier mail).
>
> And I was hoping the right way to do it was to simply build the
> interactive "e" command on top of Johannes' git-apply work. But I don't
> think that quite makes sense.

Yeah, the two approaches don't merge easily...

> His work is about fixing up the hunk header as we apply the patch, but a
> working "e" command in the hunk selection should probably not actually
> apply, but simply split into two hunks for the loop.

By "split into two hunks", you mean splitting the original "index -> 
worktree" hunk (#0) into one hunk that represents "index -> edited" (#1), 
and another hunk that represents "edited -> worktree" (#2)?

>From a technical POV this might make sense, but AFAICS, users would always 
want to answer 'y' to #1, and 'n' to #2 (see [1]), so from a user POV, 
git-add--interactive should simply stage #1, and drop #2.

(Side note: AFAIR, some of the original rationale for this feature was to 
provide a more fine-grained split than 's'. Looking at the problem from 
this POV: What is the reason for splitting a hunk in the first place? It 
must be because one part of the hunk should be staged while leaving the 
other unstaged. With 's', it just splits, and lets the user select which 
parts of the hunk to stage, using 'y'/'n'. But 'e' introduces a much more 
powerful notion of letting user split AND select in ONE operation (i.e. the 
editor). Therefore, when the user has already selected which parts of the 
hunk to stage (#1), it is not necessary to re-ask the user whether or not 
#1 should be staged (and certainly not #2).

> > ("git-add -e" would open the entire diff in an editor, as would "e"
> > from the *main* menu of git-add--interactive. However, "e" from the
> > *single hunk* menu would of course open only that single hunk within
> > the editor. We could even have an "E" command to open all
> > remaining/undecided hunks in an editor.)
>
> I agree with all of this, though I think the big question is what
> happens to the edited portion. In the interactive command, I think it
> becomes a new hunk that can be staged or not. In "git add -e" it makes
> sense to simply stage the result.

Sounds acceptable to me (although I would also be ok with automatically 
staging the edited portion in the interactive command).


Have fun! :)

...Johan


[1]: AIUI #1 represents the hunk that the user want to stage at this moment. 
Conversely, #2 represents the changes that the user is NOT interested in 
staging at this point. Therefore, the only answers that make sense is 'y' 
(i.e. "stage this hunk") for #1 and 'n' (i.e. "do not stage this hunk") for 
#2. The only problem with this is if the user screwed up the hunk edit and 
wants to revert to the original hunk (#0). I don't know if this is worth 
supporting.

-- 
Johan Herland, <johan@herland.net>
www.herland.net

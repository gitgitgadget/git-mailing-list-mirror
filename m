From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 15:26:59 -0700
Message-ID: <7vej87xioc.fsf@gitster.siamese.dyndns.org>
References: <4827DEF6.1050005@gmail.com>
 <87ej87is50.fsf@offby1.atm01.sea.blarg.net>
 <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com>
 <alpine.LNX.1.00.0805121647540.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue May 13 00:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvgUy-0002Vf-Ax
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 00:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbYELW1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbYELW1K
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 18:27:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbYELW1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 18:27:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E3DD24BD0;
	Mon, 12 May 2008 18:27:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F1C214BCC; Mon, 12 May 2008 18:27:02 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0805121647540.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 12 May 2008 17:19:32 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E727306-2072-11DD-A28B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81960>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 12 May 2008, bill lam wrote:
>
>> Johannes Schindelin wrote:
>> > > I'd rsync just the .git directory.
>> 
>> Thanks to all responders for quick reply. I still have a related question. svn
>> has a hotcopy command to ensure integrity so that it is possible to backup
>> without shutting down the svn server. If someone update the .git while I am
>> performing backup using tar or rsync? Will the atomicity of that commit still
>> preserve in my backup copy?
>
> There's the risk that the backup will start, it will copy all of the 
> objects, then a git commit happens, which adds more objects (after rsync 
> has passed) and updates a "refs" entry to refer to one of them, and then 
> rsync copies the "refs" directory.
>
> It's likewise possible to have part of the information for a commit copied 
> and part of it not. This commit will be clearly broken, however (one or 
> more objects not found). 
>
> So, essentially, every commit goes through the stages of not at all 
> written, partially written but invalid, and valid and correct. 
> Independantly, which commit is the latest is updated atomically. It's 
> possible for an ill-timed backup to get a branch updated to a commit 
> that's not yet valid in the backup. In you restored from this, you'd need 
> to use one of several methods (mainly reflogs) to get back to the last 
> valid commit that got backed up.
>
> On the other hand, git will never, even in this sort of backup, end up 
> with a commit that's valid but not completely correct.

I think suggestions from old timers on this thread to first "git fetch" is
to handle that concern.  It may not get the commit that is being created
simultaneously when such a fetch to backup repository is running (but that
will be backed up during the next round), but at least the contents of the
backup repository would be self contained and correct.  So a nightly fetch
(perhaps with --mirror) into a backup repository, and then after the fetch
finishes, copying the backup repository to tape, would give you one copy a
night.  Copying out from the central repository to backup repository would
be incremental, and until you repack the backup repository, the tape
backup of that backup repository could also be made incremental, as fetch
will be append-only into its objects/ part with updates to refs/ part.

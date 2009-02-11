From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 3/3] completion: Prevents GIT_PS1_DIRTYSTATE from breaking
 when CWD is .git
Date: Wed, 11 Feb 2009 12:20:26 -0500
Message-ID: <499308DA.9090208@tedpavlic.com>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com> <1234366634-17900-2-git-send-email-ted@tedpavlic.com> <1234366634-17900-3-git-send-email-ted@tedpavlic.com> <1234366634-17900-4-git-send-email-ted@tedpavlic.com> <7vprhogbfa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:22:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXImg-0005XI-Ff
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbZBKRUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758224AbZBKRUg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:20:36 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:35371 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758217AbZBKRUf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 12:20:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id F18BB80D8088;
	Wed, 11 Feb 2009 12:14:03 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CrqiG8yRjVui; Wed, 11 Feb 2009 12:14:03 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id CB2CA80D8036;
	Wed, 11 Feb 2009 12:14:03 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <7vprhogbfa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109451>

>> This patch uses "git rev-parse --is-inside-work-tree" to determine
>> whether a "--work-tree=.." should be added to the "git diff".
>
> Why ".."?  What prevents you from "cd .git/refs/heads"?

It was my impression that --work-tree=.. was relative to the GIT_DIR. My 
tests seem to confirm that. Within the git work tree I do:

	echo "test">>COPYING

then

	cd .git/refs/heads
	git --work=tree=.. diff

and that produces a diff of COPYING showing the new line.

("man git" confused me about how WORK_TREE was supposed to work)

> Your "is-inside-work-tree" might be a good change, but if you were to
> spend a letter to notify the users, "Warning: You are inside GIT_DIR! This
> is something unusual, proceed with caution." is a lot more important
> notice to give them than "You seem to have unstaged changes" notice.

Ok, so if "is-inside-git-dir" then send a special "!" flag (and no 
dirtyState flags)? Does that seem reasonable?

Additionally, is it a good idea to echo the branch name when inside the 
git dir? That is, what does it "mean" to be on "master" when you're 
inside .git?

> You have at least three possible states:
>   * You are not in git repository at all;
>   * You are somewhere in $GIT_DIR, perhaps in a bare repository, perhaps a
>     repository with a work tree.
>   * You are inside a work tree.

It seems like (psuedocode)...

	if git rev-parse --is-inside-git-dir; then
		use '!' flag to indicate caution

	elif git rev-parse --is-inside-work-tree; then
		proceed as before (with '*' and '+' flags)

	else
		do nothing

I think that handles those cases. No?

Thanks --
--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

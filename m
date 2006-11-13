X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 10:17:02 -0800
Message-ID: <7vr6w78b4x.fsf@assigned-by-dhcp.cox.net>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com>
	<7v8xigar36.fsf@assigned-by-dhcp.cox.net>
	<20061113091736.GA31693@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 18:20:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31307>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjgMp-0005O2-4M for gcvg-git@gmane.org; Mon, 13 Nov
 2006 19:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932575AbWKMSRH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 13:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755309AbWKMSRH
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 13:17:07 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58084 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1755310AbWKMSRD
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006
 13:17:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061113181703.MUPS20330.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Mon, 13
 Nov 2006 13:17:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id mJGd1V0051kojtg0000000; Mon, 13 Nov 2006
 13:16:37 -0500
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr=F6m <kha@treskal.com> writes:

>> After finding out $that_new_branch's name, add either
>>
>>       Pull: refs/heads/$that_new_branch:refs/heads/$that_new_branch
>>
>> or if you are in "separate remote" school, then perhaps
>>
>>       Pull: refs/heads/$that_new_branch:refs/remotes/origin/$that_ne=
w_branch
>>
>> to .git/remotes/origin and running git fetch would give you what you
>> want, I think.
>
> There really should be a flag to make git fetch do this job. And if w=
e
> use separate remotes, the flag should probably default to "on".

While I do not necessarily agree that "git fetch" is the place
to do so, I think it is sensible to have a way to easily manage
remotes/$origin file.

Things to consider are:

 - We need to notice new branches at the other end.

 - We need to remember old branches that the user is not
   interested in, so that we do not even ask to add it only
   because it does not have a local tracking branch.

 - We need to notice branches that disappeared at the other
   end.  We may want to offer the choice between droping the
   local tracking branch and keeping it in the 'the last
   fetched' state.

So from the UI point of view, considering that "git fetch" might
be called as a part of "git pull", a sensible thing to do would
be:

 - Add "Pull-ignored:" lines to list remote branches that the
   user is not interested in to .git/remotes/$origin file, and
   teach existing tools to ignore them.

 - Make "git fetch" to always run "ls-remote" (we would need to
   do this anyway to enable commit walkers to fetch from a
   repository that has packed and then pruned its refs) upfront,
   and do the "noticing" part and issue an info message when
   there are new branches (we should only do this when a
   shorthand from .git/remotes/ is used).

 - Add "git maint-remote" command that lets the user compare
   ls-remote output and Pull: lines from remotes/$origin file,
   and add/modify/delete the mapping to local tracking branches.

I think the last one is probably the easiest for the users if
done with something like dialog or whiptail.

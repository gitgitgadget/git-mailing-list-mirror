From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Test that the 'rebase -i' "reword" command always cherry-picks
 a commit.
Date: Tue, 23 Mar 2010 10:38:27 -0400
Message-ID: <4BA8D263.8040602@xiplink.com>
References: <4BA11B23.4090801@xiplink.com> <1269285942-17496-1-git-send-email-marcnarc@xiplink.com> <7vd3yw84pd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 15:36:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu5Do-0005eN-Mk
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 15:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0CWOgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 10:36:22 -0400
Received: from smtp112.dfw.emailsrvr.com ([67.192.241.112]:56013 "EHLO
	smtp112.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab0CWOgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 10:36:07 -0400
Received: from relay11.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay11.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id BE172180BAB;
	Tue, 23 Mar 2010 10:35:58 -0400 (EDT)
Received: by relay11.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E27FD1809B4;
	Tue, 23 Mar 2010 10:35:55 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
In-Reply-To: <7vd3yw84pd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143022>

Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> In particular, "reword" should cherry-pick a reworded commit even if the
>> commit's message is unchanged.
>>
>> This behaviour provides a way to deal with a situation that can arise when
>> a merge had to be reverted.  Added an addendum to revert-a-faulty-merge.txt
>> describing the situation and how to use "reword" to handle it.
>> ---
>>
>> Is this more acceptable than adding --no-ff to rebase--interactive?
>>
>> I wasn't sure how to integrate the new text into revert-a-faulty-merge.txt.
>> I went with an addendum, but I'm open to other approaches.
> 
> The addendum looked readable, but I am a bit puzzled.

Ya think _you're_ puzzled?  :)

> "rebase -i --no-ff"
> already exists, and is probably a more natural way to do this than saying
> "reword" but not rewording anything, no?
> 
> I would actually say "rebase -f P" would be even easier and clearer,
> especially as...
> 
>> ...
>> +However, you could avoid these problems if you recreated the entire branch,
>> +including commit A:
>> +
>> + P---o---o---M---x---x---W---x
>> + |\         /
>> + | A---B---C   <-- old branch
>> + \
>> +  A'---B'---C' <-- entirely recreated branch
>> +
>> +Now you can merge A'-B'-C' into the mainline branch without worrying about
>> +first reverting W.
>> +
>> +But if you don't actually need to change commit A, then you need some way to
>> +recreate it as a new commit with the same changes in it.
> 
> ... this part seems to talk about working around the tendency of 'rebase -i'
> to fast-forward.

Yes.  Thanks for pointing this out, it's cleared up a lot for me.

I was confused about the purpose of "rebase -f".  Jonathan Nieder even
pointed me to it when I posted my original patch for "rebase -i --no-ff", but
the description in the man page threw me:

	Force the rebase even if the current branch is a descendant of
	the commit you are rebasing onto. Normally the command will
	exit with the message "Current branch is up to date" in such a
	situation.

I didn't realize that this is exactly the situation that "rebase -i" normally
deals with (-i basically implies -f), and that "rebase -f" would do exactly
what I wanted "rebase -i --no-ff" to do.

But I think I see an approach that might make sense:

 - Teach "rebase -i" to recognize the -f parameter (instead of --no-ff).

 - Update rebase's man page to better explain -f.

 - Update revert-a-faulty-merge.txt to explain how to use "rebase [-i] -f".

I'll submit a new patch shortly.

		M.

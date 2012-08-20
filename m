From: Maaartin <grajcar@seznam.cz>
Subject: Re: Comparing the working tree with a commit should be independent
 of the index
Date: Mon, 20 Aug 2012 20:44:53 +0200
Message-ID: <503285A5.1010708@seznam.cz>
References: <502FE0C6.6050106@seznam.cz> <7vvcgfrj8q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:45:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3WyS-0003eM-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 20:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219Ab2HTSpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 14:45:11 -0400
Received: from smtp2.seznam.cz ([77.75.76.43]:60474 "EHLO smtp2.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab2HTSpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 14:45:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-Session-Info;
	b=gFbDhRJiiFAJvHPFIFOSkVk6zKjJ10cEK2wNBuDf7RWzkVohsktS8+JjrmGdS3SN2
	zhjQUMNPVYsAnyo4XCcfjoeDbiCxNp7q9SAphTDntZSTFOwMZRPsexy4xFh4sPY6f+s
	PAOAANkTIWTWkHVI6fOTvilj/NVhJITwbUY7n+4=
Received: from [10.0.3.200] (188-120-197-152.luckynet.cz [188.120.197.152])
	by email-relay2.ng.seznam.cz (Seznam SMTPD UNKNOWN@exported) with ESMTP;
	Mon, 20 Aug 2012 20:44:54 +0200 (CEST)  
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vvcgfrj8q.fsf@alter.siamese.dyndns.org>
X-Smtpd: UNKNOWN@exported
X-Seznam-User: grajcar@seznam.cz
X-Session: 18
X-Country: CZ
X-Session-Info: (sid='6e6200000011', ip='188.120.197.152', helo='[10.0.3.200]', login='grajcar@seznam.cz', from='grajcar@seznam.cz', country='CZ', duration='00:00:06.108')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203866>

On 08/18/2012 11:19 PM, Junio C Hamano wrote:
>> Instead I get "deleted file". Adding the file to the index changes
>> it. This is IMHO a bug.
>
> Among the 7 interesting cases, a path missing from the index have 3
> interesting cases.
> 
>     In $commit	On filesystem
> 
>     Yes		Yes
>     Yes		No
>     No		Yes
> 
> and your case is the first one.  What do you want to see happen for
> other two cases?  I would guess "deleted" and "added", as anything
> else would not be internally consistent.

Sure.

> "git diff" compares contents in the index and in the working tree.
> "git diff HEAD" compares contents in HEAD and in the working tree.
> 
> The definition of paths in the working tree in these sentences is
> not "all files on the filesystem", or "all files on the filesystem,
> filtered with the ignore mechanism".  It is "all files on the
> filesystem that are in the index", and that is why you see a path
> that is in the commit and on the filesystem but not in the index
> as deleted.

That explains it all.

> This definition worked well for us, because that will give a clean
> semantics to "git diff HEAD": what change would I be recording if I
> said "git commit -a" at this point?

Ok, I see. I nearly always inspect changes to be committed via "git gui", so I don't care much about what "git commit -a" does.

> And that is why "git add" on the path changes the output as you
> observed in your message.  It is an intended behaviour.  If you did
> not tell Git that you want a path that does not exist in the index
> with "git add", the path will not participate in the next commit
> created by "git commit -a", and "git diff HEAD" should not talk
> about it.  If the path is only in the index, not showing it as
> deletion as you saw is actually dangerous.  "git commit -a" will
> record the deletion of the path in the commit, even though you
> checked with the "git diff HEAD" before you commit to make sure you
> didn't change it.

This is a good point. The deletion itself is easily undone, but git wouldn't record the new file content, which could be a problem for me.

> Of course, our definition of the set of working tree files does not
> have to be the only one.  Instead, it could be something that
> changes the semantics of "git diff HEAD" output to: what change
> would I be recording if I said "git add -A && git commit" at this
> point?

This was more or less my POW. Or more exactly, I simply just wanted to compare the state seen in the filesystem against an old commit.

> The updated semantics will be far less useful than the current one,
> but it still is an understandable one.  You could introduce a new
> option (mode of operation to "git diff") to make it include
> untracked but not ignored paths to the set of paths on the working
> tree side of the comparison, but I do not think it is useful.

Such a behavior would suit me, but I can live with the current one. There aren't much cases when it makes a difference and git commands have already a lot of options.

> In short, I do not think there is a bug in the current behaviour.

I can live with it. Many thanks for your answer.

Do you care to copy-paste something to [1], so I could accept your answer? Otherwise, I'll do it, so the information is there.

[1]: http://stackoverflow.com/questions/8452820/how-to-compare-the-working-tree-with-a-commit

Regards, Maaartin.

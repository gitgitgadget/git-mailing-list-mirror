From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Show diffs for changed files under a new or deleted
 directory.
Date: Mon, 18 Feb 2008 02:01:02 -0300
Message-ID: <47B9110E.90707@intelinet.com.br>
References: <1203263746-2924-1-git-send-email-rogersoares@intelinet.com.br> <200802171605.48250.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 06:01:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQy7q-0005Ex-Tg
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 06:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbYBRFAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 00:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbYBRFAN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 00:00:13 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1476 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750825AbYBRFAL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 00:00:11 -0500
Received: (qmail 35844 invoked by uid 0); 18 Feb 2008 02:02:56 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.315423 secs); 18 Feb 2008 05:02:56 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 18 Feb 2008 05:02:56 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <200802171605.48250.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74229>

Hi Robin,

Robin Rosenberg escreveu:
> i.e. the tree 'a' is sorted as if there is a '/' at then end. For full path
> names that is no problem and it is actually trivial, but when you order
> things by partial names it is much messier and quite hard to test also. There
> is a bug in the IndexTreeWalker and probably the differenser and you found it.
> It seems most likely you fixed it for that particular case, but it could still 
> be broken for another.
>   
Thanks for your explanation, it makes more sense now.

I didn't look in detail yet the parts where we need to interact with the 
index and the workspace, but just thinking about it now. If we are using 
an algorithm which requires that both trees are sorted using the same 
order, and one of them can't be trusted to follow such order, them 
sorting the trees the way we want looks like a simple solution...

I intend to go back to this after I finish some more patches I'm working 
on to add more info into the revision detail viewer. So, lets go in 
steps and look at one distinct thing at a time. My patch doesn't change 
sorting or ordering of things and isn't very complicated either, it just 
adds missing functionality.

So, if in the old tree we had:

file1

and in the new tree we have:

file1
dir1/file2
dir1/file3

The compare viewer must show:

+ dir1/file2
+ dir1/file3

The current code only notices that dir1 was added and shows:

+ dir1

which confuses people reviewing code because they can't see that file2 
and file3 were added. What the patch does is take the next step and, if 
the added or removed node is a directory and it has children, add all 
the children to the compare viewer using the same Differencer from the 
directory.

The Differencer I changed was actually a bug. If you say that the files 
left in the left pane are Differencer.ADDITION, then the ones left on 
the right pane _must_ be Differencer.DELETION. It just doesn't make 
sense to say that files not on the old tree but on the new tree are 
addition, and at the same time that files on the old tree but not on the 
new tree are also addition.

There is another check that must be added. If in a commit I delete a 
directory and add a file with the same name of the directory and 
vice-versa. This case is still failing, it shows an alert with an empty 
message. But as I said, I intend to deal with it later, it is a more 
uncommon case and nobody here complained about it yet... :)

I think it should be like this for all cases, even when comparing with 
the index or the workspace, so if there is something else I'm missing 
please let me know.


> I'd love to see a unit test for your code since, even if it works, it is very easy
> to break again.
>   
Ok, I'll get a look on the test cases and probably write something when 
I get back into these compare issues. That if somebody else doesn't do 
it before me, of course :)

[]s,
Roger.

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: help needed: Splitting a git repository after subversion migration
Date: Mon, 08 Dec 2008 14:30:28 +0100
Message-ID: <493D2174.80500@drmicha.warpmail.net>
References: <493C0AAD.1040208@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 14:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9gDG-00078S-8U
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 14:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbYLHNad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 08:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbYLHNad
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 08:30:33 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36670 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbYLHNac (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2008 08:30:32 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id F1A8F1E3C2B;
	Mon,  8 Dec 2008 08:30:31 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 08 Dec 2008 08:30:31 -0500
X-Sasl-enc: CJn1a8RakhgiNRfVI8PfXl8058ZhpmoTpr/lSqEX53rO 1228743031
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5506029A79;
	Mon,  8 Dec 2008 08:30:31 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <493C0AAD.1040208@intra2net.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102543>

Thomas Jarosch venit, vidit, dixit 07.12.2008 18:41:
> Hello together,
> 
> I've successfully imported a large subversion repository into git.
> The tree contains source code and binary data ("releases"),
> the resulting .git directory is about 11GB.
> 
> After the import I recreated the tags/branches by converting the refs
> to the subversion tags using a small shell script from the web:
> 
> for branch in `git branch -r`; do
>      ...
>      version=`basename $branch`
>      git tag -s -f -m "$subject" "$version" "$branch^"
>      git branch -d -r $branch
> done
> 
> Ok, so far everything went really smooth. I wanted to split this repository
> into two repositories, one for the source code and one for the binary data.
> The current tree layout is like this:
> 
> sources/c++_xyz
> releases/large_binary_data
> ...
> 
> The original tree was imported from CVS to subversion and the layout
> of the trunk was once reorganized/moved later. Here's the command
> I used to split out the "source" tree:
> 
> git filter-branch --index-filter 'git rm --cached --ignore-unmatch -r -f
> CVSROOT Attic source/Attic develpkg/Attic
> source/packages/Attic releases update_pkg' -- --all
> 
> After that I ran these commands to reclaim the space:
> - git clone --no-hardlinks filtered_tree final_output
> - cd final_output
> - git gc
> - git prune
> - git repack -a -d --depth=250 --window=250
> 
> Unfortunately the .git directory of the "source" tree is still 7.5GB big.
> 
> When I just imported the "trunk" from subversion without any tags
> and then ran "git filter-branch --subdirectory-filter source" + git gc,
> the .git directory was about 1.5GB afterwards.
> 
> How can I find out where those other 6GB go to?
> I already looked at the tags with gitk,
> there's no sign of the releases/* stuff left.

I strongly suspect the reorganization/move to be the cause. Most
probably some releases were put in places where you don't expect them,
and therefore they are not filtered out by removing the releases subdir.
If they have distinguished file names (say you know a name from before
the move) you can find them using "git log". Or use gitk --all, switch
to "tree display" and look for unexpected files in the earliest revisions.

Also, it may be better to do the tag creation (from tags/... branches)
after the filter-branch. If you don't rewrite the tags (have you?) then
the tags will still point to the original commits (before the rewrite)
and therefore include all the "fat blobs". You avoid this best by
creating them after the rewrite.

Michael

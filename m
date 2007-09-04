From: Andreas Ericsson <ae@op5.se>
Subject: Re: Calculating tree nodes
Date: Tue, 04 Sep 2007 07:51:54 +0200
Message-ID: <46DCF27A.4040804@op5.se>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>	 <20070904025153.GS18160@spearce.org>	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>	 <Pine.LNX.4.64.0709040439070.28586@racer.site>	 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>	 <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com> <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRKU-0002oY-KQ
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbXIDFv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXIDFv6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:51:58 -0400
Received: from mail.op5.se ([193.201.96.20]:46247 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXIDFv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:51:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7300919442B;
	Tue,  4 Sep 2007 07:51:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saLgRFonKwur; Tue,  4 Sep 2007 07:51:56 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id C0087194410;
	Tue,  4 Sep 2007 07:51:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57527>

Jon Smirl wrote:
> On 9/4/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>>>> Yes.  For performance reasons, since a simple commit would kill you in any
>>>> reasonably sized repo.
>>> That's not an obvious conclusion. A new commit is just a series of
>> Hi Jon!
>>
>> If you search the archives you'll find Linus explaining that the
>> initial git had all the directory structure in one single "tree"
>> object that held all the paths, not matter how deep. The problem with
>> that was taht every commit generated a huge new tree object, so he
>> switched to the current "nested trees" structure, which also has the
>> nice feature of speeding up diffs/merges if whole subtrees haven't
>> changed.
> 
> In my scheme the commit is only a list of SHA's. The paths are stored
> as attributes of the file objects. Commits are just edits to the list
> of SHA's in the commit objects. If these lists are kept sorted, then
> the delta should be tiny. Just the info on the adds/deletes to the
> list.
> 

It will stop being fast when you need to apply (revisions*avg_num_files_changed)
patches before you can start diffing things properly.

> This is very different that a single tree blob that contains all of the paths.
> 
> Diffing two trees in the scheme is quite fast. Just get their commit
> objects into RAM and compare the lists of SHAs.
> 

That's not a very useful diff though. I'd run, screaming, from an SCM that didn't
tell me *how* things have changed in addition to *what*.

>>> edits to the previous commit. Start with the previous commit, edit it,
>>> delta it and store it. Storing of the file objects is the same. Why
>>> isn't this scheme fast than the current one?
>> I think you're a bit confused between 2 different things:
>>
>>  - git is _snapshot_ based, so every commit-tree-blob set is
>> completely independent. The "canonical" storage is each of those
>> gzipped in .git/objects
>>  - however, for performance and on-disk-footprint, we delta them (very
>> efficiently I hear)
> 
> The systems are essential the same with a little reorganization. In
> the current system the paths and SHA for a commit are spread over the
> tree nodes.
> 
> In my scheme the path info is moved into the file object nodes and the
> SHA list is in the commit node.
> 
> git still works exactly as it has before. I just moved things around
> in the storage system. The only thing that should be impacted is
> performance.
> 

Perhaps, but negatively so. Git is fast when applying patches, primarily
because it can exclude entire subtrees. It knows it can exclude those
subtrees because their SHA1 hashes are identical. It wouldn't know that
if there weren't the tree objects (well, it could, but walking all the
commits, counting changes and considering '0' to be "no changes" doesn't
scale, so that's a moot point).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Announce] gitview-0.1
Date: Wed, 1 Feb 2006 12:17:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011206040.21884@g5.osdl.org>
References: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
 <20060201042930.GV16557@redhat.com> <cc723f590601312041o1dc594c7t69418b735ef29ee@mail.gmail.com>
 <cc723f590602010328w7b4a7befr40a76620e197d00c@mail.gmail.com>
 <7v3bj2df1b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>,
	Dave Jones <davej@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 21:18:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4OQA-0001K9-HS
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422920AbWBAURj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422924AbWBAURj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:17:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422920AbWBAURi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 15:17:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11KHADZ023125
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 12:17:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11KH3LE024901;
	Wed, 1 Feb 2006 12:17:05 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bj2df1b.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15439>



On Wed, 1 Feb 2006, Junio C Hamano wrote:
> 
> Are parent_sha$N true parents of commit_sha1?  If you want to
> get three independent diffs, "git diff-tree -m -p $commit_sha1"
> would give that to you in one go.

Btw, I think we should change

	git-diff-tree --stdin

to look at the rest of the line.

Right now it _only_ takes the commit from that line, along with possibly 
the first parent if one exists (if one is not listed, the list of parents 
will be correctly taken from the commit).

Which makes it mostly useless for merges with a dense history.

Especially with the new "-cc" flag, using it for merges really does make 
a lot of sense, but it's not workable.

So right now, git-whatchanged does

	git-rev-list | git-diff-tree --stdin <filelist>

which means that it handles merges in a pruned-down history wrong. Now, 
that's ok, because it currently never prunes the history of git-rev-list 
(it instead prunes purely in git-diff-tree). So it works right, and can 
take the -cc flag because it always gets the parent information from the 
commit.

HOWEVER, currently doing the pruning the other way around, ie

	git-rev-list --parents <filelist> | git-diff-tree --stdin

does _not_ work right. It ignores anything but the first parent, because 
"git-diff-tree --stdin" doesn't understand merges.

And doing the pruning the other way around would actually make sense 
sometimes. Not for git-whatchanged (where doing the pruning in 
git-diff-tree means that we don't have to parse the history ahead of time, 
so we get immediate feedback), but in a git-annotate context you want to 
do the pruning ahead-of-time. So git-diff-tree not supporting it is sad ;(

		Linus

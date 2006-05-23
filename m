From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Mon, 22 May 2006 17:02:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221646540.3697@g5.osdl.org>
References: <4471CF23.1070807@gmx.de> <7vac99c1hv.fsf@assigned-by-dhcp.cox.net>
 <BAYC1-PASMTP1164FE2A24B4D1B4C0A607AE9A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, BjEngelmann@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 02:03:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiKMn-0000Gw-N9
	for gcvg-git@gmane.org; Tue, 23 May 2006 02:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWEWAC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 20:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWEWAC7
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 20:02:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751336AbWEWAC5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 20:02:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4N02gtH006597
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 17:02:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4N02fgX019166;
	Mon, 22 May 2006 17:02:42 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP1164FE2A24B4D1B4C0A607AE9A0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20555>



On Mon, 22 May 2006, Sean wrote:
> What seems to becoming clear as more people find new ways to use
> git is that many of them would be well served by having a solid
> infrastructure to handle metadata.  Consider the case above: _git_
> itself doesn't need a structural reference, but users and external
> applications definitely need to be able to lookup which metadata
> is associated with any given commit.  Having a git standard for
> this type of data would help.  Tags already do this, so they're
> likely to be used and abused in ways not initially envisioned,
> just because git doesn't have another such facility.

I definitely think we should allow arbitrary tags.

That said, I think that what you actually want to do may be totally 
different.

If _each_ commit has some extra information associated with it, you don't 
want to create a tag that points to the commit, you more likely want to 
create an object that is indexed by the commit ID rather than the other 
way around.

IOW, I _think_ that what you described would be that if you have the 
commit ID, you want to find the data based on that ID. No?

And that you can do quite easily, while _also_ using git to distribute the 
extra per-commit meta-data. Just create a separate branch that has the 
data indexed by commit ID. That could be as simple as having one file per 
commit (using, perhaps, a similar directory layout as the .git/objects/ 
directory itself), and then you could do something like

	# Get the SHA1 of the named commit
	commit=$(git-rev-parse --verify "$cmitname"^0)

	# turn it into a filename (slash between two first chars and the rest)
	filename=$(echo $commit | sed 's:^\(..\)\(.*\):\1/\2:')

	# look it up in the "annotations" branch
	git cat-file blob "annotations:$filename"

which gets the data from the "annotations" branch, indexed by the SHA1 
name.

Now, everybody can track your "annotations" branch using git, and get your 
per-commit annotations for the main branch.

See?

The real advantage of tags is that you can use them for the SHA1 
expressions, and follow them automatically. If that's what you want (ie 
you don't want to index things by the commit SHA1, but by some external 
name, like the name the commit had in some other repository), then by all 
means use tags. But if you just want to associate some data with each 
commit, the above "separate branch for annotations" approach is much more 
efficient.

		Linus

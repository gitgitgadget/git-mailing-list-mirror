From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-rev-parse(1) questions
Date: Mon, 30 Apr 2007 11:49:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704301138320.3419@woody.linux-foundation.org>
References: <mz0pwwi3.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 20:49:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiawA-0004Sg-PY
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 20:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946614AbXD3StX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 14:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946616AbXD3StX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 14:49:23 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:40823 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946614AbXD3StW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2007 14:49:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3UIn9An025142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Apr 2007 11:49:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3UIn7NT011854;
	Mon, 30 Apr 2007 11:49:08 -0700
In-Reply-To: <mz0pwwi3.fsf@cante.net>
X-Spam-Status: No, hits=-2.988 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45874>



On Mon, 30 Apr 2007, Jari Aalto wrote:
>
> Could someone provide example commands where and how to use these:
> 
>     * A suffix ^ followed by an empty brace pair (e.g. v0.99.8^{})
>       means the object could be a tag, and dereference the tag
>       recursively until a non-tag object is found.

I don't think you'd normally use this much. It's more visible in things 
like

	git ls-remote <git-repo-name-here>

which will show tags and the objects they derefernce to, using the "^{}" 
syntax. Normally you'd not use it in any day-to-day operation, although if 
you want to, you could for example use

	git show tag^{}

to show what the tag points to, without getting the tag part.

For an example, of this, in the git archive, do

	git show junio-gpg-pub
vs
	git show junio-gpg-pub^{}

and think about the difference in output.

But no, you'd not normally use this outside of scripts (and even inside 
scripts, it's much more common to instead use "tag^0", which does 
effectively the same *but* also requires the thing to be a commit.

>     * A colon, optionally followed by a stage number (0 to 3) and a
>       colon, followed by a path; this names a blob object in the index
>       at the given path. Missing stage number (and the colon that
>       follows it) names an stage 0 entry.

You'd never use this unless you're working with a unmerged tree entry, and 
then you can use it for things like

	git diff :1:my-path :2:their-path

if you want to look at the differences between the two blobs that are 
unmerged, and come from different branches (":1:my-path" comes from the 
branch you were merging things into,and the ":2:their-path" comes from the 
branch you were merging from).

That can be useful in the extremely rare case where you had criss-crossing 
renames, for example, and the recursive merge strategy couldn't resolve 
them, and you realize that in order to merge it properly you'll need to 
look at different pathnames that didn't pair up.

Normally, if the pathnames pair up, you'd normally just get a nice data 
conflict and you'd likely just work with that. 

I don't think anybody ever _normally_ uses the :n:path syntax. It's really 
a very esoteric capability for when things go really really wrong, and you 
want to see what the different stages contain.

		Linus

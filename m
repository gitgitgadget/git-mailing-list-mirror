From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Running git-archive recursively over submodules
Date: Tue, 16 Feb 2010 08:38:08 +0100
Message-ID: <4B7A4B60.3090401@drmicha.warpmail.net>
References: <201002152156.17132.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:40:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhI2q-0000ga-Is
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab0BPHk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 02:40:26 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38930 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754863Ab0BPHkZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 02:40:25 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1AB87DF623;
	Tue, 16 Feb 2010 02:40:25 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Feb 2010 02:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lRGSFRVLe9F32tVETgaTEmaLA2U=; b=A61BjE+4Ygt3B1VRR6NisFLBTxKpt/xjYuAzh8xPSyPsCus+m/ksI7J9LRgVOqQtU0bdJ+QW9ockOSGsqAl8pBwOAvzuSuzCxYcYwP88ti/t5ywqNTf+4nWoC+VPA2KbrwhMynf7piXG3W9iiIls8HdKzQbBrtKCD1rsKCdHQE8=
X-Sasl-enc: K3FjuJ2qY6Wn8dM5HNm2SyZxLtMZkYZ2/wzpza32z5ie 1266306024
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 80243A8AE;
	Tue, 16 Feb 2010 02:40:24 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100201 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <201002152156.17132.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140083>

Thomas Rast venit, vidit, dixit 15.02.2010 21:56:
> I'm posting this for posterity.  It came out of an IRC discussion last
> night.  Google "git archive submodules" currently finds two scripts
> for the same task:
> 
> * http://kerneltrap.org/mailarchive/git/2008/3/29/1294614
>   Can pack arbitrary revisions, but seems to be highly specific to the
>   poster's setup.
> 
> * http://wiki.github.com/meitar/git-archive-all.sh/
>   Appears to work with normal repos (I haven't really tested) but only
>   packs HEAD.
> 
> Both have in common that they run git-archive in each submodule, and
> then merge the resulting tars.
> 
> The script below follows a different approach, based on the idea that
> all the objects are already there, you just need to help git find
> them.  This of course assumes that you have the submodules checked out
> (or at least cloned).  It builds an index that contains a flattened
> version of the repository and all submodules.  This works for any
> revision you specify.  The downside is that this does not respect
> .gitattributes.
> 
> The same trick can be used for other commands, so if people find this
> useful it could be added to git-submodule.
> 
> Warning: Error detection and such are left as an exercise to the user.
> 
> -- 8< --
> #!/bin/sh
> 
> export revision="$1"
> 
> export GIT_INDEX_FILE=".git/tmpindex"
> rm -f "$GIT_INDEX_FILE"
> 
> git read-tree $revision
> 
> export up="$(pwd)"
> 
> read_one_level () {
> 	export GIT_ALTERNATE_OBJECT_DIRECTORIES="$GIT_ALTERNATE_OBJECT_DIRECTORIES":$(
> 	    git submodule foreach 'echo "$up/$path/.git/objects"' |
> 	    grep -E -v '^(Entering|No submodule mapping found)' |
> 	    tr '\n' : |
> 	    sed 's/:$//'
> 	)
> 
> 	git submodule foreach '
> 		cd "$up"
> 		subcommit=$(git rev-parse :"$path")
> 		git rm --cached "$path"
> 		git read-tree -i --prefix="$path/" $subcommit
> 	' >/dev/null
> }
> 
> while git ls-files -s | grep -q ^160000; do
>     read_one_level
> done

Am I blind, not seeing a recursion, or is there simply none? I reckon
you're reading the super project and one level of submodules into the
temporary index - which is fine for most purposes, of course. I would
say this is iterating over the submodules of the super project.

> git archive --format=tar $(git write-tree)
> 
> rm -f "$GIT_INDEX_FILE"
> -- >8 --
> 

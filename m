From: Seth House <seth@eseth.com>
Subject: Re: Conflict markers in mergetool $LOCAL ?
Date: Wed, 18 Aug 2010 03:22:58 +0000 (UTC)
Message-ID: <loom.20100818T052242-649@post.gmane.org>
References: <loom.20100817T054731-955@post.gmane.org> <20100817093008.GA26357@gmail.com> <loom.20100817T185804-167@post.gmane.org> <f595ee73-b1a3-4797-bf55-20c0f1b309e0@email.android.com> <loom.20100817T230158-934@post.gmane.org> <4C6AFE09.5020302@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 05:23:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlZFH-0006lL-2l
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 05:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786Ab0HRDXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 23:23:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:55870 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab0HRDXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 23:23:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OlZF7-0006hk-B2
	for git@vger.kernel.org; Wed, 18 Aug 2010 05:23:09 +0200
Received: from ip65-44-116-164.z116-44-65.sendoutcards.net ([65.44.116.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:23:09 +0200
Received: from seth by ip65-44-116-164.z116-44-65.sendoutcards.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:23:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.44.116.164 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.6 (KHTML, like Gecko) Chrome/6.0.493.0 Safari/534.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153808>

Charles Bailey <charles <at> hashpling.org> writes:
> Most 3-way merge tools use BASE, LOCAL and REMOTE

That is how Mercurial invokes vimdiff, except it also uses a wrapper
shell script in order to tell vimdiff where to save the final edit.

That said, you're right that vimdiff doesn't do the "good semi-automatic
conflict resolution" that you spoke of.

> I personally have used and would recommend kdiff3

I spent some time playing with kdiff3 today. Thanks for the
recommendation. I now understand why a merge tool that has native
support for comparing all four file versions ($BASE, $LOCAL, $REMOTE,
and $MERGED) is vastly more powerful than tools that don't (vimdiff,
Meld) -- and I wish that bit of information would make it into more
diff-tool comparisons discussions online.

So, back to my OP, most of the time I deal with tiny conflicts. I wanted
a quick way to look at *only* the conflicts without having to do the
search-next-search-next dance with my editor -- which is something that
vimdiff can do very well. In case anyone stumbles on to this thread
looking for something similar, I settled on the script below.

Thanks for your help/advice, David, Jacob, and Charles!

#!/bin/sh
# Use vimdiff to quickly go through Git merge conflicts.
# 
# Save your changes to the LOCAL file. MERGED will be updated if
# vimdiff exits cleanly. Use :cq to abort.
# 
# Put the following in your ~/.gitconfig
#
# [mergetool "vimdiffconflicts"]
#     cmd = unmerge.sh $BASE $LOCAL $REMOTE $MERGED
#     trustExitCode = true

if [[ -z $@ || $# != "4" ]] ; then
    echo -e "Usage: $0 \$BASE \$LOCAL \$REMOTE \$MERGED"
    exit 1
fi

BASE=$1
LOCAL=$2
REMOTE=$3
MERGED=$4

sed -e '/<<<<<<</,/=======/d' -e '/>>>>>>>/d' $MERGED > $LOCAL
sed -e '/=======/,/>>>>>>>/d' -e '/<<<<<<</d' $MERGED > $REMOTE

vim -f -d $BASE $LOCAL $REMOTE \
    -c ':diffoff' -c ':set scrollbind' -c 'wincmd l'

EC=$?

# Overwrite $MERGED
[[ $EC == "0" ]] && cat $LOCAL > $MERGED

exit $EC

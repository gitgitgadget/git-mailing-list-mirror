From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: Recording cherry-picked commits
Date: Sun, 23 Mar 2008 12:07:52 +0100
Message-ID: <ae63f8b50803230407u7062586dy26fab7d98090efb9@mail.gmail.com>
References: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>
	 <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>
	 <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 12:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdO4A-0002IV-NR
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 12:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785AbYCWLHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 07:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758884AbYCWLHz
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 07:07:55 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:42462 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604AbYCWLHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 07:07:53 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2939350fkr.5
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Pt9L8Bh9qISlGQvgBEUdPrbdUGILgSXSSyyxXHgyP0w=;
        b=Z8Mzc2jOB/6wo8xVnRSc5sPf1wlpghYWVzvWs6FEYMxtMhOpORXUlPCnQvQeFOrNDe+d+lud/fFOmlNNG8mXm19NqzrYEGphi8Yf+qtpBCchsL2ZabbkBqPMmOpUL2TMtpBO634mlTtm9wegY4Yz5mxQrIIdAQpl1VWPt3Q94Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cUEh3vpfKtUpJBouRDEfkp4X/+4rY8jywb70RRKxCrSmZ/5kpsfCa6DXRUlfczLE2+smSwkC7v3LyzDcPmaV6wLr/pNlVFzB6gUI5lQQ4rasU5C+u9PFaW49q0uQ700bEWfafIq1UV/i2uq55NXp/BoJhmu32qv2OUDHexUdXTI=
Received: by 10.78.138.6 with SMTP id l6mr10451447hud.71.1206270472191;
        Sun, 23 Mar 2008 04:07:52 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Sun, 23 Mar 2008 04:07:52 -0700 (PDT)
In-Reply-To: <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 58d23796aaec39c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77880>

2008/3/22, Rafael Garcia-Suarez <rgarciasuarez@gmail.com>:
> On 22/03/2008, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
>  > What about using a hidden ".gitcherry" file in the current branch to
>  >  store the commits that have been applied?  With the simple shell
>  >  scripts below I'm able to achieve the same effect as svnmerge:
>
> (.gitcherry should really be at the root of the git repository, not in
>  the current directory)

Yes that's what I meant.  Usually I'm always at the root when I'm
cherry-picking changes but you're right the script could be improved
in this regard.  Is there a trick to find the root repository
directory?

>  What happens to .gitcherry across merges ?  I think your solution isn't robust
> enough.

The .gitcherry is merged like any other file.  I'm just trying to
mimic svnmerge here, not to reinvent anything.  As Git does not have
file metadata, I'm using a plain text file to achieve this.

>  Here's an alternate idea: store the original sha1 in the commit
>  message, via a custom header (something like X-Cherry-Picked-From) at
>  least in case of conflict, and have git-cherry recognize it.

I like your idea of filtering on commit messages, that makes sense and
it voids the use of .gitcherry, and thus better preserves the diffs.

Here is the updated git-cherry-pick wrapper.  Note that we repeat the
commit log in the message, and we're loosing the author information.
Keeping the author would require to change git-commit to allow
combining -C and -F.  Also it seems that -C and -t are incompatible,
although git-commit does not error out.

Junio suggests to use git-cherry's -x flag, but it is not written upon
conflict, so it's useless for the current usecase about properly
handling conflicts during cherry-picking.

------------------------------------------------------------------------
#! /bin/sh -e

# Record the commit id in .git/CHERRY_COMMIT, and call git-cherry-pick without
# actually committing.  If a conflict occurs, resolve it and invoke this script
# with --continue.  The commit log is then fed to git commit.
#
# FIXME find the root repository directory

if test "$1" = "--continue" ; then
    cont=1
    commit=$(cat .git/CHERRY_COMMIT)
else
    cont=0
    commit=$1
fi

if test $cont = 0 ; then
    echo $commit > .git/CHERRY_COMMIT
    git cherry-pick -n $commit
fi

git log -1 $commit | git commit -F -
rm -f .git/CHERRY_COMMIT
------------------------------------------------------------------------


And the updated git-cherry wrapper:
------------------------------------------------------------------------
#! /bin/sh -e

# List all commits with git-cherry and exclude all the ones that are already
# part of the change log of the current branch.  For each available commit,
# invoke 'git show' to print the commit message.

tempfile=$(tempfile -p $(basename $0))
git log --pretty=format:%s | sed -ne 's/^commit
\([a-z0-9]\{40\}\)$/\1/p' > $tempfile

for commit in $(git-cherry $* | sed -ne 's/^+ //p' | grep -v -f $tempfile) ; do
    git show -s --pretty=format:"%H %s" $commit
done

rm -f $tempfile
------------------------------------------------------------------------

Cheers,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/

From: "Seth W. Klein" <sk@sethwklein.net>
Subject: Re: Converting SVN repository to git
Date: Fri, 17 Jun 2005 23:26:48 -0400
Message-ID: <20050618032648.GA23034@bubook.sethwklein.net>
References: <20050615184720.GF31997@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 05:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjTvG-0002ut-N2
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 05:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFRD2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 23:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVFRD2c
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 23:28:32 -0400
Received: from mx2.midmaine.com ([66.252.32.99]:39915 "HELO mail.midmaine.com")
	by vger.kernel.org with SMTP id S261503AbVFRD23 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 23:28:29 -0400
Received: (qmail 3217 invoked from network); 18 Jun 2005 03:28:26 -0000
Received: from 66-252-35-217.da.midmaine.com (HELO bubook.sethwklein.net) (66.252.35.217)
  by 0 with SMTP; 18 Jun 2005 03:28:26 -0000
Received: by bubook.sethwklein.net (Postfix, from userid 500)
	id F16C83E2F; Fri, 17 Jun 2005 23:26:48 -0400 (EDT)
To: Art Haas <ahaas@airmail.net>
Content-Disposition: inline
In-Reply-To: <20050615184720.GF31997@artsapartment.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2005 at 01:47:20PM -0500, Art Haas wrote:
> 
> [....] I've not seen anything, though,
> on switching Subversion repositories to git. Has there been any public
> activity in writing a tool/script to do this? Perhaps some offline
> discussion about doing this?

The following script is what I used to convert a simple svn repository.
It doesn't handle branches or tags and contains buggy use of grep and
inscrutable uncommented use of sed but it should be a starting place for
someone with a more complex repository available for testing.

export GIT_AUTHOR_EMAIL=sk@sethwklein.net
export GIT_COMMITTER_EMAIL=sk@sethwklein.net
svn co -r 1 file:///home/sk/rep/oakheart/trunk oakheart
cd oakheart
git-init-db
for REV in `seq 2 692`; do
    echo -n $REV' '
    svn update -r $REV > .svnupdate
    sed -nr 's/^A +//p' .svnupdate \
    | while read F; do [ -f "$F" ] && echo "$F"; done \
    | xargs -r git-update-cache --add --
    sed -nr 's/^D +//p' .svnupdate \ 
    | while read F; do git-ls-files | grep "^$F"'\(/\|$\)'; done \
    | xargs -r git-update-cache --remove --
    sed -nr 's/^U +//p' .svnupdate \
    | while read F; do [ -f "$F" ] && echo "$F"; done \
    | xargs -r git-update-cache --
    PARENT=
    [ -f .git/HEAD ] &&
        PARENT='-p '`cat .git/HEAD`
    svn log -r $REV | sed -n '1,3d;$d;H;/^$/!{s/.*//;x;s/\n//;p}' \
    | git-commit-tree `git-write-tree` $PARENT > .git/HEAD
done

Cheers,
Seth W. Klein
-- 
sk@sethwklein.net     AIM: sethwklein     http://www.sethwklein.net/

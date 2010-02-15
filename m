From: Thomas Rast <trast@student.ethz.ch>
Subject: Running git-archive recursively over submodules
Date: Mon, 15 Feb 2010 21:56:16 +0100
Message-ID: <201002152156.17132.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:56:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh7zV-0003A1-Gb
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 21:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab0BOU4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 15:56:20 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:36648 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104Ab0BOU4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 15:56:19 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 21:56:17 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 21:56:17 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140032>

I'm posting this for posterity.  It came out of an IRC discussion last
night.  Google "git archive submodules" currently finds two scripts
for the same task:

* http://kerneltrap.org/mailarchive/git/2008/3/29/1294614
  Can pack arbitrary revisions, but seems to be highly specific to the
  poster's setup.

* http://wiki.github.com/meitar/git-archive-all.sh/
  Appears to work with normal repos (I haven't really tested) but only
  packs HEAD.

Both have in common that they run git-archive in each submodule, and
then merge the resulting tars.

The script below follows a different approach, based on the idea that
all the objects are already there, you just need to help git find
them.  This of course assumes that you have the submodules checked out
(or at least cloned).  It builds an index that contains a flattened
version of the repository and all submodules.  This works for any
revision you specify.  The downside is that this does not respect
.gitattributes.

The same trick can be used for other commands, so if people find this
useful it could be added to git-submodule.

Warning: Error detection and such are left as an exercise to the user.

-- 8< --
#!/bin/sh

export revision="$1"

export GIT_INDEX_FILE=".git/tmpindex"
rm -f "$GIT_INDEX_FILE"

git read-tree $revision

export up="$(pwd)"

read_one_level () {
	export GIT_ALTERNATE_OBJECT_DIRECTORIES="$GIT_ALTERNATE_OBJECT_DIRECTORIES":$(
	    git submodule foreach 'echo "$up/$path/.git/objects"' |
	    grep -E -v '^(Entering|No submodule mapping found)' |
	    tr '\n' : |
	    sed 's/:$//'
	)

	git submodule foreach '
		cd "$up"
		subcommit=$(git rev-parse :"$path")
		git rm --cached "$path"
		git read-tree -i --prefix="$path/" $subcommit
	' >/dev/null
}

while git ls-files -s | grep -q ^160000; do
    read_one_level
done

git archive --format=tar $(git write-tree)

rm -f "$GIT_INDEX_FILE"
-- >8 --

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

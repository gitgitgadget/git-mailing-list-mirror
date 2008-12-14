From: "Jukka Zitting" <jukka.zitting@gmail.com>
Subject: git-svn and "svn move" of an entire project
Date: Mon, 15 Dec 2008 00:14:37 +0100
Message-ID: <510143ac0812141514k28f6dcd4y57bc50600205cd7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 00:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0By-0004oJ-7Z
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYLNXOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYLNXOj
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:14:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:31197 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYLNXOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:14:38 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2217299rvb.1
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 15:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=s8xrafwrbun357/i3QS8owHqD67qP8RP9GtyWILd8pc=;
        b=N6xCA8Bz1Bfob52VlqFdbUbxrOQbIShffQ4l4cP1iQvdNKBwHo+Lz/cwzQUBXLjKxy
         9s6YFtrBGfFaxA2p9Hi7c8zwOaZGI7h4jQHimOshCH3anNbSvYLPCJc0rggo334LyPWW
         oA6ECulppg1EQa8y5KClOQwV8BYsm/1bwJVgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=pJeD/KQRSLZF3qtMrQ/uaKjHUsk2sIRkDwWxOar9pQihocYyfqYtM0Hd9Iv2XCiy9y
         5XD5NdxKn8TrRFflZZO4JB3L/GQIyQGQpDA/wNcKkwbJhFjNpej9p9t3PHc04mRzWRGl
         IqhBY+gHFsjRX/A0LOwIa4kKMGDeaD/hvvoms=
Received: by 10.141.74.17 with SMTP id b17mr3351301rvl.26.1229296477910;
        Sun, 14 Dec 2008 15:14:37 -0800 (PST)
Received: by 10.141.195.18 with HTTP; Sun, 14 Dec 2008 15:14:37 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103103>

Hi,

I'm hosting git-svn mirrors of many Apache projects [1] and every now
and then I need to deal with cases where an entire project (trunk,
tags, branches, everything) is moved from one location to another
within the svn server. For example in revision 723328 [2] the Apache
Abdera project was moved from incubator/abdera to just abdera.

At [3] I found instructions on how to cope with such situations when
git-svn is used to follow only the svn trunk of a project. Based on
that I came up with the bash script below that allows me to update a
full (init -s) git-svn mirror to point to a new location in svn.

The script seems to work fine but I'm wondering if there's an easier
way to achieve this (and if there are any obvious mistakes in my
script). One alternative is of course to recreate the full git-svn
mirror, but that risks breaking the git history if someone has
meanwhile modified a commit message in svn or changed an author name.

Ideally I'd just run "git svn init" again with the new location and
let git-svn take care of the rest. Unfortunately that doesn't seem to
work and I'm not familiar enough with git-svn internals to know where
to start implementing something like this.

[1] http://jukka.zitting.name/git/
[2] http://svn.apache.org/viewvc?view=rev&revision=723328
[3] http://duncan.mac-vicar.com/blog/archives/282

BR,

Jukka Zitting

----

#!/bin/bash

# Location of the authors file
AUTHORS=/home/jukka/git/authors.txt

# Example:
# move-svn-project.sh /var/git/abdera.git 723328 incubator/abdera abdera
DIR=$1
REV=$2
OLD=$3
NEW=$4

# Set GIT_DIR so all git commands know which repo to use
export GIT_DIR=$DIR

# This function is the main workhorse of this script.
# It takes an existing git-svn branch and updates it
# to point to the first corresponding post-move revision
# in svn. If the branch no longer exists in svn, it is
# removed from here as well.
map() {
  REF=$1
  URL=$2
  echo "Mapping $REF to $URL"

  # Keep a backup copy of the original git-svn metadata
  cp "$GIT_DIR/svn/.metadata" "$GIT_DIR/svn/.metadata.bak"

  # Set up a temporary git-svn remote for just this subtree
  git svn init -R tmp -i tmp-git-svn-map-branch "$URL"

  # Get the first post-move version of this subtree and modify the branch
  git svn fetch -r "$REV" --authors-file "$AUTHORS" tmp
  if git rev-parse --verify --quiet refs/remotes/tmp-git-svn-map-branch; then
    git update-ref "$REF" refs/remotes/tmp-git-svn-map-branch
  else
    git update-ref -d "$REF"
  fi

  # Remove all the temporary git-svn settings
  git update-ref -d refs/remotes/tmp-git-svn-map-branch
  git config --remove-section svn-remote.tmp
  rm -rf $GIT_DIR/svn/tmp-git-svn-map-branch
  mv $GIT_DIR/svn/.metadata.bak $GIT_DIR/svn/.metadata
}

# Map all git-svn branches to corresponding new URLs
BASE=$(git config svn-remote.svn.url)
git for-each-ref refs/remotes | cut -d / -f 3- | while read REF; do
  case "$REF" in
  *@*)
    echo "Skipping $REF"
    ;;
  trunk)
    map "refs/remotes/trunk" "$BASE/$NEW/trunk"
    ;;
  tags/*)
    map "refs/remotes/$REF" "$BASE/$NEW/$REF"
    ;;
  *)
    map "refs/remotes/$REF" "$BASE/$NEW/branches/$REF"
    ;;
  esac
done

# Update git-svn configuration to point to the new URLs
for NAME in fetch branches tags; do
  VALUE="$(git config svn-remote.svn.$NAME)"
  git config "svn-remote.svn.$NAME" "${VALUE/#$OLD/$NEW}"
done

# Clean the old git-svn directory, it'll be regenerated on next update
rm -r "$GIT_DIR/svn"

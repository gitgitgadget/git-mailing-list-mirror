From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Reconstructing git-svn metadata after a git clone
Date: Sat, 8 May 2010 17:58:07 +0000
Message-ID: <AANLkTikR5EpZhwFXmRfmE9jSNtiuFoGwTgGbpcwUBxnq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 08 19:58:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAoI6-0002OS-A4
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 19:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab0EHR6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 13:58:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43476 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771Ab0EHR6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 13:58:10 -0400
Received: by gwj19 with SMTP id 19so1250065gwj.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=pja9TDYAcIitwpB4JdsrnNX5lUukEH1pgz3pqkyviws=;
        b=V+n4sdM+slbMoFW0ll2vN0PJc7bT6HflDfAda5vbCzLi1T1GJCOnTemKiV/NK5IREZ
         CFUDDqP6KYjLKjA8Tae9Sdr+kxLKB2xJAxWlstB1Af8lfKeZbTYqFrAqgliPJxWYlcuK
         AQl0r8/pnieE8hBq69dXOSONyyyygv2yDkhuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=u2tUkPBnL0E/3MkhdXkFg4HifzwOtxsYfBF0dS5P4o/q+CqXMdSpVi6PVXuzKJGjpy
         ihhB4voQXPl+Qk/nJ8Aav4jDCa1yd/wEXqDYdhqPGOm0ukQTOVfTRbr4pmYRsMeUk9mg
         QXxNTLWyDeVNrmR23S8swRL1NaoqH0qYCUY0Q=
Received: by 10.231.146.19 with SMTP id f19mr629004ibv.92.1273341489415; Sat, 
	08 May 2010 10:58:09 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Sat, 8 May 2010 10:58:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146669>

I maintain a couple of git-svn exports [1][2] on GitHub. I'd like to
instruct my users on how they should clone those projects and then
commit back to Subversion. But in some cases I can't figure out how to
reconstruct the Subversion metadata.

    1. http://github.com/openstreetmap
    2. http://github.com/mediawiki

The git-svn documentation is lacking here. I'd like to send a patch
for it, but first I have to know what to write. I can add Subversion
metadata to some repositories, but not others.

I can e.g. clone the WebKit repository
(http://trac.webkit.org/wiki/UsingGitWithWebKit#Checkout):

    git clone git://git.webkit.org/WebKit.git WebKit
    cd WebKit
    git svn init -T trunk http://svn.webkit.org/repository/webkit
    git update-ref refs/remotes/trunk origin/master

That works just fine and gives me:

    [...]
    r59025 = 542777d30c645a095d5416a74fdf60b2f3446685
    r59026 = 9afc07910ceabcc065fcd4fcd1c68382955d0d7e
    r59027 = c7c8bfaf28e19eab90f68f53dc7523dd07ef794f
    Done rebuilding
.git/svn/refs/remotes/trunk/.rev_map.268f45cc-cd09-0410-ab3c-d52691b4dbfc

However, when I do that with some other repositories I can't make it
do the right thing:

    # Made with `git svn clone
http://svn.openstreetmap.org/applications/utils/tirex/`
    git clone git://github.com/openstreetmap/tirex.git
    git svn init http://svn.openstreetmap.org/applications/utils/tirex/

So far so good, but this doesn't work:

   git update-ref refs/remotes/trunk origin/master
   # or this
   git update-ref refs/remotes/master origin/master
   # or this
   git update-ref refs/remotes/origin/master origin/master

On git-svn fetch I just get:

    $ git svn fetch
    W: Ignoring error from SVN, path probably does not exist:
(160013): Filesystem has no item:
'/!svn/bc/100/applications/utils/tirex' path not found
    W: Do not be alarmed at the above message git-svn is just
searching aggressively for old history.
    This may take a while on large repositories
    Checked through r14400

Followed by it downloading all the revisions again. I get similar
results with the MediaWiki repository:

    git clone git://github.com/mediawiki/mediawiki-svn.git
    # It was cloned with --stdlayout from this path (well, actually a
mirror, but..)
    git svn init --stdlayout svn+ssh://svn.wikimedia.org/svnroot/mediawiki

The branches look like this:

    $ git branch -l -a | head -n 20
    * trunk
      [...]
      remotes/origin/FundraiserPortal-multi@54613
      remotes/origin/HEAD -> origin/trunk
      remotes/origin/LuceneSearch-ajax
      remotes/origin/MWSearch-2.0@21624
      [...]

Trying to update-ref appropriately:

    for i in $(git branch -l -a|ack '^  remotes/origin/(\S+)$'
--output '$1'); do
        git update-ref "refs/remotes/$i" "origin/$i";
    done

Running a subsequent `git svn fetch` fails:

    Rebuilding .git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
...
    Done rebuilding
.git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
    Rebuilding .git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
...
    Done rebuilding
.git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
    Rebuilding .git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
...
    Done rebuilding
.git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
    Rebuilding .git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
...
    Done rebuilding
.git/svn/refs/remotes/trunk/.rev_map.dd0e9695-b195-4be7-bd10-2dea1a65a6b6
    Index mismatch: fc65f221da86f97a43691fb203aed3da67fb2336 !=
4b825dc642cb6eb9a060e54bf8d69288fbee4904
    rereading d226d034df045bfae1804da6c23f75fc821c4d3f
            D       CommonsBrowser/CommonsBrowser.sln
            D       CommonsBrowser/CommonsBrowser.suo
            D       CommonsBrowser/CommonsBrowser/CommonsBrowser.cspr
            [..tries to delete everything in the repo..]
    W: -empty_dir: trunk/zedler
    a.sql
            D       scavenger/tables_pg.sql
            D       scavenger/
    Last fetched revision of refs/remotes/trunk was r66073, but we are
about to fetch: r1!

However, this evil hack works fine for me:

    # Exactly like before
    git clone git://github.com/mediawiki/mediawiki-svn.git
    cd mediawiki-svn
    git svn init --stdlayout svn+ssh://svn.wikimedia.org/svnroot/mediawiki

    # Download a tarball of the .git/svn content from the original
    # repository:

    cd .git
    wget http://git.anyonecanedit.org/~avar/svn.tar.bz2
    tar xjvf svn.tar.bz2
    cd ..

    # Now git svn fetch works!

    $ git svn fetch
            D       extensions/Storyboard/jquery/jquery.ajaxscroll.min.js
            M       extensions/Storyboard/jquery/jquery.ajaxscroll.js
            M       extensions/Storyboard/README
            M       extensions/Storyboard/tags/Storyboard/storyboard.js
            M       extensions/Storyboard/storyboard.js
            M       extensions/Storyboard/INSTALL
            M       extensions/Storyboard/RELEASE-NOTES
    W: -empty_dir: trunk/extensions/Storyboard/jquery/jquery.ajaxscroll.min.js
    r66071 = f33f81701b06abde87ed11d140cfe3ce4e073bf5 (refs/remotes/trunk)
            M       extensions/Storyboard/Storyboard.i18n.php
            M
extensions/Storyboard/tags/Storysubmission/Storysubmission_body.php
            M       extensions/Storyboard/specials/Story/Story_body.php
            M       extensions/Storyboard/storyboard.js
            M       extensions/Storyboard/Storyboard.php
    r66072 = 954997aef3bbadb4c2a3215e7dd031572a6c3d09 (refs/remotes/trunk)
            M       extensions/SemanticMaps/GeoCoords/SM_GeoCoordsValue.php
            M
extensions/SemanticMaps/GeoCoords/SM_GeoCoordsValueDescription.php
    r66073 = 1902743c893d9107a3fe4e1ce4ed109c4c5ca0de (refs/remotes/trunk)
    $ git svn fetch
    $

So:

 * Am I doing something wrong? If so I can't see what it is.

 * Is there something that works for the general case, i.e. you only
   have to know the original `git svn init` options. If there is I'd
   like to document that & submit a patch.

 * Depending on the above; can git-svn itself be friendlier here?
   Maybe by having a `git svn bootstrap` command. E.g.:

  git clone git://$some_url
  # Does all the work of setting up metadata/refs
  git svn bootstrap --stdlayout $remote_svn_url

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/16] Subtree clone proof of concept
Date: Sat, 31 Jul 2010 23:18:09 +0700
Message-ID: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOQr-0002i5-VJ
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab0HAChj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:37:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab0HAChi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:37:38 -0400
Received: by pzk26 with SMTP id 26so976611pzk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=PNlS5UJYGd93X9bwIBprNo4JYVimWBad32yTVjlgrgk=;
        b=BQT2tU1NKhfpSbvjvdoUCw2xNKvcMaYi51ybBeoauxohwJKzylZ9Aq4IqudF97JU9v
         KABGdSYpFJwE51C9F6bSoMwNU6Zc9JdJ2SOvetx8FokhUAQQ8VcqjjDmoBhrjuP1QoX3
         /waTbsFWaJdaP5BFlCxRiEbKAbmic2jOCVzno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cJcEY+npMhMYOqo5iRHui7TInXWp3ZEnpvxEdg7sCCyR/QIODvEOBHP30aHsaPA/Aw
         TOg7U7Wlv6asCYElg+fgF+RltS1re+FdZ70wgjBjUcHN7bzyveDTfgytA16Dz1fHWBEC
         VAeA9tcXeTn6M6Bfh5DuqhxYA1qCB5HsB1Crw=
Received: by 10.115.107.7 with SMTP id j7mr4834039wam.107.1280630258430;
        Sat, 31 Jul 2010 19:37:38 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id g4sm7700581wae.14.2010.07.31.19.37.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:37:37 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:18:28 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152347>

Something to play with so we can evaluate which is the best strategy
for non-full clone (or whatever you call it).

The idea is the same: pack only enough to access a subtree, rewrite
commits at client side, rewrite again when pushing. However I put
git-replace into the mix, so at least commit SHA-1 looks as same as fro=
m
upstream. git-subtree is not needed (although it's still an option)

With this, I can clone Documentaion/ from git.git, update and push. I
haven't tested it further. Space consumption is 24MB (58MB for full
repo).  Not really impressive, but if one truely cares about disk
space, he/she should also use shallow clone.

Performance is impacted, due to bulk commit replacement. There is a
split second delay for every command. It's the price of replacing 24k
commits every time. I think the delay could be improved a little bit
(caching or mmap..)

Rewriting commits at clone takes time too. Doing individual object
writing takes lots of space and time. I put all new objects directly
to a pack now. Rewriting time now becomes quite acceptable (a few
seconds). Although deep subtree/repo may take longer. Rewriting on
demand can be considered in such cases.

Repo-care commands like fsck, repack, gc are left out for now.

=46inally, it's more of a hack just to see how far I can go. It will
break things.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (16):
  Add core.subtree
  list-objects: limit traversing within the given subtree if
    core.subtree is set
  parse_object: keep sha1 even when parsing replaced one
  Allow to invalidate a commit in in-memory object store
  Hook up replace-object to allow bulk commit replacement
  upload-pack: use a separate variable to control whether internal
    rev-list is used
  upload-pack: support subtree pack
  fetch-pack: support --subtree
  subtree: rewrite incoming commits
  clone: support subtree clone with parameter --subtree
  pack-objects: add --subtree (for pushing)
  subtree: rewriting outgoing commits
  Update commit_tree() interface to take base tree too
  commit_tree(): rewriting/replacing new commits
  commit: rewrite outgoing commits
  do not use thin packs and subtree together (just a bad feeling about
    this)

 Makefile               |    2 +
 builtin/clone.c        |   10 +
 builtin/commit-tree.c  |    2 +-
 builtin/commit.c       |    4 +-
 builtin/fetch-pack.c   |    8 +
 builtin/merge.c        |    4 +-
 builtin/notes.c        |    2 +-
 builtin/pack-objects.c |    4 +
 builtin/send-pack.c    |    2 +
 cache.h                |    1 +
 commit.c               |   25 +++-
 commit.h               |    4 +-
 config.c               |    3 +
 environment.c          |    2 +
 list-objects.c         |   23 ++-
 notes-cache.c          |    2 +-
 object.c               |    2 +-
 replace_object.c       |    5 +
 subtree.c              |  534 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 subtree.h              |    4 +
 upload-pack.c          |   28 ++-
 21 files changed, 651 insertions(+), 20 deletions(-)
 create mode 100644 subtree.c
 create mode 100644 subtree.h

From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Cumulative "git read-tree -m" rejected with overwriting warning
Date: Wed, 13 Feb 2013 23:02:13 +0000
Message-ID: <20130213230213.GT20333@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 00:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5lLp-0002zp-V3
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 00:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005Ab3BMXCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 18:02:30 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40250 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3BMXC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 18:02:29 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so6358890wib.6
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 15:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent:x-gm-message-state;
        bh=CYIxARVg/JHcDoJnZrK39AddmaAcZ89/l56x5/pcIgM=;
        b=QqgtuZh4YOgTcasLi0gRwC8G0DFG7y41hhczHLOVecqYM+HYNx25KM37HSfsZizBNE
         FEENiVPdstXboWV0WS5SQ3YC5p+LzDDmL311kM/uExlDOKu1ygMpVyBDv67CTMJcKb0H
         5+lBG3Rd7g8lEZ7mvdWGgv6nXAHrQLb5dI0Q5DZ8L2ftUoCKn4D+BVPpetvoAg6pczRN
         E7PMz8OsG4rLY7nTH6Qj8v/HTg0b8kMBsfCP2kB2KqFkd2mu1PVcyT5fjSk5kFqwJ7YX
         BBq/0zHoCv2Jv5aB3+IFE8+qyRroqdVpOA4DIRcObIezaLMbdJ4ZkSqa1CFo873E6SH3
         Q3bA==
X-Received: by 10.180.14.233 with SMTP id s9mr12574194wic.25.1360796537743;
        Wed, 13 Feb 2013 15:02:17 -0800 (PST)
Received: from beczulka ([89.100.125.149])
        by mx.google.com with ESMTPS id hb9sm45287104wib.3.2013.02.13.15.02.14
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 15:02:15 -0800 (PST)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1U5lLB-0002y0-JO
	for git@vger.kernel.org; Wed, 13 Feb 2013 23:02:13 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQmUCB0a4wv4CRm/7E/I5A1nww2eFJkmKiF0BQtTRZ+/AgaqeQjPQoFGfXugw9nNoJL0WD0O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216292>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Consider the following use case:

  git init
  seq 0 9 > f
  git add f
  git commit -m start
  
  git checkout -b b1
  perl -pi -e 's,0,b1,' f
  git commit -a -m b1
  
  git checkout -b b2
  perl -pi -e 's,9,b2,' f
  git commit -a -m b2
  
  git checkout master
  git merge b1 b1

As the changes to "f" don't conflict, the octopus merge deals with them
just fine, and I get a merge in a single commit object.


Now, let's say my b1 and b2 branches are a bit more special, and apart
from the main contents (i.e. the "f" file), each branch contains a
couple of files with branch-specific metadata. The names of those files
are the same in each branch.  (People familiar with topgit can probably
guess I'm talking about topgit branches here.)

I'd like to merge all such branches into "master" in one octopus-like
commit, but the metadata files introduce a conflict during simple
octopus merge.  However I don't care about that metadata when the
branches are merged into "master", so I'm trying to write a script which
would do such merge while discarding the metadata files.

The problem is, I cannot get it to work, when two branches modify the
same file (like "f" above), even if the changes don't conflict. I get
either:

error: Entry 'f' would be overwritten by merge. Cannot merge.
 - when trying to use the two-arg form of "git read-tree -m -i"

or:
f: needs merge
 - when trying to use the three-arg form

Attached is the minimal test case that reproduces the problem.

It might just be that git-read-tree cannot do what I need, and I'm just
misinterpreting the meaning of:

 "the index file saves and restores with all this information, so you
 can merge things incrementally,"

which I took to mean that I can read from multiple trees one by one
before writing the tree.

Could anyone give me some hints?

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown

--wRRV7LY7NUeQGEoC
Content-Type: application/x-sh
Content-Disposition: attachment; filename="testcase.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0Aset -e=0Aset -x=0A=0A# =0A# Prep=0A#=0A=0A# Create repo with =
one file=0Arm -rf repo=0Amkdir repo=0Acd repo=0Aseq 0 9 > f=0Agit init .=0A=
git add f=0Agit commit -m start=0A=0Afunction create_special_branch()=0A{=
=0A	name=3D"$1"=0A	substexpr=3D"$2"=0A=0A	# Create=0A	git checkout -b $name=
 master=0A=0A	# Tweak the main file	=0A	perl -pi -e "$substexpr" f=0A=0A	# =
Add something to the metadata file=0A	echo metadata-for-$name > m=0A	git ad=
d m=0A=0A	git commit -a -m $name=0A}=0A=0A# Create a couple of branches, ea=
ch changes file "f" in a different way that=0A# don't conflict, and changes=
 file "m" in a way that WOULD conflict (but we discard it later).=0Acreate_=
special_branch b1 's,0,0 - b1,'=0Acreate_special_branch b2 's,9,9 - b2,'=0A=
=0A# Change the master too.=0Agit checkout master=0Aperl -pi -e 's,5,5-mast=
er,' f=0Agit commit -a -m master=0A=0A#=0A# Now do the merging=0A#=0A=0A# M=
ake sure nothing is lying around, as we do a reset --hard at the end.=0Ates=
t -z "$(git status --porcelain)" =0A=0Afor b in b1 b2=0Ado=0A        common=
=3D$(git merge-base HEAD $b)=0A# First approach=0A        git read-tree -m =
-i $common $b=0A# Second approach=0A#        git read-tree -m -i $common HE=
AD $b=0A=0A	# Discard the metadata file=0A        git reset -q HEAD m=0A   =
     rm -f m=0Adone=0A=0A# Write the tree=0Atree=3D$($debug git write-tree)=
=0A=0A# Commit it as a merge of the two branches=0Acommit=3D$(echo "Merged =
branches b1 and b2." | git commit-tree $tree -p b1 -p b2)=0A=0A# Point the =
current branch at that commit=0Agit reset --hard $commit=0A=0Agitk --all=0A
--wRRV7LY7NUeQGEoC--

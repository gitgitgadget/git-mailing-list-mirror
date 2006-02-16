From: Ron Parker <rdparker@gmail.com>
Subject: Genealogical branches
Date: Wed, 15 Feb 2006 20:20:29 -0600
Message-ID: <1cf1c57a0602151820p32240818j897aed0a527e6175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11038_6732132.1140056429879"
X-From: git-owner@vger.kernel.org Thu Feb 16 03:20:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Yl4-0008S6-31
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 03:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWBPCUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 21:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWBPCUb
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 21:20:31 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:54004 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750886AbWBPCUb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 21:20:31 -0500
Received: by xproxy.gmail.com with SMTP id h28so39186wxd
        for <git@vger.kernel.org>; Wed, 15 Feb 2006 18:20:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=D6IiOFufOFVk4AKdSPhpdIDvcQbSBu/68AiiyDI+HCvBaRXaqUUCIEdMpKTum4Rf1Z8uuavdqt3U7bn1FL4EcClth4+o4fwh06l0JEJXw5y+Pn/UkP24BJgc16LaTwOpoDqSqi8aSYq7wk3r9LdEgEBrCC1LHFDbg6w+2iFDOzM=
Received: by 10.70.79.12 with SMTP id c12mr410386wxb;
        Wed, 15 Feb 2006 18:20:30 -0800 (PST)
Received: by 10.70.82.16 with HTTP; Wed, 15 Feb 2006 18:20:29 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16261>

------=_Part_11038_6732132.1140056429879
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am working on a stepped tutorial that walks the user through the
development of a number of related files. I have been trying to keep
this under various SCMs. Currently git seems like the best match. But
I have some questions.

The issue is that I want to have a directory which will ultimately
contain selected portions of the final products genealogy in addition
to other files. For example:

        README
        ...
        test1
        test2
        test3a
        test3b
        ...

And each step is developed from the preceding one. However, not being
perfect, there have been occasions where I have found mistakes in an
earlier step that need to be corrected and propagated to the later
steps.

I have found a work flow that seems to do what I want, but there may
be a better way to do this and I would like some advice. I initialize
the DB and work on test1, that is then branched to step2 where test1
is first renamed and then modified to become test2.

At this point I create a "final" branch and through some shenanigans I
don't completely understand, I pull from master and B2 to get both
step1 and step2 into final with their full history. Then as changes
are made to step1 I can pull those into later steps. Another tricky
part is that when I get to final, I have to pull from all of the
ancestral branches simultaneously.

Anyway, here is an annotated script that illustrates this, it is also
attached without the extra commentary:

--- BEGIN GENETEST.SH ---
mkdir genetest
cd genetest
git init-db
cat - >test1 <<EOF
aaaaaaaa
BBBBBBBB
cccccccc
EOF
echo README>README
git add .
git commit -a -m "Initial checkin"

# Create step2 branch
git checkout -b step2
git mv test1 test2
git commit -a -m "Created step2"
echo dddddddd>>test2
echo "README 2">README
git commit -a -m "Added step2 changes"

# Create conglomerate branch
git checkout master
git checkout -b final

# This is where the shenanigans come in. I'm not even completely sure
#  why it works. But arrived at the first two commands through
# experimentation. I thought one or the other would suffice, but
# neither alone did.  The two together, however, bring this basically
# up to step2 status with test1 being deleted and a step2->step2
# merge indicated in the log.
git fetch -a . step2
git pull -a . step2

# So then this finds the deleted file and brings it back in from master.
FILES=3D$(git-diff-index --name-only --diff-filter=3DD master)
git add $FILES

git commit -a -m "Created final"

# Now let's go modify master and see whether or not changes
# propagate forward to both files in final.
git checkout master
cat - >test1 <<EOF
aaaaaaaa
bbbbbbbb
cccccccc
EOF
git commit -a -m "Fixed the B... line"

# Pull the changes into step2 and resolve the conflict from the
# too-close-together line changes.
git checkout step2
git pull . master || true
mv -f test1 test2
echo dddddddd>>test2
MSG=3D$(cat .git/MERGE_MSG)
git commit -a -m "$MSG"

# Now check that all changes come through successfully,
# the interesting thing is that all the "ancestor" branches
# MUST be pulled at together or things don't work.
git checkout final
git pull . master step2

# Check that README matches the one from step2
# and that the B... line has been corrected in both
# versions of the ancestor file.
cat README
cat test1
cat test2

# If we've gotten this far, say so.
echo SUCCEEDED
--- END GENETEST.SH ---

So can anyone explain why the mystery portions "work" and why I have
to pull from all the ancestral branches simultaneously?

Also, if you have a better solution or work flow I'm open to it.

Thanks,

--
Ron Parker

------=_Part_11038_6732132.1140056429879
Content-Type: application/x-sh; name=genetest.sh
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejqfvq07
Content-Disposition: attachment; filename="genetest.sh"

set -x
set -e
mkdir genetest
cd genetest
git init-db
cat - >test1 <<EOF
aaaaaaaa
BBBBBBBB
cccccccc
EOF
echo README>README
git add .
git commit -a -m "Initial checkin"

# Create step2 branch
git checkout -b step2
git mv test1 test2
git commit -a -m "Created step2"
echo dddddddd>>test2
echo "README 2">README
git commit -a -m "Added step2 changes"
git checkout master

# Create conglomerate branch
git checkout -b final

### HERE'S THE IMPORTANT SEQUENCE
# The fetch/pull sequence with the -a args makes certain that the original
# files from the branch above are left intact.  Then the diff index picks up
# those filse that have been "deleted" because of a rename, and they are added
# back.
git fetch -a . step2
git pull -a . step2
FILES=$(git-diff-index --name-only --diff-filter=D master)
git add $FILES
git commit -a -m "Created final"

git checkout master
cat - >test1 <<EOF
aaaaaaaa
bbbbbbbb
cccccccc
EOF
git commit -a -m "Fixed the B... line"
git checkout step2
git pull . master || true
mv -f test1 test2
echo dddddddd>>test2
MSG=$(cat .git/MERGE_MSG)
git commit -a -m "$MSG"

# Now check that all changes come through successfully, the interesting thing is that all the "parent" branches MUST be pulled at once.
git checkout final
git pull . master step2
cat README
cat test1
cat test2
echo SUCCEEDED




------=_Part_11038_6732132.1140056429879--

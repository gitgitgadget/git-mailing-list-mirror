From: Ben Armstrong <BArmstrong@dymaxion.ca>
Subject: jgit standalone client on OpenVMS works (somewhat)
Date: Thu, 30 Apr 2009 12:39:36 -0300
Message-ID: <3f1ae6620904300839n48e88143y2ae1694472f712a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 17:40:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzYMr-0003c5-Ug
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 17:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761219AbZD3Pjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757807AbZD3Pjj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 11:39:39 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:48339 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbZD3Pjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 11:39:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so930819fkq.5
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ceesc1gBWwLZU7KN/JevReatbnEVgWqGGpl82f5eL5o=;
        b=mx5F8g7TPe+Nh3RMgZM1dUPjrP2E/aYdAGTm6U/3b5W3d8If1D4Y6dvDvvFFcECuzI
         WvXDoA2hojD6rwbzFwrBG6m1k1ccAvAcwpc22Mi33ldydhgHuIaur1LOCANePn1qUI+6
         B0l02qQFqe1O0Tq5tUrUyhmSPrj8NP/bZSeJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=XV4uRwcbegQR6Jel5A1Mr56oGHY/NJnGf4emtIVsHDRnfklzpO/TmzgXucNXSzZe7S
         mCd575Kur7gTyu5qfv1aUL7xB5cGyLuNDVP3IntwJJy+Y/gSdP71O5ZNT86Jya5NyVPO
         CMFLVPKk2iT6YeoPtXNCm7iE7lmPd2DhRN4E0=
Received: by 10.204.62.68 with SMTP id w4mr1579157bkh.93.1241105976092; Thu, 
	30 Apr 2009 08:39:36 -0700 (PDT)
X-Google-Sender-Auth: ea2f081a8916084e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118027>

I am happy to report that the jgit standalone client works (somewhat) on
OpenVMS/Alpha, a non-POSIX platform for which no C git port exists.  I
understand that not all functionality of the C client is supported yet, but
for limited use, and supplemented by using the C client on a PC, I may be
able to get away with this.  At least being able to do a 'git clone' is
encouraging.

The only problem I have found so far is that if a tag has dots in it and the
last dotted expression looks like a VMS file version number, it is
interpreted as such instead of part of the filepath used to represent it
under .git/refs/tags

I am using:
- egit v0.4.0.329.g06fc
- OpenVMS/Alpha V8.3
- Java 1.5.0-5

For the curious, this is what I have done so far to attempt to make
jgit work on VMS.

1. On a Linux host, checkout egit and build the standalone jgit wrapper:

git clone git://repo.or.cz/egit.git
cd egit
./make_jgit.sh

2. Copy the resulting 'jgit' script to VMS (samba S: is mapped to the VMS
    device DSA0:):

mkdir /s/dymax/jgit/
cp jgit /s/dymax/jgit/

3. On VMS, set up the jgit command environment appropriately:

$ define jgit_home dsa0:[dymax.jgit]
$ jgit==java+" -cp /jgit_home/jgit ""org.spearce.jgit.pgm.Main"""
$ git=="pipe define/user JAVA$FILENAME_CONTROLS 8 ; "+-
   "define/user DECC$ARGV_PARSE_STYLE ENABLE ; "+-
   "define/user DECC$EFS_CASE_PRESERVE ENABLE ; "+-
   "define/user DECC$EFS_CHARSET ENABLE ; jgit"

4. Set up a place to create workspaces with expected filesystem
    semantics on an ODS-5 volume (only allow one version of each file
    and allow read-only files to be renamed by all members of the [DV,*]
    security group, of which I am a member, otherwise git clone will fail):

$ set def [bg]
$ create/dir [.work]
$ set directory/ver=1 [.work]
$ set security/acl=(IDENTIFIER=[DV,*],OPTIONS=DEFAULT, -
   ACCESS=READ+WRITE+EXECUTE+DELETE) work.dir

5. change to the directory and perform a clone::

$ set def [bg.work]
$ git clone git://repo.or.cz/egit.git
Initialized empty Git repository in /DSA0/BG/WORK/egit/.git
Receiving objects:      100% (20983/20983)
Resolving deltas:       100% (11562/11562)
From git://repo.or.cz/egit.git
 * [new branch]      master     -> origin/master
 * [new branch]      stable     -> origin/stable
 * [new tag]         v0.1.1     -> v0.1.1
 * [new tag]         v0.2       -> v0.2
 ! [rejected]        v0.2.1     -> v0.2.1
 * [new tag]         v0.2.2     -> v0.2.2
 * [new tag]         v0.2.99.200709172321 -> v0.2.99.200709172321
 * [new tag]         v0.3.0     -> v0.3.0
 ! [rejected]        v0.3.1     -> v0.3.1
 * [new tag]         v0.4.0     -> v0.4.0

That doesn't look very nice ... see more notes on this below (step 7).

6. verify some things work:

$ git version
jgit version v0.4.0.329.g06fc
$ git branch
* master
  master.
$ git log -- .gitattributes
commit d4e240ab52a95dc22ae5abffdc6254b723285696
Author: Shawn O. Pearce <spearce@spearce.org>
Date:   Fri Aug 15 09:36:06 2008 -0600

    Enable diff=java for all *.java source files

    This (usually) gets more reasonable function headers to
    appear in the header line for a diff hunk.  Its slightly
    better than the default C rules.

    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
$ dir [.^.git]

Directory DSA0:[BG.WORK.egit.^.git]

branches.DIR;1      config.;3           FETCH_HEAD.;1       HEAD.;2
index.;1            logs.DIR;1          objects.DIR;1       refs.DIR;1
remotes.DIR;1
$ dir

Directory DSA0:[BG.WORK.egit]

^.git.DIR;1         .gitattributes;1    .gitignore;1        EGIT_INSTALL.;1
jgit-maven.DIR;1    jgit.sh;1           make_jgit.sh;1
org^.spearce^.egit-feature.DIR;1
org^.spearce^.egit-updatesite.DIR;1     org^.spearce^.egit^.core.DIR;1
org^.spearce^.egit^.core^.test.DIR;1    org^.spearce^.egit.DIR;1
org^.spearce^.egit^.ui.DIR;1            org^.spearce^.jgit.DIR;1
org^.spearce^.jgit^.pgm.DIR;1           org^.spearce^.jgit^.test.DIR;1
README.;1           SUBMITTING_PATCHES.;1                   tag_egit.sh;1
TODO.;1
$ type .gitignore
/jgit
/jgit.jar
/jgit_src.zip

7. see if we can sort out the tags issue:

$ git fetch -v
fatal: /DSA0/bg/work/egit/./.git/logs/refs/tags/v0.2.1 (i/o error)
fatal: Failure updating tracking ref refs/tags/v0.2.1:
/DSA0/bg/work/egit/./.git/logs/refs/tags/v0.2.1 (i/o error)
$ dir [.^.git.refs.tags]

Directory DSA0:[BG.WORK.egit.^.git.refs.tags]

v0.1;1              v0.2;2              v0^.2^.99.200709172321;1
v0.3;1              v0.4;1

Whoops, v.0.2.1 is missing.  And v0.2;2 looks suspicious.

$ git tag mytag
$ dir [.^.git.refs.tags]

Directory DSA0:[BG.WORK.egit.^.git.refs.tags]

mytag.;1            v0.1;1              v0.2;2
v0^.2^.99.200709172321;1
v0.3;1              v0.4;1

Looks good.

$ git tag mytag.1.2
$ dir [.^.git.refs.tags]

Directory DSA0:[BG.WORK.egit.^.git.refs.tags]

mytag.;1            mytag.1;2           v0.1;1              v0.2;2
v0^.2^.99.200709172321;1                v0.3;1              v0.4;1

Total of 7 files.

Herein lies the problem.  Apparently "mytag.1.2" is interpreted as
the filepath mytag.1 revsion ;2

This is trivially reproduced using the native DCL "create" command:

$ create 1.2.3
test
^Z
$ dir 1.2
Directory DSA0:[BG.WORK.egit]

1.2;3

Total of 1 file.

If I explicitly quote all dots but the last, it works:

$ create 1^.2.3
test
^Z
$ dir 1^.2.3

Directory DSA0:[BG.WORK.egit]

1^.2.3;1

$ HELP EXT_FILE_SPECS Using File_Specification_Differences
ODS-5_Syntax Interpretation_of_Period
...
             The introduction of the period (.) as a literal character in
             extended file names requires RMS to determine which periods are
             file name characters and which are delimiters.

             When only one period (.) is used in an extended file name, that
             period is interpreted as the delimiter, as in "Venice.Venezia;1"
             above. As in previous versions of OpenVMS, this behavior also
             occurs if the single period is followed by a number:

             $ CREATE Test.1

             creates the file:

             Test.1;1

             When there are multiple periods (.) in a file name, the system
             looks at all the characters after the last period. If those
             characters are five or fewer digits, or a minus sign (-) followed
             by five or fewer digits, the period is interpreted as a version
             delimiter and the period previous to it is a type delimiter.
             Notice that a legal version is less than or equal to 32767.
             If you try to create the file "grandioso.x.33333", the "33333"
             causes an illegal version error. If there is a nonnumeric
             character following the last period then it is interpreted as
             a type delimiter.
...

Uggh.  I don't know if I'm going to be able to solve this one.
I guess I just have to avoid multiple periods in tags.

Ben

From: Eric Montellese <emontellese@gmail.com>
Subject: Fwd: Git and Large Binaries: A Proposed Solution
Date: Fri, 21 Jan 2011 13:57:21 -0500
Message-ID: <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 21 19:57:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgMBC-0000Jm-HM
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 19:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab1AUS5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 13:57:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62387 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab1AUS5o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jan 2011 13:57:44 -0500
Received: by bwz15 with SMTP id 15so1871586bwz.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 10:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=VUmZYCKj9WXI7AA+gxkhPLV7hEdLJ8/AdNEjTApB4BU=;
        b=T4UsajgZUqa2nxZV483nVeW/rcoylJxUCWAuNnglMWoBM8DPL87YB9CcyOXoGgCLIt
         5BRmo2lw6qlOLIBEhpSr0bkdcmFqU6xYtexv3oahYM04HClHTSGsFTzGlMzCGQbJsio0
         6Uh6qCtRcHoqmzvTk4LfaIXm4XDs83Orq2JXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=RV65ctCBCZLP0E6WcGjxv3N4koGavTrSxUR/gr1iXqSD64jL1Tr60kVJEAbNbysHmv
         ojp8RzYDZeosAC1EHaOBIGrQQWaLi4QUNLyHGmwPfYweOVQidI8AANJtI9dqQ/d4nkEe
         z7YHZWOmKoolrmDO192KfIwvwkIRh2a6JNdCY=
Received: by 10.204.70.137 with SMTP id d9mr1052537bkj.141.1295636262013; Fri,
 21 Jan 2011 10:57:42 -0800 (PST)
Received: by 10.204.60.11 with HTTP; Fri, 21 Jan 2011 10:57:21 -0800 (PST)
In-Reply-To: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165389>

I did a search for this issue before posting, but if I am touching on
an old topic that already has a solution in progress, I apologize. =A0A=
s
far as I know, this is still an open issue (last i saw in the
kernel-trap archives was a "git and binary files" thread from Jan
2008, and there are a couple of promising related works (git annex and
git bigfiles) -- but nothing that solves the complete problem).

I'm interested in hearing your thoughts and suggestions, and
interested if there is community interest in adding this feature to
git. =A0I would be happy to be involved in making the changes, but I
have very limited time, so would prefer help and would like to know
that it has a strong chance of joining the main line before
starting...
To whet your appetite to read all of the below (I know it's long),
this is the root of the solution:

---=A0=A0 =A0 =A0 Don't track binaries in git. =A0Track their hashes.  =
     ---


Problem Background:
I work on embedded system software, with code for these products
delivered from multiple customers and in multiple formats, for
example:

1. source code -- works great and is what git is designed for
2. zipped tarballs of source code (that I will never need to modify)
-- I could unpack these and then use git to track the source code.
However, I prefer to track these deliverables as the tarballs
themselves because it makes my customer happier to see the exact
tarball that they delivered being used when I repackage updates.
(Let's not discuss problems with this model - I understand that this
is non-ideal).
3. large and/or many binaries. =A0(could be pictures, short videos,
pre-compiled binaries, etc)

The problem of course is that, as you know, git is not ideal for
handling large, or many, binaries. =A0It's better at just about
everything else, of course, but not this, for largely these two
reasons:

1. git cannot diff the binaries to their previous iterations
effectively to save space. =A0(and neither can any tool)
2. git requires that all clones of that repository must therefore
download all versions of all binaries -- which, if the binaries are
large, or many, and are poorly compressed together (as stated in 1),
this will be a very expensive operation.


Problem Statement:
We (the git user) want and "need" to be able to track large binaries
from within our repository. =A0But putting them into git slows down git
unnecessarily.
The only current alternative is to *not* check the large binaries into
git -- but now they are no longer tracked, which is unacceptable. =A0If
I want to jump back in git to a point in the tree from 6 months ago, I
do not have any way to tell which version of the large binaries I
need. =A0I could keep track of this manually, of course, but that's wha=
t
git is for...


Solution:
The short version:
***Don't track binaries in git. =A0Track their hashes.***

Solution:
The long version:
=46or my current project, I have this (the "store the hashes" idea)
implemented outside of git. =A0I am posting to this list because I woul=
d
like to see this functionality (well, something even better) become
native to git, and believe that it would remove one of the few
remaining arguments that some projects have against adopting git.
Here is how I have it implemented:

=46irst the layout:
my_git_project/binrepo/
-- binaries/
-- hashes/
-- symlink_to_hashes_file
-- symlink_to_another_hashes_file
within the "binrepo" (binary repository) there is a subdirectory for
binaries, and a subdirectory for hashes. =A0In the root of the 'binrepo=
'
all of the files stored have a symlink to the current version of the
hash.
The "binaries" directory is .gitignore'd -- the hashes directory and
the symlinks to the current hashes are maintained by git.
Whenever I receive a new version of a large binary file from a
customer, I put it into "binaries" and I create a new hash for that
file in "hashes" and update the symlink to point to that hash. =A0I 'gi=
t
commit' and 'git push' those changes (this is fast since there is no
large binary in the git repository).
The other important factor is that I must put this large binary file
somewhere accessible for others to download it. =A0In this example, it
is: =A0my_git_server.net:/binrepo/

Then I have a bash script (some psuedocode here to save space):

for (all BINFILE in binrepo) ; do
=A0=A0HASHFILE=3D$BINFILE".md5"
=A0=A0# check if the binary exists
=A0=A0if [[ -e binaries/$BINFILE ]] ; then
=A0=A0 =A0echo " =A0$BINFILE available"
=A0=A0else
=A0=A0 =A0echo " =A0$BINFILE not available. Downloading..."
=A0=A0 =A0wget http://my_git_server.net:/binrepo/$BINFILE
=A0=A0fi
=A0=A0# check md5sum
=A0=A0md5sum $BINFILE > temp.md5
=A0=A0if ! diff -q ../hashes/$HASHFILE temp.md5 >/dev/null ; then
=A0=A0 =A0echo "ERROR! $BINFILE md5 does not match!"
=A0=A0 =A0exit and/or redownload
=A0=A0fi
done

This confirms that I have the right version of all of the binaries --
my git repository is effectively tracking the large binaries, but
without actually storing them internally to the git repo. =A0If someone
else updates the "binrepo" I will know it when I do a "git pull" and I
will automatically get the right version of the binary file so that my
sandbox is up-to-date. =A0Now let's say I want to revert the version of
the large binary file to the previous version -- all I need to do is
to to edit the symlink in "binrepo", commit, and push. =A0Other users
will automatically use the old version of the file as well after they
do their pull (and without needing to re-download that file)


Summary of Big Advantages:

1. Repository is unpolluted by large binary files. =A0git clone stays f=
ast.
2. User has access to any version of any binary file, but does not
need to store every version locally if they do not want to.
3. Git does not need to worry about the big binaries - there are no
slow attempts to calculate binary deltas or pack and unpack under the
hood.


Improvements:

I imagine these features (among others):

1. In my current setup, each large binary file has a different name (a
revision number). =A0This could be easily solved, however, by generatin=
g
unique names under the hood and tracking this within git.
2. A lot of the steps in my current setup are manual. =A0When I want to
add a new binary file, I need to manually create the hash and manually
upload the binary to the joint server. =A0If done within git, this woul=
d
be automatic.
3. In my setup, all of the binary files are in a single "binrepo"
directory. =A0If done from within git, we would need a non-kludgey way
to allow large binaries to exist anywhere within the git tree. =A0If gi=
t
handles the "binrepo" under the hood though, the user would never need
to know about it -- instead git would just handle all binaries by
checking the internal "binrepo" =A0Instead of tracking symlinks, git
would track the file versions in the normal way -- it just wouldn't
store the binaries the same way (instead it would store the hash)
4. User option to download all versions of all binaries, or only the
version necessary for the position on the current branch. =A0If you wan=
t
to be able to run all versions of the repository when offline, you can
download all versions of all binaries. =A0If you don't need to do this,
you can just download the versions you need.  Or perhaps have the
option to download all binaries smaller than X-bytes, but skip the big
ones.
5. Command to purge all binaries in your "binrepo" that are not needed
for the current revision (if you're running out of disk space
locally).
6. Automatically upload new versions of files to the "binrepo" (rather
than needing to do this manually)


Rock on!
Eric

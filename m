From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: cvs2svn conversion directly to git ready for experimentation
Date: Wed, 01 Aug 2007 02:09:34 +0200
Message-ID: <46AFCF3E.5010805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: users@cvs2svn.tigris.org
To: git@vger.kernel.org
X-From: users-return-1599-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Wed Aug 01 02:09:42 2007
Return-path: <users-return-1599-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IG1mY-0000QI-7v
	for gcvscu-users@gmane.org; Wed, 01 Aug 2007 02:09:42 +0200
Received: (qmail 8230 invoked by uid 5000); 1 Aug 2007 00:09:39 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 8216 invoked from network); 1 Aug 2007 00:09:39 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAL5rr0bAbSoIgmdsb2JhbACOGQEBCQoHCA
X-IronPort-AV: i="4.19,205,1183359600"; 
   d="scan'208"; a="63317312:sNHT35795599"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54381>

I am the maintainer of cvs2svn[1], which is a program for one-time
conversions from CVS to Subversion.  cvs2svn is very robust against the
many peculiarities of CVS and can convert just about every CVS
repository we have ever seen.

I've been working on a cvs2svn output pass that writes the converted CVS
repository directly into git rather than Subversion.  The code runs now
with at least one repository from our test suite of nasty CVS repositories.

Unfortunately, I am a complete git newbie, so I would very much
appreciate help from the git community with feedback and checking
whether the conversion output is reasonable and gitlike.

The git output is very preliminary and virtually untested, and has the
following limitations (hopefully to be removed in the near future):

- It is rather slow.  Among other things, it still uses RCS or CVS to
extract the contents of the CVS revisions, which will soon be changed to
win a factor of 2 or so.

- CVS allows a branch to be created from arbitrary combinations of
source revisions and/or source branches.  cvs2svn tries to create a
branch from a single source, but if it can't figure out how to, it
creates the branch using "merge" from multiple sources.  In pathological
situations, the number of merge sources for a branch can be arbitrarily
large.

- It is not very intelligent about creating tags.  When asked to create
a tag, it unconditionally creates a "tag fixup branch"[2] with the same
name and contents as the tag, then tags this branch.  The tag fixup
branch is never deleted.

- There are no checks that CVS branch and tag names are legal git names,
or indeed that any other similar limitations of git are honored.

- The data that should be fed to git-fast-input is written to two files,
which have to be loaded into git-fast-import manually.  Eventually I
will add an option to invoke git-fast-import automatically and pipe the
output directly into git-fast-import.

- Only single projects can be converted at a time.  I don't think that
this will be a significant limitation when outputting to git.


To try it out:

1. Install svn (to be able to check out cvs2svn) and either cvs or rcs.

2. Check out the current trunk version of cvs2svn:

    svn co http://cvs2svn.tigris.org/svn/cvs2svn/trunk cvs2svn-trunk
    cd cvs2svn-trunk
    make check # ...optional

3. Configure cvs2svn for your conversion.  This has to be done via the
"options-file method"[3].  See cvs2svn-example.options and
test-data/main-cvsrepos/cvs2svn-git.options as examples; the former file
includes voluminous documentation.

4. Run cvs2svn.  This outputs two git-fast-import files, with the names
specified by your options file.  In the example, these files are named
'cvs2svn-tmp/git-blob.dat' and 'cvs2svn-tmp/git-dump.dat'.

5. Initialize a git repository, and load the dump files using
git-fast-import:

    git-init
    cat cvs2svn-tmp/git-blob.dat | \
        git-fast-import --export-marks=cvs2svn-tmp/git-marks.dat
    cat cvs2svn-tmp/git-dump.dat | \
        git-fast-import --import-marks=cvs2svn-tmp/git-marks.dat


I am looking forward to your feedback.  Even better would be if somebody
wants to join forces on this project.  I would be happy to supply the
cvs2svn knowledge if you can bring the git experience.

Michael


[1] http://cvs2svn.tigris.org/
[2] http://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html
[3] http://cvs2svn.tigris.org/cvs2svn.html#cmd-vs-options

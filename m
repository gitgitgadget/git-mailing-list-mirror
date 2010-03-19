From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: native-git-svn: A Summer of Code 2010 proposal
Date: Fri, 19 Mar 2010 22:48:27 +0530
Message-ID: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 18:25:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsfxL-0007qS-ED
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab0CSRZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 13:25:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54263 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0CSRZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 13:25:44 -0400
Received: by gwaa12 with SMTP id a12so1450422gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=Db1BZNeKXDTZJDuobI7F0hfY5B/HqBW1oVBYXBWpVOM=;
        b=l90jWK1kP2eNbNTffi9v2sd0QALuVvbhonXzByHRJXRHiK3BfmAaycfwA50A9fyCjs
         Q4ao4xDUJw3OHvj2sTHW6zVkVzYieHYGzrQ9h+YoL2fIEbVCwa2wK0pdjDpXcZbmzgN8
         tXu1sFBNCx6Yq8izmTiT9BG9yqOA/mBqQcqvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=XJzmcfu64b6zOLPpqwRzErY+1s17cMtDAU+SdKsf3EarZpnfOpAp0JA1zvSaGNtZgg
         FPKdjY6lf6OmYg9y9LxEM3LjMKHPBFsE9jXq//Mts845ps2TBuvPjOn0oU6Y/MUXGmcr
         r8rFiMywU+2eMSBVY3mYooPUECPs02FsxR+MI=
Received: by 10.90.108.6 with SMTP id g6mr769458agc.100.1269019127968; Fri, 19 
	Mar 2010 10:18:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142623>

Hi,

I picked up a project I liked from the Wiki
[https://git.wiki.kernel.org/index.php/SoC2010Ideas#A_remote_helper_for_svn]
and discussed it with Sverre. I now have a preliminary draft of my
proposal ready, and I'd really appreciate feedback.

=====================================
Project Proposal: native-git-svn | Native SVN support in Git

== The Outline ==
Currently, git-svn.perl is used to interface with SVN repositories.
However, it has serious shortcomings:
1. It is essentially an arcane 5000-line Perl script that doesn't use
git-fast-import/ git-fast-export. It converts an SVN repository to a
Git repository by hand. This makes it virtually unmaintainable.
2. Its UI is unnecessarily complex. git-svn-* has some commands
corresponding to git-* commands, and it can be quite difficult for the
user to understand which one to use in different situations. These can
be merged easily.
3. It handles the standard trunk/branches/tags layout well, but it
doesn't know how to handle non-standard/ changing SVN layout.
4. There's an array of other annoyances which makes it quite
imperfect. For example, it ignores all SVN properties except
svn:executable.

While many of these problems can be tackled in git-svn.perl itself,
problem 1 is the most prominent. git-svn.perl is very difficult to
modify or even maintain. A more permanent solution is required.

My proposal is to start from scratch and build an application that
makes dealing SVN repositories very easy. The plan is to build
component-wise, in a modular manner. The project can be considered
fully successful only after the functionality described in all the
components have been written, and the project is merged into upstream.
It will involve minimal changes to the current Git codebase, if any at
all. I additionally hope that this project will serve as a roadmap for
other projects that involve natively supporting other versioning
systems in Git.

== The Technicalities ==
The distinct components I plan to write are:
1. An SVN client that uses libsvn to fetch/ push revisions to a remote
SVN repository.
2. An exporter for SVN repositories, which will extract all the
relevant revision history and metadata to import into Git.
3. A remote helper for Git that takes the data from this SVN exporter,
and uses git-fast-import to create corresponding commits in Git.
4. Another remote helper to export commit data and metadata from Git
to import into SVN.
5. An importer for SVN, which will create revisions in SVN
corresponding to commits in Git.
6. A UI that glues all the components together into one large
consistent interface.

Due to a licensing conflict, the details of which can be found here
[1], native-git-svn will link to libsvn, but will NOT link to Git. It
will simply use a thin wrapper to call compiled Git executables
(referred to as remote helper in article). The six components will be
developed and tested independently.

The following resources are relevant to the project:
1. git_remote_helpers/git/git.py is a minimalistic remote helper
written by Sverre. I plan to extend this as much as possible before
rewriting it in C.
2. libsvn contains excellent documentation and clear examples to
create the SVN client.
3. git-svn.perl has a lot functionality that I plan to re-implement in
native-git-svn:
   3.1 parse_svn_date: Given a date (in UTC) from Subversion, return a
string in the format "<TZ Offset> <local date/time>" that Git will use
   3.2 load_authors: <svn username> = real-name <email address>
mapping based on git-svnimport
   3.3 do_git_init_db: Create and maintain svn-remotes
   3.4 get_commit_entry: Parse commit messages, and encode them; SVN
requires messages to be UTF-8 when entering the repo
   3.5 cmd_branch: Handle branching/ tagging
   3.6 cmd_create_ignore: Reads svn:ignore and puts the information
into .gitignore
4. There are several existing third-party SVN exporters worth looking into [2].

I've additionally discussed the project with Sverre Rabbelier at
length over email.

== Who am I? ==
I'm Ramkumar, a student at the Indian Institute of Technology,
Kharagpur. I haven't contributed more than a few small patches to Git
[3], and I look at this project as a fantastic opportunity to get more
involved with the community. In the summer and winter of 2008, I
worked with a Django-based startup. The team comprised of three
experienced Python developers, one designer to steer the project, and
an undergraduate student- me. We versioned everything on Git, deployed
on Apache/ PostgreSQL, using Amazon S3 for static content. While
working with the startup, I also contributed to South, a migration
framework for Django. A lot more about this is mentioned on my resume
[4].

C, C++ [5], and Python are my strongest languages. I've additionally
learnt Common Lisp through an Emacs Lisp application I wrote in summer
2009 [6]. I'm known to be very communicative, both in person, and over
email/ chat. The style and clarity of my communication is seen in the
slides I used at FOSS.IN/2009 in winter 2009 [7].

== Notes ==
[1] http://thread.gmane.org/gmane.comp.version-control.git/139545
[2] svn-all-fast-export | git://repo.or.cz/svn-all-fast-export.git and
fast-export | git://repo.or.cz/fast-export.git
[3] 52eb5173ac and 88d50e78c3
[4] TODO
[5] On a related note, I've also contributed a little to Chromium
[6] http://github.com/artagnon/ublog.el
[7] http://artagnon.com/wp-content/uploads/haskell-internals.pdf and
http://artagnon.com/wp-content/uploads/unladen-swallow.pdf
=====================================

Thanks!

Regards,
Ramkumar

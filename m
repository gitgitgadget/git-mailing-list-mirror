From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git Perl bindings, and OO interface
Date: Thu, 27 Nov 2008 03:58:49 +0200
Message-ID: <200811270258.50898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Lea Wiemann <lewiemann@gmail.com>,
	Nadim Khemir <nadim@khemir.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 03:07:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5WHU-0004Or-S3
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 03:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYK0CEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 21:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbYK0CEK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 21:04:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:22960 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbYK0CEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 21:04:08 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1587900ugf.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 18:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=aRL5KVk8EElxlKsPEckj6b2gNCPYjSmznO2d7lfPUmw=;
        b=HunEQSczsE0rf+6Czn4LuigE3QrpXNdYFg1RmLrBeqRhWpKPOpWBE5kfkHVnCgrMGx
         gyIUGHJ2PE2oMQTbhdPv9oauIacjZdrTl8I+ZSNu4wUktd78baUi3OxyhR2tyWCoRIra
         /1K63Skh0NtA1SojzjKiA7VZhmwOF+TEaKRHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=GHqtg4qpTV4PD5B9LsTO+dM/X9h5Tskyip8xWguwiylaGFRl1x4i2YOeQsuibd5mU4
         /3rbHHVh3V4TrVRUiRcD6yDiIRk0oqlQYpOJeQDk7DUA9KvPzlPaJp/xqy3lG6eCKnZ/
         t+IkwstMKkc8V2fWp+ARkqUmlo87+T9Qymopo=
Received: by 10.67.28.14 with SMTP id f14mr9472ugj.79.1227751445149;
        Wed, 26 Nov 2008 18:04:05 -0800 (PST)
Received: from ?192.168.1.11? (abww170.neoplus.adsl.tpnet.pl [83.8.246.170])
        by mx.google.com with ESMTPS id w28sm822231uge.5.2008.11.26.18.03.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 18:03:59 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101787>

There exists many Git bindings for various programming languages, some 
of them using git commands, some of them reimplementing Git, or parts 
of Git.  There is GitPython and PyGit (with some native implementation)
for Python, there is (deprecated) Ruby/Git and Grit (with some native
implementation) for Ruby, there is #Git for C#, there is ObjectiveGit
for Objective C (native), there is JGit (native) and JavaGit for Java,
there is Gat for Haskell and eWiki contains something for PHP.

And of course there is Git.pm (included with Git) and Git::Repo (part
of 'gitweb caching' GSoC 2008 project by Lea Wiemann) for Perl.  Now
Git::Repo didn't get accepted into git.git codebase, but developing it
sparked a bit of discussion about Perl interface to Git commands, and
Object Oriented interface to Git.

I'd like to spawn a discussion in this thread about interfaces to Git
and Object Oriented interface to Git, mainly but not only in Perl.
I hope that the authors of mentioned (and not mentioned) bindings, 
interfaces and implementations of Git would contribute to this thread.


0. One of points of disagreement between Git.pm and new Git::Repo was
   using Error module for frontend error handling.  While the 
   explanation in http://www.perl.com/pub/a/2002/11/14/exception.html
   is compelling, it is not standard Perl technique.  Additionally
   adding "cmd_git_try { CODE } ERRORMSG" syntactic sugar was not very
   good idea.

   So the first thing I'd like to discuss: to use Error and try/catch,
   or not in Perl interface (bindings) to Git?  I would really like to
   hear from Perl experts / Perl hackers here...

1. Git::Cmd

   If I remember correctly Git.pm started as a way to gather in one
   place safe_cmd and safe_pipe like construct from various git commands
   implemented in Perl.  The goal here is to provide portable, safe, and
   working with old Perl interface:
    * portable: this means trying to work with ActiveState Perl on 
      MS Windows; I don't know how important it is _now_ (if there are
      common other Perl distributions on MS Windows).
    * safe: if some of arguments to git commands come from variables,
      then they have to be safe against shell expansion (whitespace,
      quoting characters, escape characters, metacharacters, etc.).
    * compatibile: it should work with as old Perl version as is
      reasonable; it is possible that you can install git locally, but
      cannot upgrade Perl.

   Note that some git commands, for example 'git version', 'git
   ls-remote' and 'git clone' doesn't need git repository to work on.

   We would want to be able to catch git command output to scalar, to
   list (line by line), and to filehandle. More advanced stuff is bidi
   pipe (watch for deadlocks!), and redirecting both stdout and stderr
   of git command to filehandle.

   What instance of Git::Cmd should know is where to find 'git' binary
   (what is $GIT in gitweb, for example). It could cache/store
   internally exec_path.

2. Git::Config

   If git command (a piece of code) uses more than one configuration
   variable, then one would want to get relevant configuration using
   as few calls to git commands as possible.  Therefore using git-config
   to read each config variable is usually out of the question (but it
   is sometimes useful); we would want to read all config in one go,
   either by using "git config -l -z", or by writing config parser in
   Perl (as some command(s) did).

   The problem with this solution is that we have to implement "type
   casting", i.e. equivalent of --int and --bool options to git-config
   ourselves. This mean converting to integer with optional size suffix,
   converting to boolean, and asking for escape codes corresponding to
   given color. And if we add new type (like proposed --path, expanding
   for example '~' to HOME, and ~user to home directory of given user)
   we would have to add it to Perl interface too.
  
3. Git::Repo::Bare and Git::Repo::Nonbare

   Git.pm partially implements those, in a kind of mixed way. Git::Repo
   from Lea Wiemann implements if I remember correctly bare repo only.

   What Git::Repo::Bare (or just Git::Repo) should support is to pass
   appropriate '--git-dir=<dir>' to Git::Cmd, and support accessing git
   repository config via Git::Config.  It could have also use
   long-running pipe to "git cat-file --batch / --batch-check"
   invocation.  For gitweb we only need that part.

   Git::Repo::Nonbare has to additionally pass '--work-tree=<dir>' if
   needed, ant be able to take care and manipulate where in working
   directory we are, i.e. what for example "git rev-parse --show-prefix"
   does.

4. Git::Object: Git::Commit, Git::Tag, Git::Blob and Git::Tree

   Here begins "true" object-oriented part of Git Perl API.

   The easy part is for Git::Commit and Git::Tag to parse commit and tag
   objects (perhaps Git::Object should have interface for long-lived
   "git cat-file --batch") into headers and body (commit/tag message).
   I think we can borrow / be inspired by parse_commit() and other such
   code in gitweb; we have to remember that there might be in some time
   some new headers we don't know about but are perfectly valid (see for
   example "encoding" header in commit object format, which was added
   later, not during initial design).

   The harder part would be to be able to deal with author and committer
   info, splitting it into parts (author name, author email, date and
   timezone, etc.), and also generating dates in various formats, like
   RFC-2822 or ISO-8601.

   The easiest part would be structureless Git::Blob... but there we
   might want size of blob.

   A bit harder would be Git::Tree object and dealing with elements of
   a tree (tree entries).  I'm not sure if some kind of iterator access
   would be useful here.

   Note that for Git::Commit if we are to use plumbing like git-cat-file
   we would have to take care of fake parents info, namely grafts and
   shallow info by ourself, in Perl, to have 'effective parents'.

5. Git::Diff::Raw and Git::Diff::Patchset

   Here I am thinking simply about parsing difftree (raw diff output
   format) and patchset format, as it is used in gitweb.  It is meant
   to be able to access for example to permissions of a file, or diff
   status, or diff stats, etc.

   Here we would want to be able to deal also with merge commits and
   combined diff output format.

6. Git::Log or Git::RevList

   The only difference from list of Git::Commit objects is that 
   depending on parameters like path limiting it might have different
   effective parents if there is history simplification.

7. Git::Refs

   It is meant to represent references, mainly branches, and be filled
   using git-for-each-ref... and for example used for ref markers.

There are probably a few things I have forgot about...
-- 
Jakub Narebski
Poland

From: Per Cederqvist <cederp@opera.com>
Subject: "git branch --contains x y" creates a branch instead of checking
 containment
Date: Thu, 21 Feb 2013 14:00:27 +0100
Message-ID: <51261A6B.5020909@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 14:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Vlg-0007JV-1o
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 14:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab3BUNAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 08:00:31 -0500
Received: from smtp.opera.com ([213.236.208.81]:39129 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332Ab3BUNAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 08:00:31 -0500
Received: from [10.30.2.116] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r1LD0T3V015366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Feb 2013 13:00:29 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216770>

The "git branch --list --contains x y" command lists
all branches that contains commit x and matches the
pattern y. Reading the git-branch(1) manual page gives
the impression that "--list" is redundant, and that
you can instead write

    git branch --contains x y

That command does something completely different,
though. The "--contains x" part is silently ignored,
so it creates a branch named "y" pointing at HEAD.

Tested in git 1.8.1.1 and 1.8.1.4.

In my opinion, there are two ways to fix this:

  - change the "git branch" implementation so
    that --contains implies --list.

  - change the manual page synopsis so that
    it is clear that --contains can only be
    used if --list is also used.  Also add an
    error check to the "git branch" implementation
    so that using --contains without specifying
    --list produces a fatal error message.

Personally I would prefer the first solution.

Repeat by running these commands:

# Set up a repo with two commits.
# Branch a points to the oldest one, and
# b and master to the newest one.
mkdir contains || exit 1
cd contains
git init
touch a; git add a; git commit -m"Added a".
git branch a
touch b; git add b; git commit -m"Added b".
git branch b

git branch --list --contains a
# Prints "a", "b" and "master, as expected.

git branch --contains a
# Prints "a", "b" and "master, as expected.
# In this case, the --list option can be removed.

git branch --list --contains a b
# Prints "b", as expected.  "b" is a <pattern>.

git branch --list --contains a c
# Prints nothing, as expected, as the "c" pattern doesn't match any of
# the existing branches.

git for-each-ref
# Prints three lines: refs/heads/a, refs/heads/b and
# refs/heads/master, as expected.

git branch --contains a c
# Prints nothing, as expected, but...

git for-each-ref
# Prints four lines!  Apparently, the command above created
# refs/heads/c.

     /ceder

P.S. What I really wanted to do was "git merge-base
--is-ancestor a b", but I keep forgetting its name.

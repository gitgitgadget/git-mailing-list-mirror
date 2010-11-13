From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: [BUG] git show <remote>: bad information: Local ref configured if push.default=tracking
Date: Fri, 12 Nov 2010 20:44:11 -0500
Message-ID: <201011130144.oAD1iBeK022905@no.baka.org>
References: <201011130041.oAD0fdmM017083@no.baka.org>
        <20101113010934.GA4017@burratino>
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 13 02:44:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH5AB-0001yI-UQ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 02:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab0KMBoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 20:44:14 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:46078 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab0KMBoO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 20:44:14 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id oAD1iB6H032762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Nov 2010 20:44:11 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id oAD1iBeK022905;
	Fri, 12 Nov 2010 20:44:11 -0500
In-reply-to: <20101113010934.GA4017@burratino>
Comments: In reply to a message from "Jonathan Nieder <jrnieder@gmail.com>" dated "Fri, 12 Nov 2010 19:09:34 -0600."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161379>


In message <20101113010934.GA4017@burratino>, Jonathan Nieder writes:

    On Fri, Nov 12, 2010 at 07:41:39PM -0500, Seth Robertson wrote:

    > Not having inspected the code, it certainly appears as if the "Local
    > branch configured" and "Local ref configured" information is only
    > accidentally correct, but since the normal configuration is the case
    > in which it is accurate, no-one noticed the problem.

    However, if you want the push-to-where-you-pull-from behavior,
    just add
	    [push]
		    default = tracking
    to your ~/.gitconfig.

I already had this turned on in my ~/.gitconfig.  However, you bring
up a good point, the output as shown would be correct if the default
"matching" value was used.  Thus I guess the bug summary needs to be:

git show <remote> produces inaccurate information about "Local ref
configured" if git-config's push.default==tracking

    For your test example: rather than sample output, could you describe
    next to each command what you expect to happen and how that differs
    from what happens instead?  This would make it easier to find the
    lurking bugs.

In my example, I set up each remote identically and only varied the
name of the branch.  In all cases, you could push and pull changes
using `git pull` and `git push`, meaning that they were properly
configured tracking branches.  Thus, I argue that they should produce
information for "Local ref configured" in each case, and furthermore
that the named refs should be appropriate for the mapping in question.

I'll annotate the output below with my desired behavior.  Search for
"^**" in the output below.

In other news, the last argument of the last command of the Test case
prep should have been bar/foo_master instead of bar/master.  This
affects the "git remote show bar" subcase output, showing that the
"Local branch configured" information is correct.  The "Local ref
configured" information remains incorrect/obscure.  I updated the test
case to include the push.default=tracking configuration.

					-Seth Robertson


----------------------------------------------------------------------
mkdir foo; cd foo; git init; echo A>A; git add A; git commit -m A;
git checkout -b other; echo B>B; git add B; git commit -m B;
git checkout master; git config push.default tracking

mkdir ../bar; cd ../bar; git init; git remote add foo ../foo;
git fetch foo; git checkout --track -b foo_master foo/other
git config push.default tracking

mkdir ../baz; cd ../baz; git init; git remote add foo ../foo;
git fetch foo; git checkout --track -b master foo/master
git config push.default tracking

mkdir ../biff; cd ../biff; git init; git remote add foo ../foo;
git fetch foo; git checkout --track -b master foo/master;
git remote add baz ../baz; git fetch baz;
git checkout --track -b baz_master baz/master
git remote add bar ../bar; git fetch bar;
git checkout --track -b bar_master bar/foo_master
git config push.default tracking
----------------------------------------------------------------------

cd ../bar; git remote show foo
 --------------------------------------------------
 * remote foo
   Fetch URL: ../foo
   Push  URL: ../foo
   HEAD branch: master
   Remote branches:
     master tracked
     other  tracked
   Local branch configured for 'git pull':
     foo_master merges with remote other
 --------------------------------------------------
** DESIRED ADDITION **
 --------------------------------------------------
   Local ref configured for 'git push':
     foo_master pushes to other (up to date)
 --------------------------------------------------

cd ../baz; git remote show foo
 --------------------------------------------------
 * remote foo
   Fetch URL: ../foo
   Push  URL: ../foo
   HEAD branch: master
   Remote branches:
     master tracked
     other  tracked
   Local branch configured for 'git pull':
     master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)
 --------------------------------------------------
** OUTPUT CORRECT **

cd ../biff; git remote show foo
 --------------------------------------------------
 * remote foo
   Fetch URL: ../foo
   Push  URL: ../foo
   HEAD branch: master
   Remote branches:
     master tracked
     other  tracked
   Local branch configured for 'git pull':
     master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)
 --------------------------------------------------
** OUTPUT CORRECT **

cd ../biff; git remote show baz
 --------------------------------------------------
 * remote baz
   Fetch URL: ../baz
   Push  URL: ../baz
   HEAD branch: master
   Remote branch:
     master tracked
   Local branch configured for 'git pull':
     baz_master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)
 --------------------------------------------------
** CORRECTED LAST TWO LINES **
 --------------------------------------------------
   Local ref configured for 'git push':
     baz_master pushes to master (up to date)
 --------------------------------------------------

cd ../biff; git remote show bar
 --------------------------------------------------
 * remote bar
   Fetch URL: ../bar
   Push  URL: ../bar
   HEAD branch: foo_master
   Remote branch:
     foo_master tracked
   Local branch configured for 'git pull':
     bar_master merges with remote foo_master
 --------------------------------------------------
** DESIRED ADDITION **
 --------------------------------------------------
   Local ref configured for 'git push':
     bar_master pushes to foo_master (up to date)
 --------------------------------------------------

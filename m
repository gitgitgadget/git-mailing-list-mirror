From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: I18N.pm is incompatible with perl < 5.8.3
Date: Thu, 2 Feb 2012 14:11:20 +0100
Message-ID: <4F2A8B78.6090902@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 14:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RswbX-0004ug-1T
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 14:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab2BBNV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 08:21:28 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:27051 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745Ab2BBNVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 08:21:25 -0500
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Feb 2012 08:21:25 EST
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.213.0; Thu, 2 Feb 2012 14:11:20 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20111118)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189640>

Hello,

While running the git 1.7.9 testsuite on RHEL 3 with perl 5.8.0 and 
gettext 0.11.4 I got this error in t0202-gettext-perl.sh:
# test_external test Perl Git::I18N API failed: /usr/bin/perl 
/builddir/build/BUILD/git-1.7.9/t/t0202/test.pl
# test_external_without_stderr test no stderr: Perl Git::I18N API 
failed: /usr/bin/perl /builddir/build/BUILD/git-1.7.9/t/t0202/test.pl:

A verbose run gave me this:
# test_external test Perl Git::I18N API failed: /usr/bin/perl 
/builddir/build/BUILD/git-1.7.9/t/t0202/test.pl
# expecting no stderr from previous command
# test_external_without_stderr test no stderr: Perl Git::I18N API 
failed: /usr/bin/perl /builddir/build/BUILD/git-1.7.9/t/t0202/test.pl:
# Stderr is:
"import" is not exported by the Exporter module
Can't continue after import errors at 
/builddir/build/BUILD/git-1.7.9/t/../perl/blib/lib/Git/I18N.pm line 5
BEGIN failed--compilation aborted at 
/builddir/build/BUILD/git-1.7.9/t/../perl/blib/lib/Git/I18N.pm line 5.
Compilation failed in require at 
/builddir/build/BUILD/git-1.7.9/t/t0202/test.pl line 8.
BEGIN failed--compilation aborted at 
/builddir/build/BUILD/git-1.7.9/t/t0202/test.pl line 8.
# Looks like your test died before it could output anything.

I found the cause and the solution here:
http://www.nntp.perl.org/group/perl.module.build/2008/02/msg1214.html

I've changed
  use Exporter 'import'
to
  BEGIN {
   require Exporter;
   *{import} = \&Exporter::import;
   }
in I18N.pm.

The test now passes (GETTEXT_LOCALE=1):
# lib-gettext: No is_IS UTF-8 locale available
# lib-gettext: No is_IS ISO-8859-1 locale available
# run 1: Perl Git::I18N API (/usr/bin/perl 
/builddir/build/BUILD/git-1.7.9/t/t0202/test.pl)
1..8
ok 1 - Testing Git::I18N with NO Perl gettext library
ok 2 - Git::I18N is located at 
/builddir/build/BUILD/git-1.7.9/t/../perl/blib/lib/Git/I18N.pm
ok 3 - sanity: Git::I18N has 1 export(s)
ok 4 - sanity: Git::I18N exports everything by default
ok 5 - sanity: __ has a $ prototype
ok 6 - Passing a string through __() in the C locale works
ok 7 - Without a gettext library + <C> locale <TEST: A Perl test string> 
turns into <TEST: A Perl test string>
ok 8 - Without a gettext library + <is> locale <TEST: A Perl test 
string> turns into <TEST: A Perl test string>
# test_external test Perl Git::I18N API was ok
# expecting no stderr from previous command
# test_external_without_stderr test no stderr: Perl Git::I18N API was ok

-tgc

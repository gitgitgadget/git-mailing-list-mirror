From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 3 Dec 2010 12:22:33 +0100
Message-ID: <201012031222.33635.trast@student.ethz.ch>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <201012031136.09156.trast@student.ethz.ch> <201012031213.06321.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 12:22:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POTiu-0001uA-DF
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 12:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747Ab0LCLWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 06:22:36 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:21318 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755508Ab0LCLWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 06:22:35 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 12:22:22 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 12:22:33 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc3-git6-8-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <201012031213.06321.jnareb@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162791>

Jakub Narebski wrote:
> On Fri, 3 Dec 2010, Thomas Rast wrote:
> > "gitweb: File based caching layer (from git.kernel.org)" does not work
> > on my automated tester:
[...]
> What are the results of relevant part of
> 
>  $ cd t
>  $ ./t9502-gitweb-standalone-parse-output.sh --debug
> 
> output?

  ok 1 - setup
  FULL_ID  = 1005c80cc11c531d327b12195027cbbb4ff9e3cb
  SHORT_ID = 1005c80
  not ok - 2 snapshot: full sha1
  #       
  #               gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
  #               check_snapshot ".git-$SHORT_ID"
  #       
  Status: 200 OK
  Content-disposition: inline; filename=".git-1005c80.tar"
  Content-Type: application/x-tar

They all fail after that, the rest of the output is at the end.  OTOH
if I check out v1.7.3.1-48-g5768176 instead, where the test works ok,
it looks like this:

  ok 1 - setup
  FULL_ID  = 1005c80cc11c531d327b12195027cbbb4ff9e3cb
  SHORT_ID = 1005c80
  ok 2 - snapshot: full sha1
  Status: 200 OK
  Content-disposition: inline; filename=".git-1005c80.tar"
  Content-Type: application/x-tar

In other words, I cannot see a difference except that it fails. :-(

> Gitweb output caching should be turned off by default, so it shouldn't
> affect tests before 'enable caching' test.

Well, my test setup has a slight habit of uncovering bugs in odd code
paths since it usually runs under valgrind in a cronjob (i.e. without
a tty).  However, this one also fails when run normally.

In case it matters, this is RHEL5.5 with

  $ perl --version
  This is perl, v5.8.8 built for x86_64-linux-thread-multi



--- Rest of the --debug output ---
not ok - 3 snapshot: shortened sha1
#       
#               gitweb_run "p=.git;a=snapshot;h=$SHORT_ID;sf=tar" &&
#               check_snapshot ".git-$SHORT_ID"
#       
Status: 200 OK
Content-disposition: inline; filename=".git-1005c80.tar"
Content-Type: application/x-tar

not ok - 4 snapshot: almost full sha1
#       
#               ID=$(git rev-parse --short=30 HEAD) &&
#               gitweb_run "p=.git;a=snapshot;h=$ID;sf=tar" &&
#               check_snapshot ".git-$SHORT_ID"
#       
Status: 200 OK
Content-disposition: inline; filename=".git-1005c80.tar"
Content-Type: application/x-tar

not ok - 5 snapshot: HEAD
#       
#               gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tar" &&
#               check_snapshot ".git-HEAD-$SHORT_ID"
#       
Status: 200 OK
Content-disposition: inline; filename=".git-HEAD-1005c80.tar"
Content-Type: application/x-tar

not ok - 6 snapshot: short branch name (master)
#       
#               gitweb_run "p=.git;a=snapshot;h=master;sf=tar" &&
#               ID=$(git rev-parse --verify --short=7 master) &&
#               check_snapshot ".git-master-$ID"
#       
Status: 200 OK
Content-disposition: inline; filename=".git-master-1005c80.tar"
Content-Type: application/x-tar

not ok - 7 snapshot: short tag name (first)
#       
#               gitweb_run "p=.git;a=snapshot;h=first;sf=tar" &&
#               ID=$(git rev-parse --verify --short=7 first) &&
#               check_snapshot ".git-first-$ID"
#       
Status: 200 OK
Content-disposition: inline; filename=".git-first-1005c80.tar"
Content-Type: application/x-tar

not ok - 8 snapshot: full branch name (refs/heads/master)
#       
#               gitweb_run "p=.git;a=snapshot;h=refs/heads/master;sf=tar" &&
#               ID=$(git rev-parse --verify --short=7 master) &&
#               check_snapshot ".git-master-$ID"
#       
Status: 200 OK
Content-disposition: inline; filename=".git-master-1005c80.tar"
Content-Type: application/x-tar

not ok - 9 snapshot: full tag name (refs/tags/first)
#       
#               gitweb_run "p=.git;a=snapshot;h=refs/tags/first;sf=tar" &&
#               check_snapshot ".git-first"
#       
Status: 200 OK
Content-disposition: inline; filename=".git-first.tar"
Content-Type: application/x-tar

ok 10 - snapshot: hierarchical branch name (xx/test)
Status: 200 OK
Content-disposition: inline; filename=".git-xx.test-1005c80.tar"
Content-Type: application/x-tar

ok 11 - setup for caching tests (utf8 commit, binary file)
ok 12 - enable caching
not ok - 13 caching enabled, HTML output, generating cache
#       
#                       gitweb_run "p=.git;a=patch" &&
#                       mv gitweb.body cache.html &&
#                       test_cmp no_cache.html cache.html
#               
ok 14 - caching enabled, HTML output, cached version
not ok - 15 caching enabled, binary output, generating cache
#       
#                       gitweb_run "p=.git;a=blob_plain;f=image.png" &&
#                       mv gitweb.body cache.png &&
#                       cmp no_cache.png cache.png
#               
not ok - 16 caching enabled, binary output, cached version
#       
#                       gitweb_run "p=.git;a=blob_plain;f=image.png" &&
#                       mv gitweb.body cache.png &&
#                       cmp no_cache.png cache.png
#               
# failed 11 among 16 test(s)
1..16

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

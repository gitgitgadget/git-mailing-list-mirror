From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 12:18:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231206320.3962@g5.osdl.org>
References: <45357CC3.4040507@utoronto.ca>
	<200610232021.55625.jnareb@gmail.com>
	<1161628001.27312.8.camel@charis.lan.vernstok.nl>
	<200610232031.12399.jnareb@gmail.com>
	<Pine.LNX.4.64.0610231134450.3962@g5.osdl.org>
	<1161629801.27312.22.camel@charis.lan.vernstok.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Henstridge <james@jamesh.id.au>, bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Mon Oct 23 21:21:38 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc5Jy-0005va-Ll
	for gcvbg-bazaar-ng@m.gmane.org; Mon, 23 Oct 2006 21:18:50 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gc5Jn-0006Pa-Hn; Mon, 23 Oct 2006 20:18:40 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1Gc5Jd-0006PS-3A
	for bazaar-ng@lists.canonical.com; Mon, 23 Oct 2006 20:18:29 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NJIAaX032761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 12:18:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NJI6XB002514;
	Mon, 23 Oct 2006 12:18:07 -0700
To: Jelmer Vernooij <jelmer@samba.org>
In-Reply-To: <1161629801.27312.22.camel@charis.lan.vernstok.nl>
X-Spam-Status: No, hits=-0.477 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29865>



On Mon, 23 Oct 2006, Jelmer Vernooij wrote:
>
> Bzr stores a checksum of the commit separately from the revision id in
> the metadata of a revision. The revision is not used by itself to check
> the integrity of a revision.

That wasn't what I was trying to aim at - the problem is that the bzr 
revision ID isn't "safe" in itself. Anybody can create a revision with the 
same names - and they may both have checksums that match their own 
revision, but you have no idea which one is "correct".

So you just have to trust the person that generates the name, to use a 
proper name generation algorithm. You have to _trust_ that your 64-bit 
random number really is random, for example. And that nobody is trying to 
mess with your repo.

This isn't a problem in normal behaviour, but it's a problem in an attack 
schenario: imagine somebody hacking the central server, and replacing the 
repository with something that had all the same commit names, but one of 
the revisions was changed to introduce a nasty backhole problem. Change 
all the checksums to match too..

It would _look_ fine to somebody who fetches an update, and the maintainer 
might not ever even notice (because he wouldn't send the _old_ revision 
again, and _his_ tree would be fine, so he'd happily continue to to send 
out new revisions on top of the bad one on the public site, never even 
realizing that people are fetching something that doesn't match what he is 
pushing).

In contrast, in git, if you replace something in a git repository, the 
name changes, and if I were to try to push an update on top of a broken 
repo like that, it simply wouldn't work - I couldn't fast-forward my own 
branch, because it's no longer a proper subset of what I'm trying to send.

So in git, you can _trust_ the names. They actually self-verify. You can't 
have maliciously made-up names that point to something else than what they 
are. 

[ Also, as a result, and related to this same issue: the git protocol 
  actually never sends object names when sending the object itself. It 
  just sends the object data, and the _recipient_ generates the name from 
  that.

  So you can't do the _other_ kind of spoofing, and make a repository that 
  _claims_ to have one name and the data would differ - because if you do 
  that, anybody who pulls from the spoofed repository will re-create 
  different names than you claimed, and won't even be able to pull such a 
  malicious repository. ]

		Linus

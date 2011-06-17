From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/3] t1301-*.sh: Fix the 'forced modes' test on cygwin
Date: Fri, 17 Jun 2011 23:26:56 +0100
Message-ID: <4DFBD4B0.6020109@ramsay1.demon.co.uk>
References: <4DFA6632.40607@ramsay1.demon.co.uk> <7v8vt1h1g5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 21:06:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY0qf-0005BZ-Tw
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 21:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab1FRTGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 15:06:21 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:47022 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752187Ab1FRTGU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2011 15:06:20 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QY0qY-0006RZ-hH; Sat, 18 Jun 2011 19:06:19 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v8vt1h1g5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175980>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
[...]
>> This call to lstat() happens after git-init has set the "git_dir"
>> (so has_git_dir() returns true), but before the configuration has
>> been fully initialised. At this point git_config() does not find
>> any config files to parse and returns 0. Unfortunately, the code
>> used to determine the cygwin l/stat() function bindings did not
>> check the return from git_config() and assumed that the config
>> was complete and accessible once "git_dir" was set.
> 
> Ok, so this is not really about "a test fails so we will sweep the issue
> under rag", 

Er ... dunno! I don't quite understand what you mean by this. :(

> ... but "we try to optimize too early, before we have enough
> information, so let the code take slow path before we know what is in the
> configuration file".

Yes. While debugging this test failure, I noticed this behaviour, which
I consider to be incorrect (ie a bug), and so I determined to fix it up.
Of course, I knew that this would have the effect of delaying the binding
of l/stat to the WIN32 implementation, which in turn would have the
side-effect of fixing this test case!

So, yes, this is a "drive-by" bug-fix for this test; it could be broken
again by future patches which change the timing of various setup/config
function calls (I *don't* think it will actually, but don't quote me).

You could argue that, because of commit adbc0b6 et. seq. and commit
c869753 (which means that the test-suite is run with core.filemode as
false and core.ignorecygwinfstricks true) that the POSIXPERM prerequiste
should not be set (because the WIN32 l/stat implementation does not
support it). In that case, this test would not be run, and the whole
issue would be moot!  However, on NTFS at least, cygwin *does* support
POSIXPERM.

[Hmm, has anybody tried running the test-suite on a FAT32 filesystem
on Linux! *just joking*]

I *always* set core.filemode true in my cygwin repo(s) so that I don't
have to deal with these problems. :-P  (I would happily revert adbc0b6,
but then I don't have very large repos ...)

BTW, as far as I know, the only remaining problem with the test-suite
on cygwin is an intermittent failure of t4130-apply-criss-cross-rename.sh.
This would also not fail at all if the WIN32 l/stat were not used (this
time because of the inode emulation; just as on Linux, it forces git to
notice the file-change despite the timestamps). Note that t4130-*.sh
also fails intermittently on MinGW, for the same reason, but the frequency
of failure is about 3 times greater on cygwin.

ATB,
Ramsay Jones

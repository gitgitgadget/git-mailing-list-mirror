From: Jan Engelhardt <jengelh@medozas.de>
Subject: git-grep: option parsing conflicts with prefix-dash searches
Date: Sat, 6 Feb 2010 00:09:11 +0100 (CET)
Message-ID: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 00:09:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXIc-0006CF-Mt
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab0BEXJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:09:13 -0500
Received: from borg.medozas.de ([188.40.89.202]:36258 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab0BEXJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:09:12 -0500
Received: by borg.medozas.de (Postfix, from userid 25121)
	id A972FF0C327A6; Sat,  6 Feb 2010 00:09:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id A06C2119CE
	for <git@vger.kernel.org>; Sat,  6 Feb 2010 00:09:11 +0100 (CET)
User-Agent: Alpine 2.01 (LSU 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139108>

Greetings.


Just about now I wanted to grep for accesses of a particular struct 
member. Needless to say that it was not a very amusing experience.
I would expect that (1) probably fails:

(1)	$ git grep '->cnt' net/ipv4/netfilter/
	error: unknown switch `>'

So far so good, seems reasonable and matches what I would expect from 
most other userspace tools. So let's add -- to terminate the option 
list:

(2)	$ git grep -- '->cnt' net/ipv4/netfilter/
	fatal: bad flag '->cnt' used after filename

*bzzt*. This does not match typical behavior. Let alone that "--"
is not a filename.

What works is (3).

(3)	$ git grep -- -- '->cnt' net/ipv4/netfilter/

But it almost looks like Morse code. Or Perl. Imagine I were to
approxmiately search for all options in iptables's in-code help texts:

	git grep -- -- -- .

I think that overloading "--" was a bad choice. The option parser has
many more awkward behavior, such as not allowing to bundle most
options (`git log -z -p` vs. `git log -zp`) yet forcing it on other
options (`git log -Spattern` vs `git log -S pattern`). The use of
historic counts (cf. `git log -30` and `tail -30`) compared to a more
modern `tail -n30`) also prohibits using many standard parsers
(most notably getopt(3)), as they would recognize that as -3 -0.

As I said, it's a mess. And I know not whether any code can convince
the "but we need to watch compatibility"-sayers, because this would
definitely be a flag change.

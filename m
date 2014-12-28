From: "Randy J. Ray" <rjray@blackperl.com>
Subject: Git's Perl scripts can fail if user is configured for perlbrew
Date: Sun, 28 Dec 2014 16:36:01 -0600
Message-ID: <54A085D1.8060407@blackperl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 00:11:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5MzR-0007jO-BH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 00:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbaL1XKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2014 18:10:55 -0500
Received: from shell1.rawbw.com ([198.144.192.42]:38821 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbaL1XKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2014 18:10:54 -0500
X-Greylist: delayed 2089 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Dec 2014 18:10:54 EST
Received: from ventrue.att.net (76-205-245-68.lightspeed.okcbok.sbcglobal.net [76.205.245.68])
	(authenticated bits=0)
	by shell1.rawbw.com (8.14.9/8.14.9) with ESMTP id sBSMa4ar067321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 28 Dec 2014 14:36:04 -0800 (PST)
	(envelope-from rjray@blackperl.com)
X-Authentication-Warning: shell1.rawbw.com: Host 76-205-245-68.lightspeed.okcbok.sbcglobal.net [76.205.245.68] claimed to be ventrue.att.net
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261856>

I use git on MacOS via homebrew (http://brew.sh/), and a custom Perl 
installation built and managed via perlbrew (http://perlbrew.pl/). At 
some point, commands like "git add -i" broke. I say "at some point", 
because I'm not a git power-user and I only just noticed it this week.

I am running Git 2.2.1 with a perlbrew'd Perl 5.20.1. When I would run 
"git add -i" (or "git add -p"), it would immediately die with a signal 
11. Some poking around showed that those git commands that are 
implemented as Perl scripts run under /usr/bin/perl, and also prefix 
some directories to the module search-path. The problem stems from the 
fact that, when you are using perlbrew, you also have the PERL5LIB 
environment variable set. The contents of it lay between the 
git-provided paths and the default contents of @INC. When the Git module 
is loaded, it (eventually) triggers a load of List::Util, whose C-level 
code fails to load because of a version mismatch; you got List::Util 
from the paths in PERL5LIB, but it doesn't match the version of perl 
from /usr/bin/perl.

After poking around and trying a few different things, I have found that 
using the following line in place of "#!/usr/bin/perl" solves this problem:

	#!/usr/bin/env perl

This can be done by defaulting PERL_PATH to "/usr/bin/env perl" in Makefile.

I don't know enough about the overall git ecosystem to know if this 
would have an adverse effect on anything else (in particular, Windows 
compatibility, but then Windows probably isn't having this issue in the 
first place).

I could just create and mail in the one-line patch for this, but I 
thought it might be better to open it up for some discussion first?

Randy
-- 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Randy J. Ray      Sunnyvale, CA      http://www.dereferenced.com
rjray@blackperl.com
twitter.com/rjray
Silicon Valley Scale Modelers: http://www.svsm.org

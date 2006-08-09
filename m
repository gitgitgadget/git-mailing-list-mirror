From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Wed, 09 Aug 2006 14:04:11 +0200
Organization: At home
Message-ID: <ebcivb$t6m$1@sea.gmane.org>
References: <200608091257.19461.jnareb@gmail.com> <7vu04m413f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 09 14:04:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAmnK-0000T5-EC
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 14:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWHIMEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 08:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWHIMEN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 08:04:13 -0400
Received: from main.gmane.org ([80.91.229.2]:28610 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161008AbWHIMEN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 08:04:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAmnB-0000Rf-UP
	for git@vger.kernel.org; Wed, 09 Aug 2006 14:04:09 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 14:04:09 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 14:04:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25116>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Stop pretending that gitweb is rename-aware, and remove --full-history
>> option to git-rev-list in git_history (for "history" action):
> 
> Where did you get the idea that --full-history has anything to
> do with renames?

> Message-ID: <20060701005924.7726.qmail@web31812.mail.mud.yahoo.com>
  http://marc.theaimsgroup.com/?l=git&m=115171557714437
> Message-ID: <Pine.LNX.4.64.0606301818480.12404@g5.osdl.org>
  http://marc.theaimsgroup.com/?l=git&m=115171683714119

Ooops, sorry, my mistake. Still, even if the patch is to be dropped,
the proposal about rename detection is still valid.

I wonder which version is faster: --full-history, or filter using 
diff-tree?

ab -n 10 "http://localhost/cgi-bin/gitweb/gitweb.cgi?p=git.git;a=history;hb=next;f=gitweb/gitweb.perl"
(ApacheBench, Version 2.0.41-dev <$Revision: 1.141 $> apache-2.0) says

  Requests per second:    0.09 [#/sec] (mean)
  Time per request:       10918.552 [ms] (mean)
  Time per request:       10918.552 [ms] (mean, across all concurrent requests)
  Transfer rate:          2.13 [Kbytes/sec] received

  Connection Times (ms)
                min  mean[+/-sd] median     max
  Connect:        0    0     0.0      0       0
  Processing:  8851 10917 2776.1   9284   16420
  Waiting:      407  457    95.1    428     721
  Total:       8851 10917 2776.1   9284   16420

for --full-history version, and

  Requests per second:    0.11 [#/sec] (mean)
  Time per request:       9076.865 [ms] (mean)
  Time per request:       9076.865 [ms] (mean, across all concurrent requests)
  Transfer rate:          2.57 [Kbytes/sec] received

  Connection Times (ms)
                min  mean[+/-sd] median   max
  Connect:        0    0   0.0      0       0
  Processing:  8741 9076 271.7   9100    9581
  Waiting:      299  405  49.5    404     507
  Total:       8741 9076 271.7   9100    9581

for the pipe through git-diff-tree version, both with very similar
times (check out median column), although --full-history version
seems slightly slower...

Still, it is ab on workstation, not separate server, an only average 
over 10 requests.

And 
1025:jnareb@roke:~/git> time git rev-list next -- gitweb/gitweb.perl
  [...]
  real    0m2.623s
  user    0m2.536s
  sys     0m0.016s
1024:jnareb@roke:~/git> time git rev-list next | git diff-tree -r --stdin -- gitweb/gitweb.perl
  [...]
  real    0m6.857s
  user    0m6.024s
  sys     0m0.068s
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

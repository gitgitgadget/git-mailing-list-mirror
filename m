From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 22:59:46 +0200
Organization: At home
Message-ID: <e79njs$hue$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <20060620201035.GT2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 23:00:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsnKL-0000XI-De
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 23:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWFTU76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 16:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWFTU76
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 16:59:58 -0400
Received: from main.gmane.org ([80.91.229.2]:7640 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751031AbWFTU76 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 16:59:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FsnK9-0000UZ-GM
	for git@vger.kernel.org; Tue, 20 Jun 2006 22:59:49 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 22:59:49 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 22:59:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22225>

Petr Baudis wrote:

> Dear diary, on Tue, Jun 20, 2006 at 06:51:18PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...

>> * Refactor dispatch from if...elsif...else construction 
>>   to using 'name' => \&sub hash.
> 
> In other words, you say the result of the IRC discussion we had about
> symbol lookups and evals turned out really scary? ;-)

First, we need arrays (ordering!) of sets of possible actions for navbar,
so we will have list of all possible actions.

Besides, simple test

        [...]
        sub dispatch {
          dispatch_ifelse(@_);
          #dispatch_hash(@_);
          #dispatch_callname(@_);
          #dispatch_anonsub(@_);
        }
        
        sub test_dispatch_all {
          dispatch(undef);
        
          dispatch("summary");
          [...]
          dispatch("tag");
                
          dispatch("unknown");
          dispatch("tag();injected();");
        }
        
        test_dispatch_all() foreach (1..10000);

run with '$ time ./test.pl > /dev/null' has shown that (suprise, suprise!)
that hash is fastest, then if...elsif...else variant, then 
  my $sub = \&{"git_$action"}; eval { &$sub() };
and last, much much worse is eval "..." version.

Of course test leaves something to be desired...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

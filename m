From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional
	caching
Date: Mon, 14 Jul 2008 19:03:21 -0700
Message-ID: <1216087401.18836.11.camel@localhost.localdomain>
References: <4876B223.4070707@gmail.com>
	 <200807150114.44402.jnareb@gmail.com> <487BE7C4.2050207@gmail.com>
	 <200807150252.52604.jnareb@gmail.com> <487BFA67.3020304@gmail.com>
	 <alpine.LSU.1.00.0807150326050.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	 <487C0252.4030804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 04:04:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIZu6-0001jj-1Q
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 04:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbYGOCDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 22:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754385AbYGOCDe
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 22:03:34 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:53485 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYGOCDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 22:03:33 -0400
Received: from [10.255.255.200] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m6F23Qtp026831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 19:03:26 -0700
In-Reply-To: <487C0252.4030804@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7713/Mon Jul 14 14:59:25 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Mon, 14 Jul 2008 19:03:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88499>

To continue with that benchmarking it seems if gitweb-caching isn't hot
it takes about 3 seconds, if it is I'm about 7x faster than Lea's ;-)

$ time wget -qO/dev/null http://localhost/git/

real    0m2.952s
user    0m0.001s
sys     0m0.004s
$ time wget -qO/dev/null http://localhost/git/

real    0m0.108s
user    0m0.001s
sys     0m0.001s

But regardless of who's faster - I would still argue there are two
reasons to at least have some caching, even if it's crappy:

1) Prevent the thundering heard problem - many requests for the same
thing all generating the same data is bad, and kills I/O

2) Relatively static data can be generated once and stick around for a
bit and serve more requests more efficiently.  Now I agree that
invalidating the cache on a new mtime is better than my current
algorithm (which is purely time based on the cache data vs. the original
data, with some allowances for back-off due to load).

- John 'Warthog9' Hawley

On Tue, 2008-07-15 at 03:50 +0200, Lea Wiemann wrote:
> Johannes Schindelin wrote:
> > Wasn't the main page (i.e. the projects list) the reason why kernel.org 
> > has its own little caching mechanism in the first place?
> > 
> > And did Pasky not report recently that repo.or.cz got substantially less 
> > loaded with some caching of its own?
> 
> Yes, you need *some* caching mechanism.  Once you have that, it's fine,
> at least if the page cache is hot.  (The x-thousand stat calls that my
> caching implementation issues don't actually take that much time; I
> suspect the ~1000 calls to memcached are the more expensive [and
> optimizable] part, though I'd have to benchmark that.)
> 
> Mainline vs. my caching implementation (both with hot page cache) on
> odin3.kernel.org:
> 
> $ time wget -qO/dev/null http://localhost/git-lewiemann/vanilla/
> real    0m3.070s
> $ time wget -qO/dev/null http://localhost/git-lewiemann/
> real    0m0.719s

From: =?UTF-8?B?TmFneSBCYWzDoXpz?= <js@iksz.hu>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file
 with project owner name
Date: Fri, 01 Feb 2008 17:11:10 +0100
Message-ID: <47A3449E.6070102@iksz.hu>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <200801292236.19630.jnareb@gmail.com> <47A09ED2.6070407@iksz.hu> <200802011418.59862.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 17:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKyUh-0000uC-53
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 17:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbYBAQL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 11:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbYBAQL0
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 11:11:26 -0500
Received: from smtp.aranyoroszlan.hu ([195.56.77.57]:59977 "EHLO
	smtp.aranyoroszlan.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbYBAQLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 11:11:25 -0500
Received: (qmail 69036 invoked by uid 263); 1 Feb 2008 16:20:59 -0000
Received: from 213.178.100.12 (js@iksz.hu@213.178.100.12) by tcb.aranyoroszlan.hu (envelope-from <js@iksz.hu>, uid 256) with qmail-scanner-2.01st 
 (clamdscan: 0.88/1510. spamassassin: 3.1.0. perlscan: 2.01st.  
 Clear:RC:0(213.178.100.12):SA:0(-2.3/5.0):. 
 Processed in 3.640244 secs); 01 Feb 2008 16:20:59 -0000
X-Spam-Status: No, hits=-2.3 required=5.0
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on tcb.aranyoroszlan.hu
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RDNS_NONE autolearn=no version=3.2.4
X-Envelope-From: js@iksz.hu
Received: from unknown (HELO ?192.168.1.100?) (js@iksz.hu@213.178.100.12)
  by tcb.aranyoroszlan.hu with SMTP; 1 Feb 2008 16:20:55 -0000
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200802011418.59862.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72178>

Jakob Narebski wrote:
> Besides I'd rather opt for the other side of spectrum: instead of
> gitweb checking for freshness of a 'cache', regenerate the cache
> or just delete it when you know that contents change: from a script
> adding a repository, from a script renaming or changing description
> or an owner of repository, from a script deleting repository or
> removing it from a list, from a post-update / post-receive hook if
> the cached info includes last change, etc.
>   
[...]

> I was thinking about gitconfig file, but with limited syntax to be
> easily parseable from Perl, like git-cvsserver does, put in $projectroot,
> e.g. $projectroot/gitconfig, which would contain parts of repo config
> relevant to 'projects_list' page.  It would use gitweb.<repo>.<key>
> syntax, where <key> is one of owner, description, and perhaps url.
>
> Or we could put it in gitweb_config.perl file, in the form of parsed
> config hash... well, it should be fairly easy to combine those two
> approaches with current code: use %config hash, and fill it from
> $projectroot/gitconfig if not set.
>
> Of course you would have the usual danger when dealing with data
> duplication, naley that they would get out of sync. And usual danger
> dealing with caches, that the validating needed and other system
> caches would make it perform *worse* than without cache.
Well, I came from ClearCase world, were registry service holds all 
vob/view (repo) stuff.  What if we implement more or less the same 
here?  I mean if you have a lot of public git repos, or at least common 
for a couple of people, we could store all the fundamental data (local 
storage path, share URL) of a group of repos in a single database.  We 
could call them depots.  Moreover, we could use this as the source of 
git clone, God forbid, even remotely (some kind of git config 
depot.url=https://user:pass@git.example.org/depot.cgi/depotname).  I 
could continue but I'm afraid I'll run out of oxygen :)

I'm thinking of something similar:

$ git depot # not the actual usage info, but to show all the parameters
Usage: git depot create [-d | --description=<descr>] <depot> <path>
       git depot remove [-f | --force] <depot>
       git depot modify [-d | --description=<descr> ]
         [-p | --path=<base path>] [-n | --name=<depot>] <depot>
       git depot list
       git depot add [-a | --access=public|private] [-o | --owner=<owner>]
         <depot>[:<name>] <path>
       git depot update [-a | --access=public|private]
         [-o | --owner=<owner>] [-p | --path=<path>] <depot>:<name>
       git depot delete <depot>:<name>
       git depot show [-a | --all] [-l | --long] <depot>
$ git depot list
public /pub/scm "Public repository"
$ git depot show public
public:git /pub/scm/git.git (public, owner: "Junio C Hamano \
<gitster@pobox.com>", description: "The core git plumbing")
public:linux/kernel/torvalds/linux-2.6 \
/pub/scm/linux/kernel/torvalds/linux-2.6.git (owner: \
"Linus Torvalds <torvalds@linux-foundation.org>, description: \
"Linus' Kernel Tree")
$ git depot show --long public:git
Repository: public:git
  Path: /pub/scm/git.git
  Clone URL: git://git.kernel.org/pub/scm/git.git
  Clone URL: http://www.kernel.org/pub/scm/git/git.git
  Access: public
  Owner: Junio C Hamano <gitster@pobox.com>
  Description: The core git plumbing
--
# Access: private means only git depot show -a shows it
$ mkdir ~/git; cd ~/git
$ git clone public:git
...
$ git clone . public:git/mygit
...

I'd add some kind of cloneURL setter too, but the basic idea is this.

Regards:
-- 
Balazs Nagy

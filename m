From: Nicolas Pitre <nico@cam.org>
Subject: Re: git gc expanding packed data?
Date: Wed, 12 Aug 2009 11:35:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908121118420.10633@xanadu.home>
References: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
 <alpine.LFD.2.00.0908042203380.16073@xanadu.home>
 <3ace41890908110317k6e6ada07jc39ea446f9fa246e@mail.gmail.com>
 <alpine.LFD.2.00.0908111718490.10633@xanadu.home>
 <3ace41890908120745y305b2a59hd453b7e146e4a774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFre-0000RU-2d
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbZHLPfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbZHLPfg
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:35:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15823 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbZHLPff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:35:35 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO9001SQSN045T0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Aug 2009 11:35:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <3ace41890908120745y305b2a59hd453b7e146e4a774@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125712>

On Wed, 12 Aug 2009, Hin-Tak Leung wrote:

> On Tue, Aug 11, 2009 at 10:33 PM, Nicolas Pitre<nico@cam.org> wrote:
> <snipped>
> 
> > From git v1.6.3 the --aggressive switch makes for 'git repack' to be
> > called with --window=250 --depth=250, meaning the equivalent of:
> >
> >        git repack -a -d -f --window=250 --depth=250
> >
> > Do you still get a huge pack with the above?
> >
> >> I guess --aggressive doesn't always save space...
> >
> > If so that is (and was) a bug.
> 
> I tried 'git repack -a -d -f --window=250 --depth=250' with 1.6.2.5
> (fc11.x86_64) and it took half a day, swallowed up all the memory -
> 3GB virtual & 1.3GB resident - and finally the kernel oom killer
> killed it at a last message of (601460/957910). Left no temp files.
> Would git 1.6.3 use less memory? :-(

Probably not.  However you should try:

	git config pack.deltaCacheSize 1

That limits the delta cache size to one byte (effectively disabling it) 
instead of the default of 0 which means unlimited.  With that I'm able 
to repack that repository using the above git repack command on an 
x86-64 system with 4GB of RAM and using 4 threads (this is a quad core).  
Resident memory usage grows to nearly 3.3GB though.

If your machine is SMP and you don't have sufficient RAM then you can 
reduce the number of threads to only one:

	git config pack.threads 1

Additionally, you can further limit memory usage with the 
--window-memory argument to 'git repack'.  For example, using 
--window-memory=128M should keep a reasonable upper bound on the delta 
search memory usage although this can result in less optimal delta match 
if the repo contains lots of large files (and I think this is the case 
for the gcc repo).


Nicolas

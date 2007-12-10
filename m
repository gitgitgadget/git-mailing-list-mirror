From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git and GCC
Date: Mon, 10 Dec 2007 10:35:40 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101022300.555@xanadu.home>
References: <20071205.204848.227521641.davem@davemloft.net>
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
 <1196918132.10408.85.camel@brick>
 <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com>
 <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>
 <20071206071503.GA19504@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0712060915590.555@xanadu.home>
 <20071206173946.GA10845@sigill.intra.peff.net>
 <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
 <1197074839.22471.34.camel@brick> <20071210095426.GA32611@iram.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Harvey Harrison <harvey.harrison@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Jon Smirl <jonsmirl@gmail.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Gabriel Paubert <paubert@iram.es>
X-From: git-owner@vger.kernel.org Mon Dec 10 16:36:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1kg7-0007NH-Ky
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 16:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbXLJPf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 10:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbXLJPf5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 10:35:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41874 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbXLJPf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 10:35:56 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU004EOBBGZKH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 10:35:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071210095426.GA32611@iram.es>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67722>

On Mon, 10 Dec 2007, Gabriel Paubert wrote:

> On Fri, Dec 07, 2007 at 04:47:19PM -0800, Harvey Harrison wrote:
> > Some interesting stats from the highly packed gcc repo.  The long chain
> > lengths very quickly tail off.  Over 60% of the objects have a chain
> > length of 20 or less.  If anyone wants the full list let me know.  I
> > also have included a few other interesting points, the git default
> > depth of 50, my initial guess of 100 and every 10% in the cumulative
> > distribution from 60-100%.
> > 
> > This shows the git default of 50 really isn't that bad, and after
> > about 100 it really starts to get sparse.  
> 
> Do you have a way to know which files have the longest chains?

With 'git verify-pack -v' you get the delta depth for each object.
Then you can use 'git show' with the object SHA1 to see its content.

> I have a suspiscion that the ChangeLog* files are among them,
> not only because they are, almost without exception, only modified
> by prepending text to the previous version (and a fairly small amount
> compared to the size of the file), and therefore the diff is simple
> (a single hunk) so that the limit on chain depth is probably what
> causes a new copy to be created. 

My gcc repo is currently repacked with a max delta depth of 50, and 
a quick sample of those objects at the depth limit does indeed show the 
content of the ChangeLog file.  But I have occurrences of the root 
directory tree object too, and the "GCC machine description for IA-32" 
content as well.

But yes, the really deep delta chains are most certainly going to 
contain those ChangeLog files.

> Besides that these files grow quite large and become some of the 
> largest files in the tree, and at least one of them is changed 
> for every commit. This leads again to many versions of fairly 
> large files.
> 
> If this guess is right, this implies that most of the size gains
> from longer chains comes from having less copies of the ChangeLog*
> files. From a performance point of view, it is rather favourable
> since the differences are simple. This would also explain why
> the window parameter has little effect.

Well, actually the window parameter does have big effects.  For instance 
the default of 10 is completely inadequate for the gcc repo, since 
changing the window size from 10 to 100 made the corresponding pack 
shrink from 2.1GB down to 400MB, with the same max delta depth.


Nicolas

From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 14:06:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102141347460.14920@xanadu.home>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <m3mxm28v3i.fsf@localhost.localdomain> <201102140036.42197.johan@herland.net>
 <201102141040.35819.jnareb@gmail.com> <7vbp2etqne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:07:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp3lI-0005hK-PP
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769Ab1BNTG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:06:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21673 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1BNTG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:06:58 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGM00GAIFR8HBN0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Feb 2011 14:06:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vbp2etqne.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166749>

On Mon, 14 Feb 2011, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Please consider this use case:
> >
> > Let's assume that current maintainer steps aside for a bit, and new interim
> > temporary maintainer takes mantle.  One would add new remote _temporarily_,
> > but one would want for tags that temporary maintainer created to be as good
> > as tags from 'origin' remote... and not be deleted when you remove temp
> > remote and its remote-tracking branches.
> 
> Why don't you want to delete them?
> 
> When the "interim" maintainer gives the baton back to the authoritative
> maintainer, the tags that are blessed between these two maintainers will
> surely be propagated [*1*] to the authoritative repository and you will
> have them at refs/tags or refs/remotes/origin/tags in your repository.
> 
> And at that point, if you do not want to have refs/remotes/interim/heads/
> branches, you surely do not mind cleaning refs/remotes/interim/tags/
> hierarchy as well, no?

Exact.

> Having said all that, if we assume *1* above, then we wouldn't have needed
> separate tag namespace in the first place.

Depends.  There could be multiple compeeting "interim" maintainers 
effectively creating forks.  They may have conflicting tags.  The 
"official" maintainer may vet only one of those forks.  The other forks 
may die or have a life of their own, Etc. Etc.

> Further, think about the case where the "interim" maintainer ends up
> becoming the authoritative maintainer, which is the same thing as not
> assuming *1* above.  You would want to consolidate refs/remotes/origin/tags
> and refs/remotes/interim/tags, and we do not expect any collisions when we do
> so.

Right.  But that's an expectation based on social practices within a 
project.  In theory there _could_ be collisions.

Let's take the OpenOffice vs LibreOffice as an example.  What if I want 
both in my repository so I can easily perform diffs between those 
independent branches?  They may certainly end up producing releases with 
the same version numbers (same tag name) but different content 
(different tag references).

> Which suggests that tags namespace is really special in that it does want
> to be globally unique and agreed namespace, unlike branch namespace.

Semantically, yes.  but a separate namespace just makes special cases as 
those shown above so much easier to deal with.

The separate namespace is a _technical_ implementation detail that makes 
all the ambigous cases easy.  It doesn't make the mistake of imposing a 
social convention upon people.  So whatever people end up collectively 
doing with their tags is not tied to the tool's limitation anymore.

You end up with 2 tags with the same name?  Fine.  If they are identical 
then you may just as well ignore that they're in separate namespaces.  
The tool will present things to you as such instead of enforcing that in 
the data structure (this is just like we do with file renames). If 
they're different, then at least you now have the possibility to choose 
which tag you actually want by prefixing it with its namespace.  Right 
now this is just not possible.

Please let's not confuse technical details like data (or tag) storage 
with social conventions.


Nicolas

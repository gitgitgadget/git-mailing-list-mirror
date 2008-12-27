From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Fri, 26 Dec 2008 20:56:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812262025320.30266@xanadu.home>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
 <20081225114443.GD6115@zakalwe.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Sat Dec 27 02:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGOR0-0001y1-TQ
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 02:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYL0B4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 20:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbYL0B4O
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 20:56:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48661 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbYL0B4N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 20:56:13 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KCI00C4DIPJNDA0@VL-MH-MR001.ip.videotron.ca>; Fri,
 26 Dec 2008 20:56:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081225114443.GD6115@zakalwe.fi>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103980>

On Thu, 25 Dec 2008, Heikki Orsila wrote:

> On Wed, Dec 24, 2008 at 10:36:27PM -0800, Junio C Hamano wrote:
> > * The packfile machinery hopefully is more robust when dealing with
> >   corrupt packs if redundant objects involved in the corruption are
> >   available elsewhere.
> 
> Has anyone written a summary of how Git's redundancy operates?
> 
> * What would be the probability for a single bit flip to corrupt the 
> repository?

This is not something that git itself could answer.  The probability 
depends on the quality of your hardware.  Once that probability has 
occurred though, it is clear that your repository is then corrupted as 
there is hardly any redundant bits in a git repository.

> * And what is the situation where a single bit flip can not corrupt the 
> database?

The database can be resilient against most kind of corruptions if you 
have a redundant copy of the affected object.  It will still be 
corrupted, but git is now able to detect corruptions gracefully and 
function correctly with some fallback objects.  Those objects must exist 
in some other related repository though, and copied over to the affected 
repository manually. It's then possible and recommended to "fix" the 
corruption simply by repacking the repository at that point.

So there is no magic involved: you need to have some kind of backups, 
either using traditional backup solutions, or by simply having your 
repository cloned somewhere else.  The idea of having a repository fixed 
with redundant objects is for those cases where you need to salvage new 
work that has no corresponding backup, but although corresponding 
objects are not corrupted, they could be delta objects which base is 
against old objects which happen to be corrupted.

> * When (which commands/functions) is error detection done?

Error detection is performed all the time.  When it's not the more 
expensive SHA1 checksum, at least the zlib CRC32 is verified.  What the 
latest git version does amongst other corruption related things is to 
close some small holes where some specific kind of corruptions could 
have been undetected and propagated from one pack to another when 
repacking.


Nicolas

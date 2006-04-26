From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] reverse the pack-objects delta window logic
Date: Wed, 26 Apr 2006 13:48:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604261341200.18520@localhost.localdomain>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
 <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 19:48:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYo7e-0001uU-Te
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 19:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWDZRsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWDZRsP
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 13:48:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25020 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932307AbWDZRsP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 13:48:15 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYC00EK9C4D1O80@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 26 Apr 2006 13:48:13 -0400 (EDT)
In-reply-to: <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19214>

On Tue, 25 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Note, this is a RFC particularly to Junio since the resulting pack is 
> > larger than without the patch with git-repack -a -f.  However using a 
> > subsequent git-repack -a brings the pack size down to expected size.  So 
> > I'm not sure I've got everything right.
> 
> I haven't tested it seriously yet, but there is nothing that
> looks obviously wrong that might cause the inflation problem,
> from the cursory look after applying the patch on top of your
> last round.

Never mind.  I found a flaw in the determination of delta_limit when 
reparenting a delta target.  The immediate parent's delta_limit is 
readjusted when its longest delta is moved to another base, but if that 
parent was itself a delta then the delta_limit adjustment is not 
propagated back up to the top.  This means that some objects were 
falsely credited with too high delta_limit.

And actually I'm not sure how to solve that without walking the tree 
up to the top each time, which I want to avoid as much as possible.


Nicolas

From: Nicolas Pitre <nico@cam.org>
Subject: Re: [BUG] commit walk machinery is dangerous !
Date: Mon, 14 Jul 2008 19:08:59 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807141904250.12484@xanadu.home>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
 <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:10:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXBC-0007cA-5N
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759024AbYGNXJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758991AbYGNXJB
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:09:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17108 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758949AbYGNXJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:09:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4000HYLQYZMY30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 19:08:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88475>

On Mon, 14 Jul 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > However this time a corruption turned up and exposed what I think is a 
> > major flaw in git's error checking.  To demonstrate it, I created the 
> > following test case.  Turning the error() into a die() on line 772 of 
> > commit.c makes this test pass but I don't know if this is the 
> > appropriate fix (e.g. some attempt to parse non existing commits could 
> > be valid usage, etc.).  Note this is critical only for git versions 
> > later than commit 8eca0b47ff15.
> 
> Which probably means we should revert that commit as faulty?  IIRC, before
> that commit we did check and error out correctly but you loosened the
> check to introduce "a major flaw" with that commit.
> 
> $ for b in maint master next pu
>   do
>       echo -n $b; git cat-file blob $b:commit.c | wc -l
>   done
> maint 672
> master 672
> next 779
> pu 789
> 
> Hmph...

Well, most of them aren't that critical.  If anything they will only 
cause a segfault if ever the return value is not checked.

It is those with semantic meaning (e.g. object doesn't exist) which 
should be audited, especially if used in the context of repository 
modification, which pretty much limits it to the test case I produced.


Nicolas

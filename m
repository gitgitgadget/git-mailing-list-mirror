From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] relax delta selection filtering in pack-objects
Date: Wed, 22 Feb 2006 11:04:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602221058320.5606@localhost.localdomain>
References: <Pine.LNX.4.64.0602212034180.5606@localhost.localdomain>
 <7vpslgrkr0.fsf@assigned-by-dhcp.cox.net>
 <7vhd6rsvqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 17:05:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBwU0-00018E-SE
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 17:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWBVQEX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWBVQEW
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 11:04:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52939 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932248AbWBVQEW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 11:04:22 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV3009TGJB9I420@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Feb 2006 11:04:21 -0500 (EST)
In-reply-to: <7vhd6rsvqd.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16599>

On Tue, 21 Feb 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > I haven't dug into the issue yet, but these four delta series
> > seem to break the testsuite.
> 
> I bisected.  It is the adler32 one -- since it makes the
> generated delta much smaller, it is understandable that it would
> interact with the break/rename heuristics.  It is not strictly
> breakage in that sense -- we just need to readjust the
> heuristics thresholds for those algorithms.

I had a quick look and that code rather looks like black magic to me atm.
I however found a memory leak in diffcore-rename.c:estimate_similarity():

        delta = diff_delta(src->data, src->size,
                           dst->data, dst->size,
                           &delta_size, delta_limit);
        if (!delta)
                /* If delta_limit is exceeded, we have too much differences */
                return 0;

        /* A delta that has a lot of literal additions would have
         * big delta_size no matter what else it does.
         */
        if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
                return 0;
                   \________ delta memory is leaked.


Nicolas

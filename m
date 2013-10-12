From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack-object's try_delta fast path for v2 trees?
Date: Sat, 12 Oct 2013 10:52:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310121042290.3023@syhkavp.arg>
References: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 16:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV0Z7-0007wW-B6
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 16:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab3JLOxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 10:53:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20428 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3JLOxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 10:53:07 -0400
Received: from xanadu.home ([66.130.143.177]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUK00BK09C27M80@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 12 Oct 2013 10:52:50 -0400 (EDT)
In-reply-to: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236050>

On Sat, 12 Oct 2013, Duy Nguyen wrote:

> Hi,
> 
> Just wondering if this has been considered and dropped before.
> Currently we use try_delta() for every object including trees. But
> trees are special. All tree entries must be unique and sorted. That
> helps simplify diff algorithm, as demonstrated by diff_tree() and
> pv4_encode_tree(). A quick and dirty test with test-delta shows that
> tree_diff only needs half the time of diff_delta(). As trees account
> for like half the objects in a repo, speeding up delta search might
> help performance, I think.

Fortaking advantage of the sorted nature of tree objects, you need to 
actually parse those objects to determine tree entry boundaries.  The 
delta diff code doesn't parse anything and simply do a search into a 
binary buffer which may or may not end up slicing that buffer on actual 
tree entry boundaries.

So this could help somewhat, however the need for pre-parsing those tree 
objects is probably going to counter-balance all the performance gain 
you might get.

I think the potential for improvements would be greater by moving to 
pack v4 (when the right algorithm is in place that is).  Eventually the 
proper pack v4 tree delta diffing code could be made to serve the pack 
v2 case as well.


Nicolas

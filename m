From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Thu, 6 Aug 2009 16:48:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
References: <op.ux8i6hrbtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 16:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4GJ-0003Kx-QS
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 16:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZHFOsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 10:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbZHFOsD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 10:48:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:49590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751712AbZHFOsC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 10:48:02 -0400
Received: (qmail invoked by alias); 06 Aug 2009 14:48:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 06 Aug 2009 16:48:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sxzlO6cisX1upw3qBvmqGO00H7BltcCKkEF/rfi
	M/sq/7XJ/7M1bR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <op.ux8i6hrbtdk399@sirnot.private>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125074>

Hi,

On Thu, 6 Aug 2009, Nick Edelen wrote:

> SUGGESTED FOR 'PU':
> 
> Traversing objects is currently very costly, as every commit and tree must be 
> loaded and parsed.  Much time and energy could be saved by caching metadata and 
> topological info in an efficient, easily accessible manner.  Furthermore, this 
> could improve git's interfacing potential, by providing a condensed summary of 
> a repository's commit tree.
> 
> This is a series to implement such a revision caching mechanism, aptly named 
> rev-cache.  The series will provide:
>  - a core API to manipulate and traverse caches
>  - an integration into the internal revision walker
>  - a porcelain front-end providing access to users and (shell) applications
>  - a series of tests to verify/demonstrate correctness
>  - documentation of the API, porcelain and core concepts
> 
> In cold starts rev-cache has sped up packing and walking by a factor of 4, and 
> over twice that on warm starts.  Some times on slax for the linux repository:
> 
> rev-list --all --objects >/dev/null
>  default
>    cold    1:13
>    warm    0:43
>  rev-cache'd
>    cold    0:19
>    warm    0:02
> 
> pack-objects --revs --all --stdout >/dev/null
>  default
>    cold    2:44
>    warm    1:21
>  rev-cache'd
>    cold    0:44
>    warm    0:10

Nice!

> The mechanism is minimally intrusive: most of the changes take place in 
> seperate files, and only a handful of git's existing functions are 
> modified.

Sorry, I forgot the details, could you quickly remind me why these caches 
are not in the pack index files?

>  Documentation/rev-cache.txt           |   51 +
>  Documentation/technical/rev-cache.txt |  336 ++++++
>  Makefile                              |    2 +
>  blob.c                                |    1 +
>  blob.h                                |    1 +
>  builtin-rev-cache.c                   |  284 +++++
>  builtin.h                             |    1 +
>  commit.c                              |    3 +
>  commit.h                              |    2 +
>  git.c                                 |    1 +
>  list-objects.c                        |   49 +-
>  rev-cache.c                           | 1832 +++++++++++++++++++++++++++++++++
>  revision.c                            |   89 ++-
>  revision.h                            |   46 +-
>  t/t6015-rev-cache-list.sh             |  228 ++++
>  t/t6015-sha1-dump-diff.py             |   36 +

Hmpf.

We got rid of the last Python script in Git a long time ago, but now two 
different patch series try to sneak that dependency (at least for testing) 
back in.

That's all the worse because we cannot use Python in msysGit, and Windows 
should be a platform benefitting dramatically from your work.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 20:12:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRpH-0002Vp-G1
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 20:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbYJMSGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 14:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbYJMSGI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 14:06:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:59710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756245AbYJMSGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 14:06:07 -0400
Received: (qmail invoked by alias); 13 Oct 2008 18:06:04 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 13 Oct 2008 20:06:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kMztkW2Zkc33eUoIEnkqrIynJzWAj1XA/ndXWJt
	LCZ0XKTW4A5b9C
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98135>

Hi,

thanks for doing the due diligence that I should have done (but I ran out 
of time).

On Mon, 13 Oct 2008, Junio C Hamano wrote:

> The parts of the tests you fixed came from these:
> 
>     6738c81 (send-pack: segfault fix on forced push, 2007-11-08)

This really wants to make sure that no objects are shared or hard-linked 
between the repository in "trash directory/" and the one in its 
subdirectory "another/".  It predates "test_must_fail", too, it seems.

It never touches the working directory "another/", so using 
--update-head-ok is okay.

>     4ebc914 (builtin-remote: prune remotes correctly ..., 2008-02-29)

This tests "git remote add"'s --mirror option.

It never touches the working directory either.

>     4942025 (t5510: test "git fetch" following tags minimally, 2008-09-21)

This test is actually not fixed, but contains two test cases for the issue 
the commit fixes.

>     03db452 (Support gitlinks in fast-import., 2008-07-19)

This creates an empty repository for tests to fast-import, and fetches 
into the current (not yet existing) branch.

I actually understand now why the tests started failing: the change from 
resolve_ref() to get_branch() as requested by Daniel are at fault: 
get_branch() does not check if the branch has an initial commit.

I am actually regretting making this change.  Daniel, do you agree that it 
might be better to change back to resolve_ref(), so that the initial 
complaint (IIRC Han-Wen git pull'ed into a freshly initialized repository 
with that utterly bogus "git pull origin master:master" line) is not 
re-raised?

> With these verified, I think I should move the "Strangely" comment to 
> the commit log message proper (after stripping "Strangely" part -- it is 
> not strange anymore after we understand why).

The only test that would need fixing after reverting back to resolve_ref() 
would be the "remote add --mirror" thing, which I think should be fine.

Ciao,
Dscho

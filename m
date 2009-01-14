From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 1.5.6.5 fails to clone
 git.kernel.org/[...]/rostedt/linux-2.6-rt
Date: Thu, 15 Jan 2009 00:10:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901142357360.3586@pacific.mpi-cbg.de>
References: <E1LLAn5-0001JM-00@alva.home> <7vpriw26uo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Shepard <shep@alum.mit.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEtO-0001YC-9G
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbZANXJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 18:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbZANXJ5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:09:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:51536 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753176AbZANXJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 18:09:56 -0500
Received: (qmail invoked by alias); 14 Jan 2009 23:09:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 15 Jan 2009 00:09:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iB9MmCVmiu2wTevsqdPyGfUCF2zFXMkNxFFAHpz
	49KMJ6h24g4hva
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vpriw26uo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105727>

Hi,

On Fri, 9 Jan 2009, Junio C Hamano wrote:

> I think we lost the alternate object store support when git-fetch was 
> rewritten from the original shell script (that did support fetching from 
> such a repository over rsync:// transport) to a reimplementation in C, 
> with commit b888d61 (Make fetch a builtin, 2007-09-10).
> 
> Later, cd547b4 (fetch/push: readd rsync support, 2007-10-01) attempted to
> resurrect some rsync support (b888d61 lost rsync support completely for
> git-fetch), but introduced these lines in transport.c:
> 
> 	/* NEEDSWORK: handle one level of alternates */
> 	result = run_command(&rsync);

Indeed... And I know who's responsible for those lines.

However, I am swamped with work these days, and my Git time budget was 
_way_ overspent what with the recent patches.

So whoever would like to give it a go, go wild.

This is actually a very fine opportunity for people to get involved who 
always wanted to; it is a relatively low-hanging fruit.

It should just be a matter of getting objects/info/alternates (one can 
easily reuse a large part of the args[] array filled before the quoted 
code) into a temporary file.

If that does not succeed, return 0, otherwise fetch those objects, too 
(again reusing most of the args[] array).

It is that easy because objects as well as packs are immutable, so we can 
just build the union of objects/packs from the remote and its alternate.

Then all which is left to do is to add a test case to t/t5510-fetch.sh, 
and you're set.

As there are already test cases for rsync:// in it, it should be as simple 
as putting an empty file into a newly created directory, create an 
alternate for the "remote" pointing to the directory, fetching, and 
testing that the empty file was copied.

That's possible because rsync:// is dumb and does not verify the files it 
copied.

Oh, and don't forget to remove the NEEDSWORK comment :-)

And now I'm curious who's up for it...

Ciao,
Dscho

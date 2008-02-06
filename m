From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH WIP] git-stash: add new 'drop' subcommand
Date: Wed, 6 Feb 2008 23:53:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802062333080.8543@racer.site>
References: <alpine.LSU.1.00.0802051401000.8543@racer.site> <47A9DE06.9050307@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>, Tim Stoakes <tim@stoakes.net>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:55:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMu6i-0002wA-Rr
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764124AbYBFXy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764088AbYBFXy0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:54:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:53934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764065AbYBFXyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:54:23 -0500
Received: (qmail invoked by alias); 06 Feb 2008 23:54:21 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp053) with SMTP; 07 Feb 2008 00:54:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BlD8HMJZBXOiUl3JwJ+GlLkaxSla0nzkhiK9AqV
	sBS46jKbf7i8wN
X-X-Sender: gene099@racer.site
In-Reply-To: <47A9DE06.9050307@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72878>

Hi,

On Wed, 6 Feb 2008, Brandon Casey wrote:

> This allows a single stash entry to be deleted. It takes an optional 
> argument which is a stash reflog entry. If no arguments are supplied, it 
> drops the most recent stash entry.

Just to repeat my opinion: "drop" is not useful.  I think 'git stash pop 
"$1"' = 'git stash apply "$1" && git stash drop "$1"' would be a sane 
interface.

And this means that a multiple drop would become uninteresting.

As for your reflog delete with multiple arguments... Right.  This needs a 
change in the callback data cmd_reflog_expire_cb, recno needs to become a 
pointer to an int, instead of an int.  Then, cmd_delete() has to allocate 
argc + 1 int values, setting the last to -1.  It has to shift the recno 
pointer in the loop to the respective next element of this allocated 
array.  The values need to be sorted after the loop in ascending order.  
Then, in a loop from the last to the second entry, the _difference_ 
array[i] - array[i-1] has to be stored in array[i].  Also, recno has to be 
reset to the first element in the array.  Then, expire_reflog_ent() has to 
be changed to check "recno && *recno >= 0", and if "--*(cb->cmd->recno) == 
0", it not only has to prune, but before that increment cb->cmd->recno, so 
it points to the next element of the array.

Also, I think that "reflog delete" should probably just realise when it 
deleted the last element, and update the ref with the new last element (or 
delete it if none is left).

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sun, 8 Jul 2007 14:16:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081353560.4248@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707080248320.4093@racer.site> <7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
 <7vwsxb4e2q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 15:24:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7WkQ-0001o0-EK
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 15:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbXGHNYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 09:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbXGHNYI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 09:24:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:60517 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752506AbXGHNYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 09:24:05 -0400
Received: (qmail invoked by alias); 08 Jul 2007 13:24:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 08 Jul 2007 15:24:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dXcA4LtYdffak2ZKZAZpVT16+cK8sVU/5DMFEPL
	jFl8YGoxh6yJHV
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsxb4e2q.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51881>

Hi,

On Sat, 7 Jul 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The last time I looked at merge-recursive's D/F check, I found that it 
> > was not quite doing things right.  I may be able to dig up what I 
> > posted to the list...
> 
> It was from around April 7th-10th this year.

Unfortunately, this is way over my time budget.  As well as over my 
intelligence budget, since I did not even succeed in understanding the 
code in threeway_merge _at all_.

Besides, IMHO there is a deeper issue. Since merge-recursive started out 
as a Python script, and grew there until it was usable, and grew the 
rename detection therein, too, until it was finally converted to C, it 
accumulated a lot of features that would have been nice to have 
independently.

Almost the same goes for unpack-trees, which (its name to the contrary) 
does quite a few things to merge entries, too.  And it tries to detect d/f 
conflicts, too.

So there we are, with two really big and unwieldy chunks of code, each 
deserving an own GSoC project to clean them up.  Or maybe not even a GSoC 
project, but a longer project.

What I would _like_ to see is something as clean as merge-tree.  Which is 
clearly separated (code and file wise, too) into these stages:

- reading the trees

- determining renames

- determining true d/f conflicts

- threeway merge

- writing the tree object

- writing the work tree

- recursive

Ideally, merge-recursive would really have been as simple as

	case "$1" in
	--index_only)
		index_only=$1
		shift
	esac
	a="$1"
	b="$2"
	set $(git merge-base --all $a $b)
	temp=$1
	shift
	while case $# in 0) break;; esac
	do
		temp=$(git merge-recursive --index-only $temp $1)
		shift
	done
	git merge-non-recursive $index_only $temp -- "$a" "$b"

because _read-tree -m_ should have learnt about renames, _not_ 
merge-recursive.

As it is, both unpack_trees() and merge-recursive have a certain degree of 
not-quite duplicated yet wants-to-do-largely-the-same functionality.  
Which of course leads to much finger pointing: "it's unpack_trees() fault. 
no. it's merge-recursive's fault. no, vice versa."

Maybe the proper way out is really to start from merge-tree.c and do 
something which is easy to understand, and concise, and thus has a much 
lesser chance of being buggy.

Ciao,
Dscho

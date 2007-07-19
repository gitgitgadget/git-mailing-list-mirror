From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Introduce commit notes
Date: Thu, 19 Jul 2007 02:34:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190232570.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <200707160857.48725.andyparkins@gmail.com> <7vbqec4vk2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707161724110.14781@racer.site> <7vzm1w2pwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Alberto Bertogli <albertito@gmail.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 03:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBKuz-00026d-Cc
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 03:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763455AbXGSBef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 21:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762566AbXGSBee
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 21:34:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:38036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761572AbXGSBed (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 21:34:33 -0400
Received: (qmail invoked by alias); 19 Jul 2007 01:34:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 19 Jul 2007 03:34:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Lxm8i8kyLPn/4o+bMGZ515HKbyjCOLFGWqhZc/T
	qvuVuBAP4UCdz6
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm1w2pwk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52922>

Hi,

On Mon, 16 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Hmph, you are right.  In this sequence:
> >> 
> >> 	hex = sha1_to_hex(commit->object.sha1);
> >> 	snprintf(name, sizeof(name), "%s:%.*s/%.*s",
> >> 			notes_ref_name, 2, hex, 38, hex + 2);
> >> 	if (get_sha1(name, sha1))
> >> 		return;
> >> 
> >> Instead, we could read the tree object by hand in the commit that is 
> >> referenced by notes_ref_name, which has uniform two letter names for 
> >> subtrees which can be binary searched, open the tree for that entry, 
> >> again by hand, and do another binary search because that tree has 
> >> uniform 38-letter names.  That certainly could be done.
> >> 
> >> Sounds like a "fun" project for some definition of the word.
> >
> > I disagree.  One disadvantage to using tree objects is that it is much 
> > easier to have pilot errors.  You could even make a new working tree 
> > checking out refs/notes/commits and change/add/remove files.
> 
> I suspect you read me wrong.  I was saying that it is possible to use a 
> specialized tree object parser in place of get_sha1() only in the above 
> code to read the tree objects that represents a 'note'.  You obviously 
> would want to do a sanity check such as:
> 
>  - The size of the tree object your customized tree parser is
>    fed is multiple of expected entry size (mode word + 20 SHA1 +
>    2 + NUL for fan-out, replace 2 with 38 for lower level);
> 
>  - mode word for the entry is sane (an entry in the fan-out tree
>    would point at a tree object, an entry in lower level would
>    point at a blob);
> 
>  - The name part (2 or 38) are lowercase hexadecimal strings;

In which case it is not _that_ attractive any more, since you

- have to have a fallback anyway, and

- have a relatively complex thing.

Instead, I want to go with the hash map approach, if only to have a O(1) 
behaviour instead of O(log N).

Ciao,
Dscho

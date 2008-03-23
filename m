From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/7] Make branch merging aware of underlying case-insensitive
 filsystems
Date: Sun, 23 Mar 2008 08:41:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803230829001.16824@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org> <7v7ifueznu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 16:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdSKq-0007rE-5J
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 16:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbYCWPlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 11:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbYCWPlU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 11:41:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42084 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbYCWPlT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 11:41:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2NFf866013125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Mar 2008 08:41:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2NFf71K031229;
	Sun, 23 Mar 2008 08:41:07 -0700
In-Reply-To: <7v7ifueznu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.752 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77917>



On Sat, 22 Mar 2008, Junio C Hamano wrote:
> 
> I wonder what happens when the file with the same case does exist that we
> are trying to make sure is missing?

Can't happen. This whole code-path only triggers if the entry didn't exist 
in the index when we merge a tree.

So we know a priori that the source index didn't contain the thing.

> As far as I can tell, icase_exists() does not ask "does a file with this
> name in different case exist, and a file with this exact case doesn't?"
> but asks "does a file with this name, or another name that is different
> only in case, exist?".

Correct. But see the call chain - this thing is only called if index is 
NULL, ie "there was no entry in the index".

So in this case, the other comment (above "icase_exists()") talks about 
that:

	This gets called when there was no index entry for the tree entry 
	'dst', but we found a file in the working tree that 'lstat()' said 
	was fine, [...]

and you can verify that "verify_absent()" only gets called by things where 
"index" was NULL (only three callers, and two of them are expressly inside 
a "if (!old)" case, and the third one is right after a "if (index) return"
statement.

[ There's _one_ special case: the "index" thing may have been NULL not 
  because there was no path in the source index, but because we didn't 
  even look at the index in the first place! So strictly speaking, we 
  should have a test for "o->merge" being set, but afaik that must always 
  be true if we have "o->update" set, and again, this logic only triggers 
  for that case.

  So the only case that doesn't set "o->merge" to get the index is 
  "builtin-read-tree.c" when you do a plain tree-only merge, but that one 
  has

	if ((opts.update||opts.index_only) && !opts.merge)
		usage(read_tree_usage);

  to make sure that you cannot update the working tree without taking the 
  index into account ]

Anyway, I think it's all good. 

			Linus

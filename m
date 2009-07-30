From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Demonstrate bugs when a directory is replaced with
 a symlink
Date: Wed, 29 Jul 2009 18:06:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907291758030.3161@localhost.localdomain>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com> <1248819198-13921-2-git-send-email-james.e.pickens@intel.com> <4A70062A.4040008@drmicha.warpmail.net> <7v4osvyjl2.fsf@alter.siamese.dyndns.org> <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 <7v63dbuyru.fsf@alter.siamese.dyndns.org> <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com> <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain> <alpine.LFD.2.01.0907291656420.3161@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "Pickens, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 03:07:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWK7I-0003TE-Vb
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 03:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbZG3BGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 21:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756089AbZG3BGx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 21:06:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51554 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756049AbZG3BGw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 21:06:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6U16e6u022198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Jul 2009 18:06:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6U16dj0023551;
	Wed, 29 Jul 2009 18:06:40 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907291656420.3161@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.968 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124432>



On Wed, 29 Jul 2009, Linus Torvalds wrote:
> 
> Hmm... This looks like it should do it.
> 
> It doesn't make the test _pass_ (we don't seem to be creating a/b-2/c/d 
> properly - I haven't checked why yet, but I suspect it is becasue we think 
> it already exists due to the symlinked version lstat'ing fine), but it 
> seems to do the right thing.

Never mind. The patch does what I set out to do, but it's not relevant for 
the problem.

What happens is:

 - we remove a/b/c/d to make room for the a/b symlink:

	merge_trees ->
	  git_merge_trees ->
	    check_updates ->
	      checkout_entry ->
	        remove_subtree("a/b") ->
	          recursive rm

   This is correct

 - then we create the a/b symlink to a/b2

	merge_trees ->
	  git_merge_trees ->
	    check_updates ->
	      checkout_entry ->
	        write_entry ->
	          symlink

   This is correct

 - Then we remove 'a/b/c/d' again for the 'unmerged_cache()' case:

	merge_trees ->
	  process_entry ->
	    remove_file

   because th eprocess_entry() will decide that the original tree had that 
   "a/b/c/d" file (true) that needs to be removed (false - we already 
   did that as part of creating "a/b").

Annoying.

		Linus

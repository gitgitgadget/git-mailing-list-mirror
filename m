From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 12:23:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708231153150.30176@woody.linux-foundation.org>
References: <46CD94AB.7070709@trolltech.com>
 <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 21:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOIHo-0006jv-QX
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 21:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXHWTYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 15:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbXHWTYH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 15:24:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42823 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678AbXHWTXq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 15:23:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NJNe9Z026297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Aug 2007 12:23:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NJNdIA023308;
	Thu, 23 Aug 2007 12:23:39 -0700
In-Reply-To: <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.251 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56517>



On Thu, 23 Aug 2007, Linus Torvalds wrote:
> 
> Junio - it fixes the test for me, but quite frankly, I don't see why 
> write-tree would *ever* change any non-tree index entries. But it does. I 
> think there's another bug somewhere, or I'm missing something.

Looking more carefully at the index file before and after, the _only_ 
difference really is the ce_size field for "foo".

In the fixed one, ce_size remains at 5 (which is correct: the file 
contents are "bar\n\r"), in the broken case it gets zeroed by 
git-write-tree for some reason.

And the reason is really interesting: it only happens if the index file 
has the same date as the entry in the index, in which case we end up doign 
the "careful" check in ce_smudge_racily_clean_entry() and there the 
"ce_modified_check_fs()" will end up re-reading the file, and if we don't 
have the right CRLF behaviour, we will now return DATA_CHANGED.

So the call-chain for this is:

	cmd_write_tree ->
	  write_tree ->
	    write_index ->
	      ce_smudge_racily_clean_entry -> 
		ce_modified_check_fs ->
		  ce_compare_data ->
		    index_fd ->
		      convert_to_git ->
			** wrong answer unless auto_crlf is set **

		and now "ce_smudge_racily_clean_entry()" will do
			ce->ce_size = htonl(0);

and the one-liner fix I sent out is actually the right fix.

This was harder to find than it should have been, because it actually 
depends on the datestamp of the index file matching the datestamp of the 
file in question!

		Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Tue, 20 Mar 2007 19:37:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703201922160.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <200703181929.58278.robin.rosenberg.lists@dewire.com> <45FE8D1E.6040408@sinister.cz>
 <200703200735.41234.robin.rosenberg.lists@dewire.com> <45FFA5CB.1060700@sinister.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: David Brodsky <trekie@sinister.cz>
X-From: git-owner@vger.kernel.org Wed Mar 21 03:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTqir-0001BM-8m
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 03:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbXCUCim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 22:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbXCUCim
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 22:38:42 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44406 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbXCUCil (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 22:38:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2L2bjcD032211
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Mar 2007 19:37:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2L2bf9h017320;
	Tue, 20 Mar 2007 18:37:43 -0800
In-Reply-To: <45FFA5CB.1060700@sinister.cz>
X-Spam-Status: No, hits=-0.97 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42774>



On Tue, 20 Mar 2007, David Brodsky wrote:
> 
> And (hopefully) permanent http://steamer.kajka.koleje.cuni.cz/Eclipse

Ok, thanks, downloaded. Although the pack-file is just 1.7GB for me, not 
3.7 like somebody said.

Anyway, doing a

	git blame --incremental HEAD -- org.eclipse.debug.ui/plugin.xml > /dev/null

on that thing (picked a random file that got modified in a recent commit) 
took something like 12 seconds, so this is certainly a perfectly fine 
test-case.

Sadly, "git-gui blame" doesn't work in a bare git repository, so I had to 
do an ugly

	ln -s . .git

to make git-gui happy, and that worked, and was pretty usable. Still, 
12seconds should be something we can improve on.

And yeah, the profile is pretty horrid:

	samples  %        app name                 symbol name
	70307    20.9412  libc-2.5.so              strlen
	50925    15.1682  libz.so.1.2.3            (no symbols)
	24295     7.2364  git                      tree_entry_interesting
	19816     5.9023  libc-2.5.so              memcpy
	19569     5.8287  git                      tree_entry_extract
	17693     5.2699  vmlinux                  memcpy_c
	17032     5.0730  git                      assign_blame
	16956     5.0504  git                      get_mode
	12401     3.6937  git                      get_origin
	11815     3.5191  git                      skip_uninteresting
	10449     3.1123  git                      update_tree_entry
	10359     3.0855  git                      find_pack_entry_one
	7946      2.3667  git                      cmp_suspect
	4572      1.3618  libc-2.5.so              strncmp
	...

so I guess we need to find some more strlen's to remove ;)

			Linus

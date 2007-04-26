From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git died
Date: Thu, 26 Apr 2007 12:51:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704261246270.9964@woody.linux-foundation.org>
References: <46307671.3090109@beronet.com> <Pine.LNX.4.64.0704261126300.15751@reaper.quantumfyre.co.uk>
 <46309924.70401@beronet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Christian <crich-ml@beronet.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 21:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhA0d-00034a-Aw
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963AbXDZTwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbXDZTwD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:52:03 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:45597 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754963AbXDZTwB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2007 15:52:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3QJprAV019685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Apr 2007 12:51:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3QJpqsS009943;
	Thu, 26 Apr 2007 12:51:53 -0700
In-Reply-To: <46309924.70401@beronet.com>
X-Spam-Status: No, hits=-3.013 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45652>



On Thu, 26 Apr 2007, Christian wrote:

> Julian Phillips wrote:
> 
> Loaded symbols for /lib/tls/libnss_dns.so.2
> #0  decode_tree_entry (desc=0xbff5110c, buf=0x0, size=454) at tree-walk.c:10
> 10              while ((c = *str++) != ' ') {
> (gdb) bt
> #0  decode_tree_entry (desc=0xbff5110c, buf=0x0, size=454) at tree-walk.c:10
> #1  0x0804b9a8 in mark_tree_uninteresting (tree=0x80d0240) at revision.c:65
> #2  0x080534cd in main (argc=2, argv=Cannot access memory at address 0x1ca
> ) at http-push.c:1998

It looks like some strange corruption in http-push.

You seem to have a NULL "buf" pointer (which certainly explains a 
SIGSEGV!), but mark_tree_uninteresting will have done

	if (parse_tree(tree) < 0)
		die("bad tree %s", sha1_to_hex(obj->sha1));

	init_tree_desc(&desc, tree->buffer, tree->size);
	while (tree_entry(&desc, &entry)) {
		..


and tree_entry() does

	*entry = desc->entry;
	update_tree_entry(desc);

and none of that sets "entry->buf" to NULL unless "size" was also zero.

Can you run it under something like valgrind? You'd need to run 
"git-http-push" directly (as I don't think valgrind follows forks, and 
even if you can make it do so some way that would just be horribly slow 
and hard to debug).

		Linus

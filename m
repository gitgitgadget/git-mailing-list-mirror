From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ls-tree: handle trailing slashes in the pathspec properly.
Date: Tue, 31 May 2005 16:48:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505311636260.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
 <7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org>
 <7v8y1vvvaa.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:44:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdGOu-0003aJ-Aj
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 01:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVEaXqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 19:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVEaXqq
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 19:46:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:61883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVEaXqn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 19:46:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4VNkcjA016573
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 16:46:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4VNkbaA020732;
	Tue, 31 May 2005 16:46:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y1vvvaa.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 31 May 2005, Junio C Hamano wrote:
> 
> I take it to mean that you took my other patch for diffcore-pathspec.

No, I did my own. Rather than add more code to handle '/' as a special 
case, I just removed it all, and fixed the compare logic.

> Here is a fixed ls-tree, with a couple of new tests in an
> existing test script, to catch this bug.

You seem to think that '/' at the end is a special case, and it really 
shouldn't be. It should just fall out as a natural special case of a 
zero-sized name (which is, btw, the same natural special case that the 
path of "" should have in &root_dir).

For some reason your ls-tree.c logic seems to think that zero-sized names
means "root entry", when the _natural_ thing to do is to pass in the "base
directory", and then a zero-sized name is that base.

IOW, it would make much more sense to have

	list_one(struct tree_entry_list *tree, const char *name)
	{
		const char *slash = strchr(name, '/');
		const char *next;
		int len;

		for (;;) {
			if (!slash) {
				len = strlen(name);
				next = NULL;
			} else {
				len = slash - name;
				next = slash+1;
			}
			newtree = tree;
			if (len)
				newtree = lookup(tree, name, len);
			if (!next)
				break;
			tree = newtree;
			name = next;
		}

		/* Ok, "newtree" is the last component */
		show_entry(newtree);
	}

and then call it with

	list_one(&root_entry, full_path)

and notice how the cases of an empty path "" and "xxx//yy" and "xx/"  
just fall out from the exact same logic - a zero-sized name is the same as
the directory it is in. No special cases for slashes or empty names.

		Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 09:41:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 18:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJYzv-0008J8-SP
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 18:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbXBTRls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 12:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbXBTRls
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 12:41:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41647 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932960AbXBTRlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 12:41:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1KHfjhB016382
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Feb 2007 09:41:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1KHficW014619;
	Tue, 20 Feb 2007 09:41:44 -0800
In-Reply-To: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.459 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40245>



On Mon, 19 Feb 2007, Junio C Hamano wrote:
> 
> * core.autocrlf
> 
>   What's still missing is support for .gitignore like "these files are
>   text" information.

Well, we could actually just do that in stages.

We might start off with just saying "unlike .gitignore", we only support 
one top-level ".gitattributes" file. That makes the problem space much 
simpler, and then we can have code like

	enum file_type {
		FILE_AUTO,
		FILE_BINARY,
		FILE_TEXT
	};

	static enum file_type get_file_type(const char *pathname)
	{
		static int has_initialized = 0;

		if (!has_initialized) {
			has_initialized = 1;
			read_file_attributes_file();
		}
		... check the filename against our attribute rules ..
	}

which would be fairly straightforward, and efficient.

It gets more complicated with per-directory attributes files, because then 
you need to either open those files *all* the time (stupid and expensive 
if you have thousands of files and hundreds of directories), or you need 
to have some way to cache just the ones you need.

(In fact, it might be perfectly fine to have just a *single* cache, which 
is keyed on the dirname of the pathname: if the dirname changes, just 
throw the cache away, and read it in from all the subdirectories leading 
to that directory - you'd still re-read stuff, but all the common cases 
will walk the directory structure in a nice pattern, so you'd have a very 
simple cache that actually gets good cache hit behaviour)

>   One thing that might be tricky is what should be done while making a
>   merge or checking out from a tree.  Ideally, the information should be
>   read from the tree that is being extracted, but that would make the
>   code structure a little bit, eh, "interesting".

No, that would be pretty horrid. So just tell everybody that it's based on 
the working tree. I don't think it's likely to be a problem in practice.

		Linus

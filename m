From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix broken sha1 locking
Date: Tue, 19 Sep 2006 15:10:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609191501311.4388@g5.osdl.org>
References: <20060919205823.18579.59604.stgit@machine.or.cz>
 <Pine.LNX.4.64.0609191411460.4388@g5.osdl.org> <20060919212340.GC8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:11:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnoJ-0003Kj-Uv
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWISWLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWISWLS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:11:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbWISWLR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:11:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8JMB3nW028713
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Sep 2006 15:11:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8JMAwIO005556;
	Tue, 19 Sep 2006 15:11:01 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060919212340.GC8259@pasky.or.cz>
X-Spam-Status: No, hits=-2.508 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27297>



On Tue, 19 Sep 2006, Petr Baudis wrote:
>
> lock_ref_sha1_basic() never strdup()s ref (at least the reference used
> for git_path() later).

Ahh. So how did that ever work? Even in the current "master" branch, we 
call "resolve_ref()", which calls "git_path()", and historically we only 
had a single buffer..

So we're doing

	lock_ref_sha1_basic(git_path("refs/%s", ref),...

with that single buffer, and we _do_ do "xstrdup(path)" in between.

[ looks.. ]

Ahh.

We re-assign the "path" to point to the result value of the resolve_ref(), 
and so we do re-use the buffer, but we apparently never have any 
overlapping use. The packed-ref changes make us need pathnames in the 
middle, which we didn't use to do.

I do agree that we tend to use too many static buffers there. The static 
buffers are fine for the low-level functions ("mkpath()" and 
"git_path()"), but once they start getting passed around as arguments to 
other functions, they should be xstrdup'd or something.

		Linus

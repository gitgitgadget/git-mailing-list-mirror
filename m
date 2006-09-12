From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make ref resolution saner
Date: Tue, 12 Sep 2006 07:41:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609120739310.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
 <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> <Pine.LNX.4.64.0609112008500.27779@g5.osdl.org>
 <Pine.LNX.4.64.0609112010340.27779@g5.osdl.org> <20060912053616.GA6706@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 16:41:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN9S5-0005V9-Q3
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 16:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWILOl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWILOl1
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 10:41:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965249AbWILOl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Sep 2006 10:41:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8CEfKnW009270
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Sep 2006 07:41:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8CEfJu3023122;
	Tue, 12 Sep 2006 07:41:19 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060912053616.GA6706@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.519 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26888>



On Tue, 12 Sep 2006, Jeff King wrote:
> 
> I assume your patch is against master;

Yeah. Well, master plus my previous patches.

> it looks like there's exactly one call to resolve_ref that's in next but 
> not master. One-liner fix below.

Not quite enough. It's the same thing: wt-status.c plays games with the 
return value (which _used_ to be a path) in order to turn it back into a 
ref. But now that it's all about refs, the games are unnecessary:

> diff --git a/wt-status.c b/wt-status.c
> index ec2c728..e2f49c7 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -41,7 +41,7 @@ void wt_status_prepare(struct wt_status 
>  
>  	s->is_initial = get_sha1("HEAD", sha1) ? 1 : 0;
>  
> -	head = resolve_ref(git_path("HEAD"), sha1, 0);
> +	head = resolve_ref("HEAD", sha1, 0);
>  	s->branch = head ?
>  		    strdup(head + strlen(get_git_dir()) + 1) :
>  		    NULL;

So that "strdup(head + strlen(get_git_dir()) + 1)" should now be just 
"strdup(head)".

		Linus

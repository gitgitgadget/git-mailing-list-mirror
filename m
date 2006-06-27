From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Tue, 27 Jun 2006 11:22:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606271116360.3927@g5.osdl.org>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 27 20:23:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvIDT-0001MR-Eu
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 20:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWF0SXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 14:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWF0SXL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 14:23:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030201AbWF0SXK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 14:23:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5RIMsnW015906
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Jun 2006 11:22:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5RIMrVR007226;
	Tue, 27 Jun 2006 11:22:53 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22749>



On Tue, 27 Jun 2006, Alex Riesen wrote:
> 
> Good news is that it is faster: 6min vs 10min. Bad news is that it is still
> not enough for me and it is only on Linux (Windows will be slower,
> still testing),
> uses an awful lot of memory and CPU.

Why do you do that horrible node_list, and the broken "find common 
ancestors?"

I can't follow your code, but it _looks_ like you are using some totally 
broken graph walking function.

For git, the #1 optimization ALWAYS is to avoid walking the full commit 
graph. That fundamentally _cannot_ scale. 

Almost all of the "hard work" in git has been to try to read the minimum 
amount of commits possible. That means that you absolutely must not just 
walk the commits the "obvious" way, because that will always require you 
to build up the whole graph of the whole history, even if the common 
shared point is much closer.

So it look slike your "graph.c" is _fundamentally_ flawed.

You need to really read "git-merge-base.c" and understand it thoroughly. 
And then you need to throw away your graph.c, and use git-merge-base 
instead.

			Linus

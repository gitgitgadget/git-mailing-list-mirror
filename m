From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 5 Mar 2007 11:57:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOJJj-0005WP-DU
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 20:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXCET5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 14:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbXCET5w
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 14:57:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33777 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbXCET5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 14:57:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25Jvhq8007024
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Mar 2007 11:57:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l25JvgWh031767;
	Mon, 5 Mar 2007 11:57:43 -0800
In-Reply-To: <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.455 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41479>



On Mon, 5 Mar 2007, Linus Torvalds wrote:
> 
> NOTE! Our patches aren't really mutually incompatible, and they attack the 
> problem from two different directions. You do the separate phase (which is 
> also correct), and my patch instead tries to clean up the commit walking 
> so that the commit number limiter works more like the date limiter (which 
> fundamentally has all the same issues! Including the problem with some 
> commits possibly being marked as boundary commits when they aren't really, 
> because the path-limiting or revision-limiting ended up cutting things off 
> *differently* than the date-limiting).

Side note: the reason you don't *notice* it with the date-limiter is 
simply that the date limiter *also* runs at limit-time, rather than just 
at the incremental "run at the end" phase. So the date-limiter is much 
simpler when done together with other limiters (like path and revision 
limiters).

HOWEVER. We can't do the same thing for the numerical one, because we need 
to run the other limiters *first*, and the numerical limiter always comes 
at the end. And the path-based "dense" limiter actually runs mostly 
incrementally, so you cannot do the numerical limiter until after it has 
run..

The way to really clean stuff up would be to:

 - first phase: limit by date and revision ranges first (both of those are 
   static and quick, and don't depend on anything else)

   We do this already (limit_list)

 - second phase: limit by pathname (we don't do this as a phase at all, we 
   do it incrementally: see "rewrite_parents()")

 -third phase: limit by number

HOWEVER. There's a damn good reason why we do things the way we do, namely 
simply the fact that we want to do pathname limiting as much at run-time 
as possible.. But we *could* do the "rewrite_parents()" thing both in the
non-incremental and in the final phase. However, doing the parent 
rewriting is quite nasty and error-prone, so I've been avoiding it.

Anyway, I *suspect* that Dscho's patch might do the wrong thing for 
something like

	gitk -20 v1.4.4.. t/

exactly because of the subtle interaction between pathname limiting, 
static commit limiting *and* commit number limiting. Dscho?

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: comparing file contents in is_exact_match?
Date: Tue, 18 Jul 2006 08:37:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607180837260.3386@evo.osdl.org>
References: <20060706055729.GA12512@admingilde.org>  <87fyh1ncm0.fsf@mid.deneb.enyo.de>
  <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com> 
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de> 
 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org> 
 <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <1F90D448-5347-4CEB-80DE-3CC86C1CC16F@adacore.com> 
 <Pine.LNX.4.64.0607171431010.2478@evo.osdl.org>
 <f36b08ee0607180238i34cde4deib17426f121ae269e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 18 17:37:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2rcq-0007EZ-6m
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 17:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWGRPgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 11:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWGRPgl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 11:36:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932280AbWGRPgk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jul 2006 11:36:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6IFabnW027934
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Jul 2006 08:36:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6IFaa1P030901;
	Tue, 18 Jul 2006 08:36:36 -0700
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0607180238i34cde4deib17426f121ae269e@mail.gmail.com>
X-Spam-Status: No, hits=-0.683 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23995>



On Tue, 18 Jul 2006, Yakov Lerner wrote:
> 
> How about making this parameter (do-use-mmap  vs  not-use-mmap)
> a *runtime*  parameter  ?

The thing is, there are really two different kinds of users, and one of 
them in particular (the pack-file case) shouldn't have the problems under 
Windows at all (because the pack-files aren't moved), and have a much 
bigger reason to use mmap in the first place (because accesses will be 
sparse, so reading the whole file is wasteful).

The other user was the index file, and _that_ one is the one that gets 
renamed (to replace the previous index file), and that one is also not 
ever read only partially, so using "read()" instead of mmap is much less 
of an issue.

So I really think we should just basically always mmap the pack-files (it 
should work everywhere), and make NO_MMAP just trigger on the other cases.

		Linus

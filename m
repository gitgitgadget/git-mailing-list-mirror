From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 08:40:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908180836440.3162@localhost.localdomain>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <4A8AA511.1060205@gmail.com> <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com> <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 17:41:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdQo6-0005Q9-BH
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 17:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759197AbZHRPk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 11:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbZHRPk4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 11:40:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50066 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754757AbZHRPk4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 11:40:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7IFeRwO005203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 08:40:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7IFeOjR020904;
	Tue, 18 Aug 2009 08:40:25 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.463 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126402>



On Tue, 18 Aug 2009, Junio C Hamano wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> > On Tue, Aug 18, 2009 at 14:56, Artur Skawina<art.08.09@gmail.com> wrote:
> > ...
> >> I'd limit it to windows and any other ia32 platform that doesn't pick the
> >> bswaps itself; as is, it just adds an unnecessary hidden gcc dependency.
> >>
> >> Hmm, it's actually a gcc-4.3+ dependency, so it won't even build w/ gcc 4.2;
> >> something like this would be required: "(__GNUC__>=4 && __GNUC_MINOR__>=3)" .
> >
> > So, as you say the code makes no difference under Linux, would you be
> > OK with just testing for GCC 4.3+, and not for Windows? That would get
> > rid of the "hidden" GCC dependency and not make the preprocessor
> > checks overly complex. Moreover, limiting my patch to any "platform
> > that doesn't pick the bswaps itself" could possibly require
> > maintenance on compiler / CRT updates.
> 
> I would say that should be fine, but I'd let Linus and Nico to overrule me
> on this if they have any input.

I'd suggest not using a gcc builtin, since if you're using gcc you might 
as well just use inline asm that has been around forever (unlike the 
builtin).

Just do:

	#if defined(__GNUC__)
	#define htonl(x) ({ unsigned int __res; \
		__asm__("bswap %0":"=r" (__res):"0" (x)); \
		__res; })
	#define ntohl(x) htonl(x)
	#endif

or similar in the x86 section that does the rol/ror thing.

			Linus

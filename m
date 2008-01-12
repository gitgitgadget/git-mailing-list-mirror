From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 10:47:10 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801121040010.2806@woody.linux-foundation.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <alpine.LSU.1.00.0801112127040.31053@racer.site> <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org> <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
 <20080112144629.GE2963@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlOX-0001Se-IO
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbYALSrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 13:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbYALSrU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:47:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34969 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429AbYALSrU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 13:47:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0CIlBUX001498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jan 2008 10:47:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0CIlAQr009851;
	Sat, 12 Jan 2008 10:47:11 -0800
In-Reply-To: <20080112144629.GE2963@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70345>



On Sat, 12 Jan 2008, Dmitry Potapov wrote:
> 
> After cursory look at the source code, I wonder if converting name1
> and name2 to upper case before memcmp in cache_name_compare() can
> help case-insensitive systems. This change will change the order of
> file names in the index, but I suppose that it should not be a problem,
> because the index is host specific. Though, this fix is too simple, so
> I guess, I missed something.

No, the index isn't host-specific, and we also have a deep knowledge of 
the fact that the index order is the same as the unpacked tree order.

So no, we absolutely cannot just sort the index differently. We literally 
need to have a separate key for a "upper case lookup".

(That separate key can be just a hash table - it doesn't need to be 
something you can iterate over, so it can be pretty simple).

> > (And that's totally ignoring the fact that case-insensitivity then also 
> > has tons of i18n issues and can get *really* messy 
> 
> The proper support of i18n is not simple even without case-insensitivity.
> For instance, there are four different encodings widely used for Russian
> letters.

.. and git is very clear about this: filenames are *not* "characters" in 
the i18n sense, they are series of bytes. There is absolutely no room for 
ambiguity, and there is no locale for those things.

And that isn't going to change. It's the only sane way to do 
locale-independent names: people can *choose* to see the filenames as some 
UTF-8 sequence, or a series of Latin1, or anything, but that's not 
something git itself will care about.

Trying to involve locale in name comparison simply isn't possible. Two 
different repositories on two different filesystems would get two 
different answers. And that is simply unacceptable in a distributed 
system.

What we can do is to make the simple cases (ie the locale-*independent* 
ones) warn about problems with case insensitivity.

			Linus

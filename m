From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
 UTF8
Date: Mon, 21 Jan 2008 20:59:56 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org> <fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org> <7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 06:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHBG5-0007Ek-FB
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 06:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYAVFAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 00:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbYAVFAn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 00:00:43 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52411 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbYAVFAm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 00:00:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M4xvbI018035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 20:59:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M4xu44005406;
	Mon, 21 Jan 2008 20:59:56 -0800
In-Reply-To: <7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.722 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71417>



On Mon, 21 Jan 2008, Junio C Hamano wrote:
> 
> yet you can obtain a path component longer than 256 bytes.

Individual components are limited to 255 bytes by most filesystems 
(PATH_MAX is the whole path, not any individual component).

That said, you're right. It's not really a design requirement, and since 
you never get an array of "struct dirent", just a pointer to a single one, 
it would be perfectly normal and natural for "struct dirent" to be 
declared with a unsized d_name[].

It's also quite possible that some implementations might even have 
d_name[] not as an array, but as a pointer to somewhere else (POSIX may 
require it to be an array, I didn't check).

That said, I bet that Mark isn't the only one to have written code like 
that, so I suspect Mark's code probably works in practice pretty much 
everywhere, even if I don't think it's necessarily _required_ to work 
correctly.

I do suspect that if you really want to make this portable, and able to 
handle an expanding d_name[] too, I think you need to make sure you 
allocate a big-enough one. And if you worry about d_name perhaps being a 
pointer, that really does mean that you'd need to convert the 
system-supplied "struct dirent" into a "git_dirent_t" that you can 
control.

That said, I think this patch has a bigger problem, namely just 
fundamentally that

	char *utf8 = reencode_string(entry, "UTF8", "UTF8-MAC");

is just unbelievably slow. That's just not how it should be done.

First off, the common case is that the filename likely has everything in 
plain 7-bit ascii. So rather than re-encoding by default, the first thing 
to do is to just see if it even needs re-encoding. Even if it's as simple 
as saying "does it have any high bits at all", that's going to be a *huge* 
performance win.

So start off with something like

	int is_usascii(const char *p)
	{
		char c;

		do {
			c = *p++;
		} while (c > 0);
		return !c;
	}

and now you can do

	if (is_usascii(entry->d_name))
		return entry;

before you even *look* at re-encoding it (and this basically works for all 
cases - we really don't care about EBCDIC, do we? So even if this routine 
was meant to do Latin1<->utf8, the above "is_usascii()" test is always the 
right thing to do).

Anyway, even if you do that, our "reencode_string()" is really *so* 
expensive that you really don't want to do it on a filename by filename 
basis. It literally does a malloc() for each allocation. It might well be 
worth it to find something that is more utf-8-specific (and I could well 
imagine that Mac OS X comes with some UTF libraries, if only because we 
cannot possibly be the only people with this issue).

(Same goes for Latin1<->UTF conversion, for that matter. If somebody wants 
to add that, I suspect it's best done by hand, not using iconv and our 
rather expensive layer around it. That said, latin1->utf8 is actually 
much *easier* than utf-8 NFD->NFC).

			Linus

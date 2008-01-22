From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
 UTF8
Date: Mon, 21 Jan 2008 23:16:54 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801212304460.2957@woody.linux-foundation.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org> <fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org> <7vve5nzdqx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHDOJ-0007pT-S7
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 08:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759345AbYAVHRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 02:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYAVHRU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 02:17:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45116 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759293AbYAVHRT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 02:17:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M7GsjS022112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 23:16:55 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M7Gss8009933;
	Mon, 21 Jan 2008 23:16:54 -0800
In-Reply-To: <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.723 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71423>



On Mon, 21 Jan 2008, Linus Torvalds wrote:
> 
> I do suspect that if you really want to make this portable, and able to 
> handle an expanding d_name[] too, I think you need to make sure you 
> allocate a big-enough one. And if you worry about d_name perhaps being a 
> pointer, that really does mean that you'd need to convert the 
> system-supplied "struct dirent" into a "git_dirent_t" that you can 
> control.
> 
> That said, I think this patch has a bigger problem, namely just 
> fundamentally that
> 
> 	char *utf8 = reencode_string(entry, "UTF8", "UTF8-MAC");
> 
> is just unbelievably slow. That's just not how it should be done.

Having thought about this some more, I'm starting to suspect that the 
"readdir()" wrapper thing won't work very well.

Yes, it will work on OS X, but for all the wrong reasons. It works there 
just because of the stupid normalization that OS X does both on filename 
input and output, so if we hook into readdir() and munge the name there, 
we'll still be able to use the munged name for lstat() and open().

However, we'll never be able to test it on a sane Unix system, and it 
won't ever be able to handle the case of a filesystem actually being 
Latin1 but git being asked to try to transparently convert it to utf-8 in 
order to work with others.

Because most of those readdir() calls will just be fed back not just to 
the filesystem as lstat() calls later, but also to the recursive directory 
traversal itself, so if we munge the name, we're also going to screw name 
lookup.

Again, as an OSX-only workaround it's probably acceptable, and perhaps 
that's the only thing to look at right now. But it does strike me as a 
design mistake to do it at that level.

It would be conceptually nicer to do it in "add_file_to_index()" instead. 
Ie anything that creates a "struct cache_entry" would do the 
conversion. 

So it would be good if somebody looked at what happens if you do the OSX 
hack in add_file_to_index() instead, and see if it works there..

		Linus

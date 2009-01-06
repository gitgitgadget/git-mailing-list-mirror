From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC v2 2/4] Use 'lstat_cache()' instead of
 'has_symlink_leading_path()'
Date: Tue, 6 Jan 2009 13:08:58 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901061304280.3057@localhost.localdomain>
References: <1231274192-30478-1-git-send-email-barvik@broadpark.no> <1231274192-30478-3-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Jan 06 22:10:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKJC5-0005zY-26
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 22:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbZAFVJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 16:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZAFVJH
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 16:09:07 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51790 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751586AbZAFVJG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 16:09:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n06L8xoX030350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jan 2009 13:09:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n06L8wBu023822;
	Tue, 6 Jan 2009 13:08:59 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231274192-30478-3-git-send-email-barvik@broadpark.no>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.944 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104727>



On Tue, 6 Jan 2009, Kjetil Barvik wrote:
?
> Start using the optimised, faster and more effective symlink/directory
> cache.  The previously used call:
> 
>    has_symlink_leading_path(len, name);
> 
> should be identically with the following call to lstat_cache():
> 
>    lstat_cache(len, name,
>                LSTAT_SYMLINK|LSTAT_DIR,
>                LSTAT_SYMLINK);

I think the new interface looks worse.

Why don't you just do a new inline function that says

	static inline int has_symlink_leading_path(int len, const char *name)
	{
		return lstat_cache(len, name,
			LSTAT_SYMLINK|LSTAT_DIR,
			LSTAT_SYMLINK);
	}

and now you don't need this big patch, and people who don't care about 
those magic flags don't need to have them. End result: more readable code.

Then, the new users that want _new_ semantics can use the extended 
version.

This is how git has done pretty much all "generalized" versions. See the 
whole ce_modified() vs ie_modified() thing: they're the same function, 
it's just that 'ce_modified()' is the traditional simpler interface that 
works on the default index, while ie_modified() is the "full" version that 
takes all the details that most uses don't even want to know about.

				Linus

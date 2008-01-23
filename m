From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 08:06:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801230754180.1741@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <4796FBB6.9080609@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHiAH-0003d5-R1
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbYAWQIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 11:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756487AbYAWQID
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:08:03 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53936 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756476AbYAWQIA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 11:08:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NG6gIS019116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 08:06:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NG6ers014883;
	Wed, 23 Jan 2008 08:06:40 -0800
In-Reply-To: <4796FBB6.9080609@op5.se>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71548>



On Wed, 23 Jan 2008, Andreas Ericsson wrote:
> 
> Insofar as hashes go, it's not that shabby for hashing filenames.

Hashing filenames is pretty easy. You can do a reasonable job with any 
"multiply by an odd number, add in value". Picking the odd number is a 
random choice, some are better than others (and it depends on whether you 
end up always having a power-of-two bucket size etc), but it generally 
won't be horrible.

And considering that we generally won't have tons and tons of pathnames 
(ie we'd generally have thousands, not millions), and that the underlying 
hash not only resizes itself but actually uses the ful 32 bits as the 
lookup key, I don't worry too much. I suspect my random choice is fine.

So no, I didn't think my hash would _suck_, although I also didn't 
research which odd numbers to pick.

No, it's a joke because it doesn't really give an example of how to do the 
_expected_ hash collissions.

Here's another hash that is actually going to collide *much* more (and on 
purpose!), but is actually showing an example of something that actually 
hashes UTF strings so that upper-case and lower-case (and normalization) 
will all still hash to the same value:

	static unsigned int hash_name(const char *name, int namelen)
	{
	        unsigned int hash = 0x123;

	        do {
	                unsigned char c = *name++;
			if (c & 0x80)
				c = 0;
			c &= ~0x20;
	                hash = hash*101 + c;
	        } while (--namelen);
	        return hash;
	}

but the above does so by making the hash much much worse (although 
probably still acceptable for "normal source code name distributions" 
that don't have very many same-name-in-different-cases and high bit 
characters anyway).

The above is still fairly fast, but obviously at a serious cost in hash 
goodness, to the point of being totally unusable for anybody who uses 
Asian characters in their filenames.

To actually be really useful, you'd have to teach it about the character 
system and do a lookup into a case/normalization table.

So *that* is mainly why it's a joke. But it should work fine for the case 
it is used for now (exact match).

Picking a better-researched constant might still be a good idea.

		Linus

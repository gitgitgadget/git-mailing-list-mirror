From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Sat, 9 Jan 2010 10:05:44 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001091004380.7821@localhost.localdomain>
References: <4B474C73.8080100@mtu.net> <4B4751EA.8060707@drmicha.warpmail.net> <20100108162404.GA5799@coredump.intra.peff.net> <7vr5q05z74.fsf@alter.siamese.dyndns.org> <20100108164132.GA6171@coredump.intra.peff.net> <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org> <7vvdfcfjxo.fsf@alter.siamese.dyndns.org> <7veim0w68q.fsf_-_@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain> <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain> <7v8wc8kshh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain> <7veilzaguf.fsf@alter.siamese.dyndns.org> <7vfx6f3dm3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 19:06:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTfhR-0000Io-1a
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 19:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab0AISGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 13:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789Ab0AISGD
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 13:06:03 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51297 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754787Ab0AISGB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jan 2010 13:06:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o09I5j1l014625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Jan 2010 10:05:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o09I5ix5032363;
	Sat, 9 Jan 2010 10:05:44 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vfx6f3dm3.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.447 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136537>



On Sat, 9 Jan 2010, Junio C Hamano wrote:
> 
> Having sent these patches, I am wondering if the simplest fix might be this
> one-liner.
> 
> diff --git a/dir.c b/dir.c
> index d0999ba..7fba335 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -788,3 +788,3 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
>  	simplify = create_simplify(pathspec);
> -	read_directory_recursive(dir, path, len, 0, simplify);
> +	read_directory_recursive(dir, "", 0, 0, simplify);
>  	free_simplify(simplify);

That one-liner doesn't work at all for me.

Lookie here:

	[torvalds@nehalem linux]$ touch drivers/char/hello.c
	[torvalds@nehalem linux]$ ~/git/git ls-files --exclude-standard -o drivers/char
	[torvalds@nehalem linux]$ git ls-files --exclude-standard -o drivers/char
	drivers/char/hello.c

where that ~/git/git is the version with the one-liner.

IOW, it now ignores _everything_, because the dir and the path don't 
match.

		Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 8 Jan 2010 15:24:13 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
References: <4B474C73.8080100@mtu.net> <4B4751EA.8060707@drmicha.warpmail.net> <20100108162404.GA5799@coredump.intra.peff.net> <7vr5q05z74.fsf@alter.siamese.dyndns.org> <20100108164132.GA6171@coredump.intra.peff.net> <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org> <7vvdfcfjxo.fsf@alter.siamese.dyndns.org> <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:25:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTOCa-0001Do-4O
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab0AHXY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888Ab0AHXY7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:24:59 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54979 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781Ab0AHXY7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 18:24:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o08NOE0O008806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jan 2010 15:24:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o08NOD2p020546;
	Fri, 8 Jan 2010 15:24:13 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.446 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136496>



On Fri, 8 Jan 2010, Junio C Hamano wrote:
>
> Given pathspecs that share a common prefix, ls-files optimized its call
> into recursive directory reader by starting at the common prefix
> directory.
> 
> If you have a directory "t" with an untracked file "t/junk" in it, but the
> top-level .gitignore file told us to ignore "t/", this resulted in an
> unexpected behaviour:

Ok, I'm not sure how "unexpected" this is, since arguably you are 
overriding the ignore file by _being_ in that directory (the same way 
index contents override ignore files), but I could go either way on that.

Your patch looks fine, although I think you did this in a very odd way.

> +	at = 0;
> +	memcpy(path, path_, len);
> +	while (1) {
> +		char *cp;
> +		path[at] = '\0';
> +		/*
> +		 * NOTE! NOTE! NOTE!: we might want to actually lstat(2)
> +		 * path[] to make sure it is a directory.
> +		 */
> +		if (excluded(dir, path, &dtype))
> +			return 1;

The above starts by testing the empty string, and then after that test it 
goes on to the next directory component. That is just _odd_.

Wouldn't it be more natural to write the loop the other way around, ie 
_first_ look up the next directory component, and _then_ do the exclude 
processing for thoose components? 

Or is there some subtle reason I'm missing for actually checking the empty 
name?

				Linus

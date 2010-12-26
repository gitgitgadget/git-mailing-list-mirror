From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] diff: funcname and word patterns for perl
Date: Sun, 26 Dec 2010 05:22:04 -0600
Message-ID: <20101226112204.GA27124@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <201012261143.33190.trast@student.ethz.ch>
 <20101226105441.GA27039@burratino>
 <201012261206.11942.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Dec 26 12:22:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWogP-0000Hi-3M
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 12:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab0LZLW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 06:22:26 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33438 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab0LZLWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 06:22:25 -0500
Received: by iwn9 with SMTP id 9so7972732iwn.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 03:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9tFPjEcIYgj9pbBFCfPvuqeMr77s7zke+9FZjw6Zd54=;
        b=XEHrEr8x9BzEUquxt4t5BA2yWSiWsuCx5lYagm+9ExFML+ATYCUR9x+lVgAcF1DwdA
         EylWBZcDek22AV2S6Oa9U9O0HEpBUjjFSC7LSK1WxEi076uXS9VxTH7i1gOl/DkdnbSP
         GeQYKd/5qe2itsDCMc5JLLcfO83Gpzq5uY6A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a8CNRalI1wckDy+oXnUqqEk/2s8Hd3vx98igI3mUW8pWK8bU8+PakBe2ItTfwwutgQ
         xcSWXQUo1zkNLd7qzYvykvsBlBdzy2aUv/IMJU/LtWNZfyDaFfdwxOA1neKD2dHIn96R
         z08Tmlr1uvUDb5UBuiihMLSErY6twxj80/l7Q=
Received: by 10.42.170.138 with SMTP id f10mr11344585icz.187.1293362542669;
        Sun, 26 Dec 2010 03:22:22 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id i16sm9906621ibl.0.2010.12.26.03.22.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 03:22:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012261206.11942.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164189>

Thomas Rast wrote:

> I just took the laziest (and most obvious) approach possible when I
> wrote the original patterns.  I think the second most laziest one
> would be to observe that bit patterns for leading characters are
> always 11.., while those for continuation chars are 10..
> 
> So that gives
> 
>   |[\xc0-\xff][\x80-\xbf]+

Yes, that's what I was thinking of.  v2 will be a two-part series
starting with that.

BTW, the perl token matcher is pretty half-hearted.  In part this is
because "only perl can parse perl" [1] terrifies me and in part it is
because I am too lazy to write down the state machine implied by
PPI/Token/*.pm.

If some tokenization wizard would like to work on it, something like
the following might produce more pleasant word diffs:

	"[%&$][[:space:]]*[0-9]+"	/* $1 */
	"|[%&$][[:space:]]*([[:alpha:]_']|::)([[:alnum:]_']|::)*"	/* $var1 */
	"|[%&$][[:space:]]*\\$([[:alnum:]_]|::)([[:alnum:]_']|::)*"	/* $$var1 */
	"|[%&$][[:space:]]*\\$\\{"     /* $${ introducing complicated expression */
	"|[%&$][[:space:]]*\\$\\$"     /* $$$ introducing complicated expression */
	"|[%&$][[:space:]]*[^[:alnum:]_:'^$]"	/* $! */
	"|[%&$][[:space:]]*\\^[][A-Z\\^_?]"	/* $^A */
	"|[%&$][[:space:]]*\\{\\^[][A-Z\\^_?]\\}"	/* ${^A} */
	"|[%&$][[:space:]]*\\{\\^[][A-Z\\^_?][[:alnum:]_]*\\}" /* ${^Foo} */
	/* ${var} */
	"|[%&$][[:space:]]*\\{[[:space:]]*([[:alpha:]_']|::)[[:alnum:]_:]*[[:space:]]\\}"
	"|[%&$][[:space:]]*\\{"	/* ${ introducing complicated expression */
	...

though it is an unmaintainable mess. :)

[1] perl::toke.c and http://www.perlmonks.org/?node_id=44722

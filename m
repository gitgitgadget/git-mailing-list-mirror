From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Increase some limits in git-mailinfo
Date: Mon, 26 Feb 2007 12:13:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261207520.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702261107060.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262020590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 21:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLmDc-0002XX-Nd
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 21:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbXBZUNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 15:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbXBZUNF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 15:13:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60229 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161002AbXBZUND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 15:13:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QKCwhB005167
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 12:12:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QKCvvw030045;
	Mon, 26 Feb 2007 12:12:57 -0800
In-Reply-To: <Pine.LNX.4.63.0702262020590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.447 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40660>



On Mon, 26 Feb 2007, Johannes Schindelin wrote:
> 
> I know that you copied that, but why not use the new prefixcmp() function?

Heh. Partly just because I copied it, partly because I'm not that used to 
the interface (and partly becuase I hate how it uses the same complex 
interface as 'strncmp()' does - I'd much rather see a _boolean_ return 
value, instead of the tristate one it uses. I doubt anybody would ever use 
it for sorting purposes anyway, and the tristate return value just results 
in code that is harder to read).

So I'd rather have it return true if it matches, rather than false if it 
matches and -1/1 if it doesn't. But that's water under the bridge.


> > +	/* Get the first part of the line.. */
> > +	if (!fgets(line, sz, in))
> > +		return 0;
> > +
> > +	/*
> > +	 * Is it an empty line or not a valid rfc2822 header?
> > +	 * If so, stop here, and return false ("not a header")
> > +	 */
> > +	len = eatspace(line);
> > +	if (!len || !is_rfc2822_header(line)) {
> > +		/* Re-add the newline */
> > +		line[len] = '\n';
> > +		line[len + 1] = '\0';
> 
> Just a micro-issue: if the input ends in the middle of a header line, 
> _and_ this line is of exactly the right size (sz), then len + 1 is not 
> necessarily smaller than sz, right?

Yeah. It's an old bug, though, the old code had the same behaviour.

But you're right. It might be better to have a

	assert(sz);
	sz--;

at the top of the function, and just realize that sz is the size of the 
buffer minus the size for the final '\0', and that also indirectly would 
mean that even if the initial fgets() didn't have a '\n' at the end, we 
always have space to insert it.

> > +		addlen = eatspace(continuation);
> > +		if (len < sz) {
> 
> Shouldn't this be "sz - 1"? We are setting "line[len] = 0;" later... While 
> at it, we can always check for "addlen > 0", just in case?

Yeah. Again, the "sz--" would solve that.

			Linus

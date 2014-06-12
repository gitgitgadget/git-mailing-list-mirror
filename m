From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 01/19] add strbuf_set operations
Date: Thu, 12 Jun 2014 16:59:53 -0700
Message-ID: <20140612235953.GC17803@hudson.localdomain>
References: <cover.1402348696.git.jmmahler@gmail.com>
 <6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com>
 <5398460F.3040900@alum.mit.edu>
 <20140612071045.GC25353@hudson.localdomain>
 <53997F3C.9010608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 13 02:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvF13-0007sr-Jc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 02:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbaFLX76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 19:59:58 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46250 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbaFLX75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 19:59:57 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so1475887pdj.19
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M/CWfo6P8mp8QVB4LQtvHZSmDtZzaml1WzYkcQJOM+M=;
        b=Ek3RL22jBHaj4PdTrR4k0j2APZR8rEfbT63vAw+1cGfYemqB5jsWrIdxDskzMurTVG
         IdlBNABKtlxavYG3qjFPfzVreMHgcdUwoP8Dn0Xb5V9LY0ttsxvaUOhn7Km3f+rolUdv
         9Xfk2h1MezPdYIlFG+PVSCydC4zC1Dfx2FgAgd2xWSIBMkKxHaHnzuUuKgbg0EXk8RmP
         9ZNw+D+DgIOkUeAFmhhVBdA+TBZtmk2hwSL8yw30BVN8QiN9Zdzku8gfsUAInHy6KunV
         LdL509QkKglY6hhYZEenRkkD3OgirXitt0eQbwnSMQTpfBftO0c44oirFoV/nlonTSQm
         oWyg==
X-Received: by 10.69.31.97 with SMTP id kl1mr16574625pbd.162.1402617597257;
        Thu, 12 Jun 2014 16:59:57 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ib5sm166280pbb.55.2014.06.12.16.59.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 16:59:55 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53997F3C.9010608@alum.mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251507>

Michael,

On Thu, Jun 12, 2014 at 12:21:48PM +0200, Michael Haggerty wrote:
> On 06/12/2014 09:10 AM, Jeremiah Mahler wrote:
> > On Wed, Jun 11, 2014 at 02:05:35PM +0200, Michael Haggerty wrote:
> >> [...]
> >> If there were a function like strbuf_grow_to(sb, len):
> >>
> >> void strbuf_grow_to(struct strbuf *sb, size_t len)
> >> {
> >> 	int new_buf = !sb->alloc;
> >> 	if (unsigned_add_overflows(len, 1))
> >> 		die("you want to use way too much memory");
> >> 	if (new_buf)
> >> 		sb->buf = NULL;
> >> 	ALLOC_GROW(sb->buf, len + 1, sb->alloc);
> >> 	if (new_buf)
> >> 		sb->buf[0] = '\0';
> >> }
> >>
> > grow_to() which could reduce in size, interesting.
> 
> I don't understand what you mean by "could reduce in size".  This
> function can only grow, never reduce, the size of the strbuf, because
> ALLOC_GROW doesn't do anything unless the requested size is larger than
> the currently-allocated size.
> 
I got it now.  strbuf_grow() adds extra to the current buf.
strbuf_grow_to() will add more if len is larger than the current length.

> >> (strbuf_grow() could call it:
> >>
> >> static inline void strbuf_grow(struct strbuf *sb, size_t extra)
> >> {
> >> 	if (unsigned_add_overflows(sb->len, extra))
> >> 		die("you want to use way too much memory");
> >> 	strbuf_grow_to(sb, sb->len + extra);
> >> }
> >>
> >> ), then your function could be minimized to
> >>
> >> void strbuf_set(struct strbuf *sb, const void *data, size_t len)
> >> {
> >> 	strbuf_grow_to(sb, len);
> >> 	memcpy(sb->buf, data, len);
> >> 	strbuf_setlen(sb, len);
> >> }
> >>
> >> I think strbuf_grow_to() would be useful in other situations too.
> >>
> >> This is just an idea; I'm not saying that you have to make this change.
> >>
> > I like your idea.  I am leaning towards doing the un-optimized
> > strbuf_set operations first, then optimizing in a later patch.
> 
> That's a good plan.
> 
> In case you're interested, I sketched what the strbuf_grow_to() changes
> might look like, and also looked for other places in the code where
> strbuf_grow_to() could be used instead of strbuf_grow() [1].  This is
> only a sketch; I haven't even tested the result.  Feel free to use what
> you want from it.
> 
I started looking at it.  I will let you know if I get something
together.

> Michael
> 
> [1] Branch "strbuf-grow-to-sketch" on https://github.com/mhagger/git
> 
> -- 
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler

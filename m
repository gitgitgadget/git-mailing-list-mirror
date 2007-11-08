From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Thu, 8 Nov 2007 00:14:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080012510.4362@racer.site>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
 <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
 <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org>
 <4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx>
 <Pine.LNX.4.64.0711062343050.4362@racer.site> <47324810.2010507@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1883488808-1194480891=:4362"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipv3W-0004q0-4R
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbXKHAO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbXKHAO7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:14:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:54176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753811AbXKHAO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:14:58 -0500
Received: (qmail invoked by alias); 08 Nov 2007 00:14:57 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp033) with SMTP; 08 Nov 2007 01:14:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DFa1hlP2D9eGbCBjYxgWP/rRRZjVmZFtlKQcDW7
	xTkQ2C5wCjHj+J
X-X-Sender: gene099@racer.site
In-Reply-To: <47324810.2010507@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63908>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1883488808-1194480891=:4362
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 8 Nov 2007, René Scharfe wrote:

> Johannes Schindelin schrieb:
> 
> > On Wed, 7 Nov 2007, René Scharfe wrote:
> > 
> >> By the way, the more intrusive surgery required when using 
> >> strbuf_expand() leads to even faster operation.  Here my measurements 
> >> of most of Paul's test cases (best of three runs):
> >>
> >> [...]
> > 
> > impressive timings.  Although I wonder where the time comes from, as 
> > the other substitutions should not be _that_ expensive.
> 
> I haven't run a profiler, but my two suspects are the malloc()s and 
> free()s done by interp_set_entry(), and the fact that 
> format_commit_message() calls interpolate() twice.

But of course! *slapsthehead*

> > In any case, your approach seems much more sensible, now that we have 
> > strbuf.
> > 
> >> diff --git a/strbuf.h b/strbuf.h
> >> index cd7f295..95071d5 100644
> >> --- a/strbuf.h
> >> +++ b/strbuf.h
> >> @@ -102,6 +102,9 @@ static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
> >>  	strbuf_add(sb, sb2->buf, sb2->len);
> >>  }
> >>  
> >> +typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
> >> +extern void strbuf_expand(struct strbuf *sb, const char *fmt, const char **placeholders, expand_fn_t fn, void *context);
> > 
> > I wonder if it would even faster (but maybe not half as readable) if 
> > expand_fd_t got the placeholder_index instead of the placeholder.
> 
> I doubt it.  All this would save is one pointer dereference per
> placeholder.  I haven't tried and measured this, though.

My thinko.  I thought that you save one prefixcmp(), but strbuf_expand() 
offloads that to the callback function.

Thanks,
Dscho

--8323584-1883488808-1194480891=:4362--

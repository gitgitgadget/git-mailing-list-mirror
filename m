From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 18:21:39 +0200
Message-ID: <20071005162139.GC31413@uranus.ravnborg.org>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org> <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idput-0002ya-6u
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929AbXJEQUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbXJEQUM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:20:12 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:54838 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756756AbXJEQUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:20:11 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 2AD7DE30ADA;
	Fri,  5 Oct 2007 18:20:09 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id ACCD0580D2; Fri,  5 Oct 2007 18:21:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60103>

On Fri, Oct 05, 2007 at 08:26:44AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 5 Oct 2007, Pierre Habouzit wrote:
> >  
> > -	strbuf_grow(buf, len);
> > +	/* only grow if not in place */
> > +	if (strbuf_avail(buf) + buf->len < len)
> > +		strbuf_grow(buf, len - buf->len);
> 
> Umm. This is really ugly.
> 
> The whole point of strbuf's was that you shouldn't be doing your own 
> allocation decisions etc. So why do it?
> 
> Wouldn't it be much better to have a strbuf_make_room() interface that 
> just guarantees that there is enough room fo "len"? 
> 
> Otherwise, code like the above would seem to make the whole point of a 
> safer string interface rather pointless. The above code only makes sense 
> if you know how the strbuf's are internally done, so it should not exists 
> except as internal strbuf code. No?

Took a short look at strbuf.h after seeing the above code.
And I was suprised to see that all strbuf users were exposed to
the strbuf structure.
Following patch would at least make sure noone fiddle with strbuf internals.
Cut'n'paste - only for the example of it.
It simply moves strbuf declaration to the .c file where it rightfully belongs.

git did not build with this change....

	Sam


diff --git a/strbuf.c b/strbuf.c
index e33d06b..0d2d578 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,14 @@
 #include "cache.h"
 #include "strbuf.h"
 
+struct strbuf {
+       int alloc;
+       int len;
+       int eof;
+       char *buf;
+};
+
+
 void strbuf_init(struct strbuf *sb) {
        sb->buf = NULL;
        sb->eof = sb->alloc = sb->len = 0;
diff --git a/strbuf.h b/strbuf.h
index 74cc012..c057be3 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,11 +1,6 @@
 #ifndef STRBUF_H
 #define STRBUF_H
-struct strbuf {
-       int alloc;
-       int len;
-       int eof;
-       char *buf;
-};
+struct strbuf;
 
 extern void strbuf_init(struct strbuf *);
 extern void read_line(struct strbuf *, FILE *, int);

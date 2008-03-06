From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 02:14:43 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803060212170.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site>
 <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 02:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX4he-0001EN-Gh
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 02:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbYCFBOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 20:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYCFBOo
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 20:14:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:49858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751214AbYCFBOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 20:14:43 -0500
Received: (qmail invoked by alias); 06 Mar 2008 01:14:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 06 Mar 2008 02:14:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YR0VTFAiYE4C8c7JEBR6vt3J5w3ZjBhSH5Mxrw8
	mDsFxX/FCMsKA2
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803052327570.15786@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76303>


The most common use of addf() was to init a strbuf and addf() right away.
Since it is so common, it makes sense to have a function strbuf_initf()
to wrap both calls into one.

Unfortunately, C (and cpp) has no way to make this easy without code
duplication, as we need to va_init() in strbuf_addf() possibly a few
times.  So the code for addf() is copied.  Fortunately, the code is
pretty short, so not too much had to be copied as-is.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 5 Mar 2008, Johannes Schindelin wrote:

	> On Wed, 5 Mar 2008, Junio C Hamano wrote:
	> 
	> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> > 
	> > > [... I'd submit my ] a Reviewed-by:, but I think that this 
	> > > would only be a burden on our maintainer.
	> > 
	> > I think Reviewed-by: would indeed be a very good addition to 
	> > our patch flow convention, borrowing from the kernel folks.
	> 
	> You mean you have more people to blame, then? ;-)

	Well, it was meant as a joke...

	Anyway, here is a start of a patch series that should help the 
	King Penguin...

	strbuf_initf() is something I long planned to do; Kristian just 
	pushed me over the edge.

 strbuf.c |   23 +++++++++++++++++++++++
 strbuf.h |    2 ++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 5afa8f3..067d55a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -147,6 +147,29 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_initf(struct strbuf *sb, const char *fmt, ...)
+{
+	int len;
+	va_list ap;
+
+	strbuf_init(sb, strlen(fmt) + 64);
+	va_start(ap, fmt);
+	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+	va_end(ap);
+	if (len < 0)
+		die("your vsnprintf is broken");
+	if (len > strbuf_avail(sb)) {
+		strbuf_grow(sb, len);
+		va_start(ap, fmt);
+		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+		va_end(ap);
+		if (len > strbuf_avail(sb)) {
+			die("this should not happen, your snprintf is broken");
+		}
+	}
+	strbuf_setlen(sb, sb->len + len);
+}
+
 void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 		   void *context)
 {
diff --git a/strbuf.h b/strbuf.h
index faec229..eaf2409 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -108,6 +108,8 @@ extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format(printf,2,3)))
+extern void strbuf_initf(struct strbuf *sb, const char *fmt, ...);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
-- 
1.5.4.3.571.g9aec3


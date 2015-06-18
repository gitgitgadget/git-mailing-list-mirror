From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Thu, 18 Jun 2015 17:13:53 +0700
Message-ID: <20150618101353.GA6525@lanh>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
 <CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
 <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
 <20150617191235.GB25304@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 12:13:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5WpE-0005g7-JP
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbbFRKNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:13:32 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36100 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbFRKNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:13:30 -0400
Received: by pdjm12 with SMTP id m12so63434891pdj.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TxDzGgKhCdGFVBGo1/AQve1WCbwcbbuOv2DzNzpT94U=;
        b=rbvVuuY0xW/BIWcWMBTzySyFxkcCNYlqpnYu2eqDZJvbAvpQvpc+w6mFfn0AYNfylx
         OL6yPxnYYlkl2zoXtOXh3sjl+aZ7PMWQridZGdZXF6usLv1L47KqZJ3YfijBiWIoLeSD
         jll1BRr7aEmTFaBKSgo7UvKCRS2/h/1P/TX1vdGJ3g8iXPL3cviAYixjgPSHvSYIZRPp
         WYuaveraWS42ZZPZaRWR5l7SdNECvSb4PxkUTyAl5nU/SGvN6fHDrnkROp4b82eeFRA/
         sz3C2EH8FRumL5zT3Td7S504Zmg6ZMVHtdKSowZ5zRvSHTXK8icMyxJ0uSHYBVkNlMNX
         ZbaA==
X-Received: by 10.70.134.70 with SMTP id pi6mr19746313pdb.100.1434622409838;
        Thu, 18 Jun 2015 03:13:29 -0700 (PDT)
Received: from lanh ([115.73.27.68])
        by mx.google.com with ESMTPSA id x16sm7477859pbt.87.2015.06.18.03.13.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 03:13:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 18 Jun 2015 17:13:54 +0700
Content-Disposition: inline
In-Reply-To: <20150617191235.GB25304@peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271941>

On Wed, Jun 17, 2015 at 03:12:35PM -0400, Jeff King wrote:
> On Wed, Jun 17, 2015 at 10:58:10AM -0700, Stefan Beller wrote:
> 
> > > Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it's
> > > happy, we'll have cleaner defect list
> > 
> > It's down 31 defects, roughly 10% of all things coverity detected as
> > problematic.
> > YAY!
> 
> That's a good thing.  I do find the solution a little gross, though. I
> wonder if there is a way we can tell coverity more about how strbuf
> works. I've noticed similar problems with string_list, where it
> complains that we are touching list->items, which was assigned to NULL
> (of course it was, but then after that we did string_list_append!).

There's "function modeling" where you write simplified (and likely
incorrect) version of a function to correct how coverity's
understanding of that function. I searched, there's no "data
modeling". I think I have the user manual, but haven't looked through
it yet.

On Thu, Jun 18, 2015 at 2:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I actually think this is too ugly to live.

Well, I have another option below. Let's see how people feel about it.

> If coverity is buggy and unusable, why aren't we raising that issue
> to them?

It's technically correct though. The key point here is strbuf_slopbuf[0]
is NUL, but that cannot be statically determined. And we may also need
to teach it about strcmp' and friends' semantics. That's probably too
much for a static analyzer.

The last resort is simply filter out a whole class of warnings.
Probably good enough if both patches look equally ugly.

-- 8< --
Subject: [PATCH] strbuf: kill strbuf_slopbuf, in favor of ""

A lot of "out-of-bound access" warnings on scan.coverity.com is because
it does not realize this strbuf_slopbuf[] is in fact initialized with a
single and promised to never change. But that promise could be broken if
some caller attempts to write to strbuf->buf[0] write after STRBUF_INIT.

We really can't do much about it. But we can try to put strbuf_slopbuf
in .rodata section, where writes will be caught by the OS with memory
protection support. The only drawback is people can't do
"buf->buf == strbuf_slopbuf" any more. Luckily nobody does that in the
current code base.
---
 strbuf.c | 19 ++++++-------------
 strbuf.h | 11 ++++++++---
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 0d4f4e5..9f91229 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,17 +11,10 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
-/*
- * Used as the default ->buf value, so that people can always assume
- * buf is non NULL and ->buf is NUL terminated even for a freshly
- * initialized strbuf.
- */
-char strbuf_slopbuf[1];
-
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
 	sb->alloc = sb->len = 0;
-	sb->buf = strbuf_slopbuf;
+	sb->buf = (char*)"";
 	if (hint)
 		strbuf_grow(sb, hint);
 }
@@ -52,7 +45,7 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 	sb->len   = len;
 	sb->alloc = alloc;
 	strbuf_grow(sb, 0);
-	sb->buf[sb->len] = '\0';
+	strbuf_terminate(sb);
 }
 
 void strbuf_grow(struct strbuf *sb, size_t extra)
@@ -77,7 +70,7 @@ void strbuf_rtrim(struct strbuf *sb)
 {
 	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
 		sb->len--;
-	sb->buf[sb->len] = '\0';
+	strbuf_terminate(sb);
 }
 
 void strbuf_ltrim(struct strbuf *sb)
@@ -88,7 +81,7 @@ void strbuf_ltrim(struct strbuf *sb)
 		sb->len--;
 	}
 	memmove(sb->buf, b, sb->len);
-	sb->buf[sb->len] = '\0';
+	strbuf_terminate(sb);
 }
 
 int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
@@ -380,7 +373,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 		strbuf_grow(sb, 8192);
 	}
 
-	sb->buf[sb->len] = '\0';
+	strbuf_terminate(sb);
 	return sb->len - oldlen;
 }
 
@@ -496,7 +489,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	if (ch == EOF && sb->len == 0)
 		return EOF;
 
-	sb->buf[sb->len] = '\0';
+	strbuf_terminate(sb);
 	return 0;
 }
 #endif
diff --git a/strbuf.h b/strbuf.h
index 01c5c63..d8346ee 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -67,8 +67,13 @@ struct strbuf {
 	char *buf;
 };
 
-extern char strbuf_slopbuf[];
-#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
+#define STRBUF_INIT  { 0, 0, (char*)"" }
+
+static inline void strbuf_terminate(struct strbuf *sb)
+{
+	if (sb->buf[sb->len])
+		sb->buf[sb->len] = '\0';
+}
 
 /**
  * Life Cycle Functions
@@ -149,7 +154,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
 		die("BUG: strbuf_setlen() beyond buffer");
 	sb->len = len;
-	sb->buf[len] = '\0';
+	strbuf_terminate(sb);
 }
 
 /**
-- 
2.3.0.rc1.137.g477eb31
-- 8< --
-- 
Duy

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Fri, 19 Jun 2015 17:39:46 +0700
Message-ID: <20150619103946.GA20493@lanh>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
 <CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
 <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
 <20150617191235.GB25304@peff.net>
 <20150618101353.GA6525@lanh>
 <xmqqioalezhq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:39:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5thv-0002SL-MW
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbbFSKj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 06:39:28 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36811 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbbFSKjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:39:21 -0400
Received: by pdjm12 with SMTP id m12so88144890pdj.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WjCVE8dq4VlGwvz46Elvpe1CHSuCnPToi3yUDwJTKnQ=;
        b=ee0iZhrlSCaXkmwoJTX0QEKEXBPBMMWKbxR//l90xUD533lAL3N2GvJHKydiBuaaR7
         ITtDrZ4JCOltoDUoKVFN5fYyuwvQVTnIg5QBecL7XvKijN8c2ypAvYrvrB1wr6pXUIV9
         zdG8fYPM/JjM/Y0y/lIgsrJ+cHHhczSBHzQcDITwHievp46J1IJ+xg7c7/4R7vnopnGJ
         MCKP85abPk7KZOvKTUHwkGKzzFQjDmqmRoTN83QpduYB8RZTAkPI+QOjNPJygHs9kFoJ
         6HWpH7QsJW6/mwsx5Ia/WIsgdoC8KBqc+Wiuu4dJvJ216FRU2o39hD2EjtG0RcK1NJKR
         i4nQ==
X-Received: by 10.70.42.13 with SMTP id j13mr30687952pdl.90.1434710361103;
        Fri, 19 Jun 2015 03:39:21 -0700 (PDT)
Received: from lanh ([115.73.11.44])
        by mx.google.com with ESMTPSA id fk4sm10754767pbb.80.2015.06.19.03.39.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2015 03:39:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 19 Jun 2015 17:39:46 +0700
Content-Disposition: inline
In-Reply-To: <xmqqioalezhq.fsf@gitster.dls.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272121>

On Thu, Jun 18, 2015 at 09:46:09AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > The last resort is simply filter out a whole class of warnings.
> > Probably good enough if both patches look equally ugly.
> >
> > -- 8< --
> > Subject: [PATCH] strbuf: kill strbuf_slopbuf, in favor of ""
> >
> > A lot of "out-of-bound access" warnings on scan.coverity.com is because
> > it does not realize this strbuf_slopbuf[] is in fact initialized with a
> > single and promised to never change. But that promise could be broken if
> > some caller attempts to write to strbuf->buf[0] write after STRBUF_INIT.
> >
> > We really can't do much about it. But we can try to put strbuf_slopbuf
> > in .rodata section, where writes will be caught by the OS with memory
> > protection support. The only drawback is people can't do
> > "buf->buf == strbuf_slopbuf" any more. Luckily nobody does that in the
> > current code base.
> > ---
> 
> Hmph, would declaring slopbuf as "const char [1]" (and sprinkling
> the "(char *)" cast) have the same effect, I wonder?

I remember I tried that and failed with a compile error. I just tried
again, this time it worked. Must have made some stupid mistake in my
first try.

Anyway it does not put strbuf_slopbuf in .rodata. "./git" does not
segfault with this patch

-- 8< --
diff --git a/git.c b/git.c
index 44374b1..960e375 100644
--- a/git.c
+++ b/git.c
@@ -621,7 +621,11 @@ int main(int argc, char **av)
 	const char **argv = (const char **) av;
 	const char *cmd;
 	int done_help = 0;
+	struct strbuf sb = STRBUF_INIT;
 
+	sb.buf[0] = 'Z';
+	printf("%c\n", strbuf_slopbuf[0]);
+	return 0;
 	startup_info = &git_startup_info;
 
 	cmd = git_extract_argv0_path(argv[0]);
diff --git a/strbuf.c b/strbuf.c
index 0d4f4e5..3a0d4c9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -16,12 +16,12 @@ int starts_with(const char *str, const char *prefix)
  * buf is non NULL and ->buf is NUL terminated even for a freshly
  * initialized strbuf.
  */
-char strbuf_slopbuf[1];
+const char strbuf_slopbuf[1];
 
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
 	sb->alloc = sb->len = 0;
-	sb->buf = strbuf_slopbuf;
+	sb->buf = (char *)strbuf_slopbuf;
 	if (hint)
 		strbuf_grow(sb, hint);
 }
diff --git a/strbuf.h b/strbuf.h
index 01c5c63..eab7307 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -67,8 +67,8 @@ struct strbuf {
 	char *buf;
 };
 
-extern char strbuf_slopbuf[];
-#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
+extern const char strbuf_slopbuf[];
+#define STRBUF_INIT  { 0, 0, (char *)strbuf_slopbuf }
 
 /**
  * Life Cycle Functions
-- 8< --

> > +static inline void strbuf_terminate(struct strbuf *sb)
> > +{
> > +	if (sb->buf[sb->len])
> > +		sb->buf[sb->len] = '\0';
> > +}
> 
> This is so that you can call things like strbuf_rtrim() immediately
> after running strbuf_init() safely, but I think it needs a comment
> to save people from wondering what is going on, e.g. "this is not an
> optimization to avoid assigning NUL to a place that is already NUL;
> a freshly initialized strbuf points at an unwritable piece of NUL
> and we do not want to cause a SEGV".

Sure, if we go with this direction.
--
Duy

From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Tue, 07 Apr 2015 15:48:33 +0200
Organization: D03
Message-ID: <87zj6kjbgu.fsf@rasmusvillemoes.dk>
References: <20150405010611.GA15901@peff.net>
	<20150405011110.GC30127@peff.net> <20150405045614.GA12053@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 15:48:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfTrx-0001uH-3t
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 15:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbbDGNsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 09:48:40 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36673 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbbDGNsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 09:48:36 -0400
Received: by lbbqq2 with SMTP id qq2so34372495lbb.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=a91We2B7oHtruYC6wIHSDtUDN1U/O+yeq/AhvC9XITc=;
        b=QzMneagpjMB95inQobXUvKRZzFV6+WCmjR7RzMhj+9G22bn/KPPc+5IxSp6U/Mg/MT
         3s5hbcccspNb9aMbiHmtc5uCns/G4KyYWH2oL301/6MMoJCBqKJ+OP860js44VPBjZgx
         OavrbZwO0Jq98k1e+ZS+QDGfu6PRNkHbLbGxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=a91We2B7oHtruYC6wIHSDtUDN1U/O+yeq/AhvC9XITc=;
        b=PWyRVUwjnUXXSwIonUpelD4oEvF/GsYFO0tLMQeextefaAvbxlEzuyMvx2xgneV8iQ
         Lbdfr9I0y7ANzlHaF42E3qgW8pvSOOHgozA5iq5V1/eL7E5l4dsp0Q6OQI86v2+Ysg6I
         /YC68GD2NDEP45zhPbzAntNSSZ070tS6DyE3w0IzwR5A/7gBsqlsK2Yyvh0SnZZOUvEQ
         XnPuEEAghprAolY9sIUq7zhbCraiyaxACDburrN0XqOjJ4262Tmvvfhrgp4zBnn6IYWp
         Ux76Hnjx0Q8VHGgHOCkDpS+BJbH8CnzAEVdA4yfETQoNg0jIj3/sIoLvLcVHU1v2vJwA
         wLzw==
X-Gm-Message-State: ALoCoQkc2b1OjYG7Gh3ny3GDEH/+u84b+Cbp9juMM7ApTZVcklkxUJsOF65x3QdO0fH0uv0GTgi3
X-Received: by 10.112.56.42 with SMTP id x10mr18441193lbp.123.1428414515142;
        Tue, 07 Apr 2015 06:48:35 -0700 (PDT)
Received: from morgan.rasmusvillemoes.dk ([130.225.20.51])
        by mx.google.com with ESMTPSA id m8sm590743lbs.17.2015.04.07.06.48.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Apr 2015 06:48:34 -0700 (PDT)
X-Hashcash: 1:20:150407:git@vger.kernel.org::dwklhrSaiMiTE1p0:0000000000000000000000000000000000000000004MsI
X-Hashcash: 1:20:150407:peff@peff.net::60PKGdqbO5/lWLFo:00008AlA
In-Reply-To: <20150405045614.GA12053@peff.net> (Jeff King's message of "Sun, 5
	Apr 2015 00:56:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266913>

On Sun, Apr 05 2015, Jeff King <peff@peff.net> wrote:

> which is back to the v2.0.0 number. Even with the extra strlen, it seems
> that what fgets does internally beats repeated getc calls. Which I guess
> is not too surprising, as each getc() will have to check for underflow
> in the buffer. Perhaps there is more room to micro-optimize
> strbuf_getwholeline, but I kind of doubt it.
>
> The big downside is that our input strings are no longer NUL-clean
> (reading "foo\0bar\n" would yield just "foo". I doubt that matters in
> the real world, but it does fail a few of the tests (e.g., t7008 tries
> to read a list of patterns which includes NUL, and we silently truncate
> the pattern rather than read in the NUL and barf).
>
> So we'd have to either:
>
>   1. Decide that doesn't matter.
>
>   2. Have callers specify a "damn the NULs, I want it fast" flag.
>
>   3. Find some alternative that is more robust than fgets, and faster
>      than getc. I don't think there is anything in stdio, but I am not
>      above dropping in a faster non-portable call if it is available,
>      and then falling back to the current code otherwise.

getdelim is in POSIX 2008
(http://pubs.opengroup.org/stage7tc1/functions/getdelim.html), so should
be available on any half-{d,r}ecent platform. It obviously has the
advantage of having access to the internal stdio buffer, and by
definition handles embedded NULs. No idea if using such modern
interfaces in git is ok, though. 

Implementation-wise, I think strbuf_getwholeline could be implemented
mostly as a simple wrapper for getdelim. If I'm reading the current code
and the posix spec for getdelim correctly, something like this should do
it (though obviously not meant to be included as-is):

diff --git a/strbuf.c b/strbuf.c
index 0346e74..d3338b9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -434,6 +434,32 @@ int strbuf_getcwd(struct strbuf *sb)
 	return -1;
 }
 
+#if USE_GETDELIM
+/* Hacky declaration to avoid messing with feature test macros. */
+ssize_t getdelim(char **, size_t *, int, FILE *);
+int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
+{
+	ssize_t r;
+
+	if (feof(fp))
+		return EOF;
+
+	strbuf_reset(sb);
+	if (!sb->alloc)
+		sb->buf = NULL;
+
+	r = getdelim(&sb->buf, &sb->alloc, term, fp);
+
+	if (r > 0) {
+		sb->len = r;
+		return 0;
+	}
+	assert(r == -1);
+	if (!sb->buf)
+		strbuf_init(sb);
+	return EOF;
+}
+#else
 int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
@@ -454,6 +480,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	sb->buf[sb->len] = '\0';
 	return 0;
 }
+#endif
 
 int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 {


Rasmus

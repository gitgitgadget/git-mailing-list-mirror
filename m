From: Duy Nguyen <pclouds@gmail.com>
Subject: Support customized reordering in version sort
Date: Sat, 21 Feb 2015 10:02:10 +0700
Message-ID: <20150221030209.GA567@lanh>
References: <20150218191417.GA7767@peff.net>
 <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
 <20150220071342.GB8763@peff.net>
 <CAPc5daVJ_nYk=tWqpUYPpsX6Z50H429jOh8QfMwUdNDdTDMq9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 04:02:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP0KQ-00055m-0H
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 04:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbbBUDBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 22:01:53 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:43630 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbbBUDBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 22:01:52 -0500
Received: by paceu11 with SMTP id eu11so12528387pac.10
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CpBvYfm/dHPt2b9uPhzf5rJ0Mgu2jOy5PGWfuYOjIkY=;
        b=d9Jt4kHr2+vR0lhlY+Lm3DjNX2mxryvWFerczV5TC5Fjp2kGD27UadXHXqZEIF7KsH
         cCa3neRWjUjiVdtkLmIHLPH6gXqKR5YElw7IGyLuG7EAO+XMfHNoQ59t4AeYMwvYm8li
         WmiCGvnGqd+wlCDRJ2NOxvGubHrxzD7nIEK45UFGssmYmlzK26dL8bmAhV07shUfFJpB
         U69ld80bBG3CbUA7pUMbgdiC3qoWvwv6ubMSqiPL087+e61Mr/Qg0Vcvs+cnr3ETvdfs
         CJjK+41meiqon250PS8JhvxxsHHv4tRjYVE+jvSw6bWvrcg1QTEgMkMJBCC1laHtPJ52
         mbqA==
X-Received: by 10.66.66.230 with SMTP id i6mr1228997pat.108.1424487712064;
        Fri, 20 Feb 2015 19:01:52 -0800 (PST)
Received: from lanh ([115.73.192.171])
        by mx.google.com with ESMTPSA id cq5sm25966134pbc.79.2015.02.20.19.01.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 19:01:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Feb 2015 10:02:10 +0700
Content-Disposition: inline
In-Reply-To: <CAPc5daVJ_nYk=tWqpUYPpsX6Z50H429jOh8QfMwUdNDdTDMq9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264199>

On Fri, Feb 20, 2015 at 12:26:29AM -0800, Junio C Hamano wrote:
> On Thu, Feb 19, 2015 at 11:13 PM, Jeff King <peff@peff.net> wrote:
> 
> >> There is debian bug 777690 [1] that's basically about making tag's
> >> version sort aware about -rc, -pre suffixes. I imagine it would touch
> >> versioncmp.c and builtin/tag.c (to retrieve the suffixes from config
> >> file).
> >>
> >> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=777690
> >
> > I think that's a reasonable thing to work on, but it's too big for a
> > microproject and too small for a GSoC.
> 
> That is certainly too big as a Micro, but I do not think it is too small
> for GSoC, if it is to be done right (meaning, not just implementing an
> arbitrary version comparison hardwired, but design how to make it
> extensible).

I did write "maybe more of mini-size than micro" then looked at the
micro list again and somehow decided to delete that. Anyway while I
still have my attention on it, might as well do it.

My idea is to make it easy for the user to change the sort algorithm.
And it's probably intuitive to just substitute a string with
something. So if "1-rc1" is put incorrectly before "1.1" and you
realize that "1.999" ought to be the last one before "2". You could
tell git to internally replace "1-rc1" with "1.999".

This patch does that. The user feeds substitution rules via
versionsort.substitute config keys, e.g.

    git config versionsort.substitute "-rc .999"

Performance is not a concern because I don't think people would throw
100k tags to it. There are two issues I'm aware of but not addressed:

 - the order of substitution matters, but right now it's up in the air
 - case-sensitiveness may surprise users

-- 8< --
diff --git a/versioncmp.c b/versioncmp.c
index 7511e08..2419e38 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "strbuf.h"
 
 /*
  * versioncmp(): copied from string/strverscmp.c in glibc commit
@@ -20,6 +21,57 @@
 #define  CMP    2
 #define  LEN    3
 
+struct subst_rule
+{
+	const char *before;
+	const char *after;
+};
+static struct subst_rule *rules;
+static int rule_nr, rule_alloc;
+
+static int versioncmp_config(const char *k, const char *v, void *cb)
+{
+	char *p, *s;
+	if (strcmp(k, "versionsort.substitute"))
+		return 0;
+	ALLOC_GROW(rules, rule_nr + 1, rule_alloc);
+	s = xstrdup(v);
+	p = strchr(s, ' ');
+	if (!p)
+		return error("missing space in %s", v);
+	*p = '\0';
+	rules[rule_nr].before = s;
+	rules[rule_nr].after = p + 1;
+	rule_nr++;
+	return 0;
+}
+
+static char *substitute(const unsigned char **strp)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *str = (const char *)*strp;
+	int i;
+	if (!rules) {
+		rules = xmalloc(sizeof(*rules));
+		rule_alloc = 1;
+		git_config(versioncmp_config, NULL);
+	}
+	for (i = 0; i < rule_nr; i++) {
+		const struct subst_rule *r = rules + i;
+		const char *p = strstr(str, r->before);
+		if (!p)
+			continue;
+		if (!sb.len)
+			strbuf_addstr(&sb, str);
+		strbuf_splice(&sb, p - str, strlen(r->before),
+			      r->after, strlen(r->after));
+		str = sb.buf;
+	}
+	if ((const unsigned char *)str == *strp)
+		return NULL;
+	*strp = (const unsigned char *)sb.buf;
+	return sb.buf;
+}
 
 /*
  * Compare S1 and S2 as strings holding indices/version numbers,
@@ -32,6 +84,7 @@ int versioncmp(const char *s1, const char *s2)
 {
 	const unsigned char *p1 = (const unsigned char *) s1;
 	const unsigned char *p2 = (const unsigned char *) s2;
+	char *free1, *free2;
 	unsigned char c1, c2;
 	int state, diff;
 
@@ -58,6 +111,8 @@ int versioncmp(const char *s1, const char *s2)
 
 	if (p1 == p2)
 		return 0;
+	free1 = substitute(&p1);
+	free2 = substitute(&p2);
 
 	c1 = *p1++;
 	c2 = *p2++;
@@ -75,6 +130,10 @@ int versioncmp(const char *s1, const char *s2)
 	}
 
 	state = result_type[state * 3 + (((c2 == '0') + (isdigit (c2) != 0)))];
+	if (state != LEN) {
+		free(free1);
+		free(free2);
+	}
 
 	switch (state) {
 	case CMP:
@@ -82,10 +141,16 @@ int versioncmp(const char *s1, const char *s2)
 
 	case LEN:
 		while (isdigit (*p1++))
-			if (!isdigit (*p2++))
+			if (!isdigit (*p2++)) {
+				free(free1);
+				free(free2);
 				return 1;
+			}
 
-		return isdigit (*p2) ? -1 : diff;
+		c2 = *p2;
+		free(free1);
+		free(free2);
+		return isdigit (c2) ? -1 : diff;
 
 	default:
 		return state;
-- 8< --

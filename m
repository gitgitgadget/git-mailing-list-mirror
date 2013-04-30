From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 22:04:31 +0700
Message-ID: <20130430150430.GA13398@lanh>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 30 17:03:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXC5x-0002qd-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 17:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760498Ab3D3PDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 11:03:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34495 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759722Ab3D3PDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 11:03:48 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so350443pdi.35
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SqP4GU4TFdxO4AGHF4hWvagiYiGvGmyEYIkLJTo+haM=;
        b=gDTwq2xF3bcPKY61IdJzNva8xE0uO8345D05h7G+L3bfp4K0NgWb1Y1XwzV6hPRfzQ
         2KKoSm6rHenpV63AMSSdD28dnYqWvsiaynSy/Z+5lFmhc2VfO4ls2SNpKuMn5CmYU0ST
         nn1HmQx1VDMnTtx0ipVizfYxmndS8WHvkzBy5FWhgGVqI9cf46a/qSAsMu8NKWm2yuRI
         wmzOgF/nCH5UGeVsNqWJDyj+zKOm9X6TC2HnXePwt+pzH+eE4p3M0Z5qSeA52XpjTWDG
         qHIX8/15ZXS8DnEH5jQrmLoo04GSZaR3X24jkhMOmfY6flXxebFJGrEYYi7JeGNQSZ5v
         Cz2A==
X-Received: by 10.66.122.140 with SMTP id ls12mr64730615pab.197.1367334228182;
        Tue, 30 Apr 2013 08:03:48 -0700 (PDT)
Received: from lanh ([115.74.35.43])
        by mx.google.com with ESMTPSA id wz9sm28854364pbc.5.2013.04.30.08.03.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 08:03:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 22:04:31 +0700
Content-Disposition: inline
In-Reply-To: <87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222938>

On Tue, Apr 30, 2013 at 03:01:22PM +0200, Thomas Rast wrote:
> > This patch has the exact same effect as:
> >
> >     $ git symbolic-ref @ HEAD
> 
> But then why don't you just 'git symbolic-ref H HEAD' for a sort of
> "local alias"?

For me, it's because I don't want to do that on every repo. One day if
I change my mind and make P the new alias, i'll need to update every
repo again.

> 
> What annoys me more is that there's no way to say
> 
>   git symbolic-ref U @{u}
> 
> so that I can avoid that -- it's really clumsy to type on a Swiss German
> keyboard.  We'd need some sort of ref-alias feature for that to work.

It's not hard to do. The below patch makes "." equivalent to HEAD and
".U" -> "@{u}". Refs are not supposed to have '.' at the beginning, so
it's easy to figure somebody is using alias from what they send
you. Supporting refalias.* config should be easy.

-- 8< --
diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..7842147 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1239,6 +1239,27 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
+static int get_sha1_with_alias(const char *name, int namelen,
+			       unsigned char *sha1, int flags)
+{
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+	int alias_len = strcspn(name, "@^~:");
+	if (alias_len > namelen)
+		alias_len = namelen;
+
+	if (alias_len == 0)	/* '.' is equal to HEAD */
+		strbuf_addstr(&sb, "HEAD");
+	else if (alias_len == 1 && !strncmp(name, "U", 1))
+		strbuf_addstr(&sb, "@{u}");
+	else
+		return error("unknown alias %.*s", alias_len, name);
+	strbuf_addstr(&sb, name + alias_len);
+	ret = get_sha1_1(sb.buf, sb.len, sha1, flags);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int get_sha1_with_context_1(const char *name,
 				   unsigned flags,
 				   const char *prefix,
@@ -1252,6 +1273,8 @@ static int get_sha1_with_context_1(const char *name,
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
+	if (name[0] == '.')
+		return get_sha1_with_alias(name + 1, namelen - 1, sha1, flags);
 	ret = get_sha1_1(name, namelen, sha1, flags);
 	if (!ret)
 		return ret;
-- 8< --

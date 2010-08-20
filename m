From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: wishlist bugreport: make limit configurable for
 do_fmt_merge_msg (merge.log)
Date: Fri, 20 Aug 2010 12:17:44 +0530
Message-ID: <20100820064741.GC12794@kytes>
References: <20100820020127.GG22469@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 08:49:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmLQ2-0003NY-PN
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 08:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab0HTGte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 02:49:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36556 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab0HTGtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 02:49:32 -0400
Received: by iwn5 with SMTP id 5so491131iwn.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FJKeqKpyZ425NP21kPVPjU8/RLo0anx6wnn34BJCSKo=;
        b=FYLGWQNNGdLoBVq+xlVYO519VLhPrndkhJAX+UtGdB08E7EGsep2ZvJd2kHJE6LPqD
         gTbUznegXEThdI2HMuwLyEb1EkUARSZGrRmHO4O4mosDAhPN9MiHbCTXoXEQoOmwQtVu
         PepB9/dEy2rkqYml7cEaGTeC8IJWE6lmEeZtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dPmIU0glEaYA18bcDaq/oQbeCKPvDHGfbUA9Ll3hgW3ybwh8BBzVKaFpVIUE0rtSZP
         w0blep7KeNIX5Wq+FKg0ODAeDz447RpWEoB/BXySUxnuLEgiN2Rz4X9Ep00H2Vh+dcPc
         Tch++NHR8bj8sdbADa0hw354Qxe3ClrgU9JEo=
Received: by 10.231.169.149 with SMTP id z21mr1288678iby.11.1282286971727;
        Thu, 19 Aug 2010 23:49:31 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n20sm2295146ibe.5.2010.08.19.23.49.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 23:49:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820020127.GG22469@onerussian.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153977>

Hi Yaroslav,

Yaroslav Halchenko writes:
> merge.log (or merge.summary) enables a really nice feature of including
> a list of commits involved in the merge.  Unfortunately it is limited to
> 20 entries and only includes total number of included commits if that is
> larger than 20.
> 
> Looking at the source code (if I got it right)
> 
> static int do_fmt_merge_msg(int merge_title, int merge_summary,
> 	struct strbuf *in, struct strbuf *out) {
> 	int limit = 20, i = 0, pos = 0;
> .... no line touches limit ....
> 			shortlog(origins.items[i].string, origins.items[i].util,
> 					head, &rev, limit, out);
> 
> so, limit of 20 is hardcoded and cannot be altered via configuration.  I
> would love to have it configurable, so, if desired, be set to infinity
> (configuration wide or as a cmd line parameter for a specific merge).

You're perhpas looking for something like this? Warning: Untested.

-- 8< --
commit 86c34c682345843d9138882a85ba36faf10e0d95
Author: Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Fri Aug 20 12:12:59 2010 +0530

    fmt-merge-msg: Make the number of log entries in shortlog configurable
    
    Introduce a new configuration option called merge.logLimit to limit
    the number of log entries displayed in the shortlog of a merge commit
    configurable. Set the default value to 20.

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a76cd4e..30782f6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -12,6 +12,7 @@ static const char * const fmt_merge_msg_usage[] = {
 };
 
 static int merge_summary;
+static int log_limit = 20;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
@@ -22,6 +23,8 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 	}
 	if (!found_merge_log && !strcmp("merge.summary", key))
 		merge_summary = git_config_bool(key, value);
+	if (!strcmp("merge.logLimit", key))
+		log_limit = git_config_int(key, value);
 	return 0;
 }
 
@@ -140,7 +143,7 @@ static void print_joined(const char *singular, const char *plural,
 }
 
 static void shortlog(const char *name, unsigned char *sha1,
-		struct commit *head, struct rev_info *rev, int limit,
+		struct commit *head, struct rev_info *rev,
 		struct strbuf *out)
 {
 	int i, count = 0;
@@ -169,7 +172,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 			continue;
 
 		count++;
-		if (subjects.nr > limit)
+		if (subjects.nr > log_limit)
 			continue;
 
 		format_commit_message(commit, "%s", &sb, &ctx);
@@ -182,13 +185,13 @@ static void shortlog(const char *name, unsigned char *sha1,
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
-	if (count > limit)
+	if (count > log_limit)
 		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
 		strbuf_addf(out, "\n* %s:\n", name);
 
 	for (i = 0; i < subjects.nr; i++)
-		if (i >= limit)
+		if (i >= log_limit)
 			strbuf_addf(out, "  ...\n");
 		else
 			strbuf_addf(out, "  %s\n", subjects.items[i].string);
@@ -257,7 +260,7 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 
 static int do_fmt_merge_msg(int merge_title, int merge_summary,
 	struct strbuf *in, struct strbuf *out) {
-	int limit = 20, i = 0, pos = 0;
+	int i = 0, pos = 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
@@ -303,7 +306,7 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string, origins.items[i].util,
-					head, &rev, limit, out);
+					head, &rev, out);
 	}
 	return 0;
 }

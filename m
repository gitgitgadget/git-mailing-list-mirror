From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 11:12:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171109170.10823@g5.osdl.org>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
 <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org> <7vejythvkr.fsf@assigned-by-dhcp.cox.net>
 <7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
 <4fb292fa0605170839r259732dcw1c1bae3f1808db32@mail.gmail.com>
 <7vhd3ofsyv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bertrand Jacquin <beber.mailing@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 20:12:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgQVh-0004IP-O4
	for gcvg-git@gmane.org; Wed, 17 May 2006 20:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWEQSMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 14:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWEQSMd
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 14:12:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbWEQSMd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 14:12:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HICOtH002211
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 11:12:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HICNR9021577;
	Wed, 17 May 2006 11:12:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd3ofsyv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20216>



On Wed, 17 May 2006, Junio C Hamano wrote:
>
> "Bertrand Jacquin" <beber.mailing@gmail.com> writes:
> >
> > #if NO_H_OPTION_IN_GREP
> >               push_arg("/dev/null");
> > #else
> >               push_arg("-H");
> >               push_arg("--");
> > #fi
> 
> Exactly because I wanted to avoid conditional compilation using
> C preprocessor directive (#if).

I think this is portable and correct.

Of course, it still ignores the fact that not all grep's support some of 
the flags like -F/-L/-A/-C etc, but for those cases, the external grep 
itself will happily just say "unrecognized option -F" or similar.

So with this change, "git grep" should handle all the flags the native 
grep handles, which is really quite fine. We don't _need_ to expose 
anything more, and if you do want our extensions, you can get them with 
"--uncached" and an up-to-date index.

No configuration necessary, and we automatically take advantage of any 
native grep we have, if possible.

		Linus

---
diff --git a/builtin-grep.c b/builtin-grep.c
index 66111de..d09ddf0 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -453,7 +453,6 @@ static int external_grep(struct grep_opt
 
 	len = nr = 0;
 	push_arg("grep");
-	push_arg("-H");
 	if (opt->fixed)
 		push_arg("-F");
 	if (opt->linenum)
@@ -503,17 +502,35 @@ static int external_grep(struct grep_opt
 		push_arg("-e");
 		push_arg(p->pattern);
 	}
-	push_arg("--");
+
+	/*
+	 * To make sure we get the header printed out when we want it,
+	 * add /dev/null to the paths to grep.  This is unnecessary
+	 * (and wrong) with "-l" or "-L", which always print out the
+	 * name anyway.
+	 *
+	 * GNU grep has "-H", but this is portable.
+	 */
+	if (!opt->name_only && !opt->unmatch_name_only)
+		push_arg("/dev/null");
 
 	hit = 0;
 	argc = nr;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
+		const char *name;
 		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
-		argv[argc++] = ce->name;
+		name = ce->name;
+		if (name[0] == '-') {
+			int len = ce_namelen(ce);
+			name = xmalloc(len + 3);
+			memcpy(name, "./", 2);
+			memcpy(name + 2, ce->name, len + 1);
+		}
+		argv[argc++] = name;
 		if (argc < MAXARGS)
 			continue;
 		hit += exec_grep(argc, argv);

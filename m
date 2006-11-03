X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 08:10:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611030741530.25218@g5.osdl.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
 <20061103074857.GA15972@diana.vm.bytemark.co.uk> <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 3 Nov 2006 16:11:32 +0000 (UTC)
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30861>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg1dO-0004Ue-Lt for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753335AbWKCQKs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 11:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbWKCQKs
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:10:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26051 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1753335AbWKCQKr (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 11:10:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA3GAUoZ011746
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 3
 Nov 2006 08:10:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA3GATRj024582; Fri, 3 Nov
 2006 08:10:29 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Fri, 3 Nov 2006, Junio C Hamano wrote:
> 
> 	[remote."gitster"]

Btw, why the '.'? It doesn't even work with a dot, you have to have a 
space, which is also a lot more readable..

Also, may I suggest that we just extend the format with a robust default 
value thing?

It should be reasonably easy to have just the rule:

 - add a new "remote.<remote>.branch" thing that lists multiple simple 
   branches separated by whitespace.

 - a "simple branch" is just a "implicit refspec" for the relationship
   "heads/<name>:remotes/<remote>/<name>"

And then you should be able to write all of your cumbersome config options 
as a simple

	[remote "gitster"]
		url = gitster.example.com:/home/junio/git.git/
		branch = maint master next +pu

and you're all done. It would imply everything you said.

This would basically require that "git-parse-remote" be re-written as a 
native builtin, because quite frankly, it would be too damn painful any 
other way, but it really shouldn't be that nasty. In fact, I think we 
should have done that long ago, because the shell-code is just horrid for 
things like this.

For example, for builtin-push (which is currently the only thing that 
parses "remote" entries in C), you'd just need to do something like the 
appended..  It would generate the full refspecs from the "branch" config 
automatically.

		Linus

---
diff --git a/builtin-push.c b/builtin-push.c
index d23974e..805ffa8 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -123,15 +123,33 @@ static int get_remote_config(const char*
 {
 	if (!strncmp(key, "remote.", 7) &&
 	    !strncmp(key + 7, config_repo, config_repo_len)) {
-		if (!strcmp(key + 7 + config_repo_len, ".url")) {
+	    	const char *subkey = key + 7 + config_repo_len;
+		if (!strcmp(subkey, ".url")) {
 			if (config_current_uri < MAX_URI)
 				config_uri[config_current_uri++] = xstrdup(value);
 			else
 				error("more than %d URL's specified, ignoring the rest", MAX_URI);
 		}
-		else if (config_get_refspecs &&
-			 !strcmp(key + 7 + config_repo_len, ".push"))
-			add_refspec(xstrdup(value));
+		else if (config_get_refspecs) {
+			if (!strcmp(subkey, ".push"))
+				add_refspec(xstrdup(value));
+			else if (!strcmp(subkey, ".branch")) {
+				while (isspace(*value))
+					value++;
+				while (*value) {
+					const char *end = value;
+					while (!isspace(*end))
+						end++;
+					add_refspec(xsprintf("heads/%.*s:remotes/%.*s/%.*s",
+						end-value, value,
+						config_repo_len, config_repo,
+						end-value, value));
+					while (isspace(*end))
+						end++;
+					value = end;
+				}
+			}
+		}
 	}
 	return 0;

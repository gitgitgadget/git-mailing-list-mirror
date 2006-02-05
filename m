From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix git-rev-parse over-eager errors
Date: Sun, 5 Feb 2006 14:03:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602051355430.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
 <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
 <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org> <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602051141020.3854@g5.osdl.org> <Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
 <Pine.LNX.4.64.0602051155460.3854@g5.osdl.org> <7vpsm1h8ft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 23:04:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5rzO-0003Ro-Mh
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 23:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWBEWDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 17:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWBEWDt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 17:03:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750752AbWBEWDs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 17:03:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k15M3jDZ006739
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Feb 2006 14:03:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k15M3iT1015919;
	Sun, 5 Feb 2006 14:03:44 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsm1h8ft.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15638>



On Sun, 5 Feb 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > Using "--verify" together with "--no-flags" makes perfect sense, but 
> > git-rev-parse would complain about it when it saw a flag, even though it 
> > would never actually use/output that flag.
> 
> Ah, makes sense.

Btw, I think the exact same holds true for the "show_file()" case.

You had added a special-case for a similar problem (the "lstat()" check) 
to disable the check when the path wasn't actually printed out. Strictly 
speaking, I think that should be handled the same way wrt "verify" too.

Ie something like this.

Comments?

		Linus

---
diff --git a/rev-parse.c b/rev-parse.c
index d2f0864..124d3ee 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -143,11 +143,14 @@ static void show_datestring(const char *
 	show(buffer);
 }
 
-static void show_file(const char *arg)
+static int show_file(const char *arg)
 {
 	show_default();
-	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV))
+	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
 		show(arg);
+		return 1;
+	}
+	return 0;
 }
 
 int main(int argc, char **argv)
@@ -308,14 +311,13 @@ int main(int argc, char **argv)
 			show_rev(REVERSED, sha1, arg+1);
 			continue;
 		}
+		as_is = 1;
+		if (!show_file(arg))
+			continue;
 		if (verify)
 			die("Needed a single revision");
-		if ((filter & DO_REVS) &&
-		    (filter & DO_NONFLAGS) && /* !def && */
-		    lstat(arg, &st) < 0)
+		if (lstat(arg, &st) < 0)
 			die("'%s': %s", arg, strerror(errno));
-		as_is = 1;
-		show_file(arg);
 	}
 	show_default();
 	if (verify && revs_count != 1)

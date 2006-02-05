From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Sun, 5 Feb 2006 11:42:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602051141020.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
 <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
 <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org> <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Sun Feb 05 20:42:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5pmZ-0007U4-6m
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 20:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWBETm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 14:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWBETm2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 14:42:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750700AbWBETm1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 14:42:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k15JgADZ000376
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Feb 2006 11:42:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k15Jg9I3011620;
	Sun, 5 Feb 2006 11:42:09 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15633>



On Thu, 2 Feb 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> >
> > Ahh. You're mis-using git-diff-tree.
> >
> > git-diff-tree will _never_ show the commit log if the diff ends up being 
> > empty.
> 
> True, I should fix the documentation.
> 
> It _might_ make sense for certain users like gitk and gitview if
> we had a single tool that gives --pretty and its diff even if
> the diff is empty.  Having said that, the flag --cc -m is too
> specific.  If some uses want to see the commit log even for an
> empty diff, that flag should not be something only --cc honors.

Here's an "--always" flag that does that.

		Linus

---
diff --git a/diff-tree.c b/diff-tree.c
index 6593a69..2df23c6 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -10,6 +10,7 @@ static int show_empty_combined = 0;
 static int combine_merges = 0;
 static int dense_combined_merges = 0;
 static int read_stdin = 0;
+static int always_show_header = 0;
 
 static const char *header = NULL;
 static const char *header_prefix = "";
@@ -93,6 +94,10 @@ static const char *generate_header(const
 	offset += pretty_print_commit(commit_format, commit, len,
 				      this_header + offset,
 				      sizeof(this_header) - offset, abbrev);
+	if (always_show_header) {
+		puts(this_header);
+		return NULL;
+	}
 	return this_header;
 }
 
@@ -262,6 +267,10 @@ int main(int argc, const char **argv)
 			no_commit_id = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--always")) {
+			always_show_header = 1;
+			continue;
+		}
 		usage(diff_tree_usage);
 	}
 	if (diff_options.output_format == DIFF_FORMAT_PATCH)

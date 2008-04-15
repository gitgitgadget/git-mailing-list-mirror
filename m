From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Tue, 15 Apr 2008 11:01:36 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
References: <20080415172333.GA29489@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mundt <lethal@linux-sh.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 20:17:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlpUw-0005VQ-Ed
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 20:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYDOSCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 14:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYDOSCc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 14:02:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36787 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752034AbYDOSCb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 14:02:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3FI1bTh012769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Apr 2008 11:01:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3FI1avi007856;
	Tue, 15 Apr 2008 11:01:36 -0700
In-Reply-To: <20080415172333.GA29489@linux-sh.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.983 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79613>



On Wed, 16 Apr 2008, Paul Mundt wrote:
>
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.25.git

Paul, your git tree is odd. Not quite corrupt, but it doesn't really 
follow the rules either.

In particular, it has empty lines at the top of those commits, and I 
wonder how you created them. 

Doing things like "git log" will ignore the spurious empty lines, but they 
can be seen with things like "git cat-file", eg

	git cat-file commit fd785d6b18b930b76ad5076eed6e9af43195b281 

and I wonder if you used a buggy version of git, or whether you perhaps 
have some scripts that import these commits from the outside and uses some 
low-level commands that can generate these kinds of subtly bogus commits.

The reason I noticed is that it screws up the git merge summary, which 
will take the first line of each commit it merges (_without_ the "skip 
empty lines" logic) to generate the summary of the merge.

I think we should fix that git merge summary code to allow for this bad 
behaviour, but I also want to know why such corrupt commits exist in the 
first place. What toolchain do you use to create that commit? We should 
fix that too!

Junio? Something like this for the merge summary code? (It also turns an 
empty commit message with just whitespace in the commit message into the 
SHA1 hex string)

		Linus

----
 builtin-fmt-merge-msg.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ebb3f37..7077d52 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -201,6 +201,15 @@ static void shortlog(const char *name, unsigned char *sha1,
 			continue;
 
 		bol = strstr(commit->buffer, "\n\n");
+		if (bol) {
+			unsigned char c;
+			do {
+				c = *++bol;
+			} while (isspace(c));
+			if (!c)
+				bol = NULL;
+		}
+
 		if (!bol) {
 			append_to_list(&subjects, xstrdup(sha1_to_hex(
 							commit->object.sha1)),
@@ -208,7 +217,6 @@ static void shortlog(const char *name, unsigned char *sha1,
 			continue;
 		}
 
-		bol += 2;
 		eol = strchr(bol, '\n');
 		if (eol) {
 			oneline = xmemdupz(bol, eol - bol);

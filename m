From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bring parse_options to the shell
Date: Fri, 2 Nov 2007 08:51:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org>
References: <1194016162-23599-1-git-send-email-madcoder@debian.org>
 <20071102151453.GB27505@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inyti-0001hq-Av
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbXKBP5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbXKBP5I
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:57:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58901 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755879AbXKBP5H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 11:57:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2FpET1030314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 08:51:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2FpDxt029440;
	Fri, 2 Nov 2007 08:51:13 -0700
In-Reply-To: <20071102151453.GB27505@artemis.corp>
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63139>



On Fri, 2 Nov 2007, Pierre Habouzit wrote:

> On Fri, Nov 02, 2007 at 03:09:18PM +0000, Pierre Habouzit wrote:
> > This is also something that itches me, so here is a proposal for a
> > git-parseopt helper that can be used in shell scripts as an option
> > normalizer like getopt(1) does.
> > 
> > I migrated the discussed git-clean.sh to use it as a proof of concept.
> 
>   Needless to say, this is fetchable from
> git://git.madism.org/git.git#ph/parseopt

Hmm. Any reason why you didn't just extend on "git rev-parse"?

That command was written exactly to parse a command line. This is really 
cheesy, and doesn't really work right (it splits up numbers too), but you 
get the idea..

		Linus

---
 builtin-rev-parse.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 8d78b69..10b62f7 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -116,6 +116,17 @@ static int show_flag(const char *arg)
 	if (!(filter & DO_FLAGS))
 		return 0;
 	if (filter & (is_rev_argument(arg) ? DO_REVS : DO_NOREV)) {
+		if (arg[0] == '-' && arg[1] != '-') {
+			char split[3];
+			split[0] = '-';
+			split[2] = 0;
+			while (arg[1]) {
+				split[1] = arg[1];
+				arg++;
+				show(split);
+			}
+			return 1;
+		}
 		show(arg);
 		return 1;
 	}

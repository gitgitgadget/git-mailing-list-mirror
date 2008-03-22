From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] Final words
Date: Sat, 22 Mar 2008 11:28:00 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221121520.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221049090.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 19:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd8TV-0006XQ-60
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 19:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYCVS2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbYCVS2x
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 14:28:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39261 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752646AbYCVS2w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 14:28:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MIS1ld006629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 11:28:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MIS0Cu021570;
	Sat, 22 Mar 2008 11:28:00 -0700
In-Reply-To: <alpine.LFD.1.00.0803221049090.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.755 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77839>



On Sat, 22 Mar 2008, Linus Torvalds wrote:
> 
> Final note: I also did notice that I didn't fix the 'git add" case like I 
> thought I did, it currently only fixes "git status". So I still want to 
> fix "git add" and "git mv" to do the right thing when there are case- 
> insensitive aliases, but that's a separate issue from this particular 
> series..

git-add will want more than this, but this is an example of what we should 
do - if 'ignore_case' is set, we probably should disallow adding the same 
case-insensitive name twice to the index.

This does *not* guarantee that the index never would have aliases when 
core.ignorecase is set, since the index might have been populated from a 
tree that was generated on a sane filesystem, and we still allow that, but 
things like this are probably good things to do for projects that want to 
work case-insensitively.

So even if you have a case-sensitive filesystem, the goal (I think) should 
be that you can set core.ignorecase to true, and that should help you work 
with other people who may be stuck on case-insensitive crud.

Anyway, the reason "git add" didn't actually work with the simple change 
to dir_add_name() is that "git add" doesn't load the index until *after* 
it has done the directory traversal (because it actually *wants* to see 
files that are already in the index). 

Something like this at least disallows the dual add if the case has 
changed.

		Linus

----
 read-cache.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5dc998d..6aee6e0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -476,6 +476,13 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		return 0;
 	}
 
+	if (ignore_case) {
+		struct cache_entry *alias;
+		alias = index_name_exists(istate, ce->name, ce_namelen(ce), 1);
+		if (alias)
+			die("Will not add file alias '%s' ('%s' already exists in index)", ce->name, alias->name);
+	}
+
 	if (index_path(ce->sha1, path, &st, 1))
 		die("unable to index file %s", path);
 	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))

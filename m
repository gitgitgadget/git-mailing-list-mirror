From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 9 Mar 2008 14:47:08 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091443440.19665@iabervon.org>
References: <200803061735.47674.david-b@pacbell.net> <200803081448.47000.david-b@pacbell.net> <alpine.LNX.1.00.0803081750580.19665@iabervon.org> <200803081525.08181.david-b@pacbell.net> <alpine.LNX.1.00.0803081826080.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
X-From: git-owner@vger.kernel.org Sun Mar 09 19:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYQYp-0003ER-IS
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 19:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbYCISrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 14:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbYCISrL
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 14:47:11 -0400
Received: from iabervon.org ([66.92.72.58]:41926 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbYCISrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 14:47:10 -0400
Received: (qmail 453 invoked by uid 1000); 9 Mar 2008 18:47:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 18:47:08 -0000
In-Reply-To: <alpine.LNX.1.00.0803081826080.19665@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76663>

On Sat, 8 Mar 2008, Daniel Barkalow wrote:

> On Sat, 8 Mar 2008, David Brownell wrote:
> 
> > On Saturday 08 March 2008, Daniel Barkalow wrote:
> > > I think that there's a dependance on how your current state and  
> > > the new state happen to line up.
> > 
> > The workspace in the tarball I can send you doesn't have any issues
> > with reproducibility ... now.  
> 
> Let me see if I can write up a patch that you should be able to test 
> without moving the big file around. I may run out of time for tonight, 
> though.

Try this. I'm not at all sure that it's doing what I want, but it passes 
all the current tests, and it should only affect your test case if it's 
actually right.

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 29b38e4..37cae35 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -26,6 +26,8 @@ static const char fetch_pack_usage[] =
 #define SEEN		(1U << 3)
 #define POPPED		(1U << 4)
 
+static int marked;
+
 /*
  * After sending this many "have"s if we do not get any new ACK , we
  * give up traversing our history.
@@ -61,6 +63,16 @@ static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int
 	return 0;
 }
 
+static int clear_marks(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct object *o = deref_tag(parse_object(sha1), path, 0);
+
+	if (o && o->type == OBJ_COMMIT)
+		clear_commit_marks((struct commit *)o, 
+				   COMMON | COMMON_REF | SEEN | POPPED);
+	return 0;
+}
+
 /*
    This function marks a rev and its ancestors as common.
    In some cases, it is desirable to mark only the ancestors (for example
@@ -153,6 +165,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	unsigned in_vain = 0;
 	int got_continue = 0;
 
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
+
 	for_each_ref(rev_list_insert_ref, NULL);
 
 	fetching = 0;

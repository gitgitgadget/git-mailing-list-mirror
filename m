From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a
 certain blob
Date: Sun, 18 Feb 2007 00:31:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180026000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vire0tz51.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZ21-0007Uz-EI
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992877AbXBQXbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992878AbXBQXbh
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:31:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:33460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992877AbXBQXbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:31:36 -0500
Received: (qmail invoked by alias); 17 Feb 2007 23:31:35 -0000
X-Provags-ID: V01U2FsdGVkX1/ooNxQYhnoUA7Tbz74USzWwiKB5tQ2OKD6vC+A3X
	cHow==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vire0tz51.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40026>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +static struct object_hash file_trees = { 0, 0, NULL };
> > +static struct object_array file_commits = { 0, 0, NULL };
> 
> These don't look good for two reasons: (1) you could leave BSS
> to do the 0 initialization; (2) you need to change this if you
> need to change the shape of "struct object_hash" later.

Yes, you are right on both accounts. Can you please just ammend the 
commit?

> > +#define CONTAINS_FILE (1u<<10)
> 
> I am partly at fault, but I think we should have a consolidated
> bit assignment policy in place before introducing new users of
> object flags.  Some older code says in their comments that
> revision.h reserves lower 8 bits while others say 16.  I offhand
> know who is correct X-<.

Something like this? (I did not know where to put the comment, so I let it 
be...)

--
[PATCH] The lower 16 bits of the object flags are reserved for rev_walk

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-blame.c    |    4 ++--
 builtin-describe.c |    2 +-
 builtin-reflog.c   |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 7a5665f..8323dbf 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -66,8 +66,8 @@ static unsigned blame_copy_score;
 #define BLAME_DEFAULT_COPY_SCORE	40
 
 /* bits #0..7 in revision.h, #8..11 used for merge_bases() in commit.c */
-#define METAINFO_SHOWN		(1u<<12)
-#define MORE_THAN_ONE_PATH	(1u<<13)
+#define METAINFO_SHOWN		(1u<<16)
+#define MORE_THAN_ONE_PATH	(1u<<17)
 
 /*
  * One blob in a commit that is being suspected
diff --git a/builtin-describe.c b/builtin-describe.c
index bcc6456..07a96a4 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -4,7 +4,7 @@
 #include "refs.h"
 #include "builtin.h"
 
-#define SEEN		(1u<<0)
+#define SEEN		(1u<<16)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char describe_usage[] =
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 3415551..3aa6902 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -34,8 +34,8 @@ struct expire_reflog_cb {
 	struct cmd_reflog_expire_cb *cmd;
 };
 
-#define INCOMPLETE	(1u<<10)
-#define STUDYING	(1u<<11)
+#define INCOMPLETE	(1u<<16)
+#define STUDYING	(1u<<17)
 
 static int tree_is_complete(const unsigned char *sha1)
 {

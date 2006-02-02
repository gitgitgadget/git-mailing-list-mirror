From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Thu, 2 Feb 2006 01:48:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602020113200.30910@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> <7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0602011528030.28923@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqxqbz9q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 01:48:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4SeJ-0007C2-Uy
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 01:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWBBAsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 19:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWBBAsd
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 19:48:33 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42936 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030224AbWBBAsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 19:48:33 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DC058146549; Thu,  2 Feb 2006 01:48:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id CE868A5C;
	Thu,  2 Feb 2006 01:48:31 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A336C146549; Thu,  2 Feb 2006 01:48:31 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqxqbz9q.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15473>

Hi,

On Wed, 1 Feb 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > Worse, you cannot pull from older servers into shallow repos.
> >> 
> >> "have X" means different thing if you do not have matching
> >> grafts information, so I suspect that is fundamentally
> >> unsolvable.
> >
> > If the shallow-capable client could realize that the server is not 
> > shallow-capable *and* the local repo is shallow, and refuse to operate 
> > (unless called with "-f", in which case the result may or may not be a 
> > broken repo, which has to be fixed up manually by copying 
> > over ORIG_HEAD to HEAD).
> 
> "If ... refuse to operate" then?

Just skip the "If". I'll start to enclose all emails I write in 
<tired>..</tired> blocks.

> > Of course, the client has to know that the local repo is shallow, which it 
> > must not determine by looking at the grafts file.
> 
> Sorry, I fail to understand this requirement.  Why is it "it must not"?

See below.

> > If you introduce a different "have X" -- like "have-no-parent X" -- and 
> > teach git-rev-list that "~A" means "traverse the tree of A, but not A's 
> > parents", you'd basically have everything you need, right?
> 
> If you have such a modified rev-list, yes.  I was having doubts
> about keeping an obvious correctness guarantee when doing such
> "rev-list ~A".

I think it would be trivial: just resolve ~A to the tree A points to:

-- snip --
[PATCH] rev-list: Support "~treeish"

Now, "git rev-list --objects ~some_rev" traverses just the tree of
some_rev.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 rev-list.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

43267e65c9ad933ad1a49005c4b61c23adaec372
diff --git a/rev-list.c b/rev-list.c
index 8012762..a196110 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -720,6 +720,24 @@ static void handle_one_commit(struct com
 	commit_list_insert(com, lst);
 }
 
+static void handle_tree(const unsigned char *sha1)
+{
+	struct object *object;
+
+	object = parse_object(sha1);
+	if (!object)
+		die("bad object %s", sha1_to_hex(sha1));
+
+	if (object->type == tree_type)
+		add_pending_object(object, "");
+	else if (object->type == commit_type) {
+		struct commit *commit = (struct commit *)object;
+		if (parse_commit(commit) < 0)
+			die("unable to parse commit %s", sha1_to_hex(sha1));
+		add_pending_object(&(commit->tree->object), "");
+	}
+}
+
 /* for_each_ref() callback does not allow user data -- Yuck. */
 static struct commit_list **global_lst;
 
@@ -865,6 +883,11 @@ int main(int argc, const char **argv)
 			flags = UNINTERESTING;
 			arg++;
 			limited = 1;
+		} else if (*arg == '~') {
+			if (get_sha1(arg + 1, sha1) < 0)
+				die("cannot get '%s'", arg);
+			handle_tree(sha1);
+			continue;
 		}
 		if (get_sha1(arg, sha1) < 0) {
 			struct stat st;
-- 
1.1.4.g9bd9d-dirty
-- snap --

> > Yes, I agree. But again, the local repo has to know which grafts were 
> > introduced by making the repo shallow.
> 
> I am not sure I understand.  grafts are grafts are grafts.

Exactly. And grafts are grafts are not necessarily cutoffs.

Now, is it possible that a fetch does something unintended, when there are 
grafts which are not cutoffs? I don't know yet, but I think so.

Ciao,
Dscho

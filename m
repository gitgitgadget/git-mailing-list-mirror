From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Sat, 4 Mar 2006 20:58:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603042058250.13139@g5.osdl.org>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 05:58:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFlKU-00037w-H7
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 05:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWCEE6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 23:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWCEE6s
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 23:58:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751606AbWCEE6r (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 23:58:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k254wgDZ015151
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Mar 2006 20:58:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k254wfgh011735;
	Sat, 4 Mar 2006 20:58:41 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17203>


On Sat, 4 Mar 2006, Junio C Hamano wrote:
> 
> The most notable core-ish change is that rev-list split and new
> git-log implementation by Linus.  I've been using this myself
> for a while without problems, but there might still be some
> corner cases that I (and Linus perhaps) do not exercise where
> git-log command behaves slightly differently.  rev-list is not
> supposed to have *any* regression other than removal of
> --merge-order.  Please report regressions.

Here's a potential fix for a special case that we used to have to make

	git-rev-list --max-count=1

be faster and not unnecessarily parse any parent objects.

Now, we had that special case because gitweb was apparently doing a lot of 
it, and quite frankly, I don't know if it still does. But basically it 
avoids doing the "pop_most_recent_commit()" which will look up and parse 
the parents, if it is obvious that it can.

I'm not sure this is worth it, but it looks obvious enough. Somebody with 
gitweb somewhere should probably check if it still even wants this.

		Linus

----
diff --git a/revision.c b/revision.c
index a3df810..33a5f20 100644
--- a/revision.c
+++ b/revision.c
@@ -696,6 +696,18 @@ struct commit *get_revision(struct rev_i
 		break;
 	case 0:
 		return NULL;
+
+	/* Special case to avoid unnecessary parent checking */
+	case 1:
+		if (!revs->limited &&
+		    !revs->no_merges &&
+		    !revs->paths &&
+		    revs->min_age == -1 &&
+		    revs->max_age == -1) {
+		    	revs->max_count = 0;
+			commit->object.flags |= SHOWN;
+			return commit;
+		}
 	default:
 		revs->max_count--;
 	}

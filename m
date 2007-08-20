From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-stash segfaults ...
Date: Mon, 20 Aug 2007 22:02:55 +0200
Message-ID: <20070820200255.GD5544@steel.home>
References: <20070820174427.GC7206@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 22:03:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDSv-00059I-8R
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbXHTUDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbXHTUDE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:03:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:55908 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbXHTUDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:03:02 -0400
Received: from tigra.home (Fab03.f.strato-dslnet.de [195.4.171.3])
	by post.webmailer.de (fruni mo34) (RZmta 10.3)
	with ESMTP id j01b6ej7KK1r00 for <git@vger.kernel.org>;
	Mon, 20 Aug 2007 22:02:56 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 20A08277BD
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 22:02:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 04367BDFC; Mon, 20 Aug 2007 22:02:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070820174427.GC7206@artemis.corp>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJAI
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56247>

Pierre Habouzit, Mon, Aug 20, 2007 19:44:27 +0200:
>   When you don't use it from the root of the tree: I was in a subdir of
> my git tree, trying to do:
> 
>   git stash apply
> 
>   and I had:
> 
>   $ git stash apply
>   error: missing object referenced by
>   '0ca54c1fba7fea7dca8a1cc59bce2b2849f26d20' Segmentation fault
> 
>   going in the root of the repository (where .git is), all went fine.

Can't reproduce, but... There are places where the result of the
function which gives this message (deref_tag from tag.c) is not
checked for NULL and used. merge-recursive (used by git-stash) is one
of them (and sha1_name is another).

Pierre, could you please try the patch below and see if the crash is
replaced with a failure?

BTW, is there something unusual happening to that repo? Like manual
object removing, or removal of repo your repo was cloned from, using
something like "git clone -l -s", maybe?

diff --git a/merge-recursive.c b/merge-recursive.c
index 16f6a0f..464fc4e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1701,6 +1701,8 @@ static struct commit *get_ref(const char *ref)
 	if (get_sha1(ref, sha1))
 		die("Could not resolve ref '%s'", ref);
 	object = deref_tag(parse_object(sha1), ref, strlen(ref));
+	if (!object)
+		die("Could not resolve ref '%s' down to object", ref);
 	if (object->type == OBJ_TREE)
 		return make_virtual_commit((struct tree*)object,
 			better_branch_name(ref));

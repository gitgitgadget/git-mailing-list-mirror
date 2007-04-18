From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 12:23:43 -0700
Message-ID: <7vslaxfpvk.fsf@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704181247410.12094@racer.site>
	<20070418153445.GC12888@admingilde.org>
	<alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
	<7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
	<7vzm55fqyv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:23:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeFkp-00088u-TU
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 21:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993053AbXDRTXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 15:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993071AbXDRTXp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 15:23:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37685 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993053AbXDRTXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 15:23:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418192344.HACL1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 15:23:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ojPj1W00U1kojtg0000000; Wed, 18 Apr 2007 15:23:43 -0400
In-Reply-To: <7vzm55fqyv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Apr 2007 12:00:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44933>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> For example, for a three-way merge, it makes sense to do the three-way 
>> merge for the "internal" merge too. But it might be that that isn't true 
>> for all strategies.
>
> Yes, that is what I alluded to in one of my previous message,
> but I think the "foo-recursive" idea is a good one.  I was
> planning to give only "3-way" or "pick ancestor" choice to
> external low-level merge drivers.
>
> But I think that is a separate issue.

The syntax is a bit different from the one you came up in your
MUA.

	# a recursive merge will always just pick the ORIGINAL
	# version of a file when blending - the blending will
	# be done only on the final merge
	[merge "blend"]
		name = blend (changelog) strategy
		driver = blend %A %O %B
		recursive = binary

The variable merge.<<drivername>>.recursive names a different
low level merge driver to be used while performing the virtual
ancestor merge.  In this example, the built-in "binary" merge
which picks 'ours' for the final round and 'origin' for the
internal merge already does what we want.

-- >8 --
[PATCH] Allow low-level driver to specify different behaviour during internal merge.

This allows [merge "drivername"] to have a variable "recursive"
that names a different low-level merge driver to be used when
merging common ancestors to come up with a virtual ancestor.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4af69d7..43d6117 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -677,6 +677,7 @@ struct ll_merge_driver {
 	const char *name;
 	const char *description;
 	ll_merge_fn fn;
+	const char *recursive;
 	struct ll_merge_driver *next;
 	char *cmdline;
 };
@@ -934,6 +935,13 @@ static int read_merge_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp("recursive", ep)) {
+		if (!value)
+			return error("%s: lacks value", var);
+		fn->recursive = strdup(value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -1013,6 +1021,10 @@ static int ll_merge(mmbuffer_t *result_buf,
 	merge_attr = git_path_check_merge(a->path);
 	driver = find_ll_merge_driver(merge_attr);
 
+	if (index_only && driver->recursive) {
+		merge_attr = git_attr(driver->recursive, strlen(driver->recursive));
+		driver = find_ll_merge_driver(merge_attr);
+	}
 	merge_status = driver->fn(driver, a->path,
 				  &orig, &src1, name1, &src2, name2,
 				  result_buf);
-- 
1.5.1.1.905.g4cad0

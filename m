From: Yann Dirson <ydirson@altern.org>
Subject: [RFC PATCH] generalizing sorted-array handling
Date: Thu,  4 Nov 2010 21:33:11 +0100
Message-ID: <1288902795-8597-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 21:33:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6V8-0003Fe-JI
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab0KDUdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:33:32 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:43973 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab0KDUdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:33:31 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id AD3B5D481F7
	for <git@vger.kernel.org>; Thu,  4 Nov 2010 21:33:25 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE6Uu-0002FN-FQ
	for git@vger.kernel.org; Thu, 04 Nov 2010 21:33:24 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160756>

While writing the bulk-move series, I introduced 2 new functions,
locate_bulkmove_candidate() and locate_rename_dst_dir(), closely
derived from locate_rename_dst().  That was because it seemed not so
trivial to overcome the differences in those 3 funcs while retaining
readability.

Now when working on bulk-rm (as a new basis for next-gen bulk-move), I
find myself in the need of adding more of them: again functions for
searching/inserting in a sorted list of various contents.  My first
approach (this series) was to generalize locate_rename_dst() to
operate on other "lists of a filespec and something", since that was
matching my needs for "bulkrm_candidates".

Tell me your opinion on this: I find the result hard to read, and
difficult to adapt to all of locate_rename_dst_dir() with its
non-filespec input, let alone locate_bulkmove_candidate() with 2 of
them.  And even the memset() call is probably less efficient than the
original "= NULL".

So I'm planning of redoing the thing with a different principle:
change the core function to accept func-pointer for comparison and
initialization - that would make the core func much more readable.
Since those trivial funcs would be trivial static ones, compilers
ought to be able to instantiate specific versions of the core func,
inlining those trivial ones; if it does not, however, that would
surely give a performance penalty if it does not...

The alternative, having several mostly-identical funcs, which have to
be made generic anyway to prevent proliferation, seems to me much more
of a hell.  What's the general opinion ?

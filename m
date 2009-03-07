From: Sam Hocevar <sam@zoy.org>
Subject: Git memory usage (1): fast-import
Date: Sat, 7 Mar 2009 21:19:20 +0100
Message-ID: <20090307201920.GE12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 21:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg30s-0001SN-7Z
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079AbZCGUT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 15:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756077AbZCGUTZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:19:25 -0500
Received: from poulet.zoy.org ([80.65.228.129]:36251 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051AbZCGUTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 15:19:24 -0500
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 5724D1203FA; Sat,  7 Mar 2009 21:19:20 +0100 (CET)
Content-Disposition: inline
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112578>

   I joined a project that uses very large binary files (up to 1 GiB) in
a p4 repository and as I would like to use Git, I am trying to make it
more memory-efficient when handling huge files.

   The first problem I am hitting is with fast-import. Currently it
keeps the last imported file in memory (end of store_object()) in order
to find interesting deltas with the next file. Since most huge binary
files are already compressed, it means that fast-importing two large
X MiB files is going to use at least 3X MiB of memory: once for the
first file, once for the second file, and once for the deflate data
that is going to be as large as the file itself.

   In practice, it takes even more memory than that. Experiment shows
that importing six 100 MiB files made of urandom data takes 370 MiB of
memory (http://zoy.org/~sam/git/git-memory-usage.png) (simple script
available at http://zoy.org/~sam/git/gencommit.txt). I am unable to plot
how it behaves with 1 GiB files since I don't have enough memory, but I
don't see why the trend wouldn't stand.

   I can understand it not being a priority, but I'm trying to think of
acceptable ways to fix this that do not mess with Git's performance in
more usual cases. Here is what I can think of:

   - stop trying to compute deltas in fast-import and leave that task
   to other tools (optionally, define a file size threshold beyond
   which the last file is not kept in memory, and maybe make that a
   configuration option).

   - use a temporary file to store the deflate data when it reaches a
   given size threshold (and maybe make that a configuration option).

   - also, I haven't tracked all strbuf_* uses in fast-import, but I got
   the feeling that strbuf_release() could be used in a few places
   instead of strbuf_setlen(0) in order to free some memory.

   Any thoughts?

-- 
Sam.

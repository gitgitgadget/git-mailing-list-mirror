From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] Documentation: clarify effect of '/' in gitignore(5)
 patterns
Date: Mon, 7 Nov 2011 02:08:42 -0600
Message-ID: <20111107080842.GB30486@elie.hsd1.il.comcast.net>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, Johannes Sixt <j6t@kdbg.org>,
	"Y.G." <yamomo1@hotmail.com>, Eli Barzilay <eli@barzilay.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 09:08:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNKGA-0001zS-8i
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 09:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1KGIIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 03:08:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37325 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1KGIIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 03:08:45 -0500
Received: by gyc15 with SMTP id 15so3919267gyc.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8lzhYhMQ78wU4NJVQrRaKJHSqE8HIXBEm7J+WhgGOmU=;
        b=OclX2tS65w6MNK0AGtifQ8n9CmKX6kW1DsO+PbbsS75ZA1GjvUVjqMoc/c4QBKQb+g
         /UtPQclG/+1TrZ/fMQzRdi0cCCdlh6kHSGOLsrRoHamCyeyzYK9LavWrjQKGlqU98oeK
         aozPLcGt3UX3zpl/7iiF5HiCkus5UqF7ZL35E=
Received: by 10.50.213.40 with SMTP id np8mr41749470igc.10.1320653324743;
        Mon, 07 Nov 2011 00:08:44 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id pa4sm17823760igc.1.2011.11.07.00.08.44
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 00:08:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184959>

The introduction of directory-only matches in v1.5.5-rc0~208^2~1
(gitignore(5): Allow "foo/" in ignore list to match directory "foo",
2008-01-31) was a small, incremental change to gitignore syntax that
did not affect the rest of the rules in any major way.  A '/' at the
end of a pattern means "match directories only" and does not otherwise
affect the pattern.  And that is how the gitignore(5) manpage explains
the syntax.

However, to a person parsing an unfamiliar gitignore entry like foo/,
it is too easy to notice the later (old) rule that describes how
patterns containing a slash are anchored and miss that the slash
should have been stripped off before considering whether the rule
applies.

Let's just explicitly say that patterns are only anchored if they
contain a slash that is not at the end of the pattern, avoiding this
confusion.  A more graceful presentation of this material may be
possible, but for now the goal is to get the facts clear --- we can
refactor the text to scan well without losing its meaning later.

(While at it, tweak the wording for clarity and add an example.)

Reported-by: Y.G. <yamomo1@hotmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitignore.txt |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 5b070bf0..c7c948dd 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -77,19 +77,21 @@ PATTERN FORMAT
    directory `foo` but will not match a regular file or a
    symbolic link `foo` (this is consistent with the way
    pathspecs work in general in git).
-+
-The trailing slash is removed before applying the remaining
-rules.
 
- - If the pattern does not contain a slash '/', git treats it as
-   a shell glob pattern and checks for a match against the
-   pathname relative to the location of the `.gitignore` file
-   (relative to the toplevel of the work tree if not from a
-   `.gitignore` file).
+ - If the pattern does not contain a slash '/' at the beginning
+   or in the middle, git treats it as a shell glob pattern and
+   matches the entire pathname including slashes, relative to the
+   location of the `.gitignore` file (or relative to the toplevel
+   of the work tree if the pattern is not from a `.gitignore`
+   file), against it.
+   For example, "{asterisk}.html" matches HTML files in the
+   directory containing the `.gitignore` file and in its
+   subdirectories.
 
- - Otherwise, git treats the pattern as a shell glob suitable
-   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
-   wildcards in the pattern will not match a / in the pathname.
+ - If the pattern contains a slash '/' at the beginning or in the
+   middle, git imitates the behavior of fnmatch(3) with the
+   FNM_PATHNAME flag: wildcards in the pattern will not match a /
+   in the pathname.
    For example, "Documentation/{asterisk}.html" matches
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
-- 
1.7.8.rc0

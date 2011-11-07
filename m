From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] Documentation: unanchored gitignore patterns match
 basename
Date: Mon, 7 Nov 2011 02:09:26 -0600
Message-ID: <20111107080926.GC30486@elie.hsd1.il.comcast.net>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, Johannes Sixt <j6t@kdbg.org>,
	"Y.G." <yamomo1@hotmail.com>, Eli Barzilay <eli@barzilay.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 09:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNKGs-0002EN-5b
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 09:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab1KGIJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 03:09:29 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42371 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1KGIJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 03:09:29 -0500
Received: by ggnb2 with SMTP id b2so5014175ggn.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 00:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8gk53VV6eyRoM5ObHKaThQn3cdU1oErfIUxVcyGY7d8=;
        b=H7yfdg4PhshUsayMKYAd+J8NlpcX2w8Gi8pqlqdiC+szOrv1lEQJoxx2OtCEyi0gOQ
         cPUIhOjnjbY+5daJanuH6z9FFZxCEI9Vbxl7xUdjUtKkxfSMVm9Q+YVlyigFaiz308u6
         /GCGOdcnQ0N5Z9xh2dZHNWM43gi9k0Mi9x3z8=
Received: by 10.42.117.193 with SMTP id u1mr45568371icq.24.1320653368680;
        Mon, 07 Nov 2011 00:09:28 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p16sm37112073ibk.6.2011.11.07.00.09.27
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 00:09:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184960>

The rule described by v1.7.1.1~31^2 (gitignore.5: Clarify matching
rules, 2010-03-05) is just false: simple gitignore patterns without a
slash like "foo" and "cscope*" have always matched files in all
directories, not just the toplevel, and a question mark cannot be used
to match the slash separating path components.

For example:

	foo/ - matches directories named "foo" throughout the tree
	Documentation?foo - does not match Documentation/foo

Reported-by: Y.G. <yamomo1@hotmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitignore.txt |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index c7c948dd..e5715a27 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -80,18 +80,19 @@ PATTERN FORMAT
 
  - If the pattern does not contain a slash '/' at the beginning
    or in the middle, git treats it as a shell glob pattern and
-   matches the entire pathname including slashes, relative to the
-   location of the `.gitignore` file (or relative to the toplevel
-   of the work tree if the pattern is not from a `.gitignore`
-   file), against it.
-   For example, "{asterisk}.html" matches HTML files in the
-   directory containing the `.gitignore` file and in its
-   subdirectories.
+   checks if the pathname with leading path components
+   removed matches it.
+   For example, "x{asterisk}.html" matches HTML files whose
+   filename begins with an "x" in the directory containing
+   the `.gitignore` file and in its subdirectories.
 
  - If the pattern contains a slash '/' at the beginning or in the
    middle, git imitates the behavior of fnmatch(3) with the
-   FNM_PATHNAME flag: wildcards in the pattern will not match a /
-   in the pathname.
+   FNM_PATHNAME flag.  The pattern is used to match the entire
+   pathname, relative to the location of the `.gitignore` file
+   (or relative to the toplevel of the work tree if the pattern
+   is not from a `.gitignore` file).  Wildcards in the pattern
+   do not match a / in the pathname.
    For example, "Documentation/{asterisk}.html" matches
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
-- 
1.7.8.rc0

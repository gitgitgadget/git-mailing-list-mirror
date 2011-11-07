From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] Documentation/gitignore: explain how to un-ignore part
 of a directory
Date: Mon, 7 Nov 2011 02:11:32 -0600
Message-ID: <20111107081132.GD30486@elie.hsd1.il.comcast.net>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, Johannes Sixt <j6t@kdbg.org>,
	"Y.G." <yamomo1@hotmail.com>, Eli Barzilay <eli@barzilay.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 09:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNKIy-0002yh-Gx
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 09:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab1KGILh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 03:11:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41579 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab1KGILf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 03:11:35 -0500
Received: by iage36 with SMTP id e36so5584963iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 00:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Mc7k0XKFzXpo59hDnTSb1cQ0RSi/N6n6o94KIh6BxVI=;
        b=GJ8HhLGbckUsCCjAClSSjj2ho/6pp7J4nysxE3hjDEzNYfKsFTz7aiRy4QBuaVag1A
         f7jZxfJ3OKAxB8Go/JB/pfreFoGERDpxNFr1MdUbMeKyVydgw2vP1n5C7Nsr7ylsMhHd
         N/tWH3Z4/SE07NcPefTWmdyC+bZA/bvAP19Co=
Received: by 10.42.158.9 with SMTP id f9mr44810832icx.31.1320653495253;
        Mon, 07 Nov 2011 00:11:35 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ge16sm37133739ibb.2.2011.11.07.00.11.34
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 00:11:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184961>

From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 5 Apr 2011 23:15:54 +0200

Trying to whitelist a single file pattern in a directory that I was
otherwise content to ignore, if I try

	/m4/
	!/m4/virt-*.m4

then 'git add' will keep warning me that I have to use -f.  That is
because ignoring a directory is much different than ignoring all files
in a directory, when it comes to later negation patterns:

	/m4/*
	!/m4/virt-*.m4

However, this example is misleading because it gives the false
impression that you could do

	/foo/*
	!/foo/bar/baz

and have foo/bar/baz not ignored, and it is still ignored.  Add a
paragraph in the NOTES section explaining the general rule and
suggesting ignoring the directory and using "git add -f" to track
exceptions to cope with it.

[jn: change description distilled from messages by Eric and Hannes
to the mailing list.

As Eric noticed, while the "git add -f" trick works well with
commands like "git status" and "git add -u", plain "git add
subdir/<path>" refuses to update the index with changes from an
ignored subdirectory.  When describing the trick, explicitly list a
few commands that already behave appropriately to avoid confusion.]

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thoughts?

 Documentation/gitignore.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index e5715a27..8b6f601e 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -113,6 +113,21 @@ use 'git update-index {litdd}assume-unchanged'.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
 
+When a directory is ignored, it is not possible to un-ignore a single file
+somewhere in the directory using another pattern. E.g., with the patterns
+
+--------------
+/build/
+!/build/tests/results
+--------------
+
+the file "build/tests/results" is still ignored because when a directory is
+ignored, its contents are never investigated. In a situation where a few
+exceptions in an otherwise ignored hierarchy are needed, the recommended
+procedure is to specify to ignore the root of the hierarchy and then to 'git
+add -f' the exceptional files. Subsequent changes to the files will not be
+ignored by 'git status', 'git add .', 'git add -u', or 'git commit -a'.
+
 EXAMPLES
 --------
 
-- 
1.7.8.rc0

From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v3 1/4] t0060: Add test for manipulating symlinks via
 absolute paths
Date: Fri, 31 Jan 2014 21:22:01 +0100
Message-ID: <20140131202201.GB9731@mule>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richih@debian.org, gitster@pobox.com, tboegi@web.de,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 21:22:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9KbP-0005r1-8w
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 21:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbaAaUWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 15:22:10 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:55854 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaUWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 15:22:09 -0500
Received: by mail-lb0-f171.google.com with SMTP id c11so3880710lbj.30
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DNjq++SfCA2rF1vdWEGyZg+cRhmMkq4GOujz225BzUY=;
        b=mnAP/d5MrthWwvBrEADcX3vwNPzvzjMEa+8oNbZDmWuSVmvXfrZl+0NqTE1rUeFjVO
         sv9iOW7r8OvphouBpWBptJod9sb/RUy4QSTjrqwvd0LpHo+X/We5LblhhEbQqhDW7UhX
         yBwIswhyJlqtUnz5KKIjuSLSlBy9zkoBQruZubBC9qqzsw8ITEufUYwLy4QG6L6FCDIK
         sHgq82y/9kcvujk3pZUFmPpxZSAJgHtQ1WgWDYEZlREsFdKg157BxYh1n/0eIN69zap3
         FDBO9md0Ob5mV/Lu+9Bxvb+CpXj56ThnWhlvmbebI0JBz3PVvP1nG4Pyv4nMApy36uhp
         2QRA==
X-Received: by 10.152.42.230 with SMTP id r6mr3245059lal.18.1391199726389;
        Fri, 31 Jan 2014 12:22:06 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id ri4sm11372623lbb.6.2014.01.31.12.22.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 12:22:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241315>

When symlinks in the working tree are manipulated using the absolute
path, git dereferences them, and tries to manipulate the link target
instead.

This is a regression introduced by 18e051a:
  setup: translate symlinks in filename when using absolute paths
(which did not take symlinks in the work tree into consideration).

Add a known-breakage tests using the prefix_path function, which
currently uses real_path, causing the dereference.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t0060-path-utils.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 07c10c8..0bba988 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,6 +190,11 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+test_expect_failure SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
+	ln -s target symlink &&
+	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2

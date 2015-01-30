From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Fri, 30 Jan 2015 00:22:47 +0000
Message-ID: <20150130002247.GA22519@dcvr.yhbt.net>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
 <20150129233429.GA7162@dcvr.yhbt.net>
 <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Valery Yundin <yuvalery@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 01:22:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGzMK-0004KC-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 01:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759579AbbA3AWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 19:22:48 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43109 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbbA3AWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 19:22:48 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC6E633801;
	Fri, 30 Jan 2015 00:22:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263168>

Valery Yundin <yuvalery@gmail.com> wrote:
> Hi,
> 
> Here you go:
> dfa72fdb96befbd790f623bb2909a347176753c2 is the first bad commit

Thank you.  Can you give the following patch a try?
I have not been able to reproduce the problem on my end.
If it doesn't work out, I might be out of ideas for a bit :/
Increasing --log-window-size will help you run longer without
the error, but that's not ideal as it can also eat memory.

-----------------------8<----------------------
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: destroy all tempfiles when reloading RA

This may fix the errors some users are seeing with:
"write .git/Git_svn_hash_XXXXXX: Bad file descriptor"

Thanks to Valery Yundin for helping bisect the problem introduced in
commit dfa72fdb96befbd790f623bb2909a347176753c2
(git-svn: reload RA every log-window-size)

Cc: Valery Yundin <yuvalery@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git.pm        | 6 ++++++
 perl/Git/SVN/Ra.pm | 1 +
 2 files changed, 7 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index b5905ee..698018e 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1347,6 +1347,12 @@ sub temp_path {
 	$TEMP_FILES{$temp_fd}{fname};
 }
 
+sub temp_reset_all {
+	unlink values %TEMP_FILEMAP if %TEMP_FILEMAP;
+	%TEMP_FILEMAP = ();
+	%TEMP_FILES = ();
+}
+
 sub END {
 	unlink values %TEMP_FILEMAP if %TEMP_FILEMAP;
 }
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 622535e..878679d 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -397,6 +397,7 @@ sub gs_fetch_loop_common {
 		$_[0] = undef;
 		$self = undef;
 		$RA = undef;
+		Git->temp_reset_all;
 		$gpool->clear;
 		$self = Git::SVN::Ra->new($ra_url);
 		$ra_invalid = undef;
-- 
EW

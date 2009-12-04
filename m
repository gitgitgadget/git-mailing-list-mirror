From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: suppress the X error on exit
Date: Fri, 4 Dec 2009 07:57:51 -0800
Message-ID: <20091204155751.GB1483@spearce.org>
References: <20091204102844.3c720b21@starbug.prg01.itonis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jindrich Makovicka <makovick@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaXg-00036Z-DK
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443AbZLDP5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbZLDP5s
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:57:48 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:43893 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbZLDP5s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:57:48 -0500
Received: by vws30 with SMTP id 30so1216646vws.33
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 07:57:54 -0800 (PST)
Received: by 10.220.126.155 with SMTP id c27mr4141505vcs.81.1259942274287;
        Fri, 04 Dec 2009 07:57:54 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 4sm1577379yxd.70.2009.12.04.07.57.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 07:57:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091204102844.3c720b21@starbug.prg01.itonis.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134527>

Jindrich Makovicka <makovick@gmail.com> wrote:
> Due to a bug in Tk, git-gui almost always (unless git-gui is closed
> right after starting) produces an X window error message on exit,
> something like

Thanks.  I've wrapped it up into the following commit.  Can I get
a Signed-off-by line from you?

--8<--
[PATCH] git-gui: suppress RenderBadPicture X error caused by Tk bug

Due to a bug in Tk, git-gui almost always (unless git-gui is closed
right after starting) produces an X window error message on exit,
something like:

X Error of failed request:  RenderBadPicture (invalid Picture parameter)
  Major opcode of failed request:  150 (RENDER)
  Minor opcode of failed request:  7 (RenderFreePicture)
  Picture id in failed request: 0x3a000dc
  Serial number of failed request:  1965
  Current serial number in output stream:  1980

Respective Tk bug report is here:

http://sourceforge.net/tracker/?func=detail&atid=112997&aid=1821174&group_id=12997

This bug is triggered only when the send command is blocked via
rename send {} . The following patch re-enables send just before
quiting git-gui to suppress the error.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 037a1f2..718277a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2052,6 +2052,11 @@ proc do_quit {{rc {1}}} {
 	}
 
 	set ret_code $rc
+
+	# Briefly enable send again, working around Tk bug
+	# http://sourceforge.net/tracker/?func=detail&atid=112997&aid=1821174&group_id=12997
+	tk appname [appname]
+
 	destroy .
 }
 
-- 
1.6.6.rc0.324.gb5bf2

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir
	'libexec/git-core'
Date: Sun, 27 Jul 2008 14:24:05 -0700
Message-ID: <20080727212405.GA10075@spearce.org>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 23:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNDpK-0005qH-3Q
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 23:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbYG0VYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757727AbYG0VYI
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 17:24:08 -0400
Received: from george.spearce.org ([209.20.77.23]:40590 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757614AbYG0VYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 17:24:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CCBE5383A5; Sun, 27 Jul 2008 21:24:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217177383-25272-2-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90371>

Steffen Prohaska <prohaska@zib.de> wrote:
> The new execdir has is two levels below the root directory, while
> the old execdir 'bin' was only one level below.  This commit
> adapts the discovery of oguilib that uses relative paths
> accordingly.
...
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 940677c..baccd57 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -52,7 +52,9 @@ catch {rename send {}} ; # What an evil concept...
>  set oguilib {@@GITGUI_LIBDIR@@}
>  set oguirel {@@GITGUI_RELATIVE@@}
>  if {$oguirel eq {1}} {
> -	set oguilib [file dirname [file dirname [file normalize $argv0]]]
> +	set oguilib [file dirname \
> +	             [file dirname \
> +	              [file dirname [file normalize $argv0]]]]
>  	set oguilib [file join $oguilib share git-gui lib]

Hmmph.  This actually comes up incorrectly on my system.  The issue
appears to be `git --exec-path` gives me $prefix/libexec/git-core,
and git-gui installs its library into $prefix/libexec/share, which
is wrong.  It should have gone to $prefix/share.

I wonder if this is better.  Your other two patches seem fine.

--8<--
[PATCH] git-gui: Correct installation of library to be $prefix/share

We always wanted the library for git-gui to install into the
$prefix/share directory, not $prefix/libexec/share.  All of
the files in our library are platform independent and may
be reused across systems, like any other content stored in
the share directory.

Our computation of where our library should install to was broken
when git itself started installing to $prefix/libexec/git-core,
which was one level down from where we expected it to be.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b19fb2d..f72ab6c 100644
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,9 @@ endif
 ifndef gitexecdir
 	gitexecdir := $(shell git --exec-path)
 endif
+ifeq (git-core,$(notdir $(gitexecdir)))
+	gitexecdir := $(patsubst %/,%,$(dir $(gitexecdir)))
+endif
 
 ifndef sharedir
 	sharedir := $(dir $(gitexecdir))share
-- 
1.6.0.rc0.182.gb96c7


-- 
Shawn.

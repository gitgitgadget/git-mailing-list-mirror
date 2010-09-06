From: "Daniel A. Steffen" <das@users.sourceforge.net>
Subject: Re: [RFC/PATCH] Force using Tcl/Tk 8.4 on Mac OS X
Date: Mon, 6 Sep 2010 12:36:34 -0700
Message-ID: <CB6C69E6-7943-49B7-96E7-4C00831C3C9D@users.sourceforge.net>
References: <1283792854-45023-1-git-send-email-lists@haller-berlin.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Stefan Haller <stefan@haller-berlin.de>,
	Shawn O Pearce <spearce@spearce.org>,
	Daniel A Steffen <dsteffen@apple.com>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Sep 06 21:36:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OshUj-0007B9-QN
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 21:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab0IFTgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 15:36:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48661 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0IFTgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 15:36:39 -0400
Received: by pwi3 with SMTP id 3so1158528pwi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 12:36:39 -0700 (PDT)
Received: by 10.114.74.19 with SMTP id w19mr4046061waa.143.1283801799141;
        Mon, 06 Sep 2010 12:36:39 -0700 (PDT)
Received: from [192.168.1.6] (70-36-140-11.dsl.dynamic.sonic.net [70.36.140.11])
        by mx.google.com with ESMTPS id d39sm11854560wam.16.2010.09.06.12.36.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 12:36:37 -0700 (PDT)
In-Reply-To: <1283792854-45023-1-git-send-email-lists@haller-berlin.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155603>

Hi Stefan,

On Sep 6, 2010, at 10:07 AM, Stefan Haller wrote:

> When using Git Gui.app on a Snow Leopard system with Tcl/Tk 8.5,
> there are two problems:
> 
> 1) Menu commands that open a dialog (e.g. "Push" or "Revert changes")
>   don't work when invoked via their keyboard shortcuts. You get a
>   dialog without a title bar, and the application then hangs without
>   further responding to any user input; you need to kill it. Invoking
>   the same commands with the mouse by choosing from the menu works fine.

first time I hear of this (or see this myself, and I use git gui every day on Mac OS X); in part this may be due to the fact that many of the menu shortcuts assigned by git gui conflict with existing OS X shortcuts and don't work anyway e.g. cmd-A (esp if a text widget is in focus)...

personally I would hate for my git gui to be downgraded to Tk 8.4 and Carbon because of this small issue, and I'm unlikely to be alone.

> 2) The colored pane headers (red, green, yellow) are all grey.

this is intentional and triggered by the use of ttk, there is a config setting to turn it off (gui.usettk)

> Obviously, the first problem is much more serious than the second.
> 
> Both problems go away when using Tcl/Tk 8.4 instead of 8.5. The user
> interface looks a little "older" then, but at least it works reliably.
> 
> Until someone figures out how to solve these problems properly with
> 8.5, force using 8.4.

please don't brute-force around the problem in this way, there are many features that the Cocoa Tk in 8.5+ adds that would be lost by such a change. 
Moreover the fact that 8.4 is present in that location is for backwards compatibility only, please don't introduce any new dependencies on it.

An effective small workaround for the problem appears to be to turn off the menu accelerators for the affected commands (the key shortcuts will still work, since the actual key bindings are independent of the menu accelerators), see below.
Is there a complete list of menu shortcuts that bring up a dialog?

Ultimately the right way to address this issue is to fix it in Tk, please report this in the Tk bug tracker if you haven't already, a quick glance in the debugger shows a hang in recursive event loop invocation such as used by tk_dialog when called from a menu accelerator callback.

Thanks!

Cheers,

Daniel


diff --git i/git-gui.sh w/git-gui.sh
index 0d5c5e3..ec7ed7d 100755
--- i/git-gui.sh
+++ w/git-gui.sh
@@ -2723,6 +2723,9 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
                -accelerator $M1T-J
        lappend disable_on_lock \
                [list .mbar.commit entryconf [.mbar.commit index last] -state]
+       if {[is_MacOSX]} {
+               .mbar.commit entryconf last -accelerator {}
+       }
 
        .mbar.commit add separator
 

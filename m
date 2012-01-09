From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Please support add -p with a new file, to add only part of the
 file
Date: Mon, 9 Jan 2012 14:47:21 -0600
Message-ID: <20120109204721.GC23825@burratino>
References: <20120109105134.1239.39047.reportbug@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Mon Jan 09 21:42:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkM2x-0006q0-91
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 21:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307Ab2AIUmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 15:42:20 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40319 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933151Ab2AIUmT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 15:42:19 -0500
Received: by vbbfc26 with SMTP id fc26so2985174vbb.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Bj9uHyaS1ttArx8C+pLIzxb2W2qITpmgQd8Qaeki1p8=;
        b=ez8mBLR1kvSMgCJAam3r1fbaG1o/v2/9wmy5uwOs+uUzyCeUrWshJJmR+6K0hvV/2O
         MY35B6hroDWApbobmdw56kn0gWbXCWDX6CaW2vfBhMO9jqFEOzE/6kCrsNSMSJdenGbB
         0NgJssnw2vPq2bLZic9Q9Ia2Ietq+HoCaRilU=
Received: by 10.182.202.69 with SMTP id kg5mr11954052obc.35.1326141738647;
        Mon, 09 Jan 2012 12:42:18 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m2sm5124097obu.3.2012.01.09.12.42.17
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 12:42:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120109105134.1239.39047.reportbug@leaf>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188189>

(+cc: Wincent who brought us the "add -p" shortcut --- thanks!; Thomas,
 who expanded its scope to git checkout et al; and Jeff, who has done
 some hacking on it)
Hi Josh,

Josh Triplett wrote:

> I recently found myself with a new file that I needed to check in part
> of with several commits.  I wanted to use "git add -p newfile" and use
> 'e' to add and commit several times (along with corresponding bits in
> existing files).  However, "git add -p" does not work on a new file,
> only an existing file.

Yep.  A workaround is to use "git add -N newfile" before running
"git add -p newfile".

I imagine "git add -p '*.c'" should also offer to add hunks from
source files that git doesn't know about yet, too.

Here's a quick demo (untested) that might _almost_ do the right thing.
Unfortunately it leaves intent-to-add entries around even for files
the operator rejects.  Anyway, maybe it can be a good starting point
for playing around.

Hope that helps,
Jonathan

 git-add--interactive.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d2..6e99ff1b 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1619,6 +1619,10 @@ sub main_loop {
 process_args();
 refresh();
 if ($patch_mode) {
+	if ($patch_mode eq 'stage') {
+		# NEEDSWORK: should use "git update-index --intent-to-add"
+		system(qw(git add --intent-to-add --), @ARGV);
+	}
 	patch_update_cmd();
 }
 else {
-- 
1.7.8.2

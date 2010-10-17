From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [BUG] log -m --graph does not work
Date: Sun, 17 Oct 2010 15:29:40 -0500
Message-ID: <20101017202940.GA4534@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heikki Hokkanen <hoxu@users.sf.net>,
	Adam Simpkins <simpkins@facebook.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 17 22:33:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Zv6-0007j4-DS
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 22:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739Ab0JQUdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 16:33:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64267 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735Ab0JQUdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 16:33:21 -0400
Received: by gyg13 with SMTP id 13so66337gyg.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=A3/wxYPSyskHcVW6H3e3QaCKYuEOl2kk+XroPyheO8o=;
        b=rPvPQSpDXaB/3daolVG+jPn1YI9NWjYTaBD82swBKNHkdfn3GOLXYW+uHKQpvHL6D9
         yMbbdMYKBBzGQK4uqiP/TT2V3iH4s4Tz9+BZxQgVSUbYgqg9XZB0DOJ6Nm8YtC4xKUAK
         7O0CqkTnho94TV01oxZQCQDrPqTfl4F6JWUIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=x2T3nrhzRKv0uS2mmoKu0SSTERX4D2nooR0x3NBrjMGTdD/R3njORXhY1DnT2k55sB
         O4KAPGQE3A6tGOcthr8SAM/hwaKdb6GO+jC2EPVYKID397dH4dUDOgzGZQ/hqmoNjwyZ
         G5/WuT3Esml6bQmsjPwnwCpF1nqxKtnyBVX1g=
Received: by 10.150.131.8 with SMTP id e8mr5408111ybd.91.1287347600402;
        Sun, 17 Oct 2010 13:33:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q8sm3729226ybk.0.2010.10.17.13.33.18
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 13:33:19 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159218>

"git log" can pass "-m" to the internal diff-tree helper, with
the handy result of multiple diffs for a merge, one against
each parent.  Unfortunately the graph pretty-printer doesn't
know what to do with the second diff:

 $ git log -m --graph --oneline --shortstat origin/pu
 *   2ee46ba (from a13ef41) Merge branch 'jh/notes-merge' into pu
 |\
 | |  17 files changed, 3367 insertions(+), 143 deletions(-)
 | |
 | |
 | |
 | |
 | |
[...]

Error out to avoid getting the user's hopes up (unless -c, --cc,
or --first-parent was supplied, since they work fine).

Noticed-by: Heikki Hokkanen <hoxu@users.sf.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This patch breaks "git log --ancestry-path --graph -m -p" even in the
cases when it sort of works.  It's probably better to go straight to a
fix without this band-aid.

Hints?

 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index b1c1890..80e0cdb 100644
--- a/revision.c
+++ b/revision.c
@@ -1681,6 +1681,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
 
+	if (!revs->ignore_merges && revs->graph &&
+	    !revs->combine_merges && !revs->first_parent_only)
+		die("cannot combine -m with --graph");
+
 	return left;
 }
 
-- 
1.7.2.3

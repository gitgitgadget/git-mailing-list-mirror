From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] launch_editor: Longer error message when TERM=dumb
Date: Fri, 30 Oct 2009 05:20:48 -0500
Message-ID: <20091030102048.GB1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3oRQ-0007UR-Dz
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbZJ3KKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 06:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482AbZJ3KKe
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:10:34 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:49907 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbZJ3KKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:10:33 -0400
Received: by ywh40 with SMTP id 40so2526287ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PyuFBEOjl8mESBp1R21GtPh1zStSi7W7p24fV/umNgk=;
        b=lEWp1k7SjVSdJf95tUT29+AadnRZsJ0OUj6nsgER/K6M6Av1w1U5Fdgh7XZgEszqIA
         J2A0jrOZWVKELBSrimO0YSUknrHqJR/Kf0M5YZl47YbxwUT2sjRYYxzKwtxdMfpBxaRA
         m3K6nh1NYROGO7PTbuWnixn4ou6ODMjuUfaWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wVTbkW8EEXfp74mWi1hy1P5BcmeO3iuMltmKHjj9iQH9hucNX1Bnvj0yi+mKHTGIeW
         3UCUifbBiriHn9BvZuH4kiwine9zc75m6ZPStKP6MBNfbP3eGjPdHScy/+xGsFIbpnhA
         tBtlRA2Fb7ongociAHAsYi0iJQ4jkOHUVRkxI=
Received: by 10.150.251.40 with SMTP id y40mr2586815ybh.202.1256897438027;
        Fri, 30 Oct 2009 03:10:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm523379gxk.0.2009.10.30.03.10.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:10:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131685>

Before falling back to vi, git checks if the terminal can support
such an editor by checking if $TERM is dumb.  git-sh-setup and
editor.c have similar but distinct error messages for this case.
To avoid changes in behavior when switching from one
implementation to the other, standardize on one error message.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Probably this check should apply to $VISUAL, too, but that is a
separate topic.

I am not sure which is the better error message.  It looks like some
effort went into the longer message so I thought I should give it a
try, but I kind of prefer the shorter one.

 editor.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/editor.c b/editor.c
index 4d469d0..316d139 100644
--- a/editor.c
+++ b/editor.c
@@ -16,7 +16,13 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 
 	terminal = getenv("TERM");
 	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
-		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
+		/* Terminal is dumb but no VISUAL nor EDITOR defined. */
+		return error(
+		  "No editor specified in GIT_EDITOR, core.editor, VISUAL,\n"
+		  "or EDITOR. Tried to fall back to vi but terminal is dumb.\n"
+		  "Please set one of these variables to an appropriate\n"
+		  "editor or run again with options that will not cause an\n"
+		  "editor to be invoked (e.g., -m or -F for git commit).");
 
 	if (!editor)
 		editor = "vi";
-- 
1.6.5.2

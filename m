From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 3/3] git-gui: Do not suggest a gc if gc --auto would
 not do it
Date: Thu, 18 Feb 2010 08:41:22 -0600
Message-ID: <20100218144122.GC30520@progeny.tock>
References: <20100218143431.GA30486@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mark Brown <broonie@sirena.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 15:41:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni7ZF-0001Kg-AI
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 15:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063Ab0BROlV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 09:41:21 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:38194 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991Ab0BROlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 09:41:19 -0500
Received: by ywh35 with SMTP id 35so1027670ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bNAGFKtSWmjAJGn/5yGTPzDl7ads7zMXH+nxidj65j0=;
        b=tP50MAKam+oans17c7eNMfxue8AijI76e/VrSge9vMZkqtAGVKVsYHmol1/sjb8wF9
         pPRUxsQO+NHLvTL4ibV3Ub7YlHQMeICSfw0DYkg0HSyTrmwrs4N90cBEuKcqPD4oNu2n
         YucZoGSsXbcrjz9ejobWi1GXLMaRWx8n+WqYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=A28IyXvYYtfp7YfBaK9bV1tS4MwzSuUaIlBSr6mg2tmfE+YrZZ/5BKuOd3v8EoFQ+f
         sqUBW5P8Nj8b31+G0JOPYDDJne4UpbOH5VO+L/S20ZOV/tKlwi2UEmIDWoAYncP+cR3l
         bIUN5rhTeIgAwbSYAHGL1Ij4XrOYTvnenGw90=
Received: by 10.101.134.39 with SMTP id l39mr1968668ann.130.1266504079077;
        Thu, 18 Feb 2010 06:41:19 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm1787810gxk.5.2010.02.18.06.41.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 06:41:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100218143431.GA30486@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140342>

In particular, if the user has set gc.auto to 0 or some other value,
respect that setting.

The gui-specific heuristic of assuming Windows filesystems will
tolerate fewer loose objects has been carried over.

This patch vastly increases the loose object count threshold for a
sort of compatibility with the console-based git programs.  The ideal
threshold may be different since the user can easily turn down an
offer to gc.  But for now, let us assume that a number of loose
objects that is tolerable when working from the command line will also
be tolerable in the gui.

Unfortunately, this duplicates code from builtin-gc.c.  A proper fix
would be involve teaching gc to cooperate with the gui more closely.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Thoughts?

 lib/database.tcl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/database.tcl b/lib/database.tcl
index c8184de..4b07865 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -100,15 +100,22 @@ proc too_many_loose_objects {} {
 	# distributed, we can check only one and get a reasonable
 	# estimate.
 	#
-	# Roughly based on the function of the same name in builtin-gc.c
+	# Based on the function of the same name in builtin-gc.c
 	#
 	# 'git gc' should learn a new --porcelain option
 	# so it can take care of this.
+
+	set gc_auto_threshold [get_config gc.auto]
+	if {$gc_auto_threshold eq {}} {
+		set gc_auto_threshold 6700
+	}
+	if {$gc_auto_threshold <=3D 0} {
+		return 0
+	}
 	set ndirs 1
-	set limit 8
+	set limit [expr {($gc_auto_threshold + 255) / 256}]
 	if {[is_Windows]} {
 		set ndirs 4
-		set limit 1
 	}
=20
 	set count [llength [glob \
--=20
1.7.0

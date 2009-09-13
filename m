From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git-gui: suggest gc only when counting at least 2 objects
Date: Sun, 13 Sep 2009 18:06:37 +0200
Message-ID: <20090913160637.GA15256@localhost>
References: <20090909195158.GA12968@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 18:06:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmrbJ-0006ye-8D
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 18:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbZIMQGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 12:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754750AbZIMQGo
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 12:06:44 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:62521 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZIMQGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 12:06:44 -0400
Received: by fxm17 with SMTP id 17so380369fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Rq7j5XPX+10HbAjlxFotB2D26xSodoQrb8s1jX2WKAg=;
        b=CjbW/iCipndTgx2zNxbcQEvskgY0VWYKLd/wORDm8lDoiwYHTu2rkQcOe0sWrYnX8O
         VDB0rS7EP5FpDYvwPhdzEG/lrtb1H0ZjKJcvlS5huv/hHbxH+L3kPfqj9NktYFCxNwAX
         WJSkCrMrzjzzql8k6orDxdclTtc0m+ooppexw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=O7178VnpbptPFbZGC+uBey2ttlHMK0769lj4oCBigA+E7OtkwWgMJnZxeTqtjZyYL0
         rcEc8D6vNBNyPdnd6L1Q56kpgQkx/7PG9kd4DWhCJzgAnuq1ej24qgwIEHt7KXSl/cWP
         uRlbGiDrEQVlDIxwflX9sZp/TjKSPscyID+ec=
Received: by 10.204.24.75 with SMTP id u11mr4258250bkb.0.1252858006767;
        Sun, 13 Sep 2009 09:06:46 -0700 (PDT)
Received: from darc.lan (p549A51F1.dip.t-dialin.net [84.154.81.241])
        by mx.google.com with ESMTPS id 12sm6488405bwz.70.2009.09.13.09.06.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 09:06:45 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Mmrb4-0004BI-0N; Sun, 13 Sep 2009 18:06:38 +0200
Content-Disposition: inline
In-Reply-To: <20090909195158.GA12968@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128371>

On Windows, git-gui suggests running the garbage collector if it finds
1 or more files in .git/objects/42 (as opposed to 8 files on other
platforms). The probability of that happening if the repo contains
only about 100 loose objects is 32%. The probability for the same to happen
with at least 2 files is only 6%, which is bit more reasonable.

The following octave script shows the probability for m or more
objects to be in .git/objects/42 for a total of n objects.

m = [1 2 8];
n = 100:100:3000;

P = zeros(length(n), length(m));
for k = 1:length(n)
        P(k, :) = 1-binocdf(m-1, n(k), 1/255);
end
plot(n, P);

n \ m   1       2       8
100     32%     6%      0%
500     86%     58%     0%
1000    98%     90%     5%
2000    100%    100%    55%

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

So here is the patch for my other complaint. Note that I fixed a bug in the
octave script above, in case someone wants to check the numbers.

I even tested it on a windows VM (as if it wasn't slow enough already).

Clemens

 git-gui/lib/database.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/database.tcl b/git-gui/lib/database.tcl
index a18ac8b..44099e5 100644
--- a/git-gui/lib/database.tcl
+++ b/git-gui/lib/database.tcl
@@ -91,7 +91,7 @@ proc do_fsck_objects {} {
 proc hint_gc {} {
 	set object_limit 8
 	if {[is_Windows]} {
-		set object_limit 1
+		set object_limit 2
 	}
 
 	set objects_current [llength [glob \
-- 
1.6.5.rc0.164.g5f6b0

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Thu, 21 Aug 2008 08:40:44 -0700
Message-ID: <20080821154044.GU3483@spearce.org>
References: <20080819234433.GJ24212@spearce.org> <20080820193557.GB16626@blimp.local> <20080820194407.GJ3483@spearce.org> <7vhc9fnxa1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 17:43:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWCIO-0006W8-1x
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 17:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbYHUPkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbYHUPkp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 11:40:45 -0400
Received: from george.spearce.org ([209.20.77.23]:43431 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYHUPko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 11:40:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 096D638375; Thu, 21 Aug 2008 15:40:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vhc9fnxa1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93168>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I was just trying to be cute by using the original commit timestamp
> > of Git itself.  Perhaps 12936648 (1TB / 83)?
> 
> Well, reverse psychology did not quite work, I guess, so I'd ask more
> directly.  Why not re-send with an update to the same 8-digit rule we use
> elsewhere?

--8<--
Make reflog query '@{1219188291}' act as '@{2008.8.19.16.24.51}'

As we support seconds-since-epoch in $GIT_COMMITTER_TIME we should
also support it in a reflog @{...} style notation.  We can easily
tell this part from @{nth} style notation by looking to see if the
value is unreasonably large for an @{nth} style notation.

The value 100000000 was chosen as it is already used by date.c to
disambiguate yyyymmdd format from a seconds-since-epoch time value.

A reflog with 100,000,000 record entries is also simply not valid.
Such a reflog would require at least 7.7 GB to store just the old
and new SHA-1 values.  So our randomly chosen upper limit for @{nth}
notation is "big enough".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_name.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4fb77f8..41b6809 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -349,7 +349,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 			else
 				nth = -1;
 		}
-		if (0 <= nth)
+		if (100000000 <= nth) {
+			at_time = nth;
+			nth = -1;
+		} else if (0 <= nth)
 			at_time = 0;
 		else {
 			char *tmp = xstrndup(str + at + 2, reflog_len);
-- 
1.6.0.112.g9c75


-- 
Shawn.

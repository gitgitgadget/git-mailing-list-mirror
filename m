From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 5/5] Enable ref log creation in git checkout -b.
Date: Wed, 24 May 2006 19:36:46 -0400
Message-ID: <20060524233646.GC3554@spearce.org>
References: <20060519091716.GM22257@spearce.org> <7vk68fyarn.fsf@assigned-by-dhcp.cox.net> <20060524035234.GA13329@spearce.org> <7vy7wr3tc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 01:37:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj2uO-0005Qn-Qn
	for gcvg-git@gmane.org; Thu, 25 May 2006 01:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWEXXgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 19:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWEXXgy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 19:36:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:63618 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932337AbWEXXgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 19:36:53 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fj2u9-000594-HS; Wed, 24 May 2006 19:36:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 078EA20FB0C; Wed, 24 May 2006 19:36:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7wr3tc3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20711>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> I've swallowed all 10 and pushed them out in "pu", but could you
> >> add tests to check the Porcelainish commands you touched with
> >> this series to make sure they all log correctly?
> >
> > Sure.  I've been putting it off as I've been busy the past few days
> > and have also been thinking about trying to rebuild reflog using a
> > tag/annotation branch style, which might be more generally useful
> > to others.
> 
> It appears that there is more serious breakage caused by the
> lock_ref change.  http-fetch in "next" fails to clone, because
> the call to lock-ref-sha1 in fetch.c::pull() forgets that the
> program might be creating a new ref.

The breakage is because of current_ref always being null.  The old
code would allow locking a non-existant ref in this case while the
new code was failing.  A simple change such as the following should
fix it:

-->8--
Fix fetch when using reflog.

Previously fetch was permitted to create refs if they did not exist;
this only worked as current_ref was always NULL and thus never
would get compared against the existing ref.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

2dad4178db978c01257fde949d808361589ee003
 fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

2dad4178db978c01257fde949d808361589ee003
diff --git a/fetch.c b/fetch.c
index fd57684..15110b8 100644
--- a/fetch.c
+++ b/fetch.c
@@ -213,7 +213,7 @@ int pull(char *target)
 	save_commit_buffer = 0;
 	track_object_refs = 0;
 	if (write_ref) {
-		lock = lock_ref_sha1(write_ref, current_ref, 1);
+		lock = lock_ref_sha1(write_ref, current_ref, 0);
 		if (!lock) {
 			error("Can't lock ref %s", write_ref);
 			return -1;
-- 
1.3.3.gfad60

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] upload-pack/fetch-pack: support side-band communication
Date: Wed, 21 Jun 2006 17:17:38 -0700
Message-ID: <7vpsh2xcv1.fsf@assigned-by-dhcp.cox.net>
References: <7vsllyzs9w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Jun 22 02:17:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtCtC-0004Bp-NV
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 02:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWFVARk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 20:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWFVARk
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 20:17:40 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:25336 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751524AbWFVARj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 20:17:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622001738.IQOU554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 20:17:38 -0400
To: git@vger.kernel.org
In-Reply-To: <7vsllyzs9w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 21 Jun 2006 04:01:47 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22290>

Junio C Hamano <junkio@cox.net> writes:

> This implements a protocol extension between fetch-pack and
> upload-pack to allow stderr stream from upload-pack (primarily
> used for the progress bar display) to be passed back.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>
>  * With this, fetching and cloning over git+ssh:// and git://
>    does not discard the progress bar and error messages that
>    upload-pack emits on its standard output.  They are sent to
>    the downloader and shown to the user.
>
>    Somehow this does not work when connecting to git daemon that
>    runs under inetd.  Fixes appreciated.

This seems to fix it.

-- >8 --
Subject: [PATCH] daemon: send stderr to /dev/null instead of closing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index bdfe80d..0747ce2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -757,7 +757,7 @@ int main(int argc, char **argv)
 		struct sockaddr *peer = (struct sockaddr *)&ss;
 		socklen_t slen = sizeof(ss);
 
-		fclose(stderr); //FIXME: workaround
+		freopen("/dev/null", "w", stderr);
 
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
-- 
1.4.0.g7883

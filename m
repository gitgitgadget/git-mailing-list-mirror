From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] builtin git-mv: support moving directories
Date: Tue, 08 Aug 2006 12:52:27 -0700
Message-ID: <7virl3vwck.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261941210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<17624.55600.423000.61479@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 08 21:52:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAXd1-00026b-9Z
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 21:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWHHTwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 15:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWHHTwa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 15:52:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55505 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030278AbWHHTw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 15:52:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808195228.PTLR554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 15:52:28 -0400
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17624.55600.423000.61479@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Tue, 8 Aug 2006 20:34:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25083>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> This might have been fixed already (my tree is a couple of days old),
> but the strcat fails for me, because the alloced memory is not
> cleared.
>
> Johannes Schindelin writes:
>  > +static const char *add_slash(const char *path)
>  > +{
>  > +	int len = strlen(path);
>  > +	if (path[len - 1] != '/') {
>  > +		char *with_slash = xmalloc(len + 2);
>  > +		memcpy(with_slash, path, len);
>  > +		strcat(with_slash + len, "/");
>  > +		return with_slash;
>  > +	}
>  > +	return path;
>  > +}
>
> perhaps morph the strcat into a memcopy or append the slash and the
> NUL manually?

Thanks, well spotted.  A textually minimum change would be to
do:

- 		memcpy(with_slash, path, len);
+ 		memcpy(with_slash, path, len + 1);

but that would touch the end of the string twice, so manually
terminating the string with '/' NUL would be appropriate.

I will apply a patch I've been privately using from time to time
to catch something like this to "master".

-- >8 --
[PATCH] debugging: XMALLOC_POISON

Compile with -DXMALLOC_POISON=1 to catch errors from using uninitialized
memory returned by xmalloc.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-compat-util.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 93f5580..3bcf5b1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -91,6 +91,9 @@ static inline void *xmalloc(size_t size)
 		ret = malloc(1);
 	if (!ret)
 		die("Out of memory, malloc failed");
+#ifdef XMALLOC_POISON
+	memset(ret, 0xA5, size);
+#endif
 	return ret;
 }
 
-- 
1.4.2.rc3.g45c5

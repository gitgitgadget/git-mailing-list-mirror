From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH di/fast-import-deltified-tree] Windows: define =?utf-8?b?U19JU1VJRA==?= properly
Date: Wed, 21 Sep 2011 07:38:18 +0000 (UTC)
Message-ID: <loom.20110921T092135-714@post.gmane.org>
References: <4E798538.7070106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 09:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6HOF-0004dt-4L
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 09:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab1IUHii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 03:38:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:59334 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409Ab1IUHih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 03:38:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R6HO8-0004ao-9i
	for git@vger.kernel.org; Wed, 21 Sep 2011 09:38:36 +0200
Received: from dhcp249-230.yandex.net ([87.250.249.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 09:38:36 +0200
Received: from divanorama by dhcp249-230.yandex.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 09:38:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.250.249.230 (Opera/9.80 (X11; Linux x86_64; U; en) Presto/2.9.168 Version/11.51)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181819>

Johannes Sixt <j.sixt <at> viscovery.net> writes:

> 
> From: Johannes Sixt <j6t <at> kdbg.org>
> 
> 8fb3ad76 (fast-import: prevent producing bad delta) introduced the first
> use of S_ISUID. Since before this commit the value was irrelevant, we had
> only a dummy definition in mingw.h. But beginning with this commit the
> macro must expand to a reasonable value. Make it so.
> 
> We do not change S_ISGID from the value 0 because it is used in path.c
> (via FORCE_DIR_SET_GID) to set the mode on directories in a manner that
> is not supported on Windows, and 0 is the right value in this case.
> 
> Signed-off-by: Johannes Sixt <j6t <at> kdbg.org>
> ---
>  compat/mingw.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 547568b..e2c89d6 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -22,7 +22,7 @@ typedef int socklen_t;
>  #define S_IWOTH 0
>  #define S_IXOTH 0
>  #define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
> -#define S_ISUID 0
> +#define S_ISUID 04000
>  #define S_ISGID 0
>  #define S_ISVTX 0
> 
Ow, it's awkward that the issue was discussed in [1] but slipped and nobody 
noticed, especially me being a patch sender.

If we choose patch from [1] I'd also change a comment to smth like
/* 
 * We abuse the 04000 bit on directories to mean "do not delta".
 * It is a S_ISUID bit on setuid platforms and an unused bit on
 * non-setuid platforms supported in git. In either case git ignores
 * the bit, so it's safe to abuse it locally.
 */

[1] http://thread.gmane.org/gmane.comp.version-control.git/179223/focus=179762

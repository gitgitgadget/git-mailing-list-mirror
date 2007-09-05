From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Function for updating refs.
Date: Wed, 05 Sep 2007 00:04:14 -0700
Message-ID: <7vy7flk2z5.fsf@gitster.siamese.dyndns.org>
References: <46DE0890.5020709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISow0-0004cd-4U
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbXIEHEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 03:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbXIEHEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:04:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37472 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbXIEHEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 03:04:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070905070415.PVZI10742.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 5 Sep 2007 03:04:15 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id kX4E1X0071gtr5g0000000; Wed, 05 Sep 2007 03:04:14 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57671>

Carlos Rica <jasampler@gmail.com> writes:

> A function intended to be called from builtins updating refs
> by locking them before write, specially those that came from
> scripts using "git update-ref".
>
> Signed-off-by: Carlos Rica <jasampler@gmail.com>

Thanks.  Very nice.

I have two comments but I think they are very minor details I
can and should fix in my inbox and apply, instead of asking you
to update and resend.

> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
> index e2f8ede..a192fd7 100644
> --- a/builtin-fetch--tool.c
> +++ b/builtin-fetch--tool.c
> @@ -31,24 +31,19 @@ static void show_new(enum object_type type, unsigned char *sha1_new)
>  		find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
>  }
>
> -static int update_ref(const char *action,
> +static int update_ref_env(const char *action,
>  		      const char *refname,
>  		      unsigned char *sha1,
>  		      unsigned char *oldval)
>  {
>  	char msg[1024];
>  	char *rla = getenv("GIT_REFLOG_ACTION");
> -	static struct ref_lock *lock;
>
>  	if (!rla)
>  		rla = "(reflog update)";
> -	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
> -	lock = lock_any_ref_for_update(refname, oldval, 0);
> -	if (!lock)
> -		return 1;
> -	if (write_ref_sha1(lock, sha1, msg) < 0)
> -		return 1;
> -	return 0;
> +	if (snprintf(msg, sizeof(msg), "%s: %s", rla, action) >= sizeof(msg))
> +		error("reflog message too long: %.*s...", 50, msg);

The original I did was sloppy and did not detect this situation;
thanks for fixing it.  You do not refuse the primary operation,
which is to update the ref, so this should be a warning instead
of an error, I think.

> diff --git a/send-pack.c b/send-pack.c
> index 9fc8a81..c59eea4 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -313,14 +313,9 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
>  					if (delete_ref(rs.dst, NULL)) {
>  						error("Failed to delete");
>  					}
> -				} else {
> -					lock = lock_any_ref_for_update(rs.dst, NULL, 0);
> -					if (!lock)
> -						error("Failed to lock");
> -					else
> -						write_ref_sha1(lock, ref->new_sha1,
> -							       "update by push");
> -				}

This removal makes "struct ref_lock *lock" (not shown in the
context) unused.  I will remove the declaration.

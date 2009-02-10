From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] lockfile: set lk->fd = -1 in 'rollback_lock_file()'
Date: Tue, 10 Feb 2009 07:29:59 -0800
Message-ID: <7v63jipax4.fsf@gitster.siamese.dyndns.org>
References: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
 <1234334612-24907-2-git-send-email-guanqun.lu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guanqun Lu <guanqun.lu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWuaD-0001Hw-Ol
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbZBJPaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbZBJPaG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:30:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbZBJPaF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:30:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DBBBD98AD1;
	Tue, 10 Feb 2009 10:30:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 24F7C98ACB; Tue,
 10 Feb 2009 10:30:00 -0500 (EST)
In-Reply-To: <1234334612-24907-2-git-send-email-guanqun.lu@gmail.com>
 (Guanqun Lu's message of "Wed, 11 Feb 2009 14:43:32 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0BC81BC-F787-11DD-87F9-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109256>

Guanqun Lu <guanqun.lu@gmail.com> writes:

> Post-conditions when these functions return successfully:
>                     lk->fd == -1?    lk->filename[0] == '\0'?
> close_lock_file()       yes                 no
> commit_lock_file()      yes                 yes
> rollback_lock_file()    no*                 yes
>
> [*] This commit changes this 'no' in rollback_lock_file() to 'yes',
> which achieves more robust and unified interface.

Is there a broken caller this patch fixes?  IOW, is there a codepath that
can call rollback and then later notices lk->fd is not negative and uses
it without checking lk->filename[0] first?

> Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
> ---
>  lockfile.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 021c337..44e5253 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -243,8 +243,10 @@ int commit_locked_index(struct lock_file *lk)
>  void rollback_lock_file(struct lock_file *lk)
>  {
>  	if (lk->filename[0]) {
> -		if (lk->fd >= 0)
> +		if (lk->fd >= 0) {
>  			close(lk->fd);
> +			lk->fd = -1;
> +		}
>  		unlink(lk->filename);
>  	}
>  	lk->filename[0] = 0;
> -- 
> 1.6.1.2.392.gb04d1

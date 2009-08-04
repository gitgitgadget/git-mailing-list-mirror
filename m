From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix compiler warning by properly initialize failed_errno
Date: Mon, 03 Aug 2009 23:07:30 -0700
Message-ID: <7vmy6g6rj1.fsf@alter.siamese.dyndns.org>
References: <1249241675-77329-1-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>,
	Johannes Sixt <j6t@kdbg.org>
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDBa-0005Nu-JD
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbZHDGHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbZHDGHl
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:07:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbZHDGHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:07:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C07F51CCD5;
	Tue,  4 Aug 2009 02:07:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23BF21CCD4; Tue,  4 Aug 2009
 02:07:31 -0400 (EDT)
In-Reply-To: <1249241675-77329-1-git-send-email-sn_@gmx.net> (David Soria
 Parra's message of "Sun\,  2 Aug 2009 21\:34\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D5DE1EE-80BD-11DE-936A-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124752>

David Soria Parra <sn_@gmx.net> writes:

> From: David Soria Parra <dsp@php.net>
>
> Initilize failed_error in start_command to avoid compiler warnings
>
> Signed-off-by: David Soria Parra <dsp@php.net>
> ---
>  run-command.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index dc09433..510349b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -19,7 +19,7 @@ int start_command(struct child_process *cmd)
>  {
>  	int need_in, need_out, need_err;
>  	int fdin[2], fdout[2], fderr[2];
> -	int failed_errno;
> +	int failed_errno = 0;
>  
>  	/*
>  	 * In case of errors we must keep the promise to close FDs

We would want to be able to distinguish between a workaround for a
compiler that is not clever/careful enough, and a necessary
initialization.  In this particular case, it is the former, and we should
say

	int failed_errno = failed_errno;

instead.

The potentially uninitialized use your compiler is worried about is inside
if (cmd->pid < 0) after #ifdef/#else/#endif.

 (1) if not on MINGW32, we would have already assigned to failed_errno
     after fork() returns negative value to cmd->pid;

 (2) if on MINGW32, we would have assigned to failed_errno unconditionally
     after calling mingw_spawnvpe().

so its worry is unfounded.

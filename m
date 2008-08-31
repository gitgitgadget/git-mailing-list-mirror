From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Improvate portability: Display pid_t's always as
 long
Date: Sun, 31 Aug 2008 00:15:10 -0700
Message-ID: <7vtzd1bqpt.fsf@gitster.siamese.dyndns.org>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net>
 <1219858743-4476-2-git-send-email-sn_@gmx.net>
 <7vsksqp9f1.fsf@gitster.siamese.dyndns.org> <48B9B03F.1080304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>
To: David Soria Parra <dsoria@gmx.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 09:16:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZhAg-00038n-Dp
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 09:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbYHaHPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 03:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYHaHPV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 03:15:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYHaHPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 03:15:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF92958833;
	Sun, 31 Aug 2008 03:15:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E995058831; Sun, 31 Aug 2008 03:15:12 -0400 (EDT)
In-Reply-To: <48B9B03F.1080304@gmx.net> (David Soria Parra's message of "Sat,
 30 Aug 2008 22:40:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8FDFFC98-772C-11DD-B268-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94461>

David Soria Parra <dsoria@gmx.net> writes:

>> On the other hand, if you are shooting for maximum compatibility perhaps
>> you may want to cast it to "intmax_t" and format as such.
> Yes, good point, casting to long isn't enough. I think it's a good approach to cast the pids to intmax_t as pids
> are also used in git_path() and therefore might result in equal paths for separate processes if
> the pid is higher than int.
>
> so here is an updated patch:

Please wrap lines to reasonable length (e.g. 70-76 cols).

Please move commentary like this that clarifies context of the patch
submission to after three-dashes (emulate patches from people with good
manners).

> From da5519b3ae5ce84c703aeaab2bc4ea363897c334 Mon Sep 17 00:00:00 2001

Especially, don't paste this line.

> From: David Soria Parra <dsp at>
> Date: Fri, 29 Aug 2008 01:19:43 +0200
> Subject: [PATCH] Improvate portability: Cast pid_t's to intmax_t

"Improvate"?

Including these in your message is not very useful.  These in-body headers
are used to override what can be read from the real headers of the e-mail
message, but you do not have a valid e-mail address here!

> Some systems (like e.g. OpenSolaris) define pid_t as long,
> ...
> diff --git a/builtin-commit.c b/builtin-commit.c
> index c870037..90ef3d5 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -320,7 +320,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
>  		die("unable to write new_index file");
>
>  	fd = hold_lock_file_for_update(&false_lock,
> -				       git_path("next-index-%d", getpid()), 1);
> +				       git_path("next-index-%jd", (intmax_t) getpid()), 1);

Some systems we support do not have %j width specifier.  I'd suggest
casting up to uintmax_t and format with PRIuMAX, which we do define
a substitute for portability.

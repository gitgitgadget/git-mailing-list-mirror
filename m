From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Sun, 02 Dec 2007 13:56:07 -0800
Message-ID: <7vwsrwu5fs.fsf@gitster.siamese.dyndns.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
	<20071202212224.GA22117@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IywoC-0002bo-C1
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbXLBV4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbXLBV4O
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:56:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40029 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbXLBV4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 16:56:13 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7F9842F0;
	Sun,  2 Dec 2007 16:56:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 02F889C374;
	Sun,  2 Dec 2007 16:56:30 -0500 (EST)
In-Reply-To: <20071202212224.GA22117@midwinter.com> (Steven Grimm's message of
	"Sun, 2 Dec 2007 13:22:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66824>

Steven Grimm <koreth@midwinter.com> writes:

> +The hook may optionally choose to update the ref on its own, e.g.,
> +if it needs to modify incoming revisions in some way. If it updates
> +the ref, it should exit with a status of 100.  The hook should exit
> +with a status between 1 and 99 if it wants to disallow updating the
> +named ref.  Otherwise it should exit with zero, and the ref will be
> +updated automatically.

This makes one wonder what happens if it returns 101, iow if there is
difference between returning 99 and 101, and if so why.

> +Remote Tracking Refs
> +--------------------
> +
> +After successfully sending a pack to the remote, 'git-send-pack'
> +updates the corresponding remote tracking ref in the local repository
> +to point to the same commit as was just sent to the remote side. In
> +most cases this eliminates the need to subsequently fetch from the
> +remote repository since there would be nothing new to fetch.

Micronit.  The above is all "if exists".  Not everybody pushes to
somewhere he uses tracking with.

> @@ -70,8 +73,11 @@ static struct command *commands;
>  static const char pre_receive_hook[] = "hooks/pre-receive";
>  static const char post_receive_hook[] = "hooks/post-receive";
>  
> -static int hook_status(int code, const char *hook_name)
> +static int hook_status(int code, const char *hook_name, int ok_start)
>  {
> +	if (ok_start && -code >= ok_start)
> +		return -code;
> +

I've always been puzzled by this "ok_start" parameter from the very
beginning edition of your patch.  It is not like "if this is true, then
it is ok to run the hook but otherwise do not run".  In layman's terms,
what does the parameter mean?

Maybe the variable is misnamed and not expressing the concept well
enough.  Maybe the concept itself is muddy and hard to understand.  I
cannot tell.

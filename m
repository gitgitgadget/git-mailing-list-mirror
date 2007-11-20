From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Tue, 20 Nov 2007 17:17:41 +0100
Message-ID: <474308A5.8070301@viscovery.net>
References: <1195503174-29387-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 17:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuVnY-0006hl-CF
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 17:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760042AbXKTQRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 11:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760027AbXKTQRq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 11:17:46 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27372 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759345AbXKTQRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 11:17:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IuVmb-00040u-D6; Tue, 20 Nov 2007 17:17:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0933F6B7; Tue, 20 Nov 2007 17:17:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1195503174-29387-1-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65548>

Ping Yin schrieb:
> This patch disables the auto closing behavious of start_command
> and corrects all codes which depend on this kind of behaviour.

I've thought about this a bit more, and I think that it is better to leave 
this auto-closing behavior unchanged and change your usage of this feature, 
like so:

> +static void wt_status_print_submodule_summary(struct wt_status *s)
> +{
> +       struct child_process sm_summary;
> +       memset(&sm_summary, 0, sizeof(sm_summary));
> +       ...
> +       sm_summary.out = fileno(s->fp);

	fflush(s->fp);
	sm_summary.out = dup(fileno(s->fp));	/* run_command closes it */

> +       ...
> +       run_command(&sm_summary);
> +}

This way the change is more local without affecting well-tested other callers.

Furthermore, I don't think that it's correct to just set the .close_in or 
.close_out flags. This will close the fd only in finish_command(), which can 
be too late: Think again of a writable pipe end that remains open and keeps 
the reader waiting for input that is not going to happen.

-- Hannes

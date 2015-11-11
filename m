From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Wed, 11 Nov 2015 12:37:16 -0800
Message-ID: <CAGZ79kaZ0W5q8=iowbSTJY_mDNNYc6qdTszcWDDDCtYfZyeK_Q@mail.gmail.com>
References: <1446853737-19047-1-git-send-email-sbeller@google.com>
	<563DBDDA.2000106@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:37:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwc8x-0002Hu-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbbKKUhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:37:19 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33919 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbKKUhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:37:17 -0500
Received: by ykfs79 with SMTP id s79so69524667ykf.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9a1QU/mIZ1Or9H1qQgka8N+tAGxsJtzinp4X6p7XhYg=;
        b=FLfVMJthkU82Xq0cXy8B5Sipj4PRI2GCFr77a8VTfD/q9wzd6gZlmUHV/Ou9HMgV3t
         vQvBomRJTPjFJiYla+fBIHt7EwoTRdxH0XL+j6X5ur7nAG4fenglPPC8nzdFYXrJ6/dP
         s1/G/XjlvOybb/5A6Q/wsL/VX/zJVtxX+xB6JGW8pjG7C3POxZo6GaADpKrb+sv+2zeb
         rAqqEo/RaahY808jDV2vaKm2WJRkIeOB0mSFppLvgHqux0ExbEiwgK0JlsRpmWpJ9xxy
         bi2dUPgrp4PlGQAztxX/zAzvKA+lpkYfXyhCBC1CJMH08tHlibV93VgxftMdy8EVoYSc
         7zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9a1QU/mIZ1Or9H1qQgka8N+tAGxsJtzinp4X6p7XhYg=;
        b=lLx8WgacMZODrio77cfIbQ+6DCfbfKuSYUQbYAczTxCYCBmqx9wJs8C/zi/e7n8krc
         izyfiBvG1aN0VORyca+Gx4ptMdTSkrA6hrlDWn3E733tMHQnNkb5Cf4WbFhp+T526/Pj
         vYQy+ZcqJrMXhkS1Lcg7aOq/ruCmva/tbatF6W1XTQ3Pd3EMaekEX/o+EPkbg2eYMz6h
         YEhjSkZslJsRVlmczDh6PXBEFFXq/cetps6srFGdXPyK0ujTvZTWJjdcgyxy74GSnAf3
         QLT4UHmaxqszETk98t+VQcw/32N2DU4pjybpn+UwmA0kOBThA/eX5501oSDBTPb8tbxm
         gUOA==
X-Gm-Message-State: ALoCoQm52hnTsS0Xr5koJksn04QWRBTLVa9dYIBYAzMFKY+flmrKbFRCJ/sKOWJVCn864TS+Df0H
X-Received: by 10.129.40.147 with SMTP id o141mr11851967ywo.199.1447274236742;
 Wed, 11 Nov 2015 12:37:16 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 12:37:16 -0800 (PST)
In-Reply-To: <563DBDDA.2000106@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281197>

including the list and all others this time.

>>                         if (code < 0) {
>>                                 pp->shutdown = 1;
>> -                               kill_children(pp, SIGTERM);
>> +                               kill_children(pp, -code);
>
>
> I'll see what this means for our kill emulation on Windows. Currently, we
> handle only SIGTERM.

So currently we only pass in SIGTERM from the callers, and I certainly
only intend
to use that signal. I just thought special casing the SIGTERM signal
would do no good
in terms of design here.

So maybe that was not the right thought and we do have to special case
SIGTERM here?

I worked with another large proprietary parallel program (spawning
child processes) before.
If you pressed CTRL-C, it would omit a message like:

    Sending no further input to the children

If you press Ctrl-C again, it would print:

    Sending SIGTERM to children, to shut them down gracefully

If you pressed once again, you'll get a

    User seems to be angry, shutting down hard, sending SIGKILL
    $ # that was fast now.

I guess we don't want to play around like that, but if the parent process gets
a SIGTERM, we relay that and other signals we ignore for now?

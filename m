From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [Updated PATCH 1/2] Report exec errors from run-command
Date: Thu, 31 Dec 2009 00:26:48 -0500
Message-ID: <905315640912302126n1848c99cre0f9caa644041fad@mail.gmail.com>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<1262170338-11574-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 06:27:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQDZ4-0003QD-O7
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 06:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbZLaF1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 00:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbZLaF1J
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 00:27:09 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:52573 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZLaF1I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 00:27:08 -0500
Received: by pxi27 with SMTP id 27so7278366pxi.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 21:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=3wDg05Uql8A5XwQV82amqh9FKwTzQb6tbrMM/WhLx14=;
        b=mPGQZGpphaujr563GKX5VuRUnfvhpaRXj0gipbLBB7bO9nGGejN48gTzokFnB8ZtAV
         rvvq6lfgMC5HJnlSeg0HMiq6EYrkKwbcWR10QrpQMDzAqiaxChvQlfp+AjelE44g8F9A
         ubrXt0AZ0/uzBF+SX4ed/EZtbe1C/SVOCl2Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=o1zEHcBOaGVAXy49dBego3paRPbf/df/az3i34kYmfydDDNRIvGxYZuH3UJGR1y2pL
         dPxuz92zsAANXzIcOsLH45zT7MiqbnGJNIpfN2Qb1LaIXRkEcjiVlCEg9EP1ksCepp+x
         kVptJeNJYzGgHDFXLjfErKXfT2yplxiFvasu4=
Received: by 10.142.4.12 with SMTP id 12mr1381217wfd.133.1262237228252; Wed, 
	30 Dec 2009 21:27:08 -0800 (PST)
In-Reply-To: <1262170338-11574-2-git-send-email-ilari.liusvaara@elisanet.fi>
X-Google-Sender-Auth: 665793e3019be532
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135932>

On Wed, Dec 30, 2009 at 5:52 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Previously run-command was unable to report errors happening in exec
> call. Change it to pass errno from failed exec to errno value at
> return.
>
> The errno value passing can be done by opening close-on-exec pipe and
> piping the error code through in case of failure. In case of success,
> close-on-exec closes the pipe on successful exec and parent process
> gets end of file on read.

I was testing pu and 'git diff' and 'git log' would hang forever.

Bisecting pointed to v1 of this patch.  But seeing that v2 was out, I
tried v2 of the patch, but the issue remains.

Tried on OSX and linux with the same results.

Here's a gdb backtrace on OSX at the point where I interrupted it:
(gdb) bt
#0  0x9923dbfe in read$UNIX2003 ()
#1  0x000b399b in start_command (cmd=0x10b300) at run-command.c:110
#2  0x00099452 in setup_pager () at pager.c:94
#3  0x0002196b in cmd_diff (argc=1, argv=0xbffff42c, prefix=0x0) at
builtin-diff.c:316
#4  0x00002a2a in run_builtin [inlined] () at git.c:257
#5  0x00002a2a in handle_internal_command (argc=1, argv=0xbffff42c) at git.c:401
#6  0x00002cab in main (argc=1, argv=0xbffff42c) at git.c:443

and on linux:
(gdb) bt
#0  0x0000003530a0d590 in __read_nocancel () from /lib64/libpthread.so.0
#1  0x0000000000494858 in start_command (cmd=0x71ed60) at run-command.c:93
#2  0x000000000047daf8 in setup_pager () at pager.c:94
#3  0x000000000041d83f in cmd_diff (argc=1, argv=0x7fff256f9fe0, prefix=0x0)
    at builtin-diff.c:316
#4  0x0000000000403ced in handle_internal_command (argc=1, argv=0x7fff256f9fe0)
    at git.c:257
#5  0x0000000000403f26 in main (argc=1, argv=0x7fff256f9fe0) at git.c:445

Thanks,
Tarmigan

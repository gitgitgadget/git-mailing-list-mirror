From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH 1/2] MSVC: Do not close stdout to prevent a crash
Date: Sat, 19 Nov 2011 21:52:29 +0100
Message-ID: <4EC8170D.3070906@lyx.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org> <m2sjlkcgyl.fsf@igel.home> <7v39dkj5ad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRrtv-0007XS-Dk
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab1KSUwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:52:35 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49830 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab1KSUwe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 15:52:34 -0500
Received: by eye27 with SMTP id 27so4410296eye.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 12:52:33 -0800 (PST)
Received: by 10.14.10.104 with SMTP id 80mr599978eeu.75.1321735952846;
        Sat, 19 Nov 2011 12:52:32 -0800 (PST)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id o4sm15202390eeb.0.2011.11.19.12.52.31
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Nov 2011 12:52:31 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7v39dkj5ad.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185709>

Op 19-11-2011 20:11, Junio C Hamano schreef:
> ... This happens for 'format-patch' which closes stdout after a call to
> freopen which directs stdout to the format patch file.
>> It shouldn't do that in the first place.  This is an error on any
>> platform.
> Correct. The clean-up codepath is for built-in command implementations
> that write out their result and return 0 to signal success. If we let the
> crt0 to run its usual clean-ups like closing the standard output stream,
> we wouldn't be able to catch errors from there.
>
> For built-ins that perform their own clean-ups, it is their responsibility
> to be careful, hence we skip this part of the code.
>
> We have relied on fstat(-1,&st) to correctly error out, and if MSVC build
> crashes, it is a bug in its fstat() emulation, I would think.

This doesn't work because fileno(stdout) returns 1 no matter whether we 
closed stdout or not.

My reasoning for the proposed patch is that we call freopen(..., stdout) 
for each patch file to write, but we only call fclose(stdout) once. Sp, 
I concluded that it is not necessary to close stdout and that we just 
need to redirect any new output to stdout.

Vincent

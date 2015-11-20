From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Sat, 21 Nov 2015 00:24:19 +0100
Message-ID: <564FABA3.2040100@kdbg.org>
References: <1448053719-28340-1-git-send-email-sbeller@google.com>
 <20151120220544.GC18255@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org, johannes.schindelin@gmail.com,
	tboegi@web.de
To: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 00:24:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzv2d-00084m-Sq
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 00:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934877AbbKTXYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 18:24:25 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:24099 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759934AbbKTXYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 18:24:23 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p2YqS5h50z5tlB;
	Sat, 21 Nov 2015 00:24:20 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 72B4F29D3;
	Sat, 21 Nov 2015 00:24:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151120220544.GC18255@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281539>

Am 20.11.2015 um 23:05 schrieb Jonathan Nieder:
> Stefan Beller wrote:
>
>> Detect if a child stopped working by checking if their stderr pipe
>> was closed instead of checking their state with waitpid.
>> As waitpid is not fully working in Windows, this is an approach which
>> allows for better cross platform operation. (It's less code, too)
>
> Can you say more about what is broken about waitpid on Windows?

waitpid(-1, ...) is not implemented on Windows.

Is it necessary to mention waitpid here at all? The most compelling 
reason to write the infrastructure in this new way is that it is much 
more in line with the usual "start_command, read-until-EOF, 
finish_command" sequence.

> I ask because it's possible for a child to close stderr without
> intending to be finished.  That might be okay here (though the commit
> subject doesn't explain so, it is only affecting the workqueue
> interface that runs commands in parallel and not the normal
> run-command interface) but would need some documentation and could be
> counterintuitive.

It could be spelled out more clearly. The children have both their stdin 
and stdout redirected to the same writable end. On the parent side, we 
have to deal only with "stderr" simply because our child_process 
facility has everything to redirect like ">&2" (the stdout_to_stderr 
flag), but nothing for "2>&1".

Yeah, it's still possible that the child closes both stdout and stderr 
long before it dies, but that would really be far, far outside the norm.

> So if there's a simple way to get waitpid to work, that seems
> preferrable.

It would be possible, but not simple, to make waitpid on Windows 
suitable for the original code, but that does not make the original code 
preferrable.

-- Hannes

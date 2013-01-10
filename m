From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Thu, 10 Jan 2013 22:52:10 +0100
Message-ID: <50EF380A.9010809@kdbg.org>
References: <20130104124756.GA402@sigill.intra.peff.net> <7vr4lu3wx7.fsf@alter.siamese.dyndns.org> <20130109205116.GA24605@sigill.intra.peff.net> <7vehhu3u2y.fsf@alter.siamese.dyndns.org> <20130110001844.GC21054@google.com> <20130110112655.GB21993@sigill.intra.peff.net> <7vbocw23fq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtQ39-0001s8-OP
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 22:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab3AJVwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 16:52:16 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:1824 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753456Ab3AJVwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 16:52:15 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B9C60CDF86;
	Thu, 10 Jan 2013 22:52:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B0D9E19F45C;
	Thu, 10 Jan 2013 22:52:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vbocw23fq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213156>

Am 10.01.2013 21:22, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> Maybe the right rule is "if we are using the shell to execute, do not
>> mention SIGPIPE"? It seems a little iffy at first, but:
>>
>>   1. It tends to coincide with direct use of internal tools versus
>>      external tools.
>>
>>   2. We do not reliably get SIGPIPE there, anyway, since most shells
>>      will convert it into exit code 141 before we see it.
>>
>> I.e., something like:
> 
> Hmph.  That may be a good heuristics, but I wonder if we also want
> to special case WIFEXITED(status) && WEXITSTATUS(status) == 141 to
> pretend as if nothing went wrong, when ignore_sigpipe is in effect?

The purpose of Peff's patch is to remove the error message, but not to
pretend success (the return code remains 141).

I looked at all instances with use_shell=1 or RUN_USING_SHELL:

Most of the time, we do not care where the output of the command goes
to, which I regard as the same case as when a shell runs a command: We
don't need to report the SIGPIPE death.

The interesting cases are when git reads back the output of the command.
Here, a SIGPIPE death of the child would indicate a bug in git, I think,
and some diagnostic would be worth it. But we can just as well declare
that git doesn't have bugs ;)

These are the interesting cases:
connect.c:640:          conn->use_shell = 1;
    a connection to a local repository
convert.c:372:  child_process.use_shell = 1;
    clean/smudge filter
credential.c:216:       helper.use_shell = 1;
    credential helper
diff.c:4851:    child.use_shell = 1;
    textconv

All in all, I think the heuristics makes sense.

-- Hannes

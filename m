From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] nfv?asprintf are broken without va_copy, workaround them.
Date: Wed, 19 Sep 2007 21:27:31 -0700
Message-ID: <7vwsumkll8.fsf@gitster.siamese.dyndns.org>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org>
	<1190241736-30449-2-git-send-email-madcoder@debian.org>
	<1190241736-30449-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 06:27:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYDdj-0007Yb-Bj
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 06:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbXITE1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 00:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbXITE1k
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 00:27:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbXITE1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 00:27:40 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BDA21369F3;
	Thu, 20 Sep 2007 00:27:56 -0400 (EDT)
In-Reply-To: <1190241736-30449-3-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Thu, 20 Sep 2007 00:42:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58753>

Pierre Habouzit <madcoder@debian.org> writes:

> * drop nfasprintf.
> * move nfvasprintf into imap-send.c back, and let it work on a 8k buffer,
>   and die() in case of overflow. It should be enough for imap commands, if
>   someone cares about imap-send, he's welcomed to fix it properly.
> * replace nfvasprintf use in merge-recursive with a copy of the strbuf_addf
>   logic, it's one place, we'll live with it.
>   To ease the change, output_buffer string list is replaced with a strbuf ;)

While I'd agree with all of the above,

> * rework trace.c API's so that only one of the trace functions takes a
>   vararg. It's used to format strerror()s and git command names, it should
>   never be more than a few octets long, let it work on a 8k static buffer
>   with vsnprintf or die loudly.

and I'd agree with this in principle, there is a minor nit with
the implementation and use in trace.c.  E.g.

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9b74ed2..c0f954e 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -97,7 +97,8 @@ int execv_git_cmd(const char **argv)
>  		tmp = argv[0];
>  		argv[0] = git_command;
>  
> -		trace_argv_printf(argv, -1, "trace: exec:");
> +		trace_printf("trace: exec:");
> +		trace_argv(argv, -1);

This used to be a single call into trace.c which would format a
single string to write(2) out.  Now these two messages go
through separate write(2) and can be broken up.  I think the
atomicity of the log/trace message was the primary reason the
original had such a strange calling convention.

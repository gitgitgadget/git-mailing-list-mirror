From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/5] launch_editor: propagate SIGINT from editor to git
Date: Sun, 11 Nov 2012 20:48:38 +0100
Message-ID: <50A00116.8060604@kdbg.org>
References: <20121111163100.GB13188@sigill.intra.peff.net> <20121111165706.GE19850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kalle Olavi Niemitalo <kon@iki.fi>,
	Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXdWc-0000rT-08
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 20:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab2KKTso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 14:48:44 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:56197 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab2KKTsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 14:48:43 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BC507130045;
	Sun, 11 Nov 2012 20:48:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1E56219F371;
	Sun, 11 Nov 2012 20:48:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <20121111165706.GE19850@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209440>

Am 11.11.2012 17:57, schrieb Jeff King:
> @@ -51,6 +51,8 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>  		sigchain_push(SIGINT, SIG_IGN);
>  		ret = finish_command(&p);
>  		sigchain_pop(SIGINT);
> +		if (WIFSIGNALED(ret) && WTERMSIG(ret) == SIGINT)
> +			raise(SIGINT);

The return value of finish_command() is already a digested version of
waitpid's status value. According to
Documentation/technical/api-run-command.txt:

. If the program terminated due to a signal, then the return value is
the signal number - 128, ...

the correct condition would be

		if (ret == SIGINT - 128)

-- Hannes

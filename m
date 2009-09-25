From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: 'git branch --no-merge' is ambiguous
Date: Fri, 25 Sep 2009 20:44:44 +0200
Message-ID: <m2ljk250f7.fsf@igel.home>
References: <4ABC9B69.5010205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrFmo-0004BO-Be
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 20:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbZIYSoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 14:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbZIYSoo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 14:44:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60953 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbZIYSon (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 14:44:43 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id ED9751C155A5;
	Fri, 25 Sep 2009 20:44:45 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id C9FEE901FE;
	Fri, 25 Sep 2009 20:44:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id r3aks6SsCQo0; Fri, 25 Sep 2009 20:44:44 +0200 (CEST)
Received: from igel.home (DSL01.83.171.187.22.ip-pool.NEFkom.net [83.171.187.22])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 25 Sep 2009 20:44:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5211810C5CE; Fri, 25 Sep 2009 20:44:44 +0200 (CEST)
X-Yow: Is this "BIKINI BEACH"?
In-Reply-To: <4ABC9B69.5010205@viscovery.net> (Johannes Sixt's message of
	"Fri, 25 Sep 2009 12:28:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129104>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Look here:
>
>  $ git branch --merge
>  * master
>  $ git branch --no-merge
>  error: Ambiguous option: no-merge (could be --no-merged or --no-merged)
>  usage: ...
>      --no-merged <commit>  print only not merged branches
>      --merged <commit>     print only merged branches
>
> I tried to debug it, but parse_long_opt() is such awful spaghetti code
> that I don't grok it. Please help.

parse_long_opt always matches both --opt and --no-opt for any option
"opt", and only get_value checks whether --no-opt is actually valid.
Since the options for git branch contains both "no-merged" and "merged"
there are two matches for --no-merge, but no exact match.  With this
patch the negation of a NONEG option is rejected earlier, but it changes
the error message from "option `no-opt' isn't available" to "unknown
option `no-opt'".

diff --git a/parse-options.c b/parse-options.c
index a64a4d6..f559411 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -230,6 +230,9 @@ is_abbreviated:
 				abbrev_flags = flags;
 				continue;
 			}
+			/* negation allowed? */
+			if (options->flags & PARSE_OPT_NONEG)
+				continue;
 			/* negated and abbreviated very much? */
 			if (!prefixcmp("no-", arg)) {
 				flags |= OPT_UNSET;

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Thu, 13 Mar 2008 14:59:08 +0100
Message-ID: <47D9332C.4020904@viscovery.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213916.GK26286@coredump.intra.peff.net> <47D8DCC0.9090303@viscovery.net> <20080313124103.GC19485@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 15:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnyP-0007NZ-FL
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbYCMN7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbYCMN7P
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:59:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40018 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbYCMN7P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:59:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZnwu-0000MJ-9v; Thu, 13 Mar 2008 14:58:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D759F6B7; Thu, 13 Mar 2008 14:59:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080313124103.GC19485@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77087>

Jeff King schrieb:
> Junio's fixups should restore the automagic behavior, so you shouldn't
> see any problems now, I think. But the run_command cleanup is sensible.

Thanks. But it turns out that things are not /that/ trivial. We better
live with Junio's fixup.

> -	while (waitpid(pid, &status, 0) < 0) {
> -		if (errno == EINTR)
> -			continue;
> -		return -1;
> -	}
> -	if (WIFEXITED(status)) {
> -		if (!WEXITSTATUS(status))
> -			return 1;
> -		return 0;
> -	}
> -	return -1;
> -}
> -
...
> +	status = run_command_v_opt(argv, 0);
...
> +	return status == 0 ? 1 : -1;

grep can return 0 (success, something found), 1 (nothing found), and other
values for "real" failures like usage errors or crashes. This conditional
throws the latter two into the same pot, which makes git-grep unable to
distinguish "nothing found" from failure; cf. the call sites of
flush_grep(), where want to set the flag 'hit'.

-- Hannes

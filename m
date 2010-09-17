From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Fri, 17 Sep 2010 14:06:44 +0200
Message-ID: <4C9359D4.2030109@viscovery.net>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Sep 17 14:07:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwZiW-0005uC-Mm
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 14:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab0IQMGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 08:06:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43057 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752738Ab0IQMGu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 08:06:50 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OwZiH-0006Pb-Vz; Fri, 17 Sep 2010 14:06:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D03451660F;
	Fri, 17 Sep 2010 14:06:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
In-Reply-To: <4C9351A7.7050609@web.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156379>

Am 9/17/2010 13:31, schrieb Jens Lehmann:
> But I think I found the real issue, the stdout of the forked "git fetch"
> was swallowed due to a copy & paste bug while the actual fetch commands
> were executed nonetheless. Please try the following change:
> 
> 
> diff --git a/submodule.c b/submodule.c
> index e2c3bae..4fb1071 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -260,7 +260,8 @@ int fetch_populated_submodules(int forced)
>         cp.env = local_repo_env;
>         cp.git_cmd = 1;
>         cp.no_stdin = 1;
> -       cp.out = -1;
> +       cp.out = 1;
> +       cp.err = 1;

This cannot be correct. Subsequent code reads the stdout of the child
process, i.e., you want a pipe; hence, cp.out = -1 is correct (this
requests a pipe; later code correctly closes cp.out).

As far as stderr of the child is concerned, if you only want to re-use the
standard error of the parent, then not assigning anything to cp.err is
correct (it was set to 0 in the memset before this hunk). But perhaps you
want to achieve something else?

-- Hannes

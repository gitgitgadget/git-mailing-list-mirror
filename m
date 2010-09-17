From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Fri, 17 Sep 2010 13:31:51 +0200
Message-ID: <4C9351A7.7050609@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Sep 17 13:34:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwZDE-0004WI-Ct
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 13:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab0IQLef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 07:34:35 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54466 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab0IQLee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 07:34:34 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 58B1B16071ED6;
	Fri, 17 Sep 2010 13:31:54 +0200 (CEST)
Received: from [93.240.125.96] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OwZAY-0007cH-00; Fri, 17 Sep 2010 13:31:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX194L/Ll0rzNbVDlgdkyPP+X19DyK7nyyaDBGRQd
	VFZ9aZP/1PzNN/wjsefmSuYVotsAUJRX7SZW52VvfBmwqYt7Yk
	xlg+DqLZQe9CPCiRSiQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156377>

Am 16.09.2010 21:29, schrieb Kevin Ballard:
> Unfortunately, the only effect this had was to change the order of fetches
> (it now appears to be case-sensitive alphabetical).

Yup, this is a side effect of using the index instead of the .gitmodules
file.

But I think I found the real issue, the stdout of the forked "git fetch"
was swallowed due to a copy & paste bug while the actual fetch commands
were executed nonetheless. Please try the following change:


diff --git a/submodule.c b/submodule.c
index e2c3bae..4fb1071 100644
--- a/submodule.c
+++ b/submodule.c
@@ -260,7 +260,8 @@ int fetch_populated_submodules(int forced)
        cp.env = local_repo_env;
        cp.git_cmd = 1;
        cp.no_stdin = 1;
-       cp.out = -1;
+       cp.out = 1;
+       cp.err = 1;

        for (i = 0; i < active_nr; i++) {
                struct strbuf submodule_path = STRBUF_INIT;

From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Fri, 17 Sep 2010 14:22:15 +0200
Message-ID: <4C935D77.3080008@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 17 14:24:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwZzi-0007zO-7l
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 14:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab0IQMYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 08:24:40 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52405 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab0IQMYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 08:24:39 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7298916076808;
	Fri, 17 Sep 2010 14:22:16 +0200 (CEST)
Received: from [93.240.125.96] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OwZxI-00017U-00; Fri, 17 Sep 2010 14:22:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4C9359D4.2030109@viscovery.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+h2/+3bDZHDkJimEnLu2usBqtyK/G/oqUHRT1Z
	KhH8GmNToz09omckJWTu3dIxDzwivuLrmHfKtH/NQ++u7LnhsF
	EMo10XDkSb48GGc/aS4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156381>

Am 17.09.2010 14:06, schrieb Johannes Sixt:
> Am 9/17/2010 13:31, schrieb Jens Lehmann:
>> But I think I found the real issue, the stdout of the forked "git fetch"
>> was swallowed due to a copy & paste bug while the actual fetch commands
>> were executed nonetheless. Please try the following change:
>>
>>
>> diff --git a/submodule.c b/submodule.c
>> index e2c3bae..4fb1071 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -260,7 +260,8 @@ int fetch_populated_submodules(int forced)
>>         cp.env = local_repo_env;
>>         cp.git_cmd = 1;
>>         cp.no_stdin = 1;
>> -       cp.out = -1;
>> +       cp.out = 1;
>> +       cp.err = 1;
> 
> This cannot be correct. Subsequent code reads the stdout of the child
> process, i.e., you want a pipe; hence, cp.out = -1 is correct (this
> requests a pipe; later code correctly closes cp.out).

Thanks for catching this! I copied this code from a spot where stdout
is read via a pipe (and is then closed afterwards), but that isn't the
case here.


> As far as stderr of the child is concerned, if you only want to re-use the
> standard error of the parent, then not assigning anything to cp.err is
> correct (it was set to 0 in the memset before this hunk). But perhaps you
> want to achieve something else?

Nope. You are right, setting both to 0 (via the memset) to inherit the
channel from the parent is just what is needed here.

So the correct fix should look like this:


diff --git a/submodule.c b/submodule.c
index e2c3bae..209efa4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -260,7 +260,6 @@ int fetch_populated_submodules(int forced)
        cp.env = local_repo_env;
        cp.git_cmd = 1;
        cp.no_stdin = 1;
-       cp.out = -1;

        for (i = 0; i < active_nr; i++) {
                struct strbuf submodule_path = STRBUF_INIT;

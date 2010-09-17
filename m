From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Fri, 17 Sep 2010 16:01:25 +0200
Message-ID: <4C9374B5.9020907@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <4C935FF2.7080502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 17 16:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwbXz-0000BY-45
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 16:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab0IQOEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 10:04:08 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57534 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab0IQOEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 10:04:07 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id DAFA717122E7D;
	Fri, 17 Sep 2010 16:01:27 +0200 (CEST)
Received: from [93.240.125.96] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OwbVH-0007WJ-00; Fri, 17 Sep 2010 16:01:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4C935FF2.7080502@viscovery.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/m4olx7OFvqU6pk1+NTggensiE0PR5JZhNo9KB
	37GXFWENkfX7MKMLuNJuZdHz0QsDLyNl+DOxUVQiUMAXRO/3ZP
	s73c81iRoraL20H5j/lw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156383>

Am 17.09.2010 14:32, schrieb Johannes Sixt:
> Am 9/17/2010 14:22, schrieb Jens Lehmann:
>> So the correct fix should look like this:
>>
>>
>> diff --git a/submodule.c b/submodule.c
>> index e2c3bae..209efa4 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -260,7 +260,6 @@ int fetch_populated_submodules(int forced)
>>         cp.env = local_repo_env;
>>         cp.git_cmd = 1;
>>         cp.no_stdin = 1;
>> -       cp.out = -1;
>>
>>         for (i = 0; i < active_nr; i++) {
>>                 struct strbuf submodule_path = STRBUF_INIT;
> 
> That cannot be correct, either. Look further down. There you have:
> 
> 	len = strbuf_read(&buf, cp.out, 1024);
> 
> and later
> 
> 	close(cp.out);
> 
> You can do neither when you do not request a pipe for the child's stdout.
> You must set cp.out = -1 if you want to keep these two lines.

Aah, you must be looking at submodule.c from current master. Then you'll
find is_submodule_modified() at that location, where of course the -1 is
needed for cp.out because later read() and close() are used on it.

But I was trying to fix a problem introduced by 496b35e7 in current next,
where the new function fetch_populated_submodules() is located there. And
in that function the output is not read and so cp.out = 0 is the right
thing to do here.

But thanks for double checking!

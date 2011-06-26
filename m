From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Use correct value when hinting strbuf_read()
Date: Sun, 26 Jun 2011 22:32:30 +0200
Message-ID: <4E07975E.5010900@web.de>
References: <1308161318-25637-1-git-send-email-iveqy@iveqy.com> <7vzkl4z8nl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 22:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qaw1O-0003HI-V5
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 22:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118Ab1FZUcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 16:32:55 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:57485 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab1FZUcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 16:32:35 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8EEB8192DAA12;
	Sun, 26 Jun 2011 22:32:33 +0200 (CEST)
Received: from [93.240.117.172] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qaw0P-0004Wz-00; Sun, 26 Jun 2011 22:32:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vzkl4z8nl.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/ViHhvDHEHuzAb6uXVusl8X5Qjo/ppkkHkl7o1
	ecyzYR/pCxW5BjonVNuoB9l4lH4sibE/WsFsw6l2RDC7RjLTsM
	M0vZc8B+TLM+M+eNelTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176332>

Am 26.06.2011 21:37, schrieb Junio C Hamano:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
> 
>> diff --git a/submodule.c b/submodule.c
>> index b6dec70..86baf42 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -326,7 +326,7 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
>>  		cp.no_stdin = 1;
>>  		cp.out = -1;
>>  		cp.dir = path;
>> -		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 1024))
>> +		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
>>  			is_present = 1;
> 
> The change is not incorrect per-se. If the original used 41 and a patch
> tried to update it to 1024, we wouldn't accept such a patch, but on the
> other hand, I do not think this patch would make much difference (any
> value would do here as it is merely a hint, and if the patch does make a
> difference, we would have a bigger problem, either by forking too often
> with run_command(), or by leaking buf.buf every time we do so).

Makes sense.

> It however raises a more interesting question.
> 
> This function tries to see, even a commit object name, if it is fully
> connected to any ref (IOW the tip of a branch or a tag). There are three
> outcomes:
> 
>  - It is reachable from a ref, and we get nothing from the command;
> 
>  - It is not, and we get the commit object name back (and nothing else);
> 
>  - We get something unexpected. Perhaps an error found in the repository
>    (strictly speaking I do not think we would catch this as we are not
>    capturing stderr at all).
> 
> The first one is what this if() condition catches, but we do not tell the
> second and the third apart. I wonder if we should.

Hmm, maybe we should die() if run_command() doesn't return 0? (The intention
behind not catching stderr was that the reason for the failure of rev-list
should visible to the user)

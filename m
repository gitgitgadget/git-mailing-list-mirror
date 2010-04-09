From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 1/4] Prepare checkout_entry() for recursive checkout
 of submodules
Date: Sat, 10 Apr 2010 01:11:08 +0200
Message-ID: <4BBFB40C.1060905@web.de>
References: <4BBF9D6F.2000006@web.de> <4BBF9DC9.8030905@web.de> <7vd3y81e3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 01:11:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NM8-000089-DM
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab0DIXLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 19:11:11 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35756 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab0DIXLK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 19:11:10 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 65C881564BB50;
	Sat, 10 Apr 2010 01:11:09 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0NLx-00030c-00; Sat, 10 Apr 2010 01:11:09 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vd3y81e3s.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+5vd2Y+EL9lBV7swGC3Z6EZMnvrVVeinIumUEm
	VIdRSm0aZ4LXZqm9uv6sqvPw1wSQ9bauZmZDxxnx9Pz26QeUu5
	C3U6PluNCU7PQtzwyoEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144482>

Am 09.04.2010 23:59, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> +int checkout_submodule(const char *path, const unsigned char sha1[20], int force)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	struct child_process cp;
>> +	const char *hex_sha1 = sha1_to_hex(sha1);
>> +	const char *argv[] = {
>> +		"checkout",
>> +                force ? "-qf" : "-q",
>> +		hex_sha1,
>> +		NULL,
>> +	};
> 
> Why force -q?

Good question. I seem to have tried to silence the output of checkout
from run_command(), which AFIACS doesn't reach the console anyway
unless i want it to ... (while at the same time managing to mess up
the tabs in that line ... :-/ )


>> +	strbuf_addf(&buf, "%s/.git/", path);
>> +	if (!is_directory(buf.buf)) {
>> +		strbuf_release(&buf);
>> +		/* The submodule is not populated, so we can't check it out */
>> +		return 0;
>> +	}
> 
> This would give you an incorrect result if .git is a file that records
> "gitdir: overthere" (see read_gitfile_gently() in setup.c); I would expect
> it would become a fairly important ingredient if we ever enhance the
> submodule support to add submodule that disappears/reappears in the
> history.

Right. This assumption is also present in add_submodule_odb() (used by
show_submodule_summary()) and is_submodule_modified(), so i just reused
it. This should be addressed in another patch.

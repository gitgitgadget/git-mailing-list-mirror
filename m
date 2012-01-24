From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] Fail to add a module in a subdirectory if module is already
 cloned
Date: Tue, 24 Jan 2012 22:44:34 +0100
Message-ID: <4F1F2642.1070707@web.de>
References: <jfmvpp$4v7$1@dough.gmane.org> <4F1F1E5F.2030509@web.de> <7vhazk3ibk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jehan Bing <jehan@orb.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 22:44:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpoAU-0003PE-VI
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 22:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158Ab2AXVoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 16:44:38 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:40704 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2AXVoh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 16:44:37 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5F9D71A996CC5
	for <git@vger.kernel.org>; Tue, 24 Jan 2012 22:44:36 +0100 (CET)
Received: from [192.168.178.43] ([91.3.157.14]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0M2dxF-1SfQut2ko1-00sleV; Tue, 24 Jan 2012 22:44:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vhazk3ibk.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:7Kpamz3b22oYjJj0pyJ1L1sPG/QF4l2tHbr824HlulX
 UXJFdghLQNWGsrxIbVYiW8y7xSOM2pNdJOnBIdb3f6MBcbeky3
 AiPf90oWbCWLGS6IdL7+ZQF+U4FuJowLKCWsxK29Mv69wcB3yc
 cPa+BdsIFHctuaac2AuvfqQJzpC62f/EI1zr1VhKbtFfVV6b52
 DMijSQ3om186dv7FI6VAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189072>

Am 24.01.2012 22:24, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> The reason for this bug seems to be that in module_clonse() the name is
>> not properly initialized for added submodules (it gets set to the path
>> later), so the correct amount of leading "../"s for the git directory
>> is not computed properly. The attached diff fixes that for me, I will
>> send a patch as soon as I have extended a test case for this breakage.
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 3adab93..9bb2e13 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -131,6 +131,7 @@ module_clone()
>>         gitdir=
>>         gitdir_base=
>>         name=$(module_name "$path" 2>/dev/null)
>> +       test -n "$name" || name="$path"
> 
> This somehow smells like sweeping a problem under the rug. Why doesn't
> module_name find the already registered path in the first place?
> 
> I see "module_name" calls "git config -f .gitmodules" and I do not see any
> cd_to_toplevel in git-submodule.sh that would ensure this call to access
> the gitmodules file at the top-level of the superproject. Is that the real
> reason why it is not finding what it should be finding?

Nope, it's the fact that the .gitmodules file doesn't contain this name
because the branch was rewound. Please see my post where I proposed the
same change for a slightly different problem:
  http://permalink.gmane.org/gmane.comp.version-control.git/187823
(just fast forward to the first hunk of my diff at the end)

I just didn't realize back then that this is needed even without the
other changes to work properly. The possibly missing cd_to_toplevel is
another problem, the OP started the submodule add in the top level
directory anyways.

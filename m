From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Tue, 03 Jan 2012 23:10:07 +0100
Message-ID: <4F037CBF.9010005@web.de>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com> <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de> <7vsjjwvdyl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 23:10:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiCYh-0003Yv-Ic
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 23:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975Ab2ACWKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 17:10:11 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:42548 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab2ACWKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 17:10:09 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3E9351AF36A53
	for <git@vger.kernel.org>; Tue,  3 Jan 2012 23:10:08 +0100 (CET)
Received: from [192.168.178.43] ([91.3.213.33]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M6Df8-1Sf5nR1qbS-00yBVJ; Tue, 03 Jan 2012 23:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vsjjwvdyl.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:mLwlesbi2aLmsWbN1wgXFEI7c5iDX/SoZ2Xs8ngjAz3
 ayzh1AgCKSLMPM0Gq1904lqfgZKHmuWSLHzJmT0YeyVaDsJWcO
 uA0AFdJhIRpSmzYH50yNs7Vwirpd4wIvwjgPmfwEMlnrr3wLQ7
 /+cer6rkyvUezgD5vGb1/HrXTa7eH4t6+b5QRDD6Ewe5MvOxgd
 w7y1fveSUa2+4o8BpOA3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187900>

Am 03.01.2012 19:27, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> Am 29.12.2011 23:40, schrieb Junio C Hamano:
>>> I further wonder if we can get away without using separate-git-dir option
>>> in this codepath, though. IOW using
>>>
>>>         git clone $quiet -bare ${reference:+"$reference"} "$url" "$gitdir"
>>>
>>> might be a better solution.
>>
>> A quick test shows that using a bare repo won't fly because without the
>> core.worktree setting commands that operate on the work tree can't be
>> run anymore inside submodules (starting with the initial checkout). 
> 
> Probably the right thing to do would be to restructure the flow as I
> suggested, i.e.
> 
> 	if we do not have it yet
>         then
>         	git clone --bare ...
> 	fi
> 	# now we have it, make sure they are correct
> 	git config core.bare false

Ah, I forgot to set core.bare to false when trying this. But even then
a dozen tests fail, no matter if I set core.worktree or not. A cursory
glance indicates problems with branches ... I'll have to dig deeper
here.

> 	git config core.worktree $there

Please see below.

>         echo "gitdir: $here" >$there/.git
> 
>> Yes, and the core.worktree setting also contains an absolute path. So
>> we must either make that relative too and rewrite it on every "git
>> submodule add" to record the possibly changed path there or make the
>> bare clone work with a work tree (which sounds a bit strange ;-).
> 
> Update of core.worktree has to be done regardless of the absolute/relative
> differences anyway, no?

Not if we would implement a "if no worktree is set but we came here via
a gitfile, then take the directory the gitfile was found in as worktree"
heuristic. And that heuristic looks quite sane to me, as a gitfile can
only be found in a work tree, or am I missing something obvious here?

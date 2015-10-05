From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] clone --dissociate: avoid locking pack files
Date: Mon, 05 Oct 2015 20:32:35 +0200
Organization: gmx
Message-ID: <4033cd50d604c7088633e6b99f0f9b6a@dscho.org>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <20150930192814.GA26154@wheezy.local> <20151001043936.GB26154@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 20:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjAZ5-0001GB-2Z
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 20:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbbJEScm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 14:32:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:49916 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbbJEScl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 14:32:41 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MK0bZ-1ZkY8f3ftd-001RzF; Mon, 05 Oct 2015 20:32:36
 +0200
In-Reply-To: <20151001043936.GB26154@wheezy.local>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:ZglXxR8uqmimQw2uEexnN429pyfmhYg2sqi77/9E23hbmhck0RL
 waJDLPSS/VaY3OkAC2dyGldL1Ja7f+T2TiQOdzikHXzypjP6RsE+iGLaqFYMDfb7PgMEUR/
 u7gPE7Ti4iW9aGuTcSlZxe6HrWiGHQFJA/gk/MHbHeTx+vXUnp7aE+DKEpWhE/MBWOxKlnr
 JSyw6YzzxPyd22/p0d7NQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SrTMwvWuK/Q=:AEYn2dOTaKy2UKCwM7MxhQ
 wQIUH3uYWhllTANryPwJIbRoPXKhdpFIcbWPb7Ho4m7YWFQ/0ymecNq9P8FhvOkeuK4Mi0ML3
 nFBQ2cYnBYne8JCtKwUttF8lL56f5FiO/S0vSIMmCI+8mjFTkUe9XCq50oh+aI1fWHw3O7C9n
 4vgriix3GXbe2b8twAO0fPkbPfTYarvJcJCSHNW053vlLiIzIcSqZ1/4RI6BPTX7WUQRfZmOu
 K+UcwjDZ1GqnF9fUAHQSupSznsxaoqwU4j2kT7MHnpQe0GIsgehFQljqTHZ/aYgBuQbW+9YbK
 z6ODwR7FXSAQ42vDIyFwoUnRWxuJ3mSuW6KsxDYL9BUS9XXNobUWbrrBz7Nk4jQ41g9ZoZGq4
 PUmJkPdUfCxKSCx7WCKpB6JSVXUacdOl4tAiVVC0OW1kU9M9nqSuBS5iZQIFlwdLgch2YPKMq
 h4pz44KVg8yrdMDMaQBv2zlDL7r8BKJ4QN1NUczH2L0lz/43DrCkyMlLS99riql1q5EWVJTdN
 qet/TdV8FpiKJ2iyA9KOvZ/KSdRIkyuTcyLbQztcF1yhensigjZlax2yS/lr4108jldL0pTI4
 92OHV1Knc74fRHXgRdnkr+ksHyMBczkwGz9zWFAC6DntmA3LRWOcKBowOl7E4IwtTYmb2nDTD
 KPoeQf7JPx1qO6beJJlJ+zzf8g/tm2Atoptso3Yjqer7slEoHGZ8zrwXzJxFg8IHZe3pR6eRt
 U1QVQ7NSaYp0EiKmvd2uNEw/AIVna6zMHMzIYacixRoshRVqOF1YNdjrg+7pN4IwTKYhHXYw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279065>

Hi Max,

On 2015-10-01 06:39, Max Kirillov wrote:
> On Wed, Sep 30, 2015 at 10:28:14PM +0300, Max Kirillov wrote:
>> On Mon, Sep 28, 2015 at 09:44:57PM +0200, Johannes Schindelin wrote:
>>> -	if (option_dissociate)
>>> +	if (option_dissociate) {
>>> +		struct packed_git *p;
>>> +
>>> +		for (p = packed_git; p; p = p->next) {
>>> +			close_pack_windows(p);
>>> +			close_pack_index(p);
>>> +		}
>>>  		dissociate_from_references();
>>> +	}
> 
>> This does not seem to close handles to the pack files
>> themseves, does Windows still allow removing the files? I
>> probably did not tried that, because I started from handles,
>> and discovered mapped files only later.
> 
> Apparently, pack file is closed just after mapping if it's
> smaller than core.packedGitWindowSize. Could it be the
> reason that this patch worked in you test case?

That must be the reason, thanks!

Ciao,
Dscho

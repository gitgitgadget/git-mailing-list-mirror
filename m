From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] mergetool--lib: Simplify command expressions
Date: Tue, 29 Jan 2013 14:27:49 -0800
Message-ID: <7vip6foc9m.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <20130129192204.GC1342@serenity.lan>
 <CAJDDKr4CFyQrAec3jCxyDCx0+4BMXmQAciG1YcnMYS=PAeW-Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Jf4-0007lW-6A
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 23:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab3A2W1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 17:27:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452Ab3A2W1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 17:27:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A038DBBAB;
	Tue, 29 Jan 2013 17:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9/MA2yhg+hItzb2D3OSObT+LKtQ=; b=xF/ZWm
	rd2oLxxbHs7+d3Rt+yRil7/+5ByT/FpRobvI8Gl3vhBPrcsxhogKzgeK4CuBXalu
	hGuc2KuC12R9NTGIMo02Ccnl50vX8R1QVMmjEffcXSMCaRkySq+b7IfZOZy0CVB1
	pBzPXFscDTfddzK7jOz061huoQIywsALzBOFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V+3WDpEyCzkZndDRnIR882M8hsYMYRN1
	fDflWVuKBpwtS1ymfGzbnQuJpyMgV9gXjR1JQFM4jxLCXYpnNqPb8o9U20flXiu9
	DjxIBrogZsXg6+s5VKMD59wRLwrGSYqRWZ7i0vJhS9RkEuAMHBVz9NoG9vLb/mVK
	ADEPq2Tf7Ms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94491BBA9;
	Tue, 29 Jan 2013 17:27:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 236B5BBA8; Tue, 29 Jan 2013
 17:27:51 -0500 (EST)
In-Reply-To: <CAJDDKr4CFyQrAec3jCxyDCx0+4BMXmQAciG1YcnMYS=PAeW-Mw@mail.gmail.com> (David
 Aguilar's message of "Tue, 29 Jan 2013 14:09:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DF65B70-6A63-11E2-A38E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214977>

David Aguilar <davvid@gmail.com> writes:

> On Tue, Jan 29, 2013 at 11:22 AM, John Keeping <john@keeping.me.uk> wrote:
>> On Sun, Jan 27, 2013 at 04:52:23PM -0800, David Aguilar wrote:
>>> Update variable assignments to always use $(command "$arg")
>>> in their RHS instead of "$(command "$arg")" as the latter
>>> is harder to read.  Make get_merge_tool_cmd() simpler by
>>> avoiding "echo" and $(command) substitutions completely.
>>>
>>> Signed-off-by: David Aguilar <davvid@gmail.com>
>>> ---
>>> @@ -300,9 +292,9 @@ get_merge_tool_path () {
>>>       fi
>>>       if test -z "$merge_tool_path"
>>>       then
>>> -             merge_tool_path="$(translate_merge_tool_path "$merge_tool")"
>>> +             merge_tool_path=$(translate_merge_tool_path "$merge_tool")
>>>       fi
>>> -     if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
>>> +     if test -z $(get_merge_tool_cmd "$merge_tool") &&
>>
>> This change should be reverted to avoid calling "test -z" without any
>> other arguments, as Johannes pointed out in v1.
>>
>> The rest of this patch looks good to me.
>
> You're right.  My eyes have probably been staring at it too long and I
> missed this (even though I thought I had checked).

By now you (and people who were following this thread) are beginning
to see why I said "I'd feel safer with extra dq" ;-)

I'll amend locally and push the result out.

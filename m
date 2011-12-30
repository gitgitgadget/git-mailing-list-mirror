From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] expanded hook api with stdio support
Date: Fri, 30 Dec 2011 19:04:55 +0100
Message-ID: <4EFDFD47.2060700@kdbg.org>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net> <1325207240-22622-2-git-send-email-joey@kitenet.net> <4EFD88CB.3050403@kdbg.org> <20111230171344.GA9667@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Dec 30 19:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RggpE-0001v3-AZ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 19:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab1L3SFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 13:05:00 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:52845 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751019Ab1L3SE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 13:04:58 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4B0C3130052;
	Fri, 30 Dec 2011 19:04:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 81E0019F5D2;
	Fri, 30 Dec 2011 19:04:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20111230171344.GA9667@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187807>

Am 30.12.2011 18:13, schrieb Joey Hess:
> Johannes Sixt wrote:
>> IMHO, this is overengineered. I don't think that we need something like
>> this in the foreseeable future, particularly because such a pipeline or
>> multi-hook infrastructure can easily be constructed by the (single) hook
>> script itself.
> 
> Junio seemed to think this was a good direction to move in and gave some
> examples in <7vlipz930t.fsf@alter.siamese.dyndns.org>
> 
> Anyway, the minimum cases for run_hook_complex() to support are:
> 
> * no stdin, no stdout
> * only stdin
> * stdin and stdout (needed for tweak-fetch)
> * only stdout (perhaps)
> 
> The generator and reader members of struct hook allow the caller to
> easily specify which of these cases applies to a hook, and also provides
> a natural separation of the caller's stdin generation and stdout parsing
> code.

But as long as the generator only needs to generate a strbuf *and* only
one hook is run, there is no value to have it as a callback; the caller
can just specify the strbuf itself, run_hook_* does not need to care how
it was generated.

I can see some value in a reader callback to avoid allocating yet
another strbuf.

> ... The data member could
> be eliminated and global variables used by callers that need that,
> but I prefer designs that don't require global variables.

Absolutely.

>>> +	If the hook does not exist or is not executable, the return value
>>> +	will be zero.
>>> +	If it is executable, the hook will be executed and the exit
>>> +	status of the hook is returned.
>>
>> What is the rationale for these error modes? It is as if a non-existent
>> or non-executable hook counts as 'success'. (I'm not saying that this
>> would be wrong, I'm just asking.)
> 
> They are identical to how run_hook already works.
> A non-existant/non-executable hook *is* a valid configuration,
> indeed it's the most likely configuration.

So, it is so that the caller does not itself have to check whether a
hook exists. That may be worth a word in the API documentation.

-- Hannes

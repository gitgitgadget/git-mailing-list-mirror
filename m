From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] userdiff: allow * between cpp funcname words
Date: Wed, 07 Dec 2011 22:13:10 +0100
Message-ID: <4EDFD6E6.5050301@kdbg.org>
References: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch> <201112062117.57690.trast@student.ethz.ch> <7vfwgxflkv.fsf@alter.siamese.dyndns.org> <201112070904.28212.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 07 22:13:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYOo2-0004ut-TH
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 22:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758078Ab1LGVNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 16:13:16 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:40288 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757046Ab1LGVNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 16:13:15 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 41D1C130059;
	Wed,  7 Dec 2011 22:13:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CDB9D19F49D;
	Wed,  7 Dec 2011 22:13:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <201112070904.28212.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186500>

Am 07.12.2011 09:04, schrieb Thomas Rast:
> Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> Actually (sadly) I'll have to revise it.  It doesn't match much of C++
>>> either, and I haven't yet come up with a reasonable regex that
>>> matches, say,
>>>
>>>   foo::Bar<int>::t& Baz::operator<<(
>>>
>>> which I would call ludicrous, but it's valid C++.
>>
>> Heh, I'd rather not see us go that route, which would either end up
>> implementing a C++ parser or reverting the heuristics back to "non-blank
>> at the beginning of the line" that was already reasonably useful.
> 
> Well, there are many things that we deliberately do not match right
> now and for which that's a good thing:
> 
>   label:
>   public:
>   void declaration_only(...);
>   int global_variable;
> 
> At some point I was wondering whether it would be better to just
> declare a non-match for '.*;' and '^[A-Za-z_][A-Za-z_0-9]+:', and
> otherwise match all '^[A-Za-z].*\(' but I may be missing something.

The current cpp pattern doesn't work that well with C++. Since it
requires a blank before a name before the opening parentheses, it
doesn't catch constructors:

Foo::Foo()

and it should fail for GNU style C function definitions as well (I
didn't test):

void
do_the_foo()

I'll run this pattern for a while:

diff.cpp.xfuncname=!^[a-zA-Z_][a-zA-Z_0-9]*[[:space:]]*:[[:space:]]*$
^[a-zA-Z_].*

BTW, your match pattern requires an opening parenthesis; it would not
catch class definitions.

-- Hannes

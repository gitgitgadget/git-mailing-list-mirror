From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Tue, 16 Apr 2013 09:18:46 +0200
Message-ID: <516CFB56.1090805@viscovery.net>
References: <20130415230651.GA16670@sigill.intra.peff.net> <20130415230802.GA11267@sigill.intra.peff.net> <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com> <20130416004228.GA14995@sigill.intra.peff.net> <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com> <20130416025024.GA20932@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 09:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US0AK-0006C8-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 09:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab3DPHSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 03:18:52 -0400
Received: from so.liwest.at ([212.33.55.14]:44958 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754025Ab3DPHSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 03:18:51 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1US0AB-0007d6-IM; Tue, 16 Apr 2013 09:18:47 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1D3531660F;
	Tue, 16 Apr 2013 09:18:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130416025024.GA20932@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221372>

Am 4/16/2013 4:50, schrieb Jeff King:
> On Mon, Apr 15, 2013 at 07:34:07PM -0700, Brandon Casey wrote:
> 
>>> Right. My assumption was that we are primarily interested in protecting
>>> against the die_routine. Compat functions should never be calling die.
>>
>> I think the rule we have been enforcing is less strict than that.  We
>> have only said that any compat function in a die handler path should
>> never call die.  But maybe that's what you meant.
> 
> No, I assumed we were following the stronger rule. If you are a compat
> function for a C library function, then you should never need to die.
> You should be conforming to the existing interface, which will have some
> mechanism for passing back an error.

This rule has been violated LOOOONG ago, and not only in compat/mingw.c
(see xmalloc in compat/qsort.c, for example).

>> The primary motivation was that Hannes Sixt had to step in and point
>> out yet again that the high-level memory allocators should not be
>> called in anything that could be in a die handler code path.  I was on
>> the thread, but I don't remember the topic (ah, Jonathan has stepped
>> in with the answer).  I do remember that I was not the only one who
>> had forgotten about that rule though.
> 
> Yeah, it is subtle enough that it may be worth protecting against.

Too late.

>> To implement this check correctly/completely (i.e. detect recursion in
>> the main thread as well as in any child threads), I think you really
>> do need to use thread-local storage as you mentioned in 3/3 which
>> could look something like:
>>
>>    static pthread_key_t dying;
>>    static pthread_once_t dying_once = PTHREAD_ONCE_INIT;
>>
>>    void setup_die_counter(void)
>>    {
>>            pthread_key_create(&dying, NULL);
>>    }
>>
>>    check_die_recursion(void)
>>    {
>>            pthread_once(&dying_once, setup_die_counter);
>>            if (pthread(getspecific(dying)) {
>>                    puts("BUG: recursion...");
>>                    exit(128);
>>            }
>>
>>            pthread_setspecific(dying, &dying);
>>    }
> 
> Yeah, that seems sane; my biggest worry was that it would create
> headaches for Windows folks, who would have to emulate pthread_key. But
> it seems like we already added support in 9ba604a.

pthread_key is not a problem, but pthread_once is. It's certainly
solvable, but do we really have to?

-- Hannes

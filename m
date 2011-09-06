From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: abort on shells that do not support ${parameter%word}
 expansion
Date: Tue, 06 Sep 2011 14:32:45 -0500
Message-ID: <2i2CfjMHrXZ7dV7ciebqx3PjO-cpw8QIplKjdcx_bGmGt8jgFr3efDXeMJMcn_I9ZH6X71aBdaO7vGiRBQuhbukGEWFJZQuvWtq079u0KYQ@cipher.nrlssc.navy.mil>
References: <7vbouzxy7g.fsf@alter.siamese.dyndns.org> <rPnr5AVZRRnklxb_Yaj0gopXRTVCT-tq7iVG-1NoXjOrHWsyuLop-co4qtQjezJ98BaKc0R71r8fMcBOijq9oCOgfBF6ticVk17DwDQzV91bcC719fGSUPDsf40AuoRfgjURcxREkMk@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com, David Barr <davidbarr@google.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 21:33:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R11OO-00024u-I5
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 21:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab1IFTdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 15:33:04 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:42665 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab1IFTdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 15:33:01 -0400
Received: by mail3.nrlssc.navy.mil id p86JWkiQ023312; Tue, 6 Sep 2011 14:32:46 -0500
In-Reply-To: <rPnr5AVZRRnklxb_Yaj0gopXRTVCT-tq7iVG-1NoXjOrHWsyuLop-co4qtQjezJ98BaKc0R71r8fMcBOijq9oCOgfBF6ticVk17DwDQzV91bcC719fGSUPDsf40AuoRfgjURcxREkMk@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Sep 2011 19:32:45.0693 (UTC) FILETIME=[C0DF6AD0:01CC6CCB]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180824>


FYI:
It should be possible to test this patch on a modern system by doing
something like:

   make SHELL_PATH=/bin/false

and you should see something like this:

   make: *** [please_set_SHELL_PATH_to_a_more_modern_shell] Error 1

But beware, GNU make 3.81 seems to have a bug which sends it into an
infinite loop.

make 3.80 produces the desired results, as does 3.77 which I have
installed on an old machine.  GNU make 3.82 seems to be the latest but
I don't have access to it.  If anyone does, I'd appreciate if you
could test.

-Brandon


On 09/06/2011 02:09 PM, Brandon Casey wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> Add an entry to the please_set_SHELL_PATH_to_a_more_modern_shell target
> which tests whether the shell supports ${parameter%word} expansion.  I
> assume this one test is enough to indicate whether the shell supports the
> entire family of prefix and suffix removal syntax:
> 
>    ${parameter%word}
>    ${parameter%%word}
>    ${parameter#word}
>    ${parameter##word}
> 
> FreeBSD, for one, has a /bin/sh that, apparently, supports $() notation but
> not the above prefix/suffix removal notation.
> ---
> 
> On 09/05/2011 02:09 AM, Junio C Hamano wrote:
>> Naohiro Aota <naota@elisp.net> writes:
>>
>>> Variable expansions like "${foo#bar}" or "${foo%bar}" doesn't work on
>>> shells like FreeBSD sh and they made the test to fail.
>>
>> Sorry, I do appreciate the effort, but a patch like this takes us in the
>> wrong direction.
>>
>> While we do not allow blatant bashisms like ${parameter:offset:length}
>> (substring expansion), ${parameter/pattern/string} (pattern substitution),
>> "local" variables, "function" noiseword, and shell arrays in our shell
>> scripts, the two kinds of substitution you quoted above are purely POSIX,
>> and our coding guideline does allow them to be used in the scripts.
> 
> Perhaps we should add a test for this shell feature.
> 
> -Brandon
> 
>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 8d6d451..46d9c5d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1738,6 +1738,7 @@ endif
>  
>  please_set_SHELL_PATH_to_a_more_modern_shell:
>  	@$$(:)
> +	@foo=bar_suffix && test bar = "$${foo%_*}"
>  
>  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>  

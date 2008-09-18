From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] diff.c: associate a flag with each pattern and use
 it for compiling regex
Date: Thu, 18 Sep 2008 00:12:47 -0700
Message-ID: <7vod2myljk.fsf@gitster.siamese.dyndns.org>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
 <GZAEBf1BcP9-dznrIesxaE4Rb8bim6DpwDWCb9yWl99UVoQC9Dog0A@cipher.nrlssc.navy.mil> <7vod2m1464.fsf@gitster.siamese.dyndns.org> <48D1F80C.5030502@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDil-0001T7-4v
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 09:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbYIRHNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 03:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbYIRHNA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 03:13:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbYIRHM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 03:12:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52D8862192;
	Thu, 18 Sep 2008 03:12:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6871A6218F; Thu, 18 Sep 2008 03:12:49 -0400 (EDT)
In-Reply-To: <48D1F80C.5030502@op5.se> (Andreas Ericsson's message of "Thu,
 18 Sep 2008 08:41:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38D44124-8551-11DD-8AF3-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96175>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
> ...
>>>  static struct funcname_pattern {
>>>  	char *name;
>>>  	char *pattern;
>>> +	int cflags;
>>
>> What does "C" stand for?
>
> "compile". It's the same name as regcomp(3) uses for the flags being
> used to compile the regular expression. The full mnemonic name would
> be regex_compile_flag, which is a bit unwieldy. Perhaps regcomp_flags
> would be a good compromise?

Ah, I see.

When I saw that new field for the first time, I didn't think it will be
used to store the bare flag values regcomp/regexec library would accept
directly (I expected we would see #define or enum to tweak our own set of
features, not limiting ourselves EXTENDED/ICASE etc. that regcomp/regexec
library supports)

IOW, it just did not click for me to look at "man 3 regcomp" which says:

    int regcomp(regex_t *preg, const char *regex, int cflags);

So unless others feel that we might get a better layering separation by
not storing REG_EXTENDED and stuff directly in that field (which was my
initial reaction without looking at 4/4 which does store REG_EXTENDED
there without our own enums), cflag is perfectly a good name here.

Thanks --- I am bit under the weather and not thinking quite straight.

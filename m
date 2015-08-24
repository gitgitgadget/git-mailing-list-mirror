From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] describe --contains: default to HEAD when no commit-ish
 is given
Date: Mon, 24 Aug 2015 18:14:17 +0200
Message-ID: <20150824181417.Horde.2DAlveA2ZaXbdApUl8wLOQ8@webmail.informatik.kit.edu>
References: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
 <1440168632-15412-1-git-send-email-szeder@ira.uka.de>
 <xmqqoai07gen.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 18:14:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTuOK-0005rr-9i
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 18:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbbHXQOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 12:14:32 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51996 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbbHXQOb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 12:14:31 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZTuOD-0000AN-0n; Mon, 24 Aug 2015 18:14:29 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZTuO1-0001S0-Ou; Mon, 24 Aug 2015 18:14:17 +0200
Received: from x4db0f032.dyn.telefonica.de (x4db0f032.dyn.telefonica.de
 [77.176.240.50]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 24 Aug 2015 18:14:17 +0200
In-Reply-To: <xmqqoai07gen.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1440432869.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276457>


Quoting Junio C Hamano <gitster@pobox.com>:

>> @@ -443,10 +443,13 @@ int cmd_describe(int argc, const char **argv, =
=20
>> const char *prefix)
>>  			if (pattern)
>>  				argv_array_pushf(&args, "--refs=3Drefs/tags/%s", pattern);
>>  		}
>> -		while (*argv) {
>> -			argv_array_push(&args, *argv);
>> -			argv++;
>> -		}
>> +		if (argc)
>
> "What would this code do to 'describe --all --contains'?" was my
> knee-jerk reaction, but the options are all parsed by this code and
> nothing is delegated to name-rev, so 'if (!argc)' here is truly the
> lack of any revisions to be described, which is good.

Exactly.  parse-opts removes all --options from argv as it processes
them, barfs at --unknown-options, so all what remains must be treated
as a commit-ish.  And if nothing is left, well, then there was none
given.

>> +			while (*argv) {
>> +				argv_array_push(&args, *argv);
>> +				argv++;
>> +			}
>> +		else
>> +			argv_array_push(&args, "HEAD");
>
> By the way, I usually prefer a fatter 'else' clause when everything
> else is equal, i.e.
>
> 	if (!argc)
>         	argv_array_push(&args, "HEAD"); /* default to HEAD */
> 	else {
> 		while (*argv) {
>                 	...
> 		}
> 	}
>
> because it is easy to miss tiny else-clause while reading code, but
> it is harder to miss tiny then-clause.  In this case, however, the
> while loop can be replaced with argv_array_pushv() these days, so
> perhaps
>
> 	if (!argc)
>         	argv_array_push(&args, "HEAD"); /* default to HEAD ... */
> 	else
> 		argv_array_pushv(&args, argv); /* or relay what we got */
>
> or something?

Indeed, I didn't notice argv_array_pushv() being added, log tells me
it happened quite recently.  I suppose with both branches becoming a
one-liner the order of them can remain what it was in the patch,
this sparing the negation from 'if (!argc)'.

v2 comes in a minute.


G=C3=A1bor

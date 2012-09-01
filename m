From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Test failures in t4034
Date: Sat, 01 Sep 2012 18:43:41 +0100
Message-ID: <5042494D.9040401@ramsay1.demon.co.uk>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com> <5030FD49.6060704@ramsay1.demon.co.uk> <7vboi6nzym.fsf@alter.siamese.dyndns.org> <5033D573.9030103@ramsay1.demon.co.uk> <7v1uizdhi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQP-00041g-QE
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab2IAS1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:27:50 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44472 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751854Ab2IAS1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:27:50 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 0B60D128076;
	Sat,  1 Sep 2012 19:27:48 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id F41E6128075;	Sat,  1 Sep 2012 19:27:46 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:27:45 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v1uizdhi7.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204639>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 

[snip]

>> diff --git a/test-regex.c b/test-regex.c
>> new file mode 100644
>> index 0000000..9259985
>> --- /dev/null
>> +++ b/test-regex.c
>> @@ -0,0 +1,35 @@
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <stdarg.h>
>> +#include <sys/types.h>
>> +#include <regex.h>
>> +
>> +static void die(const char *fmt, ...)
>> +{
>> +	va_list p;
>> +
>> +	va_start(p, fmt);
>> +	vfprintf(stderr, fmt, p);
>> +	va_end(p);
>> +	fputc('\n', stderr);
>> +	exit(128);
>> +}
> 
> Looks like a bit of overkill for only two call sites, whose output
> we would never see because it is behind the test, but OK.

Yes, there was a net increase in the line count when I introduced
die(), but the main program flow was less cluttered by error handling.
The net result looked much better, so I thought it was worth it.

What may not be too obvious, however, is that test-regex.c was written
to be independent of git. You should be able to compile the (single) file
on any POSIX system to determine if the system regex routines suffer this
problem. (It was also supposed to be quiet, unless it die()-ed, and
provide the result via the exit code).

Given that I'm now building it as part of git, I should have simply
#included <git-compat-util.h> and used the die() routine from libgit.a
(since I'm now *relying* on test-regex being linked with libgit.a).

>> +int main(int argc, char **argv)
>> +{
>> +	char *pat = "[^={} \t]+";
>> +	char *str = "={}\nfred";
>> +	regex_t r;
>> +	regmatch_t m[1];
>> +
>> +	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
>> +		die("failed regcomp() for pattern '%s'", pat);
>> +	if (regexec(&r, str, 1, m, 0))
>> +		die("no match of pattern '%s' to string '%s'", pat, str);
>> +
>> +	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
>> +	if (m[0].rm_so == 3) /* matches '\n' when it should not */
>> +		exit(1);
> 
> This could be the third call site of die() that tells the user to
> build with NO_REGEX=1.  Then "cd t && sh t0070-fundamental.sh -i -v" would
> give that message directly to the user.

Hmm, even without "-i -v", it's *very* clear what is going on, but sure
it wouldn't hurt either. (Also, I wanted to be able to distinguish an exit
via die() from a "test failed" error return).

So, new (tested) version of the patch comming.

ATB,
Ramsay Jones

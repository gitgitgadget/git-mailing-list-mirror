From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 21:52:52 +0100
Organization: Organization?!?
Message-ID: <87ha8ewqfv.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 21:53:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmzb-00019j-5E
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbaBDUxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:53:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:38250 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109AbaBDUxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:53:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAmzT-00015L-76
	for git@vger.kernel.org; Tue, 04 Feb 2014 21:53:07 +0100
Received: from x2f4740e.dyn.telefonica.de ([2.244.116.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 21:53:07 +0100
Received: from dak by x2f4740e.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 21:53:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4740e.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:P4/LIVkQJOqW1+MoFHoZIN+oAfg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241551>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Making a single preparation run for counting the lines will avoid memory
>> fragmentation.  Also, fix the allocated memory size which was wrong
>> when sizeof(int *) != sizeof(int), and would have been too small
>> for sizeof(int *) < sizeof(int), admittedly unlikely.
>>
>> Signed-off-by: David Kastrup <dak@gnu.org>
>> ---
>>  builtin/blame.c | 40 ++++++++++++++++++++++++----------------
>>  1 file changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index e44a6bb..522986d 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -1772,25 +1772,33 @@ static int prepare_lines(struct scoreboard *sb)
>>  {
>>  	const char *buf = sb->final_buf;
>>  	unsigned long len = sb->final_buf_size;
>> -	int num = 0, incomplete = 0, bol = 1;
>> +	const char *end = buf + len;
>> +	const char *p;
>> +	int *lineno;
>> +	
>> +	int num = 0, incomplete = 0;
>
> Is there any significance to the blank line between these two
> variable definitions?

Well, I needed more than the whitespace error to be motivated for
redoing.  Cough, cough.

>> +
>> +	for (p = buf;;) {
>> +		if ((p = memchr(p, '\n', end-p)) == NULL)
>> +			break;
>> +		++num, ++p;
>
> You have a peculiar style that is somewhat distracting.  Why isn't
> this more like so?
>
> 	for (p = buf; p++, num++; ) {

More likely
	for (p = buf;; p++, num++)
            
> 		p = memchr(p, '\n', end - p);
> 		if (!p)
> 			break;
> 	}
>
> which I think is the prevalent style in our codebase.  The same for
> the other loop we see in the new code below.

I rearranged a few times in order to have both loops be closely
analogous.  The second loop would then have to be

       for (p = buf;; p++) {
               *lineno++ = p-buf;
               p = memchr(p, '\n', end-p)
               if (!p)
                       break;
       }

Admittedly, that works.  I am not too happy about the termination
condition being at the end of the loop but not in the for statement, but
yes, this seems somewhat nicer than what I proposed.

>  - favor post-increment unless you use it as rvalue and need
>    pre-increment;

In my youth, the very non-optimizing C compiler I used under CP/M
produced less efficient code for x++ than for ++x even when not using
the resulting expression.  Surprisingly habit-forming.

>
>  - SP around each binary ops e.g. 'end - p';

Ok.

>> +	}
>>  
>> -	if (len && buf[len-1] != '\n')
>> +	if (len && end[-1] != '\n')
>>  		incomplete++; /* incomplete line at the end */
>
> OK, so far we counted "num" complete lines and "incomplete" may be
> one if there is an incomplete line after them.

That's pretty much the gist of the original code.

>> -	while (len--) {
>> -		if (bol) {
>> -			sb->lineno = xrealloc(sb->lineno,
>> -					      sizeof(int *) * (num + 1));
>> -			sb->lineno[num] = buf - sb->final_buf;
>> -			bol = 0;
>> -		}
>> -		if (*buf++ == '\n') {
>> -			num++;
>> -			bol = 1;
>> -		}
>> +
>> +	sb->lineno = lineno = xmalloc(sizeof(int) * (num + incomplete + 1));
>
> OK, this function is called only once, so we know sb->lineno is NULL
> originally and there is no reason to start from xrealloc().

[...]

> These really *were* unnecessary reallocations.

Well, if a realloc will increase the allocation size by a constant
factor each time, the amortization cost is O(n) for n entries.  So with
a suitable realloc, the effect will not really be noticeable.  It still
offends my sense of aesthetics.

> Thanks for catching them, but this patch needs heavy style fixes.

Well, does not look all that heavy, but I'll repost.

There is another oversight: I am using memchr here, but there is no
obvious header file definiting it (the respective header will likely be
pulled in indirectly via something unrelated).

Anybody know offhand what I should be including here?  It looks like Git
has some fallback definitions of its own, so it's probably not just
<string.h> I should include?

-- 
David Kastrup

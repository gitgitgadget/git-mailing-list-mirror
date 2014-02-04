From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 22:27:00 +0100
Organization: Organization?!?
Message-ID: <874n4ewouz.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 22:27:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnWh-0002AQ-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934684AbaBDV1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:27:19 -0500
Received: from plane.gmane.org ([80.91.229.3]:48915 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933726AbaBDV1O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:27:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAnWR-00023N-Mr
	for git@vger.kernel.org; Tue, 04 Feb 2014 22:27:11 +0100
Received: from x2f4740e.dyn.telefonica.de ([2.244.116.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 22:27:11 +0100
Received: from dak by x2f4740e.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 22:27:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4740e.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:2LD6ZaHo+8wnQ+ETK4aFA8rS1fg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241557>

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
>
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
> 		p = memchr(p, '\n', end - p);
> 		if (!p)
> 			break;
> 	}

Ok, I now wrote

	for (p = buf;; num++, p++) {
		p = memchr(p, '\n', end - p);
		if (!p)
			break;
	}

and you know what?  Its logic seems wrong.  The reason is that the p++
does not really have anything to do with the iteration, but rather steps
past the '\n' from the memchr.  So it's more like

	for (p = buf;; num++) {
		p = memchr(p, '\n', end - p);
		if (p) {
			p++;
                        continue;
                }
		break;
	}

So barring protests, that's what I'm going to use instead.

-- 
David Kastrup

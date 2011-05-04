From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 1/2] diff: introduce --stat-lines to limit the stat
 lines
Date: Wed, 04 May 2011 09:16:13 +0200
Message-ID: <4DC0FD3D.9010004@drmicha.warpmail.net>
References: <7vmxj6s22r.fsf@alter.siamese.dyndns.org> <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net> <7vfwoviptm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 09:16:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHWJp-0004uz-GG
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 09:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab1EDHQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 03:16:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50866 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753227Ab1EDHQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 03:16:16 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 81A43207B9;
	Wed,  4 May 2011 03:16:15 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 04 May 2011 03:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=INQOS+i42dUdp6lj3Qj0LnTSS2o=; b=dxqe+4oR+qES6cAr6YGFAKWkNqJWvmISwGhDi3lHD5m9wRLsKu5wf16siRZrc1eSI5nOrE6ptbywFHk0m2jr2UsbCesx37FcrVY+Y6Qv3kSJv98SMELXFTlb0mxksTD6s2I8hzF7DwP+1x+gyw6Y8qDt45MQBduLxFevpaBzLOo=
X-Sasl-enc: gzCpM9lFF1TkaR9exdeCgBwtpvSbv9tsueeXTTNa5B7e 1304493375
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E4590447152;
	Wed,  4 May 2011 03:16:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vfwoviptm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172721>

Junio C Hamano venit, vidit, dixit 03.05.2011 20:47:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> In the case with <count>+1 items one may argue whether it makes more sense to
>> ignore the user wish and output all <count>+1 lines, or <count> lines (as
>> requested) plus the "..." line.
> 
> I think that is a must if we care about consistency. fmt-merge-msg should

I assume you mean the part before the "or" by "this".

> already do this (I remember being careful about this particular case when
> I wrote its first version, but I do not know it has regressed as I do not
> remember writing tests for this boundary case---my bad ;-).

I'll recheck with fmt-merge-msg. Seems this series needs more work than
I expected... and may take some time.

>> (I saw the suggestion about N-2...2 just now. Would work also, but I guess
>> we would do this in more cases then, as Junio indicated.)
> 
> It is not clear what you mean by N-2...2 but if you are referring to my
> "first N-1 entries, dots and the last one, to make the total N+1 lines
> that show N entries", then yes I think it would make sense to do that also
> in fmt-merge-msg.c::shortlog() as well as here.  But that would be a
> separate topic.

Yes, N-2, then the remaining 2 or "..." plus the last one. Sorry for the
confusion.

>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 34f0145..000eae0 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -48,11 +48,14 @@ endif::git-format-patch[]
>>  --patience::
>>  	Generate a diff using the "patience diff" algorithm.
>>  
>> ---stat[=<width>[,<name-width>]]::
>> +--stat[=<width>[,<name-width>[,<count>]]]::
>>  	Generate a diffstat.  You can override the default
>>  	output width for 80-column terminal by `--stat=<width>`.
>>  	The width of the filename part can be controlled by
>>  	giving another width to it separated by a comma.
>> +	By giving a third parameter `<count>`, you can limit the
>> +	output to the first `<count>` lines, followed by
>> +	`...` if there are more.
> 
> Does an empty-string <count> mean "use default" (currently "no limit")?
> This matters when we teach a new parameter to --stat and make the above:
> 
> 	--stat=[=<width>[,<name-width>[,<count>[,<nitfol>]]]]
>

Yes, strtoul("") is 0, and 0 denotes default, which is unlimited. By
design, but maybe I should mention it somewhere, probably as part of
2/2, because that same effect is true and undocumented for the 1st 2
slots, i.e. --stat=",,5" sets the count argument to 5 and the others to
default.

>> +	for (i = count; i < data->nr; i++) {
>> +		uintmax_t added = data->files[i]->added;
>> +		uintmax_t deleted = data->files[i]->deleted;
>> +		if (!data->files[i]->is_renamed &&
>> +			 (added + deleted == 0)) {
>> +			total_files--;
>> +			continue;
>> +		}
>> +		adds += added;
>> +		dels += deleted;
>> +	}
>>  	fprintf(options->file, "%s", line_prefix);
>>  	fprintf(options->file,
>>  	       " %d files changed, %d insertions(+), %d deletions(-)\n",
> 
> This is culling the output of what is in struct diffstat that we have
> already spent cycles to possibly fill thousands of entries.  I first
> thought it may make sense to also tweak the loop in diff_flush() that runs
> diff_flush_stat() to all filepairs to run it only on the first <count>
> (and later the first <count-1> and the last) filepairs, but we have to
> show the short-stat summary at the end, so this cannot be avoided.

Yeah, in my 0th version that stat was for the shown lines only...

> What happens when I say "diff --numstat --stat-count=4"?
> 
> Should it error out upon seeing a limit that is not infinite, or should it
> also elide the lines in its output?

None of the --stat-* options affects --numstat, again by design. All of
width, name-width and count would make sense for --numstat (and
--dirstat) also, but that would require some restructuring.

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> > @@ -1302,7 +1304,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>> >  	else
>> >  		width = max_change;
>> >  
>> > -	for (i = 0; i < data->nr; i++) {
>> > +	for (i = 0; i < count; i++) {
>> >  		const char *prefix = "";
>> >  		char *name = data->files[i]->print_name;
>> >  		uintmax_t added = data->files[i]->added;
> This first loop can omit a "struct diffstat_file" that is not a rename and
> does not add nor delete any lines (look for "total_files--"), but you do
> not seem to compensate for it. If you have such a record in the earlier
> part of the result for whatever reason, you would end up showing fewer
> entries than what "count" indicates in this loop.

Uh, sorry and thanks for noticing. I wasn't aware that we may skip a
pair completely.

I wanted to make the design optimal in the sense that I introduce as few
additional conditionals within the two loops there. I guess I'll have to
sacrifice that in the first loop.

Michael

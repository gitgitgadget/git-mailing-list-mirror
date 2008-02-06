From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] [v8] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Wed, 6 Feb 2008 12:23:42 +0100
Message-ID: <885376AD-510D-4E8E-8DCF-87073AC0F88F@zib.de>
References: <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de> <12021001351967-git-send-email-prohaska@zib.de> <7vbq6u32mq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 12:23:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMiNT-00065m-Sz
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 12:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbYBFLXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 06:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYBFLXK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 06:23:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:41344 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbYBFLXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 06:23:08 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m16BMiWY011547;
	Wed, 6 Feb 2008 12:22:44 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m16BMhN1024540
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 6 Feb 2008 12:22:44 +0100 (MET)
In-Reply-To: <7vbq6u32mq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72800>


On Feb 6, 2008, at 9:33 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> This repaces v7 of the patch and includes the following changes
>>  - Commit message defends safecrlf=warn default.
>>  - refactored to lines max 84 chars long.
>>
>>     Steffen
>>
>> ---- snip ---
>>
>> CRLF conversion bears a slight chance of corrupting data.
>> ...
>
> Is this meant for application?

Yes, this is the best I have and I personally test it in practice.
It works for me, although I recognized that I tend to miss warnings
sometimes, for example during "git commit -a".  The reason is that
the warnings are printed, but the editor for the commit message
pops up right afterwards.  With "git add" this is not a problem.

More feedback by others would be helpful.  So yes, the patch
should be applied.

But you have quite a few comments below; so I'll send an update.



> If so please do not do "^---- snip ---".  More than three dashes
> at the beginning of line discards everything after that from the
> commit log message so "git am -i" becomes very cumbersome.  And
> that is the reason you often see "-- >8 --" scissors mark from
> me (notice two dashes, not three).

Ahh.. ok, I thought any number of dashes unequal 3 would work.
I'll use your mark in the future.


>
>> autocrlf=true will convert CRLF to LF during commit and LF to
>> CRLF during checkout.  A file that contains a mixture of LF and
>> CRLF before the commit cannot be recreated by git.  For text
>> files this does not really matter because we do not care about
>> the line endings anyway; ...
>
> That is a wrong explanation.  It is not that we do not _care_.
>
> Far from it.  With autocrlf, we _deeply_ care about the line
> endings of text files to be canonical with LF in the repository
> data, and canonical with platform convention in the work tree
> data.  A file with mixed LF and CRLF have _wrong_ line endings
> in the work tree data, hence it actively gets _corrected_.
>
> So it is not _anyway_.  It is what we _want to happen_.

Hmm, yes, I agree with your reasoning.  We do care and we only
want LF.  Maybe I had Dscho's arguments in mind when I wrote
this paragraph.  He often claims that git users on Unix do care
about every single bit of the files, which means including the
"wrong" line endings.  But I don't think this is true. I think
we don't mind that autocrlf=true modifies the line endings in
a way that they cannot be exactly restored.  We don't mind
because we do not care about the exact line endings.  We only
need to know that the line ends, not if it ends in CRLF or LF.

[ comments about commit message that I'll include in the update. ]


>
>> diff --git a/convert.c b/convert.c
>> index 80f114b..94c70f4 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -85,8 +85,36 @@ static int is_binary(unsigned long size, struct  
>> text_stat *stats)
>>  	return 0;
>>  }
>>
>> +static void check_safe_crlf(const char* path, int action,
>> +                            struct text_stat* stats, enum  
>> safe_crlf checksafe)
>
> Asterisk comes near the variable name not type: "const char *path".

I know that but I tend to forget because I follow a different rule
all day ;)  Will fix.


>> +{
>> +	if (action == CRLF_INPUT || auto_crlf <= 0) {
>> +		/*
>> +		 * CRLFs would not be restored by checkout:
>> +		 * check if we'd remove CRLFs
>> +		 */
>> +		if (stats->crlf) {
>> +			if (checksafe == SAFE_CRLF_WARN)
>> +				warning("CRLF will be replaced by LF in %s.", path);
>> +			else
>> +				die("CRLF would be replaced by LF in %s.", path);
>
> What happens when checksafe == SAFE_CRLF_FALSE, I had to wonder,
> until looking at the caller.
>
> 			else /* i.e. SAFE_CRLF_FAIL */
>
> would have been easier to follow.

I'll add a comment and will move the "if (!checksafe)" from the  
caller to
the beginning of check_safe_crlf().


>> diff --git a/sha1_file.c b/sha1_file.c
>> index 66a4e00..4179949 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -2358,7 +2358,8 @@ int index_fd(unsigned char *sha1, int fd,  
>> struct stat *st, int write_object,
>>  	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
>>  		struct strbuf nbuf;
>>  		strbuf_init(&nbuf, 0);
>> -		if (convert_to_git(path, buf, size, &nbuf)) {
>> +		if (convert_to_git(path, buf, size, &nbuf,
>> +		                   write_object ? safe_crlf : 0)) {
>>  			munmap(buf, size);
>>  			buf = strbuf_detach(&nbuf, &size);
>>  			re_allocated = 1;
>
> Very nicely done ;-).

thanks.

	Steffen

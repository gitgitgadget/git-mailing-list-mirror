From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] rm: do not set a variable twice without intermediate
 reading.
Date: Tue, 23 Jul 2013 20:47:23 +0200
Message-ID: <51EECFBB.3050406@googlemail.com>
References: <1374571162-22881-1-git-send-email-stefanbeller@googlemail.com> <7v4nbl86us.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 20:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1hcR-0007j4-0s
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 20:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933819Ab3GWSr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 14:47:27 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33564 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933683Ab3GWSr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 14:47:26 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so4092776wgg.24
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=8x1rt8UhL316doEfNvVx8i53U0oiyX48EpwLSaUT5lM=;
        b=rrYJzEK+Fjh4qelst+zqPJEK25sDHRyStUK3AJLuH9QOkYzjEhRWVdG84qC3mZl3ak
         +CinvZO2y+wfqv40XzCmyhZ0fzVPctggSq0fo6ajdr1TGZKKZgKoDGGBQb6b0e5BfYvr
         C1vxkVP5xQH7pnOjkrYN6thErkE7QY9cx5imkflN3UfyLYd5d+cbRfmaQyG1qQ6boRyC
         I2N027UGsOxKY6DlQAdlB4vysIFtcjqVVUrquE/x5zdUSmXitLbSpp2bXr5VvKswxfX0
         UTukBSeijDCLJ9dz2JoyWDPQ+SuqIxG4zj/UwMxbRwpqGcPz19ahxBzgZM4Vi826Ln1f
         wZBA==
X-Received: by 10.180.84.70 with SMTP id w6mr9501wiy.36.1374605244904;
        Tue, 23 Jul 2013 11:47:24 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d8sm237819wiz.0.2013.07.23.11.47.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 11:47:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7v4nbl86us.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231050>

On 07/23/2013 08:32 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
>> Just the next line assigns a non-null value to seen.
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>> ---
>>  builtin/rm.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/builtin/rm.c b/builtin/rm.c
>> index 5b63d3f..df85f98 100644
>> --- a/builtin/rm.c
>> +++ b/builtin/rm.c
>> @@ -316,7 +316,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>  	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
>>  	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
>>  
>> -	seen = NULL;
>>  	seen = xcalloc(pathspec.nr, 1);
>>  
>>  	for (i = 0; i < active_nr; i++) {
> 
> Interesting. This is ancient and dates back to 7612a1ef (git-rm:
> honor -n flag., 2006-06-08).
> 

Well the removed line itself maybe, but the next line ... as well.

The next line "seen = xcalloc(...)" was introduced in 29211a93c14
(2013-07-14) and was changed 4 or 5 times before (changing the
the malloc function to xmalloc and then to xcalloc.
I suppose these changes did not pay attention to the local area
around, but rather were interested in making the memory allocation
fast or safe in many places.


Originally it comes from d9b814cc97 (by Linus), which introduced:
+	seen = NULL;
+	if (pathspec) {
+		for (i = 0; pathspec[i] ; i++)
+			/* nothing */;
+		seen = xmalloc(i);
+		memset(seen, 0, i);
+	}

Then in 7612a1efdb0c the second seen assignment was made unconditional.
And since then it has been not noticed. ;)

However that being said, I am currently playing around with different
code analyzers (find dead code, possible null pointers, and such),
and the coding style of git is very different to what I am used to
(and what the tools are used to as well, lots of false positives).

Personally the coding style of git often reminds me to 'C as a
macro-assembler' rather than 'C as a high level programming
language'.

Stefan

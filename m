From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Mon, 25 Feb 2013 22:00:46 +0100
Message-ID: <512BD0FE.5040108@web.de>
References: <201302090052.22053.thom311@gmail.com> <7vsj56xsg5.fsf@alter.siamese.dyndns.org> <7vobfuxrns.fsf@alter.siamese.dyndns.org> <20130209002710.GA5570@sigill.intra.peff.net> <7vfw16xqvj.fsf@alter.siamese.dyndns.org> <7va9rexqii.fsf@alter.siamese.dyndns.org> <20130211191607.GA21269@sigill.intra.peff.net> <7v621ymxfv.fsf@alter.siamese.dyndns.org> <20130211205958.GA32740@sigill.intra.peff.net> <512B22DE.9070603@viscovery.net> <20130225151916.GA7725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 22:01:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA5Ag-0002Xn-Io
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 22:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702Ab3BYVAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 16:00:49 -0500
Received: from mout.web.de ([212.227.17.12]:51522 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140Ab3BYVAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 16:00:49 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LfiZ8-1Uc1JM3fbu-00pPma; Mon, 25 Feb 2013 22:00:47
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <20130225151916.GA7725@sigill.intra.peff.net>
X-Provags-ID: V02:K0:3tsGaA7uaeVTjd86OMr0xWnLMURVxxXOKENJwefESUb
 +w8vNO/MK5ATnZiPsSLZntqUTjfw3IF2lJFfExF4yFLh/6fPiF
 tPFTlEiBvumHuARYTNDsooHmNp+hw5sDQvIhd87L4QO/4Bnz6f
 jEi5NkJ2LnZNr7EVrqaCzjKYDH9LudmXX8zX/iUCuleCg1d151
 aTbR/2MCcbNuzgKHJQyHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217106>

On 25.02.13 16:19, Jeff King wrote:
> On Mon, Feb 25, 2013 at 09:37:50AM +0100, Johannes Sixt wrote:
> 
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> iconv on Windows does not know the encoding name "utf8", and does not
>> re-encode log messages when this name is given. Request "UTF-8" encoding.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  I'm not sure whether I'm right to say that "UTF-8" is the correct
>>  spelling. Anyway, 'iconv -l' on my old Linux box lists "UTF8", but on
>>  Windows it does not.
> 
> UTF-8 is correct according to:
> 
>   https://en.wikipedia.org/wiki/Utf8#Official_name_and_variants
> 
>>  A more correct fix would probably be to use is_encoding_utf8() in more
>>  places, but it's outside my time budget look after it.
> 
> Yeah, I wonder if this is a symptom of a deeper issue, which is that
> utf-8 has many synonyms, and we would prefer to canonicalize the
> encoding name before generating an object to avoid inconsistencies (of
> course we cannot do so for every imaginable encoding, but utf-8 is a
> pretty obvious one we handle already). We _should_ be generating commits
> with no encoding header at all for utf-8, though.
> 
> And indeed, it looks like that is the case. commit_tree_extended has:
> 
>     /* Not having i18n.commitencoding is the same as having utf-8 */
>     encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
> 
>     [...]
> 
>     if (!encoding_is_utf8)
>             strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
> 
> 
> which makes me think that this first hunk...
> 
>> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
>> index 52a7472..b1956e2 100755
>> --- a/t/t4210-log-i18n.sh
>> +++ b/t/t4210-log-i18n.sh
>> @@ -15,7 +15,7 @@ test_expect_success 'create commits in different encodings' '
>>  	t${utf8_e}st
>>  	EOF
>>  	git add msg &&
>> -	git -c i18n.commitencoding=utf8 commit -F msg &&
>> +	git -c i18n.commitencoding=UTF-8 commit -F msg &&
>>  	cat >msg <<-EOF &&
>>  	latin1
> 
> ...should be a no-op; the utf8 there should never be seen by anybody but
> git. Can you confirm that is the case?
> 
>> @@ -30,7 +30,7 @@ test_expect_success 'log --grep searches in log output encoding (utf8)' '
>>  	latin1
>>  	utf8
>>  	EOF
>> -	git log --encoding=utf8 --format=%s --grep=$utf8_e >actual &&
>> +	git log --encoding=UTF-8 --format=%s --grep=$utf8_e >actual &&
>>  	test_cmp expect actual
>>  '
> 
> This one will feed it to iconv, though, because the latin1 commit will
> need to be re-encoded. I think the simplest thing would just be:
> 
> diff --git a/utf8.c b/utf8.c
> index 1087870..8d42b50 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -507,6 +507,17 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
>  
>  	if (!in_encoding)
>  		return NULL;
> +
> +	/*
> +	 * Some platforms do not have the variously spelled variants of
> +	 * UTF-8, so let us feed iconv the most official spelling, which
> +	 * should hopefully be accepted everywhere.
> +	 */
> +	if (is_encoding_utf8(in_encoding))
> +		in_encoding = "UTF-8";
> +	if (is_encoding_utf8(out_encoding))
> +		out_encoding = "UTF-8";
> +
>  	conv = iconv_open(out_encoding, in_encoding);
>  	if (conv == (iconv_t) -1)
>  		return NULL;
> 
> Does that fix the tests for you? It's a larger change, but I think it
> makes git friendlier all around for people on Windows.
> 
> -Peff
> --
 
Thanks, I'm OK with your version.

And a test on cygwin was OK for the new t4210.

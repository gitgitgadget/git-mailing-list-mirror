From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v4 4/7] notes copy --stdin: read lines with
 strbuf_getline()
Date: Mon, 29 Feb 2016 20:26:50 +0100
Message-ID: <56D49B7A.2060601@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de> <56D40314.7040608@moritzneeb.de>
 <CAPig+cSptQr21QMOJmxT4RPVR3r3zkEQ2TkTU8RoaJfo7=KChw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:26:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTT7-000426-8A
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbcB2T0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:26:53 -0500
Received: from moritzneeb.de ([78.47.1.106]:40812 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbcB2T0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:26:52 -0500
Received: from [192.168.20.130] (port-213-160-9-202.static.qsc.de [213.160.9.202])
	by moritzneeb.de (Postfix) with ESMTPSA id 174581C058;
	Mon, 29 Feb 2016 20:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456774011;
	bh=HNnSk8EhGd49iKC1DuTXrHL+UAFmueUsAbyXAQWPl3o=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=dhoJNTitgSbXuyYK43zcVj0r29/duoaU7FdcCJIGgT0RkM6Fw+pzYN5tlN4GfkqWX
	 VWuTIdpgHienEp6ME2WPKWY8h7DCm96SE3zEVFWTbPdnYHSWly6EBpaf37krqzeqeE
	 R/n+YcJazCpZRsIXUAJqFu1qStfhpWz5/olbx/Jg=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAPig+cSptQr21QMOJmxT4RPVR3r3zkEQ2TkTU8RoaJfo7=KChw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287887>

On 02/29/2016 07:19 PM, Eric Sunshine wrote:
> If you do elect to keep things the way they are, then (as mentioned in
> my v2 review) it would be helpful for the above paragraph to explain
> that strbuf_split() leave the "terminator" on the split elements, thus
> clarifying why the rtrim() of split[0] is still needed.
> 

Yes I would rather leave it like it is. I have the feeling it is
unmotivated to remove the rtrim of split[1] in the patch 5/7, because it
is directly related to the strbuf_getline_lf() replacement. Thats's what
I was trying to explain in the 2nd paragraph of the commit message.

First I was following your review, but then I had to add a paragraph in
patch 5/7 that says something like "because the effect of the previous
patch is that there is not a CR anymore, we can now safely remove
rtrim() split[1]."

You're right, maybe I should add a comment about why I left rtrim() of
split[0] to make it more obvious. I thought that would get clear by
looking at the context, i.e. patch 5/7, where it is explained (by you,
thanks for that), that strbuf_split leave this space. Is the assumption,
that those two patches are most times viewed in context wrong?

Thanks,
Moritz


>> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
>> ---
>>  builtin/notes.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index ed6f222..706ec11 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -290,7 +290,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>>                 t = &default_notes_tree;
>>         }
>>
>> -       while (strbuf_getline_lf(&buf, stdin) != EOF) {
>> +       while (strbuf_getline(&buf, stdin) != EOF) {
>>                 unsigned char from_obj[20], to_obj[20];
>>                 struct strbuf **split;
>>                 int err;
>> @@ -299,7 +299,6 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>>                 if (!split[0] || !split[1])
>>                         die(_("Malformed input line: '%s'."), buf.buf);
>>                 strbuf_rtrim(split[0]);
>> -               strbuf_rtrim(split[1]);
>>                 if (get_sha1(split[0]->buf, from_obj))
>>                         die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
>>                 if (get_sha1(split[1]->buf, to_obj))
>> --
>> 2.4.3

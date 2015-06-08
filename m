From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] commit: cope with scissors lines in commit message
Date: Mon, 08 Jun 2015 18:30:19 +0200
Message-ID: <20150608183019.Horde.Kp4b2pClPLqAJp3LacT_fA1@webmail.informatik.kit.edu>
References: <1433727639-5927-1-git-send-email-szeder@ira.uka.de>
 <xmqqoakqciv1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:31:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zxC-0005mW-3K
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbbFHQbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 12:31:06 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59885 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753263AbbFHQa4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 12:30:56 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Z1zws-000849-Ei; Mon, 08 Jun 2015 18:30:54 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Z1zwJ-0004AF-Jc; Mon, 08 Jun 2015 18:30:19 +0200
Received: from x590e5e8c.dyn.telefonica.de (x590e5e8c.dyn.telefonica.de
 [89.14.94.140]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 08 Jun 2015 18:30:19 +0200
In-Reply-To: <xmqqoakqciv1.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1433781054.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271069>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> The diff and submodule shortlog appended to the commit message templ=
ate
>> by 'git commit --verbose' are not stripped when the commit message
>> contains an indented scissors line.
>>
>> When cleaning up a commit message with 'git commit --verbose' or
>> '--cleanup=3Dscissors' the code is careful and triggers only on a pu=
re
>> scissors line, i.e. a line containing nothing but a comment characte=
r, a
>> space, and the scissors cut.  This is good, because people can embed
>> scissor lines in the commit message while using 'git commit --verbos=
e',
>> and the text they write after their indented scissors line doesn't g=
et
>> deleted.
>>
>> While doing so, however, the cleanup function only looks at the firs=
t
>> line matching the scissors pattern and if it doesn't start at the
>> beginning of the line, then the function just returns without perfor=
ming
>> any cleanup.  This is bad, because a "real" scissors line added by '=
git
>> commit --verbose' might follow, and in that case the diff and submod=
ule
>> shortlog get included in the commit message.
>
> Yikes; this is not just "bad" but simply "wrong".  Thanks for
> noticing.

Great, the other day I scored a "Gaaah" from Peff, now a "Yikes" from =20
you...  Doin' good! ;)

>>  void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
>>  {
>> -	const char *p;
>> +	const char *p =3D buf->buf;
>>  	struct strbuf pattern =3D STRBUF_INIT;
>>
>>  	strbuf_addf(&pattern, "%c %s", comment_line_char, cut_line);
>> -	p =3D strstr(buf->buf, pattern.buf);
>> -	if (p && (p =3D=3D buf->buf || p[-1] =3D=3D '\n'))
>> -		strbuf_setlen(buf, p - buf->buf);
>> +	while ((p =3D strstr(p, pattern.buf))) {
>> +		if (p =3D=3D buf->buf || p[-1] =3D=3D '\n') {
>> +			strbuf_setlen(buf, p - buf->buf);
>> +			break;
>> +		}
>> +		p++;
>> +	}
>
> I however wonder if we should make strstr() do more work for us.
>
> 	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
> 	if (starts_with(buf->buf, pattern.buf + 1))
> 		strbuf_setlen(buf, 0);
> 	else if ((p =3D strstr(buf->buf, pattern.buf)) !=3D NULL)
>         	strbuf_setlen(buf, p - buf->buf + 1);
> 	strbuf_release(&pattern);
>
> perhaps?

Though this has one more if statement, it doesn't add a loop and =20
eliminates the if (... || ...).
Good, will try to reroll in the evening.

G=C3=A1bor

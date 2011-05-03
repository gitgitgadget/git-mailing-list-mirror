From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: add known breakage of coloring when using extended
 patterns
Date: Tue, 03 May 2011 19:36:39 +0200
Message-ID: <4DC03D27.80803@lsrfire.ath.cx>
References: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com> <4DBEE672.5070707@lsrfire.ath.cx> <7vd3k1ngun.fsf@alter.siamese.dyndns.org> <4DBF1D2A.6030807@lsrfire.ath.cx> <7vwri8kbcy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoQ==?= =?UTF-8?B?aSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>,
	Thiago dos Santos Alvest <hiago.salves@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 19:36:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHJWl-0003HL-5B
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 19:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab1ECRgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 13:36:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:57457 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab1ECRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 13:36:45 -0400
Received: from [192.168.2.106] (p4FFD98B8.dip.t-dialin.net [79.253.152.184])
	by india601.server4you.de (Postfix) with ESMTPSA id 53A1F2F8050;
	Tue,  3 May 2011 19:36:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vwri8kbcy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172674>

Am 03.05.2011 00:04, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Aggregating the set of matching characters and passing them back
>> during expression evaluation can be more efficient, yes, as it would
>> avoid calling regexec() on the printed lines again only to find out
>> what to color.  But I wouldn't call it easy.  E.g. how to return the
>> set of matching characters in the following case?
>>
>> 	$ git grep --color -e foo --and -e bar
>=20
> I would na=C3=AFvely expect each of the "grep_expr" in the parsed gre=
p tree to
> have not just a one-bit "hit", but rm_so/rm_eo pair, but as I said, I=
 was
> asleep while "coloring the parts that matched" discussion was in prog=
ress
> ;-)

That's true, but each one represents a single contiguous run of
characters to color.  But I meant to say that returning non-contiguous
ranges, as you can get in the --and example above, is not that easy.  T=
o me.

Hmm, if one just wants to color the parts that triggered a match it get=
s
a lot easier.  Each pattern just needs to remember the last matching
offsets and then show_line can walk the expression tree to find out wha=
t
needs coloring.  Not sure about the details, though. :)

> But
>=20
>> Also GNU grep doesn't only color the first sufficient match.
>> E.g. this will color both b and d:
>>
>> 	$ echo abcde | grep --color -e b -e d
>=20
> that is probably a useful thing to have.  Obviously, my suggestion sh=
ould
> optimize away the match with 'd' to begin with, so keeping rm_so/rm_e=
o
> pair would not help painting d at all.  Worse yet, I would expect tha=
t
>=20
> 	$ echo abcdeabcde | grep --color -e b -e d
>=20
> would need to paint all occurrences for such a purpose, so obviously =
you
> would need an extra pass to find all potential hits.  Ugly and makes =
me
> personally wonder if it is really worth it, but the user is explicitl=
y
> asking for --color and is prepared to pay the price, so it probably i=
s Ok.

The performance impact is low as long as there are lots more lines that
don't match than matching ones.  Which should be a given for most uses
of grep.

I always miss hit coloring if I have to use an environment that doesn't
provide , similarly to syntax highlighting, so I do think it's worth it=
,
for me at least.

Ren=C3=A9

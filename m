From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git grep does not support multi-byte characters (like UTF-8)
Date: Tue, 7 Jul 2015 19:22:28 +0700
Message-ID: <CACsJy8A035JsR-z34g56QWLVkN0Tg0tOqmrT+Hp6ecsVBhm25g@mail.gmail.com>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
 <CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com> <775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Plamen Totev <plamen.totev@abv.bg>
X-From: git-owner@vger.kernel.org Tue Jul 07 14:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCRtx-0004zi-PF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 14:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbbGGMXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 08:23:00 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35094 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbbGGMW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2015 08:22:58 -0400
Received: by iecuq6 with SMTP id uq6so132854790iec.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HTSJs8WT3l2/ZNNzSQIlRF1AoydhGFznqQnBJ7w1Ziw=;
        b=Cjrpx+KQUvegap6vnYAdnSXd13HIudDaHYeWjyGOSn2Y5btwPbaJQ1mW5sRJRnDCdK
         K5Iiv3kdQjsnd5NUDn8QDfAWSdYdra8l/EfkfiVQMs9Aop7A021LzZLNjnLLcSoBaMQb
         rK3wgB839q3KiMRz2H8GdDEZ3RCy0ychZHjAddRqT4po07xDq3+xbsiM3VGKYaU071Zk
         w+eocCs7W8IYklkpGbZgiM1Nwap9AQJB4Tgsb/lZu/7qdx7rEDoq0kCvdWkas7M1uqQX
         xBYr917N9Cb/wE/yFCa+pQX7ngdIzDfEIcZ/kuG3Z4qLpsQ9Mh5Qv2gVOGxuQaZp1hGf
         wSQA==
X-Received: by 10.50.164.233 with SMTP id yt9mr76240651igb.41.1436271778221;
 Tue, 07 Jul 2015 05:22:58 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 7 Jul 2015 05:22:28 -0700 (PDT)
In-Reply-To: <775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273498>

On Tue, Jul 7, 2015 at 3:58 PM, Plamen Totev <plamen.totev@abv.bg> wrot=
e:
> Nguyen, thanks for the help and the patch. Also the escaping suggeste=
d by Scharfe seems as good choice. But i dig some more into the problem=
 and I found some other thing. That's why I replied on the main thread =
not on the patch. I hope you'll excuse me if this is a bad practice.

So far this is very good reporting. I can't complain :)

> git grep -i -P also does not works because the PCRE_UTF8 is not set a=
nd pcre library does not treat the string as UTF-8.

We do prefer utf-8, but i don't know if we can assume utf-8 everywhere
yet. I guess it's ok in this case.

> pickaxe search also uses kwsearch so the case insensitive search with=
 it does not work (e.g. git log -i -S).  Maybe this is a less of a prob=
lem here as one is expected to search for exact string (hence knows the=
 case)

Will fix (i'm close to being done with git-grep, not counting the pcre
bug you just found)

> There is a interesting corner case. is_fixed treats all patterns cont=
aining nulls as fixed. So what about if the string contains non-ASCII s=
ymbols as well as nulls and the search is case insensitive :) I have to=
 admin that my knowledge in UTF-8 is not enough to answer the question =
if this could occur during normal usage. For example the second byte in=
 multi-byte symbol is NULL. I would guess that's not true as it would b=
reak a lot of programs that depend on NULL delimited string but it's go=
od if somebody could confirm.

=46or utf-8, if NUL occurs in a byte stream, it must be ASCII NUL, not
part of any multibyte character. Utf-8 is really well tuned for C
strings.

> GNU grep indeed uses escaped regular expressions when the string is u=
sing multi-byte encoding and the search is case insensitive. If the enc=
oding is UTF-8 then this strategy could be used in git too. Especially =
that git already have support and helper functions to work with UTF-8. =
As for the other multi-byte encodings - I think the things would become=
 more complicated. As far I know in UTF-8 the '{' character for example=
 is two bytes not one. Maybe really a support could be added only for t=
he UTF-8 and if the string is not UTF-8 to issue a warning.

In the worst case we could reuse the trick we do elsewhere in git:
convert to utf-8 with iconv, do whatever we need to (escaping...) then
convert back before feeding it to regcomp and friends.

> So maybe the following makes sense when a grep search is performed:
> * check if the multi-byte encoding is used. If it's and the search is=
 case insensitive and the encoding is not UTF-8 give a warning;
> * if pcre is used and the string is UTF-8 encoded set the PCRE_UTF8 f=
lag;
> * if the search is case insensitive, the string is fixed and the enco=
ding  used is UTF-8 use regcomp instead of kwsearch and escape any rege=
x special characters in the pattern;
>
> And the question with the behavior of pickaxe search remains open. Us=
ing kwset does not work with case insensitive non-ASCII searches. Inste=
ad of fixing grep.c maybe it's better if new function is introduced tha=
t performs keyword searches so it could be used by both grep, diffcore-=
pickaxe and any other code in the future that may require such function=
ality. Or maybe diffcore-pickaxe should use grep instead of directly kw=
set/regcomp

That would function be called "grep". More refactor would be needed.
"git grep regcomp" reveals some many places. Many some of them would
benefit from kws if we provide this new function you mentioned.

> Regards,
> Plamen Totev
>
>
>
>>-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
>>=D0=9E=D1=82: Duy Nguyen pclouds@gmail.com
>>=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: Git grep does not sup=
port multi-byte characters (like UTF-8)
>>=D0=94=D0=BE: Plamen Totev <plamen.totev@abv.bg>
>>=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
06.07.2015 15:23
>
>> I think we over-optimized a bit. If you your system provides regex
>> with locale support (e.g. Linux) and you don't explicitly use fallba=
ck
>> regex implementation, it should work. I suppose your test patterns
>> look "fixed" (i.e. no regex special characters)? Can you try just ad=
d
>> "." and see if case insensitive matching works?
>
> This is indeed the problem. When I added the "." the matching works j=
ust fine.



--=20
Duy

From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Need your help with MinGW Issue 17: --color options don't work (produce garbage)
Date: Wed, 15 Aug 2007 08:32:35 +0100
Message-ID: <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 09:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILDMx-0007nE-3Z
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 09:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXHOHci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 03:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbXHOHci
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 03:32:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:60187 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbXHOHcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 03:32:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1658274rvb
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 00:32:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OOgdvrKo8Q9Lak8qP5/P97Jo73KRgkq0RFrHEV6+5S1vPwF/kWlzmj/vE9ocKu9kOQZgGGJK5UakRj04+yq5XoRaHz8fldbrXswfs9pm8720ISzNzJT0kWMKdZupsl91l6AHVjJ/ya4IE2CYcUm0kInOMEb0VeD9wvDTqehePkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=moD3XtlfDTYSE5l5tGmg76P4fE5lOz/B6DuFaJ+guLkqMhwJMD5Lp0Nmp4agJCkwy/WIxey54QjX8uLNGAtNKiihu6AYZEchB2zJG2Pak9AbXRddog21Qdlj7c54PL1rO5B/jPGBNoPqv71RFVgo06L9PXU/FToHpK/acbHTF9s=
Received: by 10.141.14.14 with SMTP id r14mr87449rvi.1187163156010;
        Wed, 15 Aug 2007 00:32:36 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Wed, 15 Aug 2007 00:32:35 -0700 (PDT)
In-Reply-To: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55885>

On 15/08/07, Dmitry Kakurin wrote:
> Here are the facts:
>
> 'git branch --color' produces garbage:
> $ git branch --color
>   devel←[m
>   dima←[m
>   dmitryk←[m
> * ←[32mmaster←[m
>   mob←[m
>   next←[m
>
> 'git branch --color | cat' produces expected colored output.
>
> I've traced it down to printf statement in gdb and it sends the right
> esc-sequence.
> Where should I look next?

Windows doesn't recognise the *nix printf colour codes.

Piping through cat will be going through cygwin/mingw emulation,
translating the colour codes to the correct API calls.

You need to call the SetConsoleTextAttribute Win32 API. For example:

#ifdef defined(WIN32) || defined(WIN64)

typedef WORD color_t;

color_t red = FOREGROUND_INTENSITY | FOREGROUND_RED;
color_t green = FOREGROUND_INTENSITY | FOREGROUND_GREEN;
color_t blue = FOREGROUND_INTENSITY | FOREGROUND_BLUE;

color_t white = red | green | blue;

void set_color( color_t color )
{
    SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color );
}

#else

typedef const char * color_t;

color_t red = ...;
...

void set_color( color_t color ){ printf( color ); }

#endif

That way, you can do things like:
    set_color( red );
    printf( ... );
    set_color( blue );

This is not as pretty as the existing codebase, so another possibility
would be to create wrappers around the console output functions (i.e.
printf) and call SetConsoleTextAttribute there. This way, you can
restore the old colour when a restore settings sequence is
intercepted. It is also possible to reuse the GetStdHandle return
value.

NOTE: There isn't a GetConsoleTextAttribute in the Windows API, but
Google found this:

#if ( (defined(WIN32) || defined(_WINDOWS)) && !defined(__CYGWIN__) )
&& defined(_CONSOLE)

static WORD GetConsoleTextAttribute(HANDLE Console)
{
    CONSOLE_SCREEN_BUFFER_INFO ConsoleInfo;
    GetConsoleScreenBufferInfo(Console, &ConsoleInfo);
    return ConsoleInfo.wAttributes;
}

#endif

HTH,
- Reece

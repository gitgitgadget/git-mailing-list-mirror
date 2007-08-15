From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options
 don't work (produce garbage)
Date: Wed, 15 Aug 2007 17:10:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708151708570.19222@wbgn129.biozentrum.uni-wuerzburg.de>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
 <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 17:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILKVr-0001lQ-OO
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 17:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760439AbXHOPKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 11:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760346AbXHOPKK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 11:10:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:33854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760290AbXHOPKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 11:10:08 -0400
Received: (qmail invoked by alias); 15 Aug 2007 15:10:05 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp050) with SMTP; 15 Aug 2007 17:10:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+peIpLUC2p1O31lWYn+B0IMUzZDFwtcUBkOnrV16
	/j2D11cZWAJfeh
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55910>

Hi,

On Wed, 15 Aug 2007, Reece Dunn wrote:

> On 15/08/07, Dmitry Kakurin wrote:
> > Here are the facts:
> >
> > 'git branch --color' produces garbage:
> > $ git branch --color
> >   devel??[m
> >   dima??[m
> >   dmitryk??[m
> > * ??[32mmaster??[m
> >   mob??[m
> >   next??[m
> >
> > 'git branch --color | cat' produces expected colored output.
> >
> > I've traced it down to printf statement in gdb and it sends the right
> > esc-sequence.
> > Where should I look next?
> 
> Windows doesn't recognise the *nix printf colour codes.
> 
> Piping through cat will be going through cygwin/mingw emulation,
> translating the colour codes to the correct API calls.
> 
> You need to call the SetConsoleTextAttribute Win32 API. For example:
> 
> #ifdef defined(WIN32) || defined(WIN64)
> 
> typedef WORD color_t;
> 
> color_t red = FOREGROUND_INTENSITY | FOREGROUND_RED;
> color_t green = FOREGROUND_INTENSITY | FOREGROUND_GREEN;
> color_t blue = FOREGROUND_INTENSITY | FOREGROUND_BLUE;
> 
> color_t white = red | green | blue;
> 
> void set_color( color_t color )
> {
>     SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color );
> }
> 
> #else
> 
> typedef const char * color_t;
> 
> color_t red = ...;
> ...
> 
> void set_color( color_t color ){ printf( color ); }
> 
> #endif
> 
> That way, you can do things like:
>     set_color( red );
>     printf( ... );
>     set_color( blue );
> 
> This is not as pretty as the existing codebase, so another possibility
> would be to create wrappers around the console output functions (i.e.
> printf) and call SetConsoleTextAttribute there. This way, you can
> restore the old colour when a restore settings sequence is
> intercepted. It is also possible to reuse the GetStdHandle return
> value.
> 
> NOTE: There isn't a GetConsoleTextAttribute in the Windows API, but
> Google found this:
> 
> #if ( (defined(WIN32) || defined(_WINDOWS)) && !defined(__CYGWIN__) )
> && defined(_CONSOLE)
> 
> static WORD GetConsoleTextAttribute(HANDLE Console)
> {
>     CONSOLE_SCREEN_BUFFER_INFO ConsoleInfo;
>     GetConsoleScreenBufferInfo(Console, &ConsoleInfo);
>     return ConsoleInfo.wAttributes;
> }
> 
> #endif

Hmm.  Somehow I doubt that this hack works _outside_ of the Windows 
console.  I.e. if you call git in rxvt, it will fail, if you ssh into 
Windows, it will fail.

Ciao,
Dscho

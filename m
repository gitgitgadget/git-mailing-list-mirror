From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Tue, 09 Apr 2013 14:24:26 +0200
Message-ID: <5164087A.3030007@gmail.com>
References: <20130409054553.GA1537@mteis.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 14:24:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPXbH-0001xn-J5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 14:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935032Ab3DIMYb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 08:24:31 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:52542 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab3DIMYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 08:24:30 -0400
Received: by mail-ea0-f177.google.com with SMTP id q14so2760106eaj.8
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/nsxNk/RUvUP2fGHI0AEXiU9yGLQU5fkKoNQkiUCQV8=;
        b=ePovr2Nkk4hAB3qmuH1y+pxw6uOW2eLh2793Uk+Sanrt2Hqul0ZrKFktNQWpp5e92v
         hU5QKPqIqWUux+IWSsA743rWMVnWurJI/Nypuw35h72MnKNVYcvuV2Y8WJBykqk+Fega
         0xCi+WScm0GD1T3t0UIODSiy9bDIg9Fdgztl+LeVPEYWnl9FxlV2YOPBqsUKalTgnttq
         T8F8NTNGH3TLJV7naB6P+wOZRq4Lk4Kcf9vD06tr5wHAp13GiIcXoFm8hGY46yLdUJMk
         oeFJOeE7WoMpQGp5vbs5uTlDWi/wfS9owPli5AFPfOyaGN9UkGe9W7c7KD/wW2WjVKzj
         L2SQ==
X-Received: by 10.14.210.132 with SMTP id u4mr48675955eeo.19.1365510269675;
        Tue, 09 Apr 2013 05:24:29 -0700 (PDT)
Received: from [192.168.1.14] (eio154.neoplus.adsl.tpnet.pl. [83.21.130.154])
        by mx.google.com with ESMTPS id cb50sm15974874eeb.14.2013.04.09.05.24.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 05:24:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130409054553.GA1537@mteis.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220567>

On 09.04.2013, Magnus Therning wrote:

> I've been trying to set up git-http-backend+lighttpd.  I've managed t=
o
> set up anonymous read-only access, and I then successfully configured
> authentication for both read and write.  Then I get stuck.  The
> man-page for git-http-backend says that the following snippet can be
> used for Apache 2.x:
>=20
>     <LocationMatch "^/git/.*/git-receive-pack$">
>         AuthType Basic
>         AuthName "Git Access"
>         Require group committers
>         ...
>     </LocationMatch>
>=20
> However, when I put in this match on location in my lighty config and
> try to push I'm not asked for a password, instead I'm greeted with
>=20
>     % git push=20
>     error: The requested URL returned error: 403 Forbidden while=20
>      accessing
http://magnus@tracsrv.local/git/foo.git/info/refs?service=3Dgit-receive=
-pack
>=20
> AFAICS this means the man-page is wrong, and that I instead ought to
> match on the "service=3Dgit-receive-pack" part.  Is that a correct
> conclusion?

Yes, it is.

I have tried to do the same anonymous read and authenticated write
in "smart HTTP" access in Apache.  There are some proposals[1],
all I think which use mod_rewrite (as LocationMatch doesn't take
query string into account, unfortunately), but I haven't been able
to make it work.

The problem is that both POST *and GET* (to get refs) must be authethic=
ated.

Nb. I thought that it was corrected... which git version do you use?

[1]: http://paperlined.org/apps/git/SmartHTTP_Ubuntu.html


In the end I have worked around this by allowing all registered users t=
o
read with "require valid-user" (which in my situation might be even mor=
e
correct solution; the case being repositories for Computer Science clas=
s
lab work), and restricting write via pre-receive hook which checks
REMOTE_USER.

--=20
Jakub Nar=C4=99bski

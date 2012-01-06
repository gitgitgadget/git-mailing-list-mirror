From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Handling of non-UTF8 data in gitweb
Date: Fri, 6 Jan 2012 17:35:31 +0100
Message-ID: <201201061735.32908.jnareb@gmail.com>
References: <201112041709.32212.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 17:35:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjClh-0006Ge-6M
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 17:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367Ab2AFQfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 11:35:43 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49042 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab2AFQfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 11:35:42 -0500
Received: by eekc4 with SMTP id c4so1172699eek.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 08:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=lUeM4SxC7oRUN9orXLExxNjw05PzrYA6LqvhO+9kIFg=;
        b=HwrXDvYeOnHi+eqZ7f4YdzUXp8pzk+FA9aBhCbTA3OtbwkxJK4vC7jbWi1apPE91Bm
         jHfrrKp6jmHqPvSQBH8xOxM5Sg0XWAkLfZk4xyAMTESQImwEDJiiQPZw+Lab9FpJJpLy
         vyVbTeki8phGcZwgr4+iCrR1CxKITSxqBT2K0=
Received: by 10.14.29.77 with SMTP id h53mr2581696eea.51.1325867740026;
        Fri, 06 Jan 2012 08:35:40 -0800 (PST)
Received: from [192.168.1.13] (abwd1.neoplus.adsl.tpnet.pl. [83.8.227.1])
        by mx.google.com with ESMTPS id b49sm218579849eec.9.2012.01.06.08.35.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Jan 2012 08:35:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201112041709.32212.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188034>

On Sun, 4 Dec 2011, Jakub Narebski wrote:
>=20
> Currently gitweb converts data it receives from git commands to Perl=20
> internal utf8 representation via to_utf8() subroutine
[...]
> Each part of data must be handled separately.  It is quite error pron=
e
> process, as can be seen from quite a number of patches that fix handl=
ing
> of UTF-8 data (latest from J=C3=BCrgen).
>=20
>=20
> Much, much simpler would be to force opening of all files (including=20
> output pipes from git commands) in ':utf8' mode:
>=20
>   use open qw(:std :utf8);
>=20
> [Note: perhaps instead of ':utf8' it should be ':encoding(UTF-8)'=20
>  there...]
>=20
> But doing this would change gitweb behavior.  [...]
[...]
> I don't know if people are relying on the old behavior.  I guess
> it could be emulated by defining our own 'utf-8-with-fallback'
> encoding, or by defining our own PerlIO layer with PerlIO::via.
> But it no longer be simple solution (though still automatic).

I have now created simple Encode::UTF8WithFallback module, so that

  use Encode::UTF8WithFallback;
  use open IN =3D> ':encoding(utf8-with-fallback)';

should be able to replace all calls to to_utf8() without any change
in behavior; at least simple tests shows that.


There however are two problems with this solution:

1. Encode::UTF8WithFallback should really be a separate Perl module
   in a separate file (e.g. 'gitweb/lib/Encode/UTF8WithFallback.pm');
   I was not able to make it work without a separate file.

   This means that it very much requires the change that allows splitti=
ng
   gitweb into many files and/or load extra helper modules, and/or requ=
ire
   extra non-core modules but provide and install them with gitweb if t=
hey
   are not available.  These changes are ready, and can be find in=20

     'gitweb/split'
  =20
   branch in my git.git repositories:

     http://repo.or.cz/w/git/jnareb-git.git
     https://github.com/jnareb/git


2. It turned out that the "open" pragma 1.04 from Perl v5.8.6 does not
   work correctly.  We need at least "open" 1.06 (version 1.05 consists
   supposedly only of documentation-only change).

   Because "open" is a core Perl module (core pragma), this means that
   gitweb will require in practice Perl v5.8.9 at least, increasing
   version requirement from current v5.8.0
=20
--=20
Jakub Narebski
Poland

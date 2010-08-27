From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Reduce zlib deflate code duplication
Date: Thu, 26 Aug 2010 18:56:40 -0700
Message-ID: <AANLkTikxxxxZwty156XG13QsOoimzYzuxSuTcf5KonTE@mail.gmail.com>
References: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 03:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OooBw-0002zu-Hc
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 03:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab0H0B5C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 21:57:02 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41332 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab0H0B5B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 21:57:01 -0400
Received: by iwn5 with SMTP id 5so2106238iwn.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 18:57:00 -0700 (PDT)
Received: by 10.231.80.213 with SMTP id u21mr191153ibk.173.1282874220085; Thu,
 26 Aug 2010 18:57:00 -0700 (PDT)
Received: by 10.231.179.143 with HTTP; Thu, 26 Aug 2010 18:56:40 -0700 (PDT)
In-Reply-To: <1282856164-5126-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154572>

2010/8/26 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Most of deflation code is simply "given this buffer, just deflate
> it". Make a common routine and reuse it instead.
>
> Exceptions include index-pack, http-push, fast-import,
> write_sha1_file, which either make multiple zlib streams, or compress
> and calculate sha1/checksum in parallel.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0There is possibly a regression here. remote-curl.c/post_rpc()
> =C2=A0specifies more compression options, although I doubt it affects
> =C2=A0performance. It also reveals places where deflation is expected
> =C2=A0to be always successful.

It is a regression.

The compression options in remote-curl.c are to setup a gzip style
stream, because that is what the servers expect.  Your new common
routine is using the bare deflation stream, which isn't the same
header/footer formatting, and thus servers will choke with your change
and smart HTTP payloads that are compressed by the client.

So yea, you can't get rid of all of those options for the remote-curl
init.  You'll need to still let remote-curl setup its options itself,
and then pass you the zlib structure to deflate on.

--=20
Shawn.

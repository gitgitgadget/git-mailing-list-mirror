From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC/PATCH 1/8] compat: provide a fallback va_copy definition
Date: Thu, 24 Feb 2011 16:57:04 +0100
Message-ID: <AANLkTin7NBx5NVRkHpgymcZfnaZaJehMMpPv=zD+cKtV@mail.gmail.com>
References: <20110224142308.GA15356@sigill.intra.peff.net> <20110224142647.GA15477@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psdnl-0005VQ-2X
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab1BXQMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 11:12:20 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52110 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1BXQMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 11:12:19 -0500
Received: by bwz15 with SMTP id 15so1156622bwz.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MBVFDmjprD9PMgsUBJLsOMs7qefimWXMQAGgDAVEGB4=;
        b=Zy3OWSzTNbADkE85+mPe0wv6NA7MeJFauYSbUudwot/az9Yn/FSLCicpN7f3SPTGVS
         101BPPt7A0HxbltyqjCz/8/QNGzoLh3JnouDmP9n9hpGtsMNLMxqgxfX4Zi+DIrnNqBB
         JroMhzvRxgsr6Z140TbXCPuWdnppkI59OKnGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=NCnpJbUaFX+jwst5jQnQyVdA4BEnswWhpM/sLi7JBe43iSDeBazVk5InitBATao0HU
         lRRd/VX8D9OAPzT6bqT/TYrw+XaWKH924MTSUcVM+Hs/qbkC9o3vMuvlntPEB1hIoqDj
         h+1slXkZ3TF+gBNk3A+ZDdnMfiYk395PIE8aA=
Received: by 10.223.101.134 with SMTP id c6mr1252468fao.12.1298563421699; Thu,
 24 Feb 2011 08:03:41 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Thu, 24 Feb 2011 07:57:04 -0800 (PST)
In-Reply-To: <20110224142647.GA15477@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167833>

On Thu, Feb 24, 2011 at 3:26 PM, Jeff King <peff@peff.net> wrote:
> va_copy is C99. Prior to this, the usual procedure was to
> simply copy the va_list by assignment.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We have avoided using va_copy many times in the past, which has led t=
o a
> bunch of cut-and-paste. From everything I found searching the web,
> implementations have historically either provided va_copy or just let
> your code assume that simple assignment of worked. I couldn't find an=
y
> mention of any other alternatives.
>
> So my guess is that this will be sufficient, but I we won't really kn=
ow
> for sure until somebody reports a problem. :(
>
> =A0git-compat-util.h | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9c23622..00d41e4 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -535,6 +535,10 @@ void git_qsort(void *base, size_t nmemb, size_t =
size,
> =A0#define fstat_is_reliable() 1
> =A0#endif
>
> +#ifndef va_copy
> +#define va_copy(dst,src) (dst) =3D (src)
> +#endif
> +

Wouldn't it be even more portable to fall back on use __va_copy (if
present), as suggested by Junio in
<7vbpip86q5.fsf@alter.siamese.dyndns.org>? He also suggested using
memcpy instead of assignment in the same e-mail, due to a
recommendation in the Autoconf manual.

There's already a va_copy fall-back in compat/msvc.h, perhaps this
should be removed?

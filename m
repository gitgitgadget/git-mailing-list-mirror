From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix esc_param
Date: Wed, 14 Oct 2009 11:03:18 +0200
Message-ID: <200910141103.19295.jnareb@gmail.com>
References: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com> <cb7bb73a0910132319p27b4f362sf5bffa2afe6e5849@mail.gmail.com> <4AD56FD9.70602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:05:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxznG-0001FD-Go
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247AbZJNJEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 05:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758226AbZJNJEF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:04:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:64318 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757843AbZJNJEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:04:02 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1262393fgg.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=moVW7cd47PYJmXLgcw7uf4tWyalea3Ba/lLGQQySTTY=;
        b=tigaL2Ao9d4C3lIdW1EDLwW2SkK9/zj2CoV4J4rl89HTij3bQdpMHgO7GcJUFMGEEt
         WQNQ3jlK0H3z1eNcoThutXKrGVKvGnF2Hyg6redIDFmIILS2zo/4TGtG6KYuf83T+YA6
         1+uV6os9f2D6ekLuLMxeWZj+OaFjRAxeyHJxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wIt3DDdPV+TKsFbZyz3QJAuSMskZ36i5xCKm0zvb2p+2NOsTxR1urtblxeV7yCHcgd
         J1bgxZumfuvZysx6L9jntOcxkI4KH0tjXkx2jJ0R4DAzO/5eDYHBRAjZkJxuTsEZbyCy
         a+pYoi7huAppuyMbuCq+TNtMNGSozUNZa/kCI=
Received: by 10.86.227.26 with SMTP id z26mr2372336fgg.76.1255510934582;
        Wed, 14 Oct 2009 02:02:14 -0700 (PDT)
Received: from ?192.168.1.13? (abvb70.neoplus.adsl.tpnet.pl [83.8.199.70])
        by mx.google.com with ESMTPS id l12sm1827401fgb.2.2009.10.14.02.02.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 02:02:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4AD56FD9.70602@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130267>

On Wed, 14 Oct 2009, Stephen Boyd wrote:
> Giuseppe Bilotta wrote:
>> On Wed, Oct 14, 2009 at 3:13 AM, Stephen Boyd <bebarino@gmail.com> w=
rote:
>>
>>> This works great for my purposes. Thanks.
>>>
>> Can you also check if this fixes the branch name issue you mentioned
>> in the other branch? (And/or do you have a repository exposing the
>> problem if not?)
>=20
> (We're jumping back and forth between threads haha)
>=20
> Sorry, it doesn't. But this diff fixes the first part of the problem.
> There are still problems with the RSS/Atom feed names being mangled. =
The
> branch name I'm using is gitw=E9b, but I imagine any utf8 character w=
ill fail.

That it is (probably) not because of lack of esc_html, but because
of lack of to_utf8.  Grrr... we really should convert to utf8 (usually
just mark as utf8) on reading input, to avoid such kind of errors.

>=20
> I see the title and the actual text being mangled without this patch.
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4b21ad2..910c370 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1500,9 +1500,10 @@ sub format_ref_marker {
>                                 -href =3D> href(
>                                         action=3D>$dest_action,
>                                         hash=3D>$dest
> -                               )}, $name);
> +                               )}, esc_html($name));

Hmmm... to_utf8 would be enough here, but for the fact that=20
git-check-ref-format doesn't prohibit '<', '>' in ref names,=20
so it is possible that somebody somewhere is using such strange
ref names (e.g. branch named '<b>' is valid branch name).

> =20
> -                       $markers .=3D " <span class=3D\"$class\" titl=
e=3D\"$ref\">" .
> +                       my $title_ref =3D esc_html($ref);
> +                       $markers .=3D " <span class=3D\"$class\" titl=
e=3D\"$title_ref\">" .

Here it would be really useful to have esc_attr (which would do to_utf8
plus escaping of '"' and '%', quote and escape characters), although
I guess that full HTML escaping done with esc_html wouldn't do anything
bad.

>                                 $link . "</span>";
>                 }
>         }

--=20
Jakub Narebski
Poland

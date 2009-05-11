From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 3/4] gitweb: Simplify snapshot format detection logic in 
	evaluate_path_info
Date: Mon, 11 May 2009 19:52:23 +0200
Message-ID: <cb7bb73a0905111052g4f3f7e23yfbe54bf3cb3e2518@mail.gmail.com>
References: <20090511173025.15152.94215.stgit@localhost.localdomain>
	 <20090511173950.15152.61267.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 19:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Zg5-0003JA-M4
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 19:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbZEKRwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZEKRwZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 13:52:25 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:50476 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbZEKRwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 13:52:24 -0400
Received: by bwz22 with SMTP id 22so2812030bwz.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O3O98VBRamN/1pwcsi19q05d0xkLkom7ngWouNk9DBU=;
        b=uWO6PDbdLPrLGhr6H3jIR98zOIuyu2AFXRNE7YUU+Twm0vy/Xi+sOKWJ+MZ/Pc/OkI
         QX7OgQCm0ZnRNM2HCGGV9KvCly4Ebe/7bKOOFs3UDl6hkQXtQcyTlkJUW4LMRaRhJTmD
         0weu8+1eqdWhOXINBWnhl+HUYEmzr0vORO+ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uLKEeVWQhq/8eOhqeVmOU1F7crYsbilt+SGu+SYsXVn9hkr3fPIgI5aoNDqC95iKbX
         TYi91vPzoPuzfg/cuBlKNVueb9IxNOPOiOgPdW3bTizvATg1RGV3Vm0pWnE+mKx+RrNX
         wUX1fBqfFLwsDhydj107oJdak9wwnc02uE2/w=
Received: by 10.204.115.139 with SMTP id i11mr7120390bkq.199.1242064343173; 
	Mon, 11 May 2009 10:52:23 -0700 (PDT)
In-Reply-To: <20090511173950.15152.61267.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118817>

On Mon, May 11, 2009 at 7:42 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> This issue was caught by perlcritic in harsh severity level noticing
> that catch variable was used outside conditional thanks to the
> Perl::Critic::Policy::RegularExpressions::ProhibitCaptureWithoutTest
> policy. =A0See "Perl Best Practices", chapter 12. Regular Expressions=
,
> section 12.15. Captured Values:
>
> =A0 Pattern matches that fail never assign anything to $1, $2, etc.,
> =A0 nor do they leave those variables undefined. After an unsuccessfu=
l
> =A0 pattern match, the numeric capture variables remain exactly as th=
ey
> =A0 were before the match was attempted.
>
> New version is in my opinion much easier to understand; previous
> version worked correctly due to the fact that we returned from loop
> on first found match.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is not the only place caught by this policy, but this is the one
> where fix was obviously needed to improve readibility of code.
>
> In _most_ (but not all) of other places we assume that output we pars=
e
> is in given format, and that regexp would always match...
>
> =A0gitweb/gitweb.perl | =A0 =A07 ++++---
> =A01 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 097bd18..c72ae10 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -690,9 +690,10 @@ sub evaluate_path_info {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# format key itself, with a prepended =
dot
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (my ($fmt, $opt) =3D each %known=
_snapshot_formats) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $hash =3D $refname;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $sfx;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $hash =3D~ s/(\Q$opt->{=
'suffix'}\E|\Q.$fmt\E)$//;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next unless $sfx =3D $1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unless ($hash =3D~ s/(\=
Q$opt->{'suffix'}\E|\Q.$fmt\E)$//) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $sfx =3D $1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# a valid suffix was f=
ound, so set the snapshot format
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# and reset the hash p=
arameter
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$input_params{'snapsho=
t_format'} =3D $fmt;

Totally mea culpa on this, I was optimizing it the wrong way.

Acked-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>


--=20
Giuseppe "Oblomov" Bilotta

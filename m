From: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH 17/18] Place the open() call inside the do{} struct and
 prevent failing close
Date: Thu, 06 Jun 2013 23:30:29 +0200
Message-ID: <51B0FF75.9070506@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr> <1370547263-13558-18-git-send-email-celestin.matte@ensimag.fr> <7vhahbx7r7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:30:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkhlZ-0004j0-Oj
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab3FFVah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 17:30:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46631 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab3FFVag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 17:30:36 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r56LUOmv031036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 23:30:24 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56LUR2S022526;
	Thu, 6 Jun 2013 23:30:27 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56LUQ0r027165;
	Thu, 6 Jun 2013 23:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vhahbx7r7.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 06 Jun 2013 23:30:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56LUOmv031036
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371159028.3144@zUALsCg+OGNDJ9QiQHJytw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226563>

Le 06/06/2013 23:13, Junio C Hamano a =C3=A9crit :
> Confused.  Which part of this patch moves open inside a do{} block?
> This was last touched by [9/18] but it doesn't do any such thing,
> either.

I must have failed the rebase, as the first part of the commit moved to
[14/18] because it modifies a part of it:
>@@ -344,10 +344,10 @@ sub get_mw_pages {
> #        $out =3D run_git("command args", "raw"); # don't interpret
>output as UTF-8.
> sub run_git {
> 	my $args =3D shift;
>-	my $encoding =3D (shift || "encoding(UTF-8)");
>-	open(my $git, "-|:$encoding", "git " . $args)
>-	    or die "Unable to open: $!\n";
>-	my $res =3D do {
>+	my $encoding =3D (shift || 'encoding(UTF-8)');
>+	my $res =3D do {
>+		open(my $git, "-|:$encoding", "git ${args}")
>+		    or die "Unable to fork: $!\n";
> 		local $/ =3D undef;
> 		<$git>
> 	};
I'm not sure how I should correct this. I'll have a look if this commit
actually is useful.

> Upon leaving this subroutine, $git filehandle will go out of scope,
> so in that sense, close may not be necessary, but that does not
> match what the proposed log message claims what the patch does.
>=20
> Also, this patch does not remove "or die" 9/18 added, even though
> the proposed log message claims that with autodie it is no longer
> necessary.
>=20
> I am not convinced that using autodie globally, without vetting the
> calls the original code make, is a good idea in the first place.
> How does this change interact with existing calls to open, close,
> etc. that check the return value from them, now these calls throw
> exception and will not give a chance for the existing error handling
> codepath to intervene?

So using autodie may not be a good idea.
But the problem is that in the current state, open() return values are
checked, but print ones are not, although it should be. So, either:
- we use autodie and remove checking of existing return values, or
- we don't use autodie and add checking of return value of print calls
- or I'm missing some point :)


--=20
C=C3=A9lestin Matte

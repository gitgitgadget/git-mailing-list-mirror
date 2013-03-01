From: =?utf-8?Q?Jan_Pe=C5=A1ta?= <jan.pesta@certicon.cz>
Subject: RE: [PATCH] In inproperly merges, the ranges contains additional character "*"
Date: Fri, 1 Mar 2013 22:37:24 +0100
Message-ID: <001001ce16c4$f7265a50$e5730ef0$@certicon.cz>
References: <002101ce1681$4f261090$ed7231b0$@certicon.cz> <7v1ubzgg4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	"'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 22:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBXeI-0000Rl-32
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 22:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab3CAVhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Mar 2013 16:37:25 -0500
Received: from service.certicon.cz ([90.183.112.10]:1361 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3CAVhY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Mar 2013 16:37:24 -0500
Received: from miami (ip-89-103-254-63.net.upcbroadband.cz [89.103.254.63])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id 21B181707E7;
	Fri,  1 Mar 2013 22:37:20 +0100 (CET)
In-Reply-To: <7v1ubzgg4e.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGDAUZlWbFLEuqeP/eqLmKXC+L1UQFqOja0mRw1L7A=
Content-Language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: 21B181707E7.A410A
X-certicon-MailScanner: Found to be clean
X-certicon-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.2, required 5.1, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80)
X-certicon-MailScanner-From: jan.pesta@certicon.cz
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217294>

Hi Junio,

You have right. But I think if there is a "*" sign, it should be skiped=
, instead of failing on comparing string with a number.

I will prepare another patch.

Regards,
Jan

Kind regards / S pozdravem
=20
Jan Pe=C5=A1ta
SW Engineer Sr.

CertiCon a.s., www.certicon.cz
Vaclavska 12
12000 Prague 2
Czech Republic
=20
Office Prague: +420 224 904 406
Mobile: +420 604 794 306
=20
E-mail: jan.pesta@certicon.cz

-----Original Message-----
=46rom: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On=
 Behalf Of Junio C Hamano
Sent: Friday, March 01, 2013 6:55 PM
To: Jan Pe=C5=A1ta
Cc: git@vger.kernel.org; 'Matthieu Moy'
Subject: Re: [PATCH] In inproperly merges, the ranges contains addition=
al character "*"

Jan Pe=C5=A1ta <jan.pesta@certicon.cz> writes:

> In inproperly merges, the ranges contains additional character "*".

Thanks, but -ECANNOTPARSE.  What are "inproperly merges"?

> See http://www.open.collab.net/community/subversion/articles/merge-in=
fo.html
> Extract:
> The range r30430:30435 that was added to 1.5.x in this merge has a '*=
'
> suffix for 1.5.x\www.
> This '*' is the marker for a non-inheritable mergeinfo range.
> The '*' means that only the path on which the mergeinfo is explicitly=
 set
> has had this range merged into it.

If I am reading the above correctly, blindly removing '*' from the
range will record a wrong merge in the result, because on the SVN
side only the history of part of the tree is merged but we represent
the result as a full merge (and Git only records full merge of
histories), no?

My gut feeling tells me that failing the import, saying "We cannot
represent this history", might be a more honest and safe thing to
do.

> Signed-off-by: Jan Pesta <jan.pesta@certicon.cz>
> ---
>  perl/Git/SVN.pm | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 0ebc68a..6bd18e9 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1493,6 +1493,7 @@ sub lookup_svn_merge {
>  	my @merged_commit_ranges;
>  	# find the tip
>  	for my $range ( @ranges ) {
> +		$range =3D~ s/[*]$//;
>  		my ($bottom, $top) =3D split "-", $range;
>  		$top ||=3D $bottom;
>  		my $bottom_commit =3D $gs->find_rev_after( $bottom, 1, $top );

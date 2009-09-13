From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [RFC/PATCH v4 2/2] gitweb: append short hash ids to snapshot
 files
Date: Sun, 13 Sep 2009 01:39:56 -0400
Message-ID: <4AAC85AC.9080004@mailservices.uwaterloo.ca>
References: <4AAC2917.6000306@mailservices.uwaterloo.ca> <7v7hw34ivl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 07:40:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmhon-0007L2-Hk
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 07:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbZIMFj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2009 01:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZIMFj6
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 01:39:58 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:57013 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750867AbZIMFj5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 01:39:57 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8D5dui4005867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Sep 2009 01:39:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <7v7hw34ivl.fsf@alter.siamese.dyndns.org>
X-UUID: c7250a01-89df-4614-be4d-21d174f17c85
X-Miltered: at mailchk-m05 with ID 4AAC85AC.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Sun, 13 Sep 2009 01:39:58 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128336>

On 09-09-12 11:35 PM, Junio C Hamano wrote:
>> @@ -5207,6 +5227,12 @@ sub git_snapshot {
>> ...
>> +
>> +	if ($full_hash !~ /$hash/) {
>> +		$hash .=3D '-' . git_get_short_hash($project, $hash);
>> +	} else {
>> +		$hash =3D git_get_short_hash($project, $hash);
>> +	}
>=20
> I do not get this test.  What is this unanchored pattern match about?

I missed that, it should have been anchored.

> I do not think you wanted to allow matching a partial 1234567 $hash t=
o
> substitute a full 01234567..... $full_hash, so I am guessing that you
> meant to say "$full_hash !~ /^$hash/" at least, or perhaps you meant =
even
> "$full_hash ne $hash".
>=20
> But that still does not make much sense to me.  Perhaps you meant to =
catch
> a case where $hash is a tagname (or refname), i.e. $hash =3D 'v1.6.3'=
 or
> $hash =3D 'next'?
>=20
> If that is indeed the case, then perhaps you should check for that mo=
re
> explicitly, perhaps using "git show-ref $hash" or something.  I do no=
t
> know if the complexity (not just the "detect handcrafted $hash string=
 that
> is not an SHA-1", but this whole "give shorten one" topic) is worth i=
t,
> though.  And if you drop the hunk that changes user supplied $hash to
> $full_hash in the output file name in your [PATCH 1/2], I do not thin=
k you
> need this anyway.  If somebody asked for 'next', he will get 'next'.
>=20
> If somebody asked for 01234... (full 40 hexdigits) because that was t=
he
> link on the gitweb output page, it might make sense to give him a
> shortened name, but then the above conditional needs to be only:
>=20
> 	if ($full_hash eq $hash) {
>         	$hash =3D git_get_short_hash($project, $hash);
> 	}
>=20
> no?

This was a manifestation of a suggestion from Jakub:
> Second, I'd rather have better names for snapshots than using full SH=
A-1.
> For snapshot of 'v1.5.0' of repository 'repo.git' I'd prefer for snap=
shot
> to be named 'repo-v1.5.0', and for snapshot of 'next' branch of the s=
ame
> project to be named for example 'repo-next-20090909', or perhaps
> 'repo-next-2009-09-10T09:16:18' or 'repo-next-20090909-g5f6b0ff',
> or 'repo-v1.6.5-rc0-164-g5f6b0ff'.
>=20
> I'm not sure what would be the best name of snapshot of given=20
> subdirectory...
>=20
>=20
> In short: I'd rather not improve on bad design of using full SHA-1
> in snapshot name.

=46or me, there are two fates that snapshots will end up with: being de=
leted
as soon as I have unrolled the contents, or long term archiving. For th=
e
latter case, it is nice to have an idea of when it came from, though I
guess I should have appended a date in that case... =AF\(=B0_o)/=AF

Thoughts?


>> +test_commit \
>> +	'SnapshotFileTests' \
>> +	'i can has snapshot?'
>> +test_expect_success \
>> +	'snapshots: give full hash' \
>> +	'ID=3D`git rev-parse --verify HEAD` &&
>> +	gitweb_run "p=3D.git;a=3Dsnapshot;h=3D$ID;sf=3Dtgz" &&
>> +	ID=3D`git rev-parse --short HEAD` &&
>> +	grep ".git-$ID.tar.gz" gitweb.output'
>=20
> I'd rather see these indented like:
>=20
>         test_expect_success 'snapshots: give full hash' '
> 		ID=3D$(git rev-parse --verify HEAD) &&
> 		gitweb_run ...
>         '
>=20
> Also, if I am not mistaken, "test_commit" is not about doing any test=
, but
> is a short-hand for doing an operation, right?  It would be better to=
 have
> it inside test_expect_success just in case your "git commit" or some =
other
> commands are broken.  I.e. like
>=20
> 	test_expect_success 'create a test commit' '
> 		test_commit SnapshotFileTests "Can I have shapshot?"
>         '

Can I have snapshot?!?! What do you have against LOLspeak? :P


--=20
Mark Rada (ferrous26)
marada@uwaterloo.ca

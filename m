From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv4 3/3] Advices about 'git rm' during conflicts (unmerged
 paths) more relevant
Date: Wed, 30 May 2012 23:50:48 +0200
Message-ID: <20120530235048.Horde.jSNYW3wdC4BPxpY4izr11PA@webmail.minatec.grenoble-inp.fr>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vipfdzeyu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 23:50:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqnB-0002rA-SC
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067Ab2E3Vuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 17:50:54 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:47365 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756990Ab2E3Vux (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 17:50:53 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 334731A02E9;
	Wed, 30 May 2012 23:50:49 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Wed, 30 May
 2012 23:50:48 +0200
In-Reply-To: <7vipfdzeyu.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198839>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> +		if (d->stagemask =3D=3D 1 && !both_deleted_flag)
>> +			both_deleted_flag =3D 1;
>> +		else if ((d->stagemask =3D=3D 3 || d->stagemask =3D=3D 5) && =20
>> !simple_deleted_flag)
>> +			simple_deleted_flag =3D 1;
>> +		else if ((d->stagemask =3D=3D 2 || d->stagemask =3D=3D 4 || d->st=
agemask =3D=3D 6 ||
>> +				d->stagemask =3D=3D 7) && !not_deleted_flag)
>> +			not_deleted_flag =3D 1;
>> +	}
>
> 	switch (d->stagemask) {
>         case 1:
>         	both_deleted =3D 1;
>                 break;
>         case 3:
>         case 5:
>         	simple_deleted =3D 1;
>                 break;
>         default:
>         	not_deleted =3D 1;
>                 break;
> 	}

Yes, using switch makes the code easier to read. In fact, I put explici=
tly the
condition when there are no delete (cases 2, 4, 6 and 7) because there =
=20
are cases
when d->stagemask can take other number than 1..7. For example:

git init git &&
cd git &&
test_commit foo main.txt foo &&
git branch second_branch &&
git mv main.txt sub_master.txt &&
git commit -m "main.txt renamed in sub_master.txt" &&
git checkout second_branch &&
git mv main.txt sub_second.txt &&
git commit -m "main.txt renamed in sub_second.txt" &&
git merge master &&
git add sub_master.txt &&
git add sub_second.txt

At this point, the output of git status shows in unmerged paths the =20
file main.txt
that is marked as 'both deleted' so the number of elements in =20
s->change.items should
be 1. However, in this case, there are 2 elements. One is about the =20
file main.txt and
its stagemask is '1' (as expected) but the stagemask of the other =20
element (I don't
know its origin) is '0'.
Anyway, the new code becomes something like:

switch (d->stagemask) {
case 0:
	break;
case 1:
	both_deleted =3D 1;
	break;
case 3:
case 5:
	del_mod_conflict =3D 1;
	break;
default:
	not_deleted =3D 1;
	break;
}

Though I don't know if d->stagemask can take values such as 8, 9, etc.

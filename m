From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Thu, 10 Feb 2011 19:50:35 +0100
Message-ID: <4D54337B.6040307@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx> <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx> <7v1v3wd1al.fsf@alter.siamese.dyndns.org> <4D437CA0.1070006@lsrfire.ath.cx> <7vsjwcb6rh.fsf@alter.siamese.dyndns.org> <4D4477E4.6020006@lsrfire.ath.cx> <7vk4hbsbjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 19:50:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnbbO-0001iD-VR
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 19:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab1BJSup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 13:50:45 -0500
Received: from india601.server4you.de ([85.25.151.105]:38289 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab1BJSuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 13:50:44 -0500
Received: from [192.168.2.103] (p4FFDAF81.dip.t-dialin.net [79.253.175.129])
	by india601.server4you.de (Postfix) with ESMTPSA id 962A52F804F;
	Thu, 10 Feb 2011 19:50:42 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vk4hbsbjr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166491>

Am 07.02.2011 23:51, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-re=
v-list-graph-simplify-history.sh
>> index f7181d1..50ffcf4 100755
>> --- a/t/t6016-rev-list-graph-simplify-history.sh
>> +++ b/t/t6016-rev-list-graph-simplify-history.sh
>> @@ -168,6 +168,7 @@ test_expect_success '--graph --full-history --si=
mplify-merges -- bar.txt' '
>>   	echo "|\\  ">>  expected&&
>>   	echo "| * $C4">>  expected&&
>>   	echo "* | $A5">>  expected&&
>> +	echo "* | $A4">>  expected&&
>>   	echo "* | $A3">>  expected&&
>>   	echo "|/  ">>  expected&&
>>   	echo "* $A2">>  expected&&
>
> Thanks for a patch with a test; I am not sure if this is quite correc=
t,
> though.
>
> A4 has three parents, C2, A3 and B2, and does not introduce any chang=
e
> with respect to bar.txt.  A6 has bar.txt identical to that of A5, but=
 we
> cannot omit it because we are showing its two parents (A5 and C4), an=
d
> that is why we show it.  A4 isn't even gets shown as a merge, so I do=
n't
> understand why we need to show it?

Yes, this looks a bit silly on closer look.  I thought that it matches=20
=46rancis' use case, but that's wrong -- having --simplify-merges inste=
ad=20
of -Sstring makes a difference, obviously.

After looking at the case again, I think I have a simpler solution: no=20
code change, just add --sparse (include all walked commits).  This give=
s=20
the same results as the patched version:

	$ git log --oneline -m --sparse --full-history \
		-Sblacklist_iommu v2.6.26..v2.6.29 -- \
		drivers/pci/intel-iommu.c | wc -l
	    160

Sorry for the noise.

So, the lesson would be: If you want to find commits that removed a=20
certain string in a certain set of files, add --full-history, -m and=20
--sparse to your "git log -Sstring -- files" command.  This allows you=20
to catch merges that reverted those files to a state before the string=20
was introduced in the first place, otherwise history simplification can=
=20
hide them.

I'm not sure if there's a way to make the flags and their interactions=20
more intituitive.

Ren=C3=A9

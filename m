From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 20:17:26 +0200
Message-ID: <4E8607B6.2040800@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org> <4E8587E8.9070606@lsrfire.ath.cx> <7vfwjeotv1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 20:17:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9hea-00059V-HY
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 20:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab1I3SRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 14:17:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:55552 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714Ab1I3SRj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 14:17:39 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id C31642F803A;
	Fri, 30 Sep 2011 20:17:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <7vfwjeotv1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182497>

Am 30.09.2011 18:52, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Hi Martin,
>>
>> Am 29.09.2011 22:11, schrieb Martin Fick:
>>> Your patch works well for me.  It achieves about the same=20
>>> gains as Julian's patch. Thanks!
>>
>> OK, and what happens if you apply the following patch on top of my f=
irst
>> one?  It avoids going through all the refs a second time during clea=
nup,
>> at the cost of going through the list of all known objects.  I wonde=
r if
>> that's any faster in your case.
>> ...
>>  static void describe_one_orphan(struct strbuf *sb, struct commit *c=
ommit)
>> @@ -690,8 +689,7 @@ static void orphaned_commit_warning(struct commi=
t *commit)
>>  	else
>>  		describe_detached_head(_("Previous HEAD position was"), commit);
>> =20
>> -	clear_commit_marks(commit, -1);
>> -	for_each_ref(clear_commit_marks_from_one_ref, NULL);
>> +	clear_commit_marks_for_all(ALL_REV_FLAGS);
>>  }
>=20
> The function already clears all the flag bits from commits near the t=
ip of
> all the refs (i.e. whatever commit it traverses until it gets to the =
fork
> point), so it cannot be reused in other contexts where the caller
>=20
>  - first marks commit objects with some flag bits for its own purpose=
,
>    unrelated to the "orphaned"-ness check;
>  - calls this function to issue a warning; and then
>  - use the flag it earlier set to do something useful.
>=20
> which requires "cleaning after yourself, by clearing only the bits yo=
u
> used without disturbing other bits that you do not use" pattern.

Yes, clear_commit_marks_for_all is a bit brutal.  Callers could clear
specfic bits (e.g. SEEN|UNINTERESTING) instead of ALL_REV_FLAGS, though=
=2E

> It might be a better solution to not bother to clear the marks at all=
;
> would it break anything in this codepath?

Unfortunately, yes; the cleanup part was added by 5c08dc48 later, when
it become apparent that it's really needed.

However, since the patch only buys us a 5% speedup I'm not sure it's
worth it in its current form.

Ren=C3=A9

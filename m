From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Make local branches behave like remote branches when
 --tracked
Date: Fri, 27 Mar 2009 09:47:01 +0100
Message-ID: <49CC9285.407@drmicha.warpmail.net>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org> <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net> <1238100805-19619-2-git-send-email-git@drmicha.warpmail.net> <1238100805-19619-3-git-send-email-git@drmicha.warpmail.net> <7vprg3fkw8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 09:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln7kg-0005UD-2y
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 09:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbZC0IrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 04:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754385AbZC0IrO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 04:47:14 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45509 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743AbZC0IrL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 04:47:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 412252F5936;
	Fri, 27 Mar 2009 04:47:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 27 Mar 2009 04:47:08 -0400
X-Sasl-enc: mLdnpNymVhBapeIOTWvs64qpIKyi1Wfx85RgrhsYEdVr 1238143627
Received: from localhost.localdomain (p4FC63422.dip0.t-ipconnect.de [79.198.52.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 12B8720FCB;
	Fri, 27 Mar 2009 04:47:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vprg3fkw8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114873>

Junio C Hamano venit, vidit, dixit 27.03.2009 09:08:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>=20
>> This makes sure that local branches, when followed using --track, be=
have
>> the same as remote ones (e.g. differences being reported by git stat=
us
>> and git checkout). This fixes 1 known failure.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  remote.c                 |    9 +++++----
>>  t/t6040-tracking-info.sh |    2 +-
>>  2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/remote.c b/remote.c
>> index 2b037f1..5d2d7a1 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1170,8 +1170,9 @@ struct branch *branch_get(const char *name)
>>  			for (i =3D 0; i < ret->merge_nr; i++) {
>>  				ret->merge[i] =3D xcalloc(1, sizeof(**ret->merge));
>>  				ret->merge[i]->src =3D xstrdup(ret->merge_name[i]);
>> -				remote_find_tracking(ret->remote,
>> -						     ret->merge[i]);
>> +				if(remote_find_tracking(ret->remote,
>> +						     ret->merge[i]) && !strcmp(ret->remote_name, "."))
>> +					ret->merge[i]->dst =3D xstrdup(ret->merge_name[i]);
>>  			}
>>  		}
>>  	}
>=20
> Yuck; please have a SP betweeen "if" and "(", and also have a decency=
 to
> break a long line at a more sensible place, like:
>=20
> 			if (remote_find_tracking(ret->remote, ret->merge[i])
> 			    && !strcmp(...))
>                             	then do this;
>=20

Sorry about the space. Regarding the break, you can see that the break
was like that before already, and I just followed suite, which I think
makes the diff more readable. But no problem changing that,

> A na=C3=AFve question from me to this change is why this "fix-up" is =
done here.

It was the easiest and least intrusive way for me...

>=20
> The remote_find_tracking() function is given a half-filled refspec (t=
his
> caller fills the src side, and asks to find the dst side to the funct=
ion).
> After it fails to find a fetch refspec that copies remote refs to tra=
cking
> refs in the local repository that match the criteria, it returns -1 t=
o
> signal an error, otherwise it returns 0 after updating the other half=
 of
> the refspec.
>=20
> After calling r-f-t, because this new code assumes that for the "." r=
emote
> (aka "local repository"), r-f-t lies and does not give back what it
> expects, fixes what it got back from r-f-t.  Shouldn't we be fixing t=
his
> inside r-f-t?

The technical reason is that there is no local remote, i.e. no remote
struct for '.', and I don't think we want it, because it would show up
in all places where the list of remotes is searched/displayed/...

With ret being the branch we talk about, r-f-t is passed ret->remote an=
d
ret->merge[i] only. In the local case, r-f-t cannot use the remote
struct for '.' (there is none) to find what it needs, and it has no eas=
y
access to ret->merge_names[i] which is that info.

branch_get(), on the other hand, has all needed info in place. So,
having r-f-t do it would require changing the parameters or adding a
remote struct for '.' and adjusting all callers correspondingly. Doing
it the way I did it is "minimally invasive" in that respect, with the
(small) downside that we may call r-f-t unnecessarily in the local case
- but we don't know before: If someone set up a remote config for '.'
then we have to go through r-f-t anayways.

>=20
>> @@ -1449,8 +1450,8 @@ int format_tracking_info(struct branch *branch=
, struct strbuf *sb)
>>  		return 0;
>> =20
>>  	base =3D branch->merge[0]->dst;
>> -	if (!prefixcmp(base, "refs/remotes/")) {
>> -		base +=3D strlen("refs/remotes/");
>> +	if (!prefixcmp(base, "refs/")) {
>> +		base +=3D strlen("refs/");
>=20
> I am not sure if this is a good change.  The majority of the case wou=
ld
> be remotes/ and we would be better off not repeating them.  Can't you
> limit the use of longer refs only when disambiguation is necessary?
>=20

The majority will be remotes, yes, but will the majority be unique? In
my case not.  Even when we knew that format_tracking_info() would have
to deal with remote branches only (before this series) there was a
(high) chance of outputting non-unique refs, even worse: if foo is
ambiguous because refs/heads/foo and refs/remotes/foo exist then
refs/heads/foo would win, i.e. we used to output the *wrong* ref. The
above disambiguates. But I'll see if I can simplify the output based on
the necessity of disambiguation.

Michael

From: Thomas Spura <tomspur@fedoraproject.org>
Subject: Re: [PATCH] speed: reuse char instead of recreation in loop
Date: Mon, 25 May 2009 20:40:27 +0000 (UTC)
Message-ID: <pan.2009.05.25.20.40.20@fedoraproject.org>
References: <pan.2009.05.25.19.44.10@fedoraproject.org>
	<20090525201602.GA18471@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 22:40:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8gyV-0004Ja-W2
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 22:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbZEYUkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 16:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZEYUkk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 16:40:40 -0400
Received: from main.gmane.org ([80.91.229.2]:46593 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbZEYUkj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 16:40:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M8gyN-0002Jm-Mn
	for git@vger.kernel.org; Mon, 25 May 2009 20:40:39 +0000
Received: from p5b20e9ac.dip.t-dialin.net ([91.32.233.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 May 2009 20:40:39 +0000
Received: from tomspur by p5b20e9ac.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 May 2009 20:40:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5b20e9ac.dip.t-dialin.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119963>

Am Mon, 25 May 2009 22:16:02 +0200 schrieb Bj=C3=B6rn Steinbrink:

> On 2009.05.25 19:44:10 +0000, Thomas Spura wrote:
>> Move a char and a char * outside of a for loop for speed improvement=
s
>>=20
>> Signed-off-by: Thomas Spura <tomspur@fedoraproject.org> ---
>> Comments?
>>=20
>>  transport.c |    7 +++----
>>  1 files changed, 3 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/transport.c b/transport.c index 17891d5..e350937 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -263,11 +263,10 @@ static int write_refs_to_temp_dir(struct strbu=
f
>> *temp_dir,
>>  		int refspec_nr, const char **refspec)
>>  {
>>  	int i;
>> +	unsigned char sha1[20];
>> +	char *ref;
>> =20
>>  	for (i =3D 0; i < refspec_nr; i++) {
>> -		unsigned char sha1[20];
>> -		char *ref;
>> -
>=20
> I doubt that this makes any difference at all.

With ints, the loop costs about 40% of speed. Without recreation, it=20
should be always faster.

>=20
>>  		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) !
>> =3D 1)
>>  			return error("Could not get ref %s", refspec[i]);
>> =20
>> @@ -275,8 +274,8 @@ static int write_refs_to_temp_dir(struct strbuf
>> *temp_dir,
>>  			free(ref);
>>  			return -1;
>>  		}
>> -		free(ref);
>>  	}
>> +	free(ref);
>=20
> And this now leaks memory.

Hmm, I don't see it atm. Where do you mean?

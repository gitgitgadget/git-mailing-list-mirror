From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] git apply: binary files differ can be applied with -pN
 (N>1).
Date: Thu, 25 Nov 2010 09:46:57 +0800
Message-ID: <4CEDC011.1050503@gmail.com>
References: <4CECA0AE.90505@gmail.com> <7vlj4itz8j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 02:48:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLQwI-0006H5-D5
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 02:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab0KYBrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 20:47:06 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41691 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0KYBrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 20:47:05 -0500
Received: by pva4 with SMTP id 4so92444pva.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 17:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=B8ygz4KfmoDHGb0vnb/ILL2XSD+KoXa4JBypN+2zQQg=;
        b=wkaWt6gYTkEfj9IxkN71RtH5aXGaU0g7y5Tq7ci1NJcdFykk1QOv9piuRpxUZT4pth
         3505jPwzqib0PdjubzYfdFq912dVs7ltQgQqHQzQidXIIwLkSTLX5BfEIYOHfosBlJsO
         jI7kZYzG2+ly8l+EIp4+ROxoXJwSB10f/YIEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=WfgRFoh/GSzsrs8vsnJboKVgdmeMIIiQyh4E+5NT5Ui921Lj1bgf07PAU0/5tj/IDF
         F5xYsPvEUYl/mu9jBON5LrEvA5tNIezawOBpDFfCRWp3pOX2faP2r5lfo5IjLpYzrDN5
         EzRrgQ061D/3LD6P9lfmNVUCU9bZMe4slrXiw=
Received: by 10.142.223.15 with SMTP id v15mr78795wfg.330.1290649623645;
        Wed, 24 Nov 2010 17:47:03 -0800 (PST)
Received: from [192.168.0.50] ([123.115.150.125])
        by mx.google.com with ESMTPS id v19sm213764wfh.0.2010.11.24.17.47.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 17:47:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); zh-CN; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vlj4itz8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162097>


=E4=BA=8E 2010=E5=B9=B411=E6=9C=8825=E6=97=A5 01:20, Junio C Hamano =E5=
=86=99=E9=81=93:
> Jiang Xin <worldhello.net@gmail.com> writes:
>=20
>> When patch file generated against two non-git directories using
>> 'git diff --binary --no-index' without '--no-prefix', the patch
>> file has patch level greater then 1, and should be applied with
>> '-p2' option. But it does not work if there are binary differ
>> in the patch file, it is because in one case the patch level is
>> not properly handled.
>>
>> Signed-off-by: Jiang Xin <jiangxin@ossxp.com>
>=20
> Can you please add a testcase to protect your fix from getting broken=
 by
> later changes by other people, perhaps to t/t4120?
>=20

Yes, I add a testcase in t/t4120, and I will send it as a new PATCH.
The new testcase is like following:

+test_expect_success 'apply git diff with -p2 and use default name from=
 header' '
+       sed -e "/^\(---\|+++\) / d" patch.file > patch.newheader &&
+       cp file1.saved file1 &&
+       git apply -p2 patch.newheader
+'
+

> By the way, this codepath is shared by all forms of patches "diff --g=
it"
> header, not just binary.  Do you see a similar breakage with --no-pre=
fix
> patches that are not binary, and if not why?
>=20

The breakage will appear under these circumstances:
* the patch is in git style: header with "diff --git".
* the header does not contain '--- path/to/old' and '+++ path/to/new'.
* has a patch level greater than 1.

When I do `git diff` against binary files, I find the patch header does=
 not has
'--- path/to/old' and '+++ path/to/new'. May be there exist other cases=
, but
I'm not sure.

>> ---
>>  builtin/apply.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 23c18c5..d603e37 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -1126,6 +1126,7 @@ static char *git_header_name(char *line, int l=
len)
>>  	 * form.
>>  	 */
>>  	for (len =3D 0 ; ; len++) {
>> +		int nslash =3D p_value;
>>  		switch (name[len]) {
>>  		default:
>>  			continue;
>> @@ -1137,7 +1138,7 @@ static char *git_header_name(char *line, int l=
len)
>>  				char c =3D *second++;
>>  				if (c =3D=3D '\n')
>>  					return NULL;
>> -				if (c =3D=3D '/')
>> +				if (c =3D=3D '/' && --nslash <=3D 0)
>>  					break;
>>  			}
>>  			if (second[len] =3D=3D '\n' && !memcmp(name, second, len)) {
>> --=20
>> 1.7.3.2.245.g03276.dirty


--=20
Jiang Xin

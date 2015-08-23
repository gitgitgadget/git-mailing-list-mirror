From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Sun, 23 Aug 2015 19:10:30 +0200
Message-ID: <D3B14EF1-C005-43CE-A3FF-2ABEF879CA01@gmail.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com> <xmqqmvxk5xm9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:10:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTYn4-0002dt-6B
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 19:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbbHWRKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 13:10:38 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37114 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbHWRKh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2015 13:10:37 -0400
Received: by widdq5 with SMTP id dq5so53080640wid.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VWLxhwm1sGWOhyY/goYjDM4AAYu5fp9/AcmzN6r8TWg=;
        b=OnAinVYhrAeYsYOK719DlvDf7M3o32FEinrr/DWs6XMsze2TbGIa3cXRU+v6zm5PzP
         EDNCMe+ArhhufQ+o+Rha5YThsvQDHVM5o220fWViNw0iIInPJikadkMX+YVvOSrzoK60
         sH21c6ZVXiyodQcNemuR0YIODfHaFBxUIV2cdpxrJ0CPGWfbSQVDMyDyxvPLr71AT/Kx
         S14ZnBBnVcU292livni/h9saDgZztuIQlvAqf2mr370oUAJBEwP8b4YrQ6d+tbAl5IG+
         i0wYvJAGycdLNiyrZwBisU2x0jzKvc/Ji7iuMP4P+vEsGJZFdFVZxcjBWnkLrxC3+0z5
         Pw4Q==
X-Received: by 10.180.211.11 with SMTP id my11mr21771826wic.51.1440349835821;
        Sun, 23 Aug 2015 10:10:35 -0700 (PDT)
Received: from [10.32.248.113] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p1sm19396278wjq.28.2015.08.23.10.10.33
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Aug 2015 10:10:34 -0700 (PDT)
In-Reply-To: <xmqqmvxk5xm9.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276413>


On 21 Aug 2015, at 20:01, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> PROBLEM:
>> We run P4 servers on Linux and P4 clients on Windows. For an unknown
>> reason the file path for a number of files in P4 does not match the
>> directory path with respect to case sensitivity.
>>=20
>> E.g. `p4 files` might return
>> //depot/path/to/file1
>> //depot/PATH/to/file2
>>=20
>> If you use P4/P4V then these files end up in the same directory, e.g=
=2E
>> //depot/path/to/file1
>> //depot/path/to/file2
>>=20
>> If you use git-p4 then all files not matching the correct file path
>> (e.g. `file2`) will be ignored.
>>=20
>> SOLUTION:
>> Identify path names that are different with respect to case sensitiv=
ity.
>> If there are any then run `p4 dirs` to build up a dictionary
>> containing the "correct" cases for each path. It looks like P4
>> interprets "correct" here as the existing path of the first file in =
a
>> directory. The path dictionary is used later on to fix all paths.
>>=20
>> This is only applied if the parameter "--ignore-path-case" is passed=
 to
>> the git-p4 clone command.
>>=20
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>=20
> Thanks.  A few comments.
>=20
> - Have you checked "git log" on our history and notice how nobody
>   says "PROBLEM:" and "SOLUTION:" in capital letters?  Don't try to
>   be original in the form; your contributions are already original
>   and valuable in the substance ;-)
haha ok. I will make them lower case :-)

>=20
> - I think I saw v3 yesterday.  It would be nice to see a brief
>   description of what has been updated in this version.
I discovered an optimization. In v3 I fixed the paths of *all* files th=
at are underneath of a given P4 clone path. In v4 I fix only the paths =
that are visible on the client via client-spec (P4 can perform partial =
checkouts via =93client-views=94). I was wondering how to convey this c=
hange. Would have been a cover letter for v4 the correct way or should =
I have made another commit on top of my v3 change?
=20
>=20
> I do not do Perforce and am not familiar enough with this code to
> judge myself.  Will wait for area experts (you have them CC'ed, which
> is good) to comment.
>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 073f87b..61a587b 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1931,7 +1931,7 @@ class View(object):
>>                 (self.client_prefix, clientFile))
>>         return clientFile[len(self.client_prefix):]
>>=20
>> -    def update_client_spec_path_cache(self, files):
>> +    def update_client_spec_path_cache(self, files, fixPathCase =3D =
None):
>=20
> I didn't check the remainder of the file, but I thought it is
> customery *not* to have spaces around '=3D' when the parameter is
> written with its default value in Python?
Yes, that is PEP-8 style and I will change it accordingly. Unfortunatel=
y git-p4.py does not follow a style guide.=20
e.g. line 2369: def commit(self, details, files, branch, parent =3D "")=
:

More annoyingly (to me at least) is that git-p4 mixes CamelCase with sn=
ake_case even within classes/functions. I think I read somewhere that t=
hese kind of refactorings are discouraged. I assume that applies here, =
too?

>=20
>> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path=
-variations.sh
>> ...
>> +test_expect_success 'Clone the repo and WITHOUT path fixing' '
>> +	client_view "//depot/One/... //client/..." &&
>> +	git p4 clone --use-client-spec --destination=3D"$git" //depot &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		# This method is used instead of "test -f" to ensure the case is
>> +		# checked even if the test is executed on case-insensitive file s=
ystems.
>> +		cat >expect <<-\EOF &&
>> +			two/File2.txt
>> +		EOF
>=20
> I think we usually write the body of the indented here text
> (i.e. "<<-") indented to the same level as the command and
> delimiter, i.e.
>=20
> 	cat >expect <<-\EOF &&
>        body of the here document line 1
>        body of the here document line 2
>        ...
>        EOF
ok

>=20
>> +		git ls-files >actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>=20
> I think you used to check the result with "find .", i.e. what the
> filesystem actually recorded.  "ls-files" gives what the index
> records (i.e. to be committed if you were to make a new commit from
> that index).  They can be different in case on case-insensitive
> filesystems, which I think are the ones that are most problematic
> with the issue your patch is trying to address.
>=20
> You are verifying what the set of "canonical" paths should be by
> checking ls-files output.  I think that is what you intended to do
> (i.e. I am saying "I think the code is more correct than the earlier
> round that used find"), but I just am double checking.
I agree that =93ls-files=94 is better because it reflects what ends up =
in the Git repository and how it ends up there.

>=20
>> +test_expect_success 'Add a new file and clone the repo WITH path fi=
xing' '
>> +	client_view "//depot/... //client/..." &&
>> +	(
>> +		cd "$cli" &&
>> +
>> +		mkdir -p One/two &&
>=20
> A blank after 'cd' only in this one but not others.  A blank line is
> a good vehicle to convey that blocks of text above and below it are
> logically separate, but use it consistently.  I _think_ this blank
> line can go.
Agreed.
>=20
>> +		>One/two/File0.txt &&
>> +		p4 add One/two/File0.txt &&
>=20
> Thanks.

Thanks again for the feedback,
Lars

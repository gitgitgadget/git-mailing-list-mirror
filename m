From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 2/2] git-p4: handle "Translation of file content failed"
Date: Tue, 15 Sep 2015 17:38:41 +0200
Message-ID: <5FF97F9B-E2FB-4919-BCAF-5462ED9D1EEE@gmail.com>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com> <1442249728-89494-3-git-send-email-larsxschneider@gmail.com> <55F7BE2A.80609@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 17:38:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsJm-00086B-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbbIOPiq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2015 11:38:46 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33688 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbbIOPip convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 11:38:45 -0400
Received: by wiclk2 with SMTP id lk2so34721286wic.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JxrzSDS2Zc/UoUiO3FQvz+iUP+d+GoH3ALihvH866E4=;
        b=ubNWxdrDWjGXikjZdtc/PQpurSnADYmNucEZx72QqN3qR6q4DdPt4QAaM+bEM1+XjQ
         Lobn+xAyzpq2Ucsig2+EZAZsy4ITLgQRvNH4GpgXEZPKv2ACVjR+mrnO1FNFq9sgA52a
         PvRNdqqgjPILwgJ30r1338UOA4ynW8MnMakrCa6N0kokWAivr3chYtovAT4c87Ps6tkO
         QCZQw9AB5Js1hVV6CfxOMsxu0sVr74DmimRuI1W+2tfp8VnCeTCUsIsFGg1Cv/0A41iR
         y50ETmeK7Nqs+datpHrCfPOJrW0bw1Sx7YgC67ZsupHwGcX/y16zItjFfr23Mumj3kF+
         /AEA==
X-Received: by 10.194.20.161 with SMTP id o1mr43224162wje.32.1442331523913;
        Tue, 15 Sep 2015 08:38:43 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id fz1sm20493031wic.8.2015.09.15.08.38.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 08:38:43 -0700 (PDT)
In-Reply-To: <55F7BE2A.80609@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277920>


On 15 Sep 2015, at 08:43, Luke Diamand <luke@diamand.org> wrote:

> On 14/09/15 17:55, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> A P4 repository can get into a state where it contains a file with
>> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
>=20
> Sorry - what's a BOM? I'm assuming it's not a Bill of Materials?
BOM stands for Byte Order Mark. The UTF-16 BOM is a two byte sequence a=
t the beginning of a UTF-16 file. It is not part of the actual content.=
 It is only used to define the encoding of the remaining file. FEFF sta=
nds for UTF-16 big-endian encoding and FFFE for little-endian encoding.

More info here: http://www.unicode.org/faq/utf_bom.html#bom1


> Do we know the mechanism by which we end up in this state?
Unfortunately no. I tried hard to reproduce the error with =93conventio=
nal=94 methods. As you can see I ended up manipulating the P4 database=85

However, it looks like this error happens in the wild, too:
https://stackoverflow.com/questions/5156909/translation-of-file-content=
-failed-error-in-perforce
https://stackoverflow.com/questions/887006/perforce-translation-of-file=
-content-failed-error


>> attempts to retrieve the file then the process crashes with a
>> "Translation of file content failed" error.
>>=20
>> Fix this by detecting this error and retrieving the file as binary
>> instead. The result in Git is the same.
>>=20
>> Known issue: This works only if git-p4 is executed in verbose mode.
>> In normal mode no exceptions are thrown and git-p4 just exits.
>=20
> Does that mean that the error will only be detected in verbose mode? =
That doesn't seem right!
Correct. I don=92t like this either but I also don=92t want to make hug=
e changes to git-p4.
You can see the root problem here:
https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a87d6=
d/git-p4.py#L110-L114

Any idea how to approach that best?


>=20
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  git-p4.py | 27 ++++++++++++++++-----------
>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 073f87b..5ae25a6 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -134,13 +134,11 @@ def read_pipe(c, ignore_error=3DFalse):
>>          sys.stderr.write('Reading pipe: %s\n' % str(c))
>>=20
>>      expand =3D isinstance(c,basestring)
>> -    p =3D subprocess.Popen(c, stdout=3Dsubprocess.PIPE, shell=3Dexp=
and)
>> -    pipe =3D p.stdout
>> -    val =3D pipe.read()
>> -    if p.wait() and not ignore_error:
>> -        die('Command failed: %s' % str(c))
>> -
>> -    return val
>> +    p =3D subprocess.Popen(c, stdout=3Dsubprocess.PIPE, stderr=3Dsu=
bprocess.PIPE, shell=3Dexpand)
>> +    (out, err) =3D p.communicate()
>> +    if p.returncode !=3D 0 and not ignore_error:
>> +        die('Command failed: %s\nError: %s' % (str(c), err))
>> +    return out
>>=20
>>  def p4_read_pipe(c, ignore_error=3DFalse):
>>      real_cmd =3D p4_build_cmd(c)
>> @@ -2186,10 +2184,17 @@ class P4Sync(Command, P4UserMap):
>>              # them back too.  This is not needed to the cygwin wind=
ows version,
>>              # just the native "NT" type.
>>              #
>> -            text =3D p4_read_pipe(['print', '-q', '-o', '-', "%s@%s=
" % (file['depotFile'], file['change']) ])
>> -            if p4_version_string().find("/NT") >=3D 0:
>> -                text =3D text.replace("\r\n", "\n")
>> -            contents =3D [ text ]
>> +            try:
>> +                text =3D p4_read_pipe(['print', '-q', '-o', '-', '%=
s@%s' % (file['depotFile'], file['change'])])
>> +            except Exception as e:
>=20
> Would it be better to specify which kind of Exception you are catchin=
g? Looks like you could get OSError, ValueError and CalledProcessError;=
 it's the last of these you want (I think).
I think it is just a plain exception. See here:
https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a87d6=
d/git-p4.py#L111


>=20
>> +                if 'Translation of file content failed' in str(e):
>> +                    type_base =3D 'binary'
>> +                else:
>> +                    raise e
>> +            else:
>> +                if p4_version_string().find('/NT') >=3D 0:
>> +                    text =3D text.replace('\r\n', '\n')
>> +                contents =3D [ text ]
>=20
> The indentation on this bit doesn't look right to me.
I believe it is exactly how it was:
https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a87d6=
d/git-p4.py#L2397-L2399


In general, what is the appropriate way to reference code in this email=
 list? Are GitHub links OK?


Thanks,
Lars

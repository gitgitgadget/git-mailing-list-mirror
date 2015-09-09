From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 1/2] git-p4: print stderr if P4 read_pipe operation fails
Date: Wed, 9 Sep 2015 20:50:15 +0200
Message-ID: <6A7A961A-9DB6-4B12-91E1-D6FE1F5E0358@gmail.com>
References: <1441629723-90604-1-git-send-email-larsxschneider@gmail.com> <1441629723-90604-2-git-send-email-larsxschneider@gmail.com> <xmqqbndb7fc0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 20:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZkRs-0000DY-OK
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 20:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbbIISuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 14:50:21 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32897 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbbIISuT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 14:50:19 -0400
Received: by wiclk2 with SMTP id lk2so2092458wic.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HrM33g9/WfjiC+ij1PXtZcpTuoB/oRB7eMf5IPDsu2Q=;
        b=wkgwmHlhnJzD/2esoTw5a+Bff6J1u3duqkvGS8CVjoP0dvn7n6uf2VxnDxtH1DDLGm
         kUo6wQeMawyE2b4c9NwE+HXAbohVkeUucq8Pva1cFV7DB+YrFT79QqRL0YeGvIc8iEew
         tCsQrhyO3vtlEu4t1YL2CfidCWK2BzHOAa4M5VRjahMIwjdhTVMehO0dc59m7Mi3zO5k
         jbj9y+jk9NZx5JbN0/fZY02uxGtOuHDMAVEWqpHENSxnNvTnFcycbrAUvO0bRRo95TnB
         9oOisAjV+BwhejgoduoYjlRJkJfXBgo6q0yUM0uraAWP5TnIVWWnL7oJOMIH+iKPcHcN
         pALw==
X-Received: by 10.194.58.40 with SMTP id n8mr65390886wjq.134.1441824617999;
        Wed, 09 Sep 2015 11:50:17 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-106-108-157.188.106.pools.vodafone-ip.de. [188.106.108.157])
        by smtp.gmail.com with ESMTPSA id c7sm11622270wjb.19.2015.09.09.11.50.16
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Sep 2015 11:50:17 -0700 (PDT)
In-Reply-To: <xmqqbndb7fc0.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277561>


On 09 Sep 2015, at 18:00, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> If read_pipe crashes then the caller can inspect the error and handl=
e
>> it appropriately.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> git-p4.py | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 073f87b..36a4bcb 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -134,11 +134,11 @@ def read_pipe(c, ignore_error=3DFalse):
>>         sys.stderr.write('Reading pipe: %s\n' % str(c))
>>=20
>>     expand =3D isinstance(c,basestring)
>> -    p =3D subprocess.Popen(c, stdout=3Dsubprocess.PIPE, shell=3Dexp=
and)
>> +    p =3D subprocess.Popen(c, stdout=3Dsubprocess.PIPE, stderr=3Dsu=
bprocess.PIPE, shell=3Dexpand)
>>     pipe =3D p.stdout
>>     val =3D pipe.read()
>>     if p.wait() and not ignore_error:
>> -        die('Command failed: %s' % str(c))
>> +        die('Command failed: %s\nError: %s' % (str(c), p.stderr.rea=
d()))
>=20
> I don't know enough about the callers of this helper function to
> tell offhand if that is an issue, but this looks unsafe depending on
> what the process on the other side of these pipes are doing.
>=20
> If it attempts to spew a lot on its standard error stream first and
> then write some to its standard output, I would not be surprised it
> would get stuck waiting for us to read and drain its standard error
> before it can proceed to write to its standard output, and in the
> meantime we would be waiting for it to say something on its standard
> output, no?
>=20
You are right. I will use the =93communicate=94 function here as recomm=
ended in the Python docs:
https://docs.python.org/2/library/subprocess.html#subprocess.Popen.wait

Thanks!

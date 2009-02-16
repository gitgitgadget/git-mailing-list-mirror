From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-archive: Add new option "--output" to write
 archive to a file instead of stdout.
Date: Mon, 16 Feb 2009 13:38:02 -0800
Message-ID: <7v8wo6f4g5.fsf@gitster.siamese.dyndns.org>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D5@NOK-EUMSG-02.mgdnok.nokia.com>
 <4999C884.5050209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: carlos.duclos@nokia.com, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBBr-0006Cf-Hg
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbZBPViM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 16:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbZBPViK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:38:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZBPViJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 16:38:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AC0992B45B;
	Mon, 16 Feb 2009 16:38:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7836C2B463; Mon,
 16 Feb 2009 16:38:04 -0500 (EST)
In-Reply-To: <4999C884.5050209@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Mon, 16 Feb 2009 21:11:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A2FFFE0-FC72-11DD-80F8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110245>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> carlos.duclos@nokia.com schrieb:
>> NOTE: I can only use a webmail client, so some of the tabs might hav=
e
>> overwritten by it. If  that's the case I'll resend the patch as MIME
>> attachment.
>
> Please do, as applying the patch as-is would be difficult, painful ev=
en.

Thanks.  I agree with everything you said in your review, and adding a =
bit
more.

>> diff --git a/archive.c b/archive.c
>> index e6de039..fde8602 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -239,6 +239,18 @@ static void parse_treeish_arg(const char **argv=
,
>>         ar_args->time =3D archive_time;
>>  }
>>=20
>> +static void create_output_file(const char *output_file)
>> +{
>> +       int output_fd =3D creat(output_file, 0666);

"git grep -n -w -e 'creat' -- '*.c'" shows nothing; we seem to prefer
using a longhand:

	open(path, O_CREAT | O_WRONLY | O_TRUNC, 0666);

instead.  Personally I see nothing wrong in creat(2) per-se, but let's =
be
consistent.

>> +       if (dup2(output_fd, 1) !=3D 1)
>> +       {
>> +               close(output_fd);
>> +               die("could not redirect output");
>> +       }
>> +}
>
> Style:
> 	if (condition) {
> 		do(something);
> 		...
> 	}
>
> output_fd can be closed after dup2()ing.

If the user is sick enough to close fd#1 from the shell when running
archive, it could already be pointing at fd#1 ;-)

> A successful dup2() call can return 0 on some systems (mingw here).

Yikes.

The logic would become:

	fd =3D creat();
        if (fd < 0)
        	die();
	if (fd !=3D 1) {
        	if (dup2(fd, 1) < 0 || close(fd))
	        	die();
	}                       =20

>> @@ -294,6 +308,9 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>>         if (!base)
>>                 base =3D "";
>>=20
>> +       if(output)

Style: if (output)

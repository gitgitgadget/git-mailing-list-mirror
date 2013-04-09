From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain,
 commitdiff_plain, and patch
Date: Tue, 09 Apr 2013 13:31:57 +0200
Message-ID: <5163FC2D.9050408@gmail.com>
References: <m2zjx8bxaj.fsf@blackdown.de> <7vd2u4vg4o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 13:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPWmW-0001aK-SY
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 13:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935265Ab3DILcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 07:32:04 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:39662 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935125Ab3DILcC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 07:32:02 -0400
Received: by mail-ea0-f171.google.com with SMTP id b15so2736405eae.30
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=xo2+U34H2NtDcpc1+xTxwpfnolQW+Ekq/MGD1iZSUd4=;
        b=ReocENgCtEHlpIRTAfDy31zyP7PfdSyDIwX5Egs2CAGP6C1Y5OY+KGTkpIt3Ew0fb6
         1Gq26+Jz4YObxAR+qI04BhyalDvSxYWCLEQ4dFgyvAJHaV+9gG0tzCZ/1PRWD8cZZptN
         aJw9jkinT478uPUbB1+uSCiDgyZXCNe39msbB8M28UwvI6S54h0DCgyP/4HC4WPYpbGU
         CbYWhznKcGwPoFuoR8yR2qNHymBbj1VB1BTTRgDmLENs275JEZbI0XoZ4NkrnAJtVHQ/
         MHEelFT4yu94f64ty/EI87dm1lHXWK/eUCIvD2AjI5x2QD34SM04pz7ZldvLtbEAPbu1
         crgw==
X-Received: by 10.14.4.69 with SMTP id 45mr59567853eei.0.1365507120646;
        Tue, 09 Apr 2013 04:32:00 -0700 (PDT)
Received: from [192.168.1.14] (eio154.neoplus.adsl.tpnet.pl. [83.21.130.154])
        by mx.google.com with ESMTPS id i53sm8164443eeu.5.2013.04.09.04.31.58
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 04:31:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vd2u4vg4o.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220561>

On 08.04.2013, Junio C Hamano wrote:
> jk@blackdown.de (J=C3=BCrgen Kreileder) writes:
>=20
>> Fixes the encoding for several _plain actions and for text/* and */*=
+xml blobs.=20
>>
>> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>

I see that this patch does (or tries to do) two _independent_ things,
and should be split into at least two separate commits:

>> ---
>=20
> Thanks, will queue but not hold until I hear something from Jakub.
>=20
>>  gitweb/gitweb.perl |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 1309196..9cfe5b5 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -3823,7 +3823,7 @@ sub blob_contenttype {
>>  	my ($fd, $file_name, $type) =3D @_;
>> =20
>>  	$type ||=3D blob_mimetype($fd, $file_name);
>> -	if ($type eq 'text/plain' && defined $default_text_plain_charset) =
{
>> +	if (($type =3D~ m!^text/\w[-\w]*$! || $type =3D~ m!^\w[-\w]*/\w[-\=
w]*\+xml$!) && defined $default_text_plain_charset) {
>>  		$type .=3D "; charset=3D$default_text_plain_charset";
>>  	}

=46irst, it extends adding "; charset=3D$default_text_plain_charset" to
other mimetypes for 'blob_plain' view to all 'text/*' and '*/*+xml'
mimetypes (without changing name of variable... though this is more
complicated as it is configuration variable and we would want to
preserve backward compatibility, but at least a comment would be,
I think, needed).
=20
Originally it applied only to 'text/plain' files, which can be
displayed inline by web browser, and which need charset in
'Content-Type:' HTTP header to be displayed correctly, as they
do not include such information inside the file.

'text/html' and 'application/xhtml+xml' can include such information
inside them (meta http-equiv for 'text/html' and <?xml ...> for
'application/xhtml+xml').  I don't know what browser does when there
is conflicting information about charset, i.e. which one wins, but
it is certainly something to consider.

It might be a good change; I don't know what web browser do when
serving 'text/css', 'text/javascript', 'text/xml' to client to
view without media type known.


BTW I have noticed that we do $prevent_xss dance outside
blob_contenttype(), in it's only caller i.e. git_blob_plain()...
which for example means that 'text/html' converted to 'text/plain'
don't get '; charset=3D...' added.  I guess that it *might* be
what prompted this part of change... but if it is so, it needs
to be fixed at source, e.g. by moving $prevent_xss to
blob_contenttype() subroutine.


About implementation:

>> +	if (($type =3D~ m!^text/\w[-\w]*$! || $type =3D~ m!^\w[-\w]*/\w[-\=
w]*\+xml$!) && defined $default_text_plain_charset) {
>>  		$type .=3D "; charset=3D$default_text_plain_charset";

would be better with line split

>> +	if (($type =3D~ m!^text/\w[-\w]*$! || $type =3D~ m!^\w[-\w]*/\w[-\=
w]*\+xml$!) &&
>> +	    defined $default_text_plain_charset) {
>>  		$type .=3D "; charset=3D$default_text_plain_charset";

Also: do we need to be strict with '\w[-\w]*', or would '.*' suffice?

>> @@ -7637,7 +7637,9 @@ sub git_blobdiff {
>>  			last if $line =3D~ m!^\+\+\+!;
>>  		}
>>  		local $/ =3D undef;
>> +		binmode STDOUT, ':raw';
>>  		print <$fd>;
>> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>>  		close $fd;
>>  	}
>>  }
>> @@ -7884,12 +7886,16 @@ sub git_commitdiff {
>> =20
>>  	} elsif ($format eq 'plain') {
>>  		local $/ =3D undef;
>> +		binmode STDOUT, ':raw';
>>  		print <$fd>;
>> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>>  		close $fd
>>  			or print "Reading git-diff-tree failed\n";
>>  	} elsif ($format eq 'patch') {
>>  		local $/ =3D undef;
>> +		binmode STDOUT, ':raw';
>>  		print <$fd>;
>> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>>  		close $fd
>>  			or print "Reading git-format-patch failed\n";
>>  	}

Second it changes 'blobdiff_plain', 'commitdiff_plain' (which I think
that should be abandoned in favor of 'patch' view; but that is
a separate issue) and 'patch' views so they use binary-safe output.

Note that in all cases (I think) we use

   $cgi->header(
     -type =3D> 'text/plain',
     -charset =3D> 'utf-8',
     ...
   );

promising web browser that output is as whole in 'utf-8' encoding.

It is not explained in the commit message what is the reason for this
change.  Is it better handing of a situation where files being diff-ed
being in other encoding (like for example in commit that changes
encoding of files from legacy encoding such like e.g. iso-8859-2
or cp1250 to utf-8)?  But what about  -charset =3D> 'utf-8'  then?


About implementation: I think after this change common code crosses
threshold for refactoring it into subroutine, for example:

  sub dump_fh_raw {
  	my $fh =3D shift;

  	local $/ =3D undef;
  	binmode STDOUT, ':raw';
  	print <$fh>;
  	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi

  	return $fh;
  }

--=20
Jakub Nar=C4=99bski

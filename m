From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 00:25:45 +0200
Message-ID: <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Michael Wagner <accounts@mwagner.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:26:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkhd8-0006sp-Gr
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbaENW00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 May 2014 18:26:26 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:39642 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbaENW00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2014 18:26:26 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so262429obc.18
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WV2gNPlqBkz09RahAJ1vJFw2N5EmshSj/DyDTxnGpBk=;
        b=osi0YKEQZyueSpwdE/2kuQ7dlyF8782fueNtOaBhShnnFsk+i3CDXPTWShMnY1y+4w
         CytUIUpGbkQ0RiNtHv+xHGacyfBgjQoPhzU4kZwbgeJdhL05v+FII+TGIsgbBn6dOUZO
         llX0JdZKP7RW+lDe09EqzkH9C3fHyfpoUXi35VT/xFyEM2qi/iKHWrGrkEVl+6DNXOSS
         yj/13X7fgyHOSIQDxEy6UMR175vAYQPDf6XXvFeyEx8lWoB10pAPpfeBKjaztNcMw3WZ
         O6A7+bM2cWCW13Czuh//eV6F71H3q+8gklRZk6jNSQQ94eT1YaHGPRPF51Ryu33nNMW0
         huYA==
X-Received: by 10.182.72.227 with SMTP id g3mr6323940obv.28.1400106385494;
 Wed, 14 May 2014 15:26:25 -0700 (PDT)
Received: by 10.76.132.4 with HTTP; Wed, 14 May 2014 15:25:45 -0700 (PDT)
In-Reply-To: <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249041>

On Wed, May 14, 2014 at 11:57 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Michael Wagner <accounts@mwagner.org> writes:
>
>> Perl has an internal encoding used to store text strings. Currently,=
 trying to
>> view files with UTF-8 encoded names results in an error (either "404=
 - Cannot
>> find file" [blob_plain] or "XML Parsing Error" [blob]). Converting t=
hese UTF-8
>> encoded file names into Perl's internal format resolves these errors=
=2E

Could you give us an example?  What is important is whether filename
is passed via path_info or via query string.

Because in evaluate_uri() there is

     our $path_info =3D decode_utf8($ENV{"PATH_INFO"});

and in evaluate_query_params() there is

    $input_params{$name} =3D decode_utf8($cgi->param($symbol));

>> Signed-off-by: Michael Wagner <accounts@mwagner.org>
>> ---
>
> Cc'ing Jakub, who have been the area maintainer, for comments.
>
> One thing I wonder is that, if there are some additional calls to
> encode() necessary before we embed $file_name (which are now decoded
> to the internal string form, not a byte-sequence that happens to be
> in utf-8) in the generated pages, if we were to do this change.

There should be no problem with output encoding.  esc_path(), which
should be used for filenames, includes to_utf8, which in turn uses
decode($fallback_encoding, $str, Encode::FB_DEFAULT);

>>  gitweb/gitweb.perl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a9f57d6..6046977 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1056,7 +1056,7 @@ sub evaluate_and_validate_params {
>>               }
>>       }
>>
>> -     our $file_name =3D $input_params{'file_name'};
>> +     our $file_name =3D decode("utf-8", $input_params{'file_name'})=
;
>>       if (defined $file_name) {
>>               if (!is_valid_pathname($file_name)) {
>>                       die_error(400, "Invalid file parameter");

Hmm... all %input_params should have been properly decoded
already, how it was missed?

Also, branchname (hash_base etc.), search query, filename in file_paren=
t,
project name can be UTF-8 too, so it is at best partial fix.

--=20
Jakub Nar=C4=99bski

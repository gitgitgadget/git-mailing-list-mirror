From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Remove "uninitialized value" Perl warning
Date: Tue, 12 Jan 2016 13:20:12 -0800
Message-ID: <CAPc5daVYHKehuDV7hFB9npw9qYt24jLTrnQr1LxDPdHQjWpkYQ@mail.gmail.com>
References: <1452569516-25657-1-git-send-email-sunny@sunbase.org> <xmqq4meitsce.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 22:20:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ6Mn-0005vx-6F
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 22:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbcALVUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2016 16:20:33 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33892 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcALVUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2016 16:20:32 -0500
Received: by mail-io0-f179.google.com with SMTP id 1so350830171ion.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=rHir13/t+VzILhNrj/+kL87EX02KBmPHTWSuJjDvFd4=;
        b=zpR52kFRygkyJvOmadwuOzXjo8Lnzl99/ne6lMp/ZrbAZOcTIGZSWk75a8XdsXC+ED
         mxiJgo7ReMEj6OoOG+qnj3RW7jWLmZh4945o6+tLtLf0nYADum+tjCk2ZMYG1xp7UbHJ
         7qSxJ/3W9bMpZ29Ktgvvjmaj7PVLRV7W/BF1YRyaFMcejxYjB3uR/d09z1lz5MWeIlhG
         9B7b7M2J2xki3Clgbt3cr7N64zlqDAuxR1sX5ZdFcWjYN+qzXxEwcy6erIyop0Ee0JjT
         B6Xo6fORQM08suMpU7n7GvQHeRpWDFitfuMEi1D00dVjKL3c8jStizgJbCmpyhTdYarW
         jsQA==
X-Received: by 10.107.138.164 with SMTP id c36mr128622585ioj.82.1452633632358;
 Tue, 12 Jan 2016 13:20:32 -0800 (PST)
Received: by 10.36.52.137 with HTTP; Tue, 12 Jan 2016 13:20:12 -0800 (PST)
In-Reply-To: <xmqq4meitsce.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: f0GgTznqbTeMKdi8FvRv7ZmxgSk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283844>

On Tue, Jan 12, 2016 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=98yvind A. Holm <sunny@sunbase.org> writes:
>
>> git_object(): Check if $type is defined before chomping it. This rem=
oves
>> a Perl warning in the server error log:
>>
>>   gitweb.cgi: Use of uninitialized value $type in scalar chomp at
>>   [...]/gitweb.cgi line 7579., referer: [...]
>>
>> when trying to access a non-existing commit, for example:
>>
>>   http://HOST/?p=3DPROJECT.git;a=3Dcommit;h=3DNON_EXISTING_COMMIT
>
> Thanks.  The analysis and description of the issue and the fix both
> make sense to me.

With this, you would then do

 print $cgi->redirect(-uri =3D> href(action=3D>$type, ...);

but then href treats $param{action} that is an undef as if it does not
even exist,
so the effect will not be felt during the invocation of this request.

I am not sure what happens to a request that lacks action (mapped to 'a=
'
parameter) that results from this redirect, though.  Would that eventua=
lly
hit dispatch where if (!defined $action) would cause it to say "Object =
does
not exist"?

In any case, this looks like a strict improvement. Thanks again.

>> Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
>> ---
>>  gitweb/gitweb.perl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 7a5b23a..05d7910 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -7576,7 +7576,7 @@ sub git_object {
>>                       git_cmd(), 'cat-file', '-t', $object_id) . ' 2=
> /dev/null'
>>                       or die_error(404, "Object does not exist");
>>               $type =3D <$fd>;
>> -             chomp $type;
>> +             defined $type && chomp $type;
>>               close $fd
>>                       or die_error(404, "Object does not exist");
>

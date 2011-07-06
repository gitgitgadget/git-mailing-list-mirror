From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 8/8] vcs-svn: allow to disable 'progress' lines
Date: Wed, 6 Jul 2011 16:14:51 +0600
Message-ID: <CA+gfSn-LEW36+bbxs1ydnhd3iQu-+wvrsSTuTszTYKm+jmuhOw@mail.gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
	<1309715877-13814-9-git-send-email-divanorama@gmail.com>
	<CALkWK0nWSVrrtzwE2ePucK=XTnSHWuojxhoayRSUbZmk1We9Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:14:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeP8E-00050L-0t
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab1GFKOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 06:14:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44372 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab1GFKOw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 06:14:52 -0400
Received: by qwk3 with SMTP id 3so3268614qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mcA8n1oFuC5pgDM1HJrTxg4n8eBkCobX5hylu8j1VaI=;
        b=Hz9aX/oQCd0GM1tqKIJvRvY94k0CP/vIlv0yjg+t9ifX0lt8NTV094cpllC8WsjF99
         H8iCLOsxDf5QHlScWlTDBHT8tWjW7Vifzo6PoKdbcFAlItDSvuIC3luDioEbtpvZFkR3
         rkfHkJDcfDtUWl4Cb7yjMskR6ZFRbRiUv6j7g=
Received: by 10.229.18.81 with SMTP id v17mr6375405qca.7.1309947291999; Wed,
 06 Jul 2011 03:14:51 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Wed, 6 Jul 2011 03:14:51 -0700 (PDT)
In-Reply-To: <CALkWK0nWSVrrtzwE2ePucK=XTnSHWuojxhoayRSUbZmk1We9Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176680>

Hi!

[...]
>> diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
[...]
>> - =A0 =A0 =A0 if (svndump_init(NULL, url, ref, backflow_fd))
>> + =A0 =A0 =A0 if (svndump_init(NULL, url, ref, backflow_fd, progress=
))
>
> You're modifying the svndump_init API for every new option that's
> added. =A0This'll clearly break down when you have many options -- ho=
w
> about wrapping it up in an options structure and then passing that?
Well, there has to be a function to init that structure then. And the
structure will become a part of API.
So don't know if it's worthy.

>> diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
>> index a7ad368..f1a459e 100644
>> --- a/contrib/svn-fe/svn-fe.txt
>> +++ b/contrib/svn-fe/svn-fe.txt
>> @@ -39,6 +39,9 @@ OPTIONS
>> =A0 =A0 =A0 =A0Integer number of file descriptor from which
>> =A0 =A0 =A0 =A0responses to 'ls' and 'cat-blob' requests will come.
>> =A0 =A0 =A0 =A0Default is fd=3D3.
>> +--[no-]progress::
>> + =A0 =A0 =A0 Write 'progress' lines to fast-import stream. These
>> + =A0 =A0 =A0 can be displayed by fast-import.
>
> Hm, this will make it a little too silent for the end-user. =A0What d=
o
> you feel about printing something minimalistic like a '.' for each
> imported revision? Atleast it won't look like it's hung.
=46or a medium 8k commit repo it is 100 lines - still too much.
A single line for the first revision seem harmless and will indicate
that the remote connection succeeded
(helps to see that it's not a connection timeout, probably caused by
dns lookup or a firewall).

> =A0Also, how does this interact with the 'progress' option of fast-im=
port protocol?
git fast-import --quiet prints any progress line produced by a helper.
transport-helper.c tries to set the option
but doesn't fail if it is not accepted or if helper doesn't support
options at all.
=46or now the helper doesn't use this protocol option.

A better solution could be to use progress.o api to display progress.
Or an ad-hoc hack with adaptive progress step, say report a progress
on each "power of two"-th revision.

As a starting point for tests let there bust a simple switch-off.

[...]
>> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
>> index cfb0f2b..a8b8603 100644
>> --- a/vcs-svn/fast_export.c
>> +++ b/vcs-svn/fast_export.c
>> @@ -19,6 +19,7 @@ static uint32_t first_commit_done;
>> =A0static struct line_buffer postimage =3D LINE_BUFFER_INIT;
>> =A0static struct line_buffer report_buffer =3D LINE_BUFFER_INIT;
>> =A0static struct strbuf ref_name =3D STRBUF_INIT;
>> +static int print_progress;
[...]
>> -void fast_export_init(int fd, const char *dst_ref)
>> +void fast_export_init(int fd, const char *dst_ref, int progress)
>> =A0{
>> =A0 =A0 =A0 =A0first_commit_done =3D 0;
>> + =A0 =A0 =A0 print_progress =3D progress;
>
> The only reason you're modifying the API of fast_export_init is so
> that it can set a global static variable?
Looked once more at how these new variables are used. We can move
progress lines generation to svndump.c. And also move ref_name from
_init and being global static to a parameter in fast_export_begin_commi=
t(),
and to be more sane s/revision/target_mark/ s/revision - 1/from_mark/ a=
nd
add a from_mark parameter, move first_commit_done logic to svndump.o.
This way fast_export.o can operate on single commits and maybe it'll be
easier to use it to apply svn branches layout in svn-fe in one run, tho=
ugh I'm
not sure I'll use svn-fe to manage svn branches.

> =A0Also, this change seems
> more absurd because progress reporting isn't directly related to
> fast_export_init. =A0How about having a dedicated function for option
> parsing that sets all the global statics?
>
> I'm sorry I haven't been more involved with this project. =A0Still, I
> hope this review helps.
This is very helpful, thanks.

>
> -- Ram
>

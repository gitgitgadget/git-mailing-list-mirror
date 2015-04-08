From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] clean: improve performance when removing lots of directories
Date: Wed, 8 Apr 2015 17:29:36 -0400
Message-ID: <CAPig+cSAMT1sECNueDckLMvBQ9q47L_t-wsnUeJ3WjCHvtOEAQ@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-4-git-send-email-erik.elfstrom@gmail.com>
	<CAPig+cQOLJcy-QuACrvd+XrCpP74k0SXxj0rBkNneG5Ovnf47Q@mail.gmail.com>
	<CAMpP7NYixn4491EdPTDX+RQFr3VZfuAoUWZ4JXuYg2rqp9XTeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 23:29:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfxXc-0006GP-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 23:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbbDHV3j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2015 17:29:39 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:36691 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbbDHV3i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 17:29:38 -0400
Received: by lagv1 with SMTP id v1so75931516lag.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=cEXV2p+tPjvJad+lo3Ztcv8sYuas4SFRmoNAKUyK/Jk=;
        b=xbW7vHbHI0yhKhqyTp4rRDYYreeMEToWNQXY/5HdwMQqWimE8Ens6RH2pjxDIcWXyd
         2xD9OMYpkcwDS7MkgSaDpQ6uPz5EkSnZ3hiAJxO2g9wc2Vb7Al5oNk1FU2JWGn7SWqIJ
         /Clh6jpbk7kwFKMc2o62a88K2/ROmuVpGUImi7RxnFaMPWttPvvhXdIi3HG1G/Ox+am7
         u/q/tKtYvDDfLSIMo64Yh1uiXhhZ5MOLKzUDCbb4FP5n5EPWfeEub5VycIvo6hWqlXf+
         dI/WDj/MiXYfSrI9NCuQPoyKMH0CmpuJ32u21T/4cLFybjOmyrrLILtwjRAW/r0iPWJE
         99pQ==
X-Received: by 10.152.26.169 with SMTP id m9mr1722890lag.45.1428528576568;
 Wed, 08 Apr 2015 14:29:36 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Wed, 8 Apr 2015 14:29:36 -0700 (PDT)
In-Reply-To: <CAMpP7NYixn4491EdPTDX+RQFr3VZfuAoUWZ4JXuYg2rqp9XTeg@mail.gmail.com>
X-Google-Sender-Auth: WFTmQkKvg3Q7N6Exxb5b5gJL394
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266974>

On Tue, Apr 7, 2015 at 3:55 PM, erik elfstr=C3=B6m <erik.elfstrom@gmail=
=2Ecom> wrote:
> On Tue, Apr 7, 2015 at 12:10 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Mon, Apr 6, 2015 at 7:48 AM, Erik Elfstr=C3=B6m <erik.elfstrom@gm=
ail.com> wrote:
>>> diff --git a/builtin/clean.c b/builtin/clean.c
>>> index 98c103f..e951bd9 100644
>>> --- a/builtin/clean.c
>>> +++ b/builtin/clean.c
>>> +static int is_git_repository(struct strbuf *path)
>>> +{
>>> +       int ret =3D 0;
>>> +       if (is_git_directory(path->buf))
>>> +               ret =3D 1;
>>> +       else {
>>> +               int orig_path_len =3D path->len;
>>> +               if (path->buf[orig_path_len - 1] !=3D '/')
>>
>> Minor: I don't know how others feel about it, but I always find it a
>> bit disturbing to see a potential negative array access without a
>> safety check that orig_path_len is not 0, either directly in the
>> conditional or as a documenting assert().
>
> I think I would prefer to accept empty input and return false rather
> than assert. What to you think about:
>
> static int is_git_repository(struct strbuf *path)
> {
>     int ret =3D 0;
>     size_t orig_path_len =3D path->len;
>     if (orig_path_len =3D=3D 0)
>         ret =3D 0;

My concern in raising the issue is that someone reviewing the patch or
reading the code later won't necessarily know whether you took the
potential negative array access into account and dismissed it as
"can't happen", or if you overlooked the possibility altogether. Had
there been an explicit check in the code (either assert() or other
special handling such as returning 'false'), a comment in the code, or
mention in the commit message, then it would have been clear that you
took the case into consideration, and I wouldn't have worried about
it.

As for the this proposed version of is_git_repository(), I don't have
strong feelings, and can formulate arguments either way. If it doesn't
make sense for is_git_repository() ever to be called with empty input,
then assert() may be the better choice for documenting that fact.
However, if you foresee some need for allowing empty input, or if you
audited the functionality and found that it can already be called with
empty input, then returning 'false' makes sense. Use your best
judgment.

>     else if (is_git_directory(path->buf))
>         ret =3D 1;
>     else {
>         if (path->buf[orig_path_len - 1] !=3D '/')
>             strbuf_addch(path, '/');
>         strbuf_addstr(path, ".git");
>         if (is_git_directory(path->buf))
>             ret =3D 1;
>         strbuf_setlen(path, orig_path_len);
>     }
>
>     return ret;
> }
>
>
> Also I borrowed this pattern from remove_dirs and it has the same
> problem. Should I add something like this as a separate commit?
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index ccffd8a..88850e3 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -201,6 +202,7 @@ static int remove_dirs(struct strbuf *path, const
> char *prefix, int force_flag,
>                 return res;
>         }
>
> +       assert(original_len > 0 && "expects non-empty path");
>         if (path->buf[original_len - 1] !=3D '/')
>                 strbuf_addch(path, '/');

I personally wouldn't mind such a patch. (I'm not sure that the string
within the assert() adds much value, and it's a not-much-used idiom
within the Git source.)

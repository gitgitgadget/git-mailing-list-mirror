From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 02/27] Convert git_snpath() to strbuf_git_path()
Date: Fri, 7 Mar 2014 12:03:13 +0700
Message-ID: <CACsJy8BwUa63yG0WownJQNedNE8JC+5_oG8PBs6sy7_tiHOh-A@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-3-git-send-email-pclouds@gmail.com>
 <CAPig+cTjqrveuOS+3+bonwJa_Kjg=STJU1JJ2Kj7Gs5U9eEB9Q@mail.gmail.com> <CACsJy8DeGCdnWHOxTeGUV4CsHyV-u_DgR-03iyOrEKznsQsqGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 06:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLmwn-0001K0-3c
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 06:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaCGFDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 00:03:45 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:52705 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaCGFDo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 00:03:44 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so10135102qgd.8
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 21:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IE1diLxPJEMPNHxQqYKP0gBmvRUj9xudTcbJ/N9I51o=;
        b=NXJ8R9Zm4VwzmM9VvagE64L3qLADQXwR3hUvQ6khUZXyc/yDE0zD5FfsDb9s3VxWSt
         TI/MyRErnwwrllPhPIPiDTlzDwfalSdDWhcozbf1x7d9pQ6i7Rfg+17WtszkwLjx0tpJ
         T2EgxKFW9gVCIReZp4BYq2UIfqbVbBtJo9/9Qt2DxvonoyIUzLrsqMv+pAWn2yFnya6A
         VQS7ZprdzaD0CWeIC2MxzXAcEZ/OTqv5VqVSd6oyJy5eIyiqj2Wl5BWNiekOktvcJJ7M
         b9vOZyDOKj2kiTlmB3uEtPwOQMteObHKhfeosFXXFYoxRdPl3QLsIH4emrF2X7AfNaYQ
         xwig==
X-Received: by 10.224.114.10 with SMTP id c10mr19243812qaq.19.1394168623526;
 Thu, 06 Mar 2014 21:03:43 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Mar 2014 21:03:13 -0800 (PST)
In-Reply-To: <CACsJy8DeGCdnWHOxTeGUV4CsHyV-u_DgR-03iyOrEKznsQsqGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243586>

On Mon, Mar 3, 2014 at 7:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Mar 3, 2014 at 7:02 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
>> On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> In the previous patch, git_snpath() is modified to allocate a new
>>> strbuf buffer because vsnpath() needs that. But that makes it awkwa=
rd
>>> because git_snpath() receives a pre-allocated buffer from outside a=
nd
>>> has to copy data back. Rename it to strbuf_git_path() and make it
>>> receive strbuf directly.
>>>
>>> The conversion from git_snpath() to git_path() in
>>> update_refs_for_switch() is safe because that function does not kee=
p
>>> any pointer to the round-robin buffer pool allocated by
>>> get_pathname().
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> diff --git a/refs.c b/refs.c
>>> index 89228e2..434bd5e 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -2717,17 +2729,19 @@ static int copy_msg(char *buf, const char *=
msg)
>>>         return cp - buf;
>>>  }
>>>
>>> -int log_ref_setup(const char *refname, char *logfile, int bufsize)
>>> +int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
>>>  {
>>>         int logfd, oflags =3D O_APPEND | O_WRONLY;
>>> +       const char *logfile;
>>>
>>> -       git_snpath(logfile, bufsize, "logs/%s", refname);
>>> +       strbuf_git_path(sb_logfile, "logs/%s", refname);
>>> +       logfile =3D sb_logfile->buf;
>>>         if (log_all_ref_updates &&
>>>             (starts_with(refname, "refs/heads/") ||
>>>              starts_with(refname, "refs/remotes/") ||
>>>              starts_with(refname, "refs/notes/") ||
>>>              !strcmp(refname, "HEAD"))) {
>>> -               if (safe_create_leading_directories(logfile) < 0)
>>> +               if (safe_create_leading_directories(sb_logfile->buf=
) < 0)
>>
>> At this point, 'logfile' is still 'sb_logfile->buf', so do you reall=
y
>> need this change?
>
> Junio made the same comment last time and I missed it. Will update.

No I will not :-) safe_create_leading_directories takes an editable
string, but logfile is now a const string. We could use
s_c_l_d_const() but that one will make a copy of the string
unncessarily. Will make a note in the commit message though.
--=20
Duy

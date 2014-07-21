From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 23/31] checkout: clean up half-prepared directories in
 --to mode
Date: Sun, 20 Jul 2014 23:34:32 -0400
Message-ID: <CAPig+cTgPgk=gJEn1kOxn_gPzqqQM-2tFfuZTxkwuZF-2X-pMw@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-24-git-send-email-pclouds@gmail.com>
	<CAPig+cRE0xOhQM4mtJQRX_gSQ3_OMr6ws87wU03TZ1eaUXui2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 05:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X94N4-0006AZ-Fx
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 05:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaGUDee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 23:34:34 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:43376 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaGUDed convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2014 23:34:33 -0400
Received: by mail-yh0-f47.google.com with SMTP id f10so3703422yha.34
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Q2gXv353ciEfde0/rN4MRfza8XT8DFC3OPtnsLXsi5U=;
        b=sUkj7yVkK+LIgyLjPKt2gZk5b5LCFas1qCC6BlmoYJ57qWuHnEBkA24BAIDuNiJhYl
         sX/ql853mi639mPeXlDgySYFI4+CA+GNfypfDoMpf1FIWgPWglZ+OdyK+oh5Hvwg2RJ5
         2SRBRv7szeyOM1YX2dl74jlNiOKuUdeMkRkLkIOEaOKrWl9UokG41o90eR9cPXfGTGXT
         MhJvcU3vT1m4adZeaVtDPos8FWEwnk8epdLhPByUDttQ384hoiuMvY8M0Gw7JI21ddpB
         S+MWulBZGgF52BvjIkufvjjEJ27BJde3k0jEJpJARiNPn9NjMUfKsGjsXSyfzg/G55xD
         r03Q==
X-Received: by 10.236.103.135 with SMTP id f7mr36152067yhg.102.1405913672806;
 Sun, 20 Jul 2014 20:34:32 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Sun, 20 Jul 2014 20:34:32 -0700 (PDT)
In-Reply-To: <CAPig+cRE0xOhQM4mtJQRX_gSQ3_OMr6ws87wU03TZ1eaUXui2g@mail.gmail.com>
X-Google-Sender-Auth: KDWhN7KHXlT9yi9L1nvLd_vCdiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253941>

On Sun, Jul 20, 2014 at 7:55 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Sun, Jul 13, 2014 at 12:51 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy
> <pclouds@gmail.com> wrote:
>> +
>> +       junk_pid =3D getpid();
>> +       atexit(remove_junk);
>> +       sigchain_push_common(remove_junk_on_signal);
>> +
>>         if (mkdir(sb_repo.buf, 0777))
>>                 die_errno(_("could not create directory of '%s'"), s=
b_repo.buf);
>> +       junk_git_dir =3D sb_repo.buf;
>
> I've managed to convince myself that, although junk_git_dir becomes a
> dangling pointer by the end of prepare_linked_checkout(), it should
> never afterward be accessed. Perhaps it would make sense to make this
> easier to follow by clearing junk_git_dir when is_junk is cleared?
>
>> +       is_junk =3D 1;
>>
>>         strbuf_addf(&sb_git, "%s/.git", path);
>>         if (safe_create_leading_directories_const(sb_git.buf))
>>                 die_errno(_("could not create leading directories of=
 '%s'"),
>>                           sb_git.buf);
>> +       junk_work_tree =3D path;
>>
>>         write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
>>                    real_path(get_git_common_dir()), name);
>> @@ -879,7 +917,14 @@ static int prepare_linked_checkout(const struct=
 checkout_opts *opts,
>>         memset(&cp, 0, sizeof(cp));
>>         cp.git_cmd =3D 1;
>>         cp.argv =3D opts->saved_argv;
>> -       return run_command(&cp);
>> +       ret =3D run_command(&cp);
>> +       if (!ret)
>> +               is_junk =3D 0;
>
> Here: perhaps also set is_junk_dir to NULL since it otherwise is abou=
t
> to become a dangling pointer.

My bad: s/is_junk_dir/junk_git_dir/

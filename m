From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 27/45] Convert run_add_interactive to use struct pathspec
Date: Tue, 19 Mar 2013 08:58:23 +0700
Message-ID: <CACsJy8AMcfwx5UurNQs1-uJLw_Xt+PAHFU_Tjizf2zOsYECyvg@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-28-git-send-email-pclouds@gmail.com> <20130318182602.GA2164@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 19 02:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHlph-0007Ny-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 02:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182Ab3CSB6y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 21:58:54 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:40540 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab3CSB6x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Mar 2013 21:58:53 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so6088043obc.12
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=BTSCqsDYzaNlB/eB3FAXhNEnt5+VGIuFVie4nD4WIKk=;
        b=FYMg+pAXnqBTfiY7jEfDQeewPwlfQFD9BM0+dSkZHdaxBJ8S+JS8WKi5DXf5tbhcPX
         BQZ6PcibdyDUP3h9BlU6tSobANatYa1adyw2XC2O9iRSI4Z0gIBpPpd6tU3UkhGbP7fz
         lv5NRhQu5EwXje/bXk+9DBgotM0hU/D+KXZHM25jCPfWZtd2jzEBtYWWgwB2l4GRl751
         E6FEEYjo7D34aTjMxVMSb9LtGvKjFR8GGIu5pmOGH1FGEDmkRcSWYFIHHfZY1ll1yj6c
         cfpjFVOxl8DiwMHwzTGw/TjyIjAe0pYKBOcRQ6zl2uK95zHiNoOAgutDuH1eNub/R9es
         57JQ==
X-Received: by 10.182.147.2 with SMTP id tg2mr173435obb.47.1363658333457; Mon,
 18 Mar 2013 18:58:53 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Mon, 18 Mar 2013 18:58:23 -0700 (PDT)
In-Reply-To: <20130318182602.GA2164@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218471>

On Tue, Mar 19, 2013 at 1:26 AM, John Keeping <john@keeping.me.uk> wrot=
e:
> On Fri, Mar 15, 2013 at 01:06:42PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> This passes the pathspec, more or less unmodified, to
>> git-add--interactive. The command itself does not process pathspec. =
It
>> simply passes the pathspec to other builtin commands. So if all thos=
e
>> commands support pathspec, we're good.
>
> This breaks "git reset --keep" in a subdirectory for me.
>
> I ran "git reset --keep <branch>" in a subdirectory and got:
>
>     fatal: BUG: parse_pathspec cannot take no argument in this case
>
> Bisecting points to this commit.
>
> The simplest test case is:
>
>     ( cd t && ../bin-wrappers/git reset --keep HEAD )
>
> which works on master but not pu.

Beautiful. I got messed up with C operator precedence. This should fix
it. I'll check the rest of parse_pathspec calls later.

diff --git a/builtin/reset.c b/builtin/reset.c
index ab3917d..b665218 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -219,7 +219,7 @@ static void parse_args(struct pathspec *pathspec,
        *rev_ret =3D rev;
        parse_pathspec(pathspec, 0,
                       PATHSPEC_PREFER_FULL |
-                      patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
+                      (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
                       prefix, argv);
 }

--=20
Duy

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] Make locked paths absolute when current directory
 is changed
Date: Mon, 21 Jul 2014 20:47:39 +0700
Message-ID: <CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
 <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1405858399-23082-2-git-send-email-pclouds@gmail.com>
 <53CD1529.9080102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:48:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Dwu-0006TA-Q0
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 15:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbaGUNsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 09:48:13 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:54776 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbaGUNsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2014 09:48:12 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so5041597qab.32
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=e3hJ3MgzQ3uXcqagm/2ZHY+D6JWT4HZYbJWCNB017/o=;
        b=WYRnxKlifm0orAjt1aPtEq7o1LtwNcwkhPkZDIF1UB89bn63A+GfbxxJ5mj4rQsO19
         ITAlkPUMJon6Yj9mTeNiVjS5wGGTtNZ+rzXIz6oxAn0HMgYqOQPdmq/1/kRsdbbANSD0
         Tnh3UGBsw61Zm09V/9Y0W8smm3ddDzVZD1Iv0Oja++ngHt43KaUMAAontJ0RuC+Z6SiC
         1JYKm5rIQ0nmhynBfkXzpZ3Dkhe4BJGkIO7XqLGos9Z1JANp5owUXx1BkN3es0wtokT/
         nSSto5FfhEtwD+bxFaLL44FI5W2+ngk+IlrE5YYogF68aGgNJoLusjBW4U6i6lZ/zqYt
         aHZA==
X-Received: by 10.224.122.83 with SMTP id k19mr42905367qar.78.1405950489263;
 Mon, 21 Jul 2014 06:48:09 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 21 Jul 2014 06:47:39 -0700 (PDT)
In-Reply-To: <53CD1529.9080102@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253965>

On Mon, Jul 21, 2014 at 8:27 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>> +void make_locked_paths_absolute(void)
>> +{
>> +     struct lock_file *lk;
>> +     for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
>> +             if (lk->filename && !is_absolute_path(lk->filename)) {
>> +                     char *to_free =3D lk->filename;
>> +                     lk->filename =3D xstrdup(absolute_path(lk->fil=
ename));
>> +                     free(to_free);
>> +             }
>> +     }
>> +}
>
> I just have to ask, why are we putting relative pathnames in this
> list to begin with? Why not use an absolute path when taking the
> lock in all cases? (calling absolute_path() and using the result
> to take the lock, storing it in the lock_file list, should not be
> in the critical path, right? Not that I have measured it, of course! =
:)

Conservative :) I'm still scared from 044bbbc (Make git_dir a path
relative to work_tree in setup_work_tree() - 2008-06-19). But yeah
looking through "grep hold_" I think none of the locks is in critical
path. absolute_path() can die() if cwd is longer than PATH_MAX (and
doing this reduces the chances of that happening). But Ren=C3=A9 is add=
ing
strbuf_getcwd() that can remove that PATH_MAX. So I guess we should be
fine with putting absolute_path() in hold_lock_file_...*
--=20
Duy

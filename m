From: Gang Hu <ganghu@cs.columbia.edu>
Subject: Re: Potential problem in git-add may corrupt the index file
Date: Sun, 29 Apr 2012 18:39:23 -0400
Message-ID: <CAEJt7hbKFKN8J5jjX9Z_Apnco+YiN0kYn=wrHTYjE9P9M=jjaw@mail.gmail.com>
References: <CAEJt7hYYJh5dT1Tk99Oze6Hg4QaOqX5ERi0faWjyifQ6dr-pWw@mail.gmail.com>
 <xmqq4ns9j3rf.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junfeng Yang <junfeng@cs.columbia.edu>,
	Heming Cui <heming@cs.columbia.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 00:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOcmT-0001Ts-5a
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 00:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab2D2Wjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Apr 2012 18:39:45 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:57869 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab2D2Wjo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2012 18:39:44 -0400
Received: by dadz8 with SMTP id z8so3284662dad.10
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SF5CzVlz83hNJWAntzrNqnv9hoFRxg0cA3PhgkaBi1o=;
        b=kVF3GUGIbJtLw/1PK0q74pCBJ+2837LbVg27FBUtiIxVvQYa/Iuv6VKLIL9satPoY6
         1spBYF5meM1ttbugzGtTu6wgiRDvEnyoNIaNd3Yj04szxZYqRZ/av3Dmr1KfvOhxNa1B
         zHTQpnIE24osGZXK5TB68gKRzik/QxIGIpw1qKcRUC/orqpDN3sP7DHLA9Dsf4ZOsy4v
         EwiGaNklVbR19+mWqtQzAZdIywUYzimfI7X1HCf9xPM4lWeDh21AVLXyLH7BuK142C7K
         7gv3zD0bA5J4gJva2L/fOl76rP1O+AIXJ5MCkepq++UpfAXYY5fZvY9b4Y5U/6WeOmbj
         ePkw==
Received: by 10.68.225.227 with SMTP id rn3mr3825994pbc.22.1335739183732; Sun,
 29 Apr 2012 15:39:43 -0700 (PDT)
Received: by 10.68.40.5 with HTTP; Sun, 29 Apr 2012 15:39:23 -0700 (PDT)
In-Reply-To: <xmqq4ns9j3rf.fsf@junio.mtv.corp.google.com>
X-Google-Sender-Auth: Y4QYVYNfzS7_-qIDT4MKMf_Qzeo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196520>

Hi Junio,

Thanks for the fast reply!  We've also discovered other similar
programs in git, enclosed below so you may want to fix them in one
patch.

Here is one example in refs.c:
1710:  lockpath =3D mkpath("%s.lock", git_HEAD);
        fd =3D open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
=2E...
      written =3D write_in_full(fd, ref, len);
// We may add
// fsync_or_die(fd, ...);
// here
      if (close(fd) !=3D 0 || written !=3D len) {
              error("Unable to write to %s", lockpath);
              goto error_unlink_return;
      }
      if (rename(lockpath, git_HEAD) < 0) {
=2E..

So there is a problem here, and the head file may be corrupted.

In server-info.c, there is a similar problem:
216:   namelen =3D sprintf(infofile, "%s/info/packs", get_object_direct=
ory());
         strcpy(name, infofile);
         strcpy(name + namelen, "+");

         init_pack_info(infofile, force);

         safe_create_leading_directories(name);
         fp =3D fopen(name, "w");
         if (!fp)
                 return error("cannot open %s", name);
         write_pack_info_file(fp);
// We may add
// fsync_or_die(fileno(fp), ...);
// here
         fclose(fp);
         adjust_shared_perm(name);
         rename(name, infofile);
Here, the packs file in the objects/info directory may be corrupted.

In the same file, the info/refs file may also be corrupted:
28:  char *path0 =3D git_pathdup("info/refs");
      int len =3D strlen(path0);
      char *path1 =3D xmalloc(len + 2);

      strcpy(path1, path0);
      strcpy(path1 + len, "+");

      safe_create_leading_directories(path0);
      info_ref_fp =3D fopen(path1, "w");
      if (!info_ref_fp)
              return error("unable to update %s", path1);
      for_each_ref(add_info_ref, NULL);
// We may add
// fsync_or_die(fileno(info_ref_fp), ...);
// here
      fclose(info_ref_fp);
      adjust_shared_perm(path1);
      rename(path1, path0);

On Mon, Apr 23, 2012 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Gang Hu <ganghu@cs.columbia.edu> writes:
>
>> If a crash happens after the rename(), the data may have not been
>> completely flushed into the index file, so the user may face an empt=
y
>> or corrupted index file.
>
> Yeah, probably we should add fsync_or_die() at the end of write_index=
()
> in read-cache.c, possibly protect it with fsync_object_files just lik=
e
> we do in close_sha1_file() in sha1_file.c for loose object files.
>
> I think the real fix would be to update the write_index() codepath to
> use the csum-file API, though. =A0Then sha1close() will give us the f=
sync
> behaviour for free.



--=20
Cheers,
Gang

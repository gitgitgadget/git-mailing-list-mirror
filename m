From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 1/2 v3] Make diffcore_std only can run once before a 
	diff_flush.
Date: Fri, 23 Apr 2010 11:55:44 +0800
Message-ID: <n2m41f08ee11004222055i498174dfi47a5991a08114cd2@mail.gmail.com>
References: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
	 <1271945142-27015-2-git-send-email-struggleyb.nku@gmail.com>
	 <7v1ve743vb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 05:55:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O59zd-0000aZ-25
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 05:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab0DWDzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 23:55:47 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:59168 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab0DWDzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 23:55:46 -0400
Received: by qyk9 with SMTP id 9so12480701qyk.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 20:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F+2wZKkHxeqZKix/3e0VEaGOzdzFuqBZxHtr/8TGEA8=;
        b=UIeq6EIdI5MJUsa5aJlYsPI251A4XaIV7LE9u06qKPhlp1TSqjAhoqToykrJb+EgJN
         yn/FrSV7Vfhs4Pk1pAE9rFMKTOLvB3dTrvGfU83mswEWHVdh0pFVw1U2qKrmKlXQ6BNc
         43Rcdd7fsSJg9cuKNL7ZMJbCdocmWgZeiJf4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L+/DlRXxC17xFBGj72oGHTpquXWs3GI8TFGQ6lEPiHe8SMWDefaFujjHgPHnE9KDCW
         erCWnZZRtzhsyKkela3bQd7NAZm9l4xOKNBKxjGicR8GzbNK1pdoEUHV0uUAPb01aJF1
         hZJ3/cqgovg9RQYgacBQwaCmFWQGIXu7GzZlw=
Received: by 10.229.98.196 with HTTP; Thu, 22 Apr 2010 20:55:44 -0700 (PDT)
In-Reply-To: <7v1ve743vb.fsf@alter.siamese.dyndns.org>
Received: by 10.229.225.7 with SMTP id iq7mr151422qcb.26.1271994944594; Thu, 
	22 Apr 2010 20:55:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145584>

On Fri, Apr 23, 2010 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> It actually is stronger than that; we should never run it more than o=
nce,
> and it would be a bug if we did so. =C2=A0Which codepath tries to cal=
l *_std()
> twice?

In command 'git log --follow ...'
log_tree_diff call diff_tree_sha1 and then diff_tree_diff_flush, when
'--follow' is given, the former function will call
try_to_follow_renames, which will call diffcore_std to detect rename.
And then, diff_tree_diff_flush call 'diffcore_std' again
unconditional. (and I have try to find a condition to make the call,
but I fail, so I figure out this patch.)

Breakpoint 1, diffcore_std (options=3D0xbf9cc044) at diff.c:3748
3748		if (diff_queued_diff.run)
(gdb) bt
#0  diffcore_std (options=3D0xbf9cc044) at diff.c:3748
#1  0x08124206 in try_to_follow_renames (t1=3D0xbf9cc130, t2=3D0xbf9cc1=
1c,
base=3D0x81571c9 "", opt=3D0xbf9cc468) at tree-diff.c:358
#2  0x08124480 in diff_tree_sha1 (old=3D0x9c51d8c
"$\033\222T=EF=BF=BD=EF=BF=BD=EF=BF=BD\a\035\200T=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD\210;8\235i", new=3D0x9c51d2c
"\201=EF=BF=BD\017<=EF=BF=BD\v=EF=BF=BD=EF=BF=BDn]\226{=EF=BF=BD+=EF=BF=
=BD\001\003\232\232\230",
    base=3D0x81571c9 "", opt=3D0xbf9cc468) at tree-diff.c:418
#3  0x080e660e in log_tree_diff (opt=3D0xbf9cc220, commit=3D0x9c51d28,
log=3D0xbf9cc1ac) at log-tree.c:536
#4  0x080e668f in log_tree_commit (opt=3D0xbf9cc220, commit=3D0x9c51d28=
)
at log-tree.c:560
#5  0x0807faa1 in cmd_log_walk (rev=3D0xbf9cc220) at builtin/log.c:237
#6  0x080806e2 in cmd_log (argc=3D5, argv=3D0xbf9cc788, prefix=3D0x0) a=
t
builtin/log.c:481
#7  0x0804b8eb in run_builtin (p=3D0x8161524, argc=3D5, argv=3D0xbf9cc7=
88)
at git.c:260
#8  0x0804ba51 in handle_internal_command (argc=3D5, argv=3D0xbf9cc788)=
 at git.c:416
#9  0x0804bb2c in run_argv (argcp=3D0xbf9cc700, argv=3D0xbf9cc704) at g=
it.c:458
#10 0x0804bcbe in main (argc=3D5, argv=3D0xbf9cc788) at git.c:529
(gdb) c
Continuing.

Breakpoint 1, diffcore_std (options=3D0xbf9cc468) at diff.c:3748
3748		if (diff_queued_diff.run)
(gdb) bt
#0  diffcore_std (options=3D0xbf9cc468) at diff.c:3748
#1  0x080e6356 in log_tree_diff_flush (opt=3D0xbf9cc220) at log-tree.c:=
449
#2  0x080e6619 in log_tree_diff (opt=3D0xbf9cc220, commit=3D0x9c51d28,
log=3D0xbf9cc1ac) at log-tree.c:537
#3  0x080e668f in log_tree_commit (opt=3D0xbf9cc220, commit=3D0x9c51d28=
)
at log-tree.c:560
#4  0x0807faa1 in cmd_log_walk (rev=3D0xbf9cc220) at builtin/log.c:237
#5  0x080806e2 in cmd_log (argc=3D5, argv=3D0xbf9cc788, prefix=3D0x0) a=
t
builtin/log.c:481
#6  0x0804b8eb in run_builtin (p=3D0x8161524, argc=3D5, argv=3D0xbf9cc7=
88)
at git.c:260
#7  0x0804ba51 in handle_internal_command (argc=3D5, argv=3D0xbf9cc788)=
 at git.c:416
#8  0x0804bb2c in run_argv (argcp=3D0xbf9cc700, argv=3D0xbf9cc704) at g=
it.c:458
#9  0x0804bcbe in main (argc=3D5, argv=3D0xbf9cc788) at git.c:529
(gdb)

> The standard calling sequence is:
>
> =C2=A0- start from an empty queue.
>
> =C2=A0- use diff_change() and diff_addremove() to populate the queue.
>
> =C2=A0- call diffcore_std(). if you need to use a non-standard chain =
of
> =C2=A0 diffcore transformations, you _could_ call the diffcore_* rout=
ines that
> =C2=A0 diffcore_std() calls, if you choose to, but as you found out, =
some of
> =C2=A0 them are not idempotent operations, and shouldn't be called tw=
ice.
>
> =C2=A0- and finally call diffcore_flush().
>
>> @@ -3745,6 +3742,12 @@ void diffcore_fix_diff_index(struct diff_opti=
ons *options)
>>
>> =C2=A0void diffcore_std(struct diff_options *options)
>> =C2=A0{
>> + =C2=A0 =C2=A0 /* We never run this function more than one time, be=
cause the
>> + =C2=A0 =C2=A0 =C2=A0* rename/copy detection logic can only run onc=
e.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if (diff_queued_diff.run)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> Shouldn't this be a BUG() instead?

Anyone may call diff_tree_sha1 and then diffcore_std, and
diff_tree_sha1 may call another diffcore_std if '--follow' given. If
this is a BUG, the calling pattern, diff_tree_sha1 -> diffcore_std
should all disappear from our code. And this involved much code
refactor. And I suggest my way that we avoid the duplicate call
actively in diffcore_std.

> The trivial rewrite to use this macro is a good idea, but it probably
> should be a separate patch.
>
>> +#define DIFF_QUEUE_CLEAR(q) \
>> + =C2=A0 =C2=A0 do { \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (q)->queue =3D NULL; \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (q)->nr =3D (q)->alloc =3D=
 (q)->run =3D 0; \
>> + =C2=A0 =C2=A0 } while(0);
>

You mean split this commit into two?

Regards!
Bo
--=20
My blog: http://blog.morebits.org

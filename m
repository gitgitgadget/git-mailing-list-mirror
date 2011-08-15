From: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [feature wishlist] add commit subcommand to git add -i
Date: Sun, 14 Aug 2011 18:44:33 -0600
Message-ID: <CAJfuBxwiMZnghKQg9vzNVTKET9P6ryT_836mecP3a-q_EcFf7Q@mail.gmail.com>
References: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
 <CALkWK0=9sT6wDwoa3vDF1bt1e8AiubwW42-o=c++MpzV47LhQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 02:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QslIr-0004lk-BP
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 02:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab1HOApG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 20:45:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58626 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1HOApF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 20:45:05 -0400
Received: by wyg24 with SMTP id 24so3201272wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 17:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f2ipCSwJFbgx1A2W5FfXXkR6m2SWHO7dMaZW2y5dTHg=;
        b=ckgLLDPxAO2IAxr4foecGtkgUW6PIt1PeSIGcBI1/vM8Or8t/wWnj+9lspL7OWw0Ik
         HZ4HXIimNviSFawaQ1RzyzQgVbrnJZ/s8qA0bw/1fNGLPyMJQ3NqJxjm/n4DQSgkg0Q4
         Gz89OrjObckDuxv7gkQHoHDX8nMoUv9AczXDw=
Received: by 10.227.24.16 with SMTP id t16mr3013762wbb.12.1313369104218; Sun,
 14 Aug 2011 17:45:04 -0700 (PDT)
Received: by 10.227.121.131 with HTTP; Sun, 14 Aug 2011 17:44:33 -0700 (PDT)
In-Reply-To: <CALkWK0=9sT6wDwoa3vDF1bt1e8AiubwW42-o=c++MpzV47LhQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179355>

On Sun, Aug 14, 2011 at 2:56 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi Jim,
>
> Jim Cromie writes:
>> when using git add -i, it would be handy to have a [c]ommit option.
>
> I can't personally comment on this because I use Magit for staging/
> unstaging and committing. =A0It's quite an awesome application- do ch=
eck
> it out if you use Emacs.
>

I;ll take a look, thanks.

>> going further, if git rebase -i =A0had ability to =A0"back" a fixup =
patch
>> back to where it should have been, and adjust the intervening patche=
s
>> where conflict would normally happen, that would be awesome.
>> Simplistically, this would just shift the patch 1 step back iterativ=
ely,
>> until it wouldnt apply properly, and then --abort, stopping at the l=
ast
>> clean rebase.
>
> Hm, I'm not sure if I understand fully: is the idea about moving a
> commit backwards iteratively so we have to resolve several simpler an=
d
> smaller conflicts?

yes - thats certainly part of it.
I added iteratively as a simplification.
I suspect there are more clever ways to do it.

the simplest case is to move a fixup patch backwards where no conflicts=
 arise,
put the fixup right after the patch where the errant code was added.

the harder one is to recognize and resolve the interim conflicts.
To avoid handwaving, I reconstructed my particular case,
which is available on github:
https://github.com/jimc/linux-2.6/tree/rebase-back-usecase

1 - patches 1-11 on dynamic-debug, from Jason Baron, last Thurs.
     (these are the ones that gave git am heartburn, fixed in git-next)
2 - Suggestion by Joe Perches to use C-99
     I cut pasted his suggestion, made a commit.
     d61db7e joes suggestion C-99
3 - 53929c5 drop enabled, check flags&bitmask
4 - 57a9be0 prefer CONFIG_DYNAMIC_DEBUG over DEBUG
5 - fixup, which needs to go back to just after 2.

specifically:
[jimc@groucho linux-2.6]$ git log --oneline -5
07d4a51 fixup C-99, move attribute before assignment
57a9be0 prefer CONFIG_DYNAMIC_DEBUG over DEBUG
53929c5 drop enabled, check flags&bitmask
d61db7e joes suggestion C-99
f06abb5 dynamic_debug: use a single printk() to emit msgs

> =A0I have to admit that I work around this problem by
> running 'rebase -i' several times, moving the commit back in the
> sequence little-by-little.

when I did it manually,
there were a number of conficts to resolve.
pretty minor really, but tedious.

<<<<<<< HEAD
		.enabled =3D false,				       \
	} __used __aligned(8) __attribute__((section("__verbose")))
=3D=3D=3D=3D=3D=3D=3D
	}
>>>>>>> 07d4a51... fixup C-99, move attribute before assignment

if I could say:

[jimc@groucho linux-2.6]$ git rebase -i HEAD~5
pick f06abb5 dynamic_debug: use a single printk() to emit msgs
pick d61db7e joes suggestion C-99
pick 53929c5 drop enabled, check flags&bitmask
pick 57a9be0 prefer CONFIG_DYNAMIC_DEBUG over DEBUG
*back* 07d4a51 fixup C-99, move attribute before assignment

and get something like (but with diff commit-ids)

[jimc@groucho linux-2.6]$ git log --oneline -5
57a9be0 prefer CONFIG_DYNAMIC_DEBUG over DEBUG
53929c5 drop enabled, check flags&bitmask
07d4a51 fixup C-99, move attribute before assignment
d61db7e joes suggestion C-99
f06abb5 dynamic_debug: use a single printk() to emit msgs

that would be *slick*
I wonder if a 3-way merge is a partial answer to the conflicts that ari=
se?

>
> -- Ram
>

thanks
Jim

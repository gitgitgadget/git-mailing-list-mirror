From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 9 Nov 2010 10:35:26 +0100
Message-ID: <AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
	<1288524860-538-2-git-send-email-avarab@gmail.com>
	<4CCFCCC8.7080603@viscovery.net>
	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
	<4CD8F965.6050402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 10:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFkc8-0006Rv-Rc
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 10:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0KIJfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 04:35:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33208 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab0KIJf1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 04:35:27 -0500
Received: by fxm16 with SMTP id 16so4773138fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 01:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=12arna1aNfVhvpjcM3Qtt0DSXkgH7hBJbC8NIe/jnyM=;
        b=c4RhRJJxKY3tv02cBX0qbRFz4OKpWboiMPk8NlhqY0PybE3FU/lY45MQDgl7yOZ5Ax
         VBxgkAB5VqagfBsxDh4RC4vctm87XAoZIMBVV3/tNqPHhoEwFU4q8Sie61OrBWRXT/NT
         /mRMztq5vD0TM6jxz4isW7t4rppxWOnb0y7Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kr3Hit4AJg+Y5o5lRUCZy+tRxOO37UV8lehcjj2Ekk5aAh3KNovO+PY6TA6J4iaS+g
         fE7FWNAKMFLw+YaZ6+OIdxSwa+k/6lwUtmmJTee3QasWH84fbigzjGOxQnH/JHCjBC/B
         iODgV8lgUntP4FBsJgo1jM8emPrcYsmLQ+A+M=
Received: by 10.223.69.134 with SMTP id z6mr4982413fai.19.1289295326407; Tue,
 09 Nov 2010 01:35:26 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 01:35:26 -0800 (PST)
In-Reply-To: <4CD8F965.6050402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161026>

On Tue, Nov 9, 2010 at 08:33, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 11/8/2010 23:39, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> =C2=A0 =C2=A0 eval_gettext () {
>> =C2=A0 =C2=A0 =C2=A0 gettext "$1" | (export PATH `envsubst --variabl=
es "$1"`; envsubst "$1")
>> =C2=A0 =C2=A0 }
>
> So, for every message printed, you have at least 3 fork()s (usually e=
ven
> more)! I'm not happy about that. You *must* avoid this at least for
> NO_GETTEXT builds, but if you can reduce them even for no-NO_GETTEXT
> builds, it would be great.

Why is that a "*must*"? For the GNU gettext versions (our will be
faster, if anything):

    $ time (for i in {1..1000}; do gettext "foobar"; done) >/dev/null
    real    0m3.219s
    user    0m0.253s
    sys     0m2.570s

    $ time (for i in {1..1000}; do eval_gettext "foobar"; done) >/dev/n=
ull
    real    0m12.615s
    user    0m1.264s
    sys     0m12.384s

So that's around 0.003 seconds and 0.01 seconds per message for
gettext() and eval_gettext() respectively.

I'm not indifferent to that slight cost, but (almost?) all of the
eval_gettext messages we have are just printing out an error message
before we die. None of them are inside a tight loop. This is the
typical use case:

    git-am.sh:    eval_gettext "When you have resolved this problem
run \"\$cmdline --resolved\".
    git-am.sh:                      clean_abort "$(eval_gettext "Patch
format \$patch_format is not supported.")"
    git-am.sh:      die "$(eval_gettext "previous rebase directory
\$dotest still exists but mbox given.")"
    git-am.sh:              die "$(eval_gettext "Dirty index: cannot
apply patches (dirty: \$files)")"
    git-am.sh:                      eval_gettext "Patch is empty.  Was
it split wrong?
    git-am.sh:      say "$(eval_gettext "Applying: \$FIRSTLINE")"
    git-am.sh:              eval_gettext 'Patch failed at $msgnum
$FIRSTLINE'; echo
    git-bisect.sh:                  die "$(eval_gettext "'\$arg' does
not appear to be a valid revision")"
    git-bisect.sh:          *)              die "$(eval_gettext "Bad
bisect_write argument: \$state")" ;;
    git-bisect.sh:                revs=3D$(git rev-list "$arg") || die
"$(eval_gettext "Bad rev input: \$arg")" ;;
    git-bisect.sh:                          die "$(eval_gettext "Bad
rev input: \$rev")"
    git-bisect.sh:         die "$(eval_gettext "'\$invalid' is not a
valid commit")"
    git-bisect.sh:  test -r "$file" || die "$(eval_gettext "cannot
read \$file for replaying")"
    git-bisect.sh:      eval_gettext "running \$command"; echo
    git-bisect.sh:    echo >&2 "$(eval_gettext "bisect run failed:
    git-bisect.sh:    echo >&2 "$(eval_gettext "bisect run failed:

The cost for that is going to be much less than the time we spend on
forking out to sed, grep and other similar utilities inside our shell
scripts. If eval_gettext() is slowing things down noticeably that's
probably a sign that we need to rewrite the script in C, not
micro-optimize the eval_gettext() implementation.

But maybe you have reason to think otherwise? I haven't noticed any
noticable slowdowns from doing it this way, but maybe I've been
looking at the wrong thing.

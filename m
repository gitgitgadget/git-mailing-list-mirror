From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 23 Jun 2015 12:27:30 -0700
Message-ID: <xmqqwpyucjj1.fsf@gitster.dls.corp.google.com>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 21:27:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Tr9-0005WX-2J
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 21:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbbFWT1f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 15:27:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36551 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbbFWT1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 15:27:33 -0400
Received: by iecvh10 with SMTP id vh10so18811841iec.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=IG2Y46OvHuet+YFj6+jISMgxBMLsIHGtTX+rR/NVEkU=;
        b=GKW0JILw+dSDuPWm166Et0r0lu+rJb7cX3lhsfHcMdNAAdm7mbCScqcaCBrEY98aho
         Ppi4f3fuxn0ZF+om7q0fZ9KT5e3WIOvi9EcaHkP0oli3EZEHpgQqNkk3r0OWcX2C2l1T
         OtbIfAwTAcWjUHDsvfKu1f8IfPAWcOPNr52EwMKQc1JD7SxHVEjh4XUT9qrg2TZiO7y4
         3ywf4MVeYf0DGgtkl8iOgitUlsbVlOby4dc20FIB2LUg1U9eEr4SNz+sVaVJWXZF0YyG
         LNv+KjxB280UQEhLEg4+VGL6HdSgLa5C8kksrDHu5zeOtQ9oR5PLNA69xuQw+HRwzZRR
         aldA==
X-Received: by 10.43.66.5 with SMTP id xo5mr32956921icb.57.1435087652678;
        Tue, 23 Jun 2015 12:27:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id l67sm7618278ioe.3.2015.06.23.12.27.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 12:27:31 -0700 (PDT)
In-Reply-To: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan =?utf-8?Q?R=C3=A9mi=22's?= message of "Mon, 22 Jun 2015 23:42:47
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272486>

Galan R=C3=A9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> +test_rebase_end () {
> +	test_when_finished "git checkout master &&
> +	git branch -D $1 &&

Is this one guaranteed to succeed?  Do we want to consider it a
failure to remove "$1" (e.g. dropTest)?

    $ git branch -D no-such-branch ; echo $?
    error: branch 'no-such-branch' not found.
    1

If dropTest branch did not exist before the test that begins with
a call to this function, what happens?

Besides, a function that must be called at the beginning of a test
piece has a name that ends with _end?  That sounds funny, no?

> +	test_might_fail git rebase --abort" &&
> +	git checkout -b $1 master
> +}

I'm wondering if this is not sufficient.

	test_rebase_i_drop_prepare () {
		git reset --hard &&
	        git checkout -B "$1" master
	}

I am guessing that you named _end because it has when_finished, but
as far as I can tell, even after these three patches, the tests do
not really rely on the fact that it is on 'master' branch.  More
importantly, just being on 'master' branch is not a sufficient
cleanliness for the next test (and that is why you added these
"branch -D" and "might-fail rebase --abort" to this function in the
first place), it seems.  So...

> +test_expect_success 'drop' '
> +	test_rebase_end dropTest &&
> +	set_fake_editor &&
> +	FAKE_LINES=3D"1 drop 2 3 drop 4 5" git rebase -i --root &&
> +	test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test C =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
> +	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
> +'
> +
>  test_done

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] revert: refactor code that prints success or
 failure message
Date: Mon, 12 Jul 2010 11:30:43 -0500
Message-ID: <20100712163043.GA1531@burratino>
References: <20100712115455.12251.53947.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 12 18:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYLur-00088j-HZ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 18:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab0GLQbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 12:31:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43697 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0GLQbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 12:31:31 -0400
Received: by iwn7 with SMTP id 7so4805058iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SmxKWbH0O6ODnDdQ+fyAq2+zA16+Ikg9zSaeTAJPdgk=;
        b=LnY6P/65cgnWkVRWc+W9XSmRgB0pvhxdH2+r1qN7KGVV74KeCltdsGlqJ1YIle8aEX
         eLqrR71egVGVPBDwqXltzaVzE2GbehEjTYSR9dca74bGIRYb2xVetQfOvVEU6F1oXJZy
         XKo9upSjD0hkmfCAw9T9vqHVsJezcsQdwacEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ONOXLz36Zn/irgh65PDfWQu2Uno73BI26HVdnYAeAOJ5f1eE8a8x3EkpiHvbBCeu6r
         bZXF0EOXq0JkHMhrjPnmH0qNlFhgHah9AhG3ohzbeVCAiM0EHm7OOqSSb+3wOiSisIcl
         2Yva4kA7qewhfZjwHGTNJgiXWE9BGO2iekvZc=
Received: by 10.231.12.76 with SMTP id w12mr13833629ibw.87.1278952289988;
        Mon, 12 Jul 2010 09:31:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm20389969ibi.0.2010.07.12.09.31.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 09:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100712115455.12251.53947.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150824>

Hi,

Christian Couder wrote:

> This patch refactors the code that prints a message like
> "Automatic cherry-pick failed. <help message>".

=46rom the point of view of refactoring, it does not seem
so promising: the patch adds more code than it removes.

 $ git diff --numstat HEAD^
 29	22	builtin/revert.c
 25	 1	t/t3508-cherry-pick-many-commits.sh

So I am hoping there is some other reason.

> To do that, now do_recursive_merge() returns an int to signal
> success or failure. And in case of failure we just return 1
> from do_pick_commit() instead of doing "exit(1)" from either
> do_recursive_merge() or do_pick_commit().

This part sounds like libification...

> In case of successful merge, do_recursive_merge() used to print
> something like "Finished one cherry-pick." but nothing was
> printed in case a special strategy like "resolve" was used.
> Now in this case a message like "Finished one cherry-pick with
> strategy resolve." is printed.
>
> So the command behavior should be more consistent wether we are
> using a special strategy or not.

This part sounds like improving output in the cherry-pick --strategy
success case.

> 	I also wonder why messages like "Finished one cherry-pick."
> 	are printed on stderr instead of stdout.

Progress reports tend to go to stderr, since they are not what the
user wanted to learn from the command but side-effects.  In other
words, I think the general principle is that

 $ git <foo> 2>/dev/null

should output whatever a traditional Unix command would (usually
nothing).

> 	And while at making a backward incompatible change, maybe
> 	we could change the message to something like:
>=20
> 	"Finished cherry-pick <sha1>"

Does <sha1> represent the old commit or the new one?

I can=E2=80=99t come up with a reason to worry about backward compatibi=
lity in
this case.  Messages to stderr from porcelain are not guaranteed to be
stable.

> +++ b/builtin/revert.c
> @@ -357,14 +356,9 @@ static void do_recursive_merge(struct commit *ba=
se, struct commit *next,
>  					i++;
>  			}
>  		}
> -		write_message(msgbuf, defmsg);
> -		fprintf(stderr, "Automatic %s failed.%s\n",
> -			me, help_msg());
> -		rerere(allow_rerere_auto);
> -		exit(1);
>  	}
> -	write_message(msgbuf, defmsg);
> -	fprintf(stderr, "Finished one %s.\n", me);
> +
> +	return !clean;
>  }

The return value is 1 if dirty, 0 if clean.  In any other
situation (e.g., the index locking or the merge machinery breaks)
it will still die, so this is not about libification.  Is it
is for unification with the try_merge_command case?

> @@ -470,30 +466,41 @@ static int do_pick_commit(void)
[...]
> +	if (res) {
> +		fprintf(stderr, "Automatic %s failed.%s\n",
> +			mebuf.buf, help_msg());
> +		rerere(allow_rerere_auto);
> +	} else {
> +		fprintf(stderr, "Finished one %s.\n", mebuf.buf);
> +	}
> +
> +	strbuf_release(&mebuf);

Yep, looks like it is.

[...]
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -23,12 +23,36 @@ test_expect_success setup '

New tests for the success output.

>  '
> =20
>  test_expect_success 'cherry-pick first..fourth works' '
> +	cat <<-EOF > expected &&
> +	Finished one cherry-pick.
> +	Finished one cherry-pick.
> +	Finished one cherry-pick.
> +	EOF
> +
> +	git checkout -f master &&
> +	git reset --hard first &&
> +	test_tick &&
> +	git cherry-pick first..fourth 2>actual &&
> +	git diff --quiet other &&
> +	git diff --quiet HEAD other &&
> +	test_cmp expected actual &&

This breaks test runs with sh -x or GIT_TRACE=3D1 (I am not sure
whether we support them, but I think it is worth avoiding
problems where possible).  Maybe:

	...
	grep "Finished one cherry-pick\." actual >filtered &&
	n=3D$(wc -l <filtered) &&
	... &&
	test $n -eq 3

Summary: I was misled by the commit message.  Maybe something
like

	Subject: cherry-pick --strategy: report success

	"git cherry-pick foo" has always reported success
	with "Finished one cherry-pick" and cherry-pick
	--strategy is starting to feel left out.  Move the
	code to write that message from do_recursive_merge
	to do_cherry_pick so other strategies can share it.

would have set me straight.

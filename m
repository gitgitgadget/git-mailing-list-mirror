From: Jardel Weyrich <jweyrich@gmail.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Sat, 12 Jan 2013 06:09:35 -0200
Message-ID: <CAN8TAOvP_HX6BEK86aYoX-kVqWDmsbyptxTT2nk+fx+Ut1Tojg@mail.gmail.com>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:18:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtwI5-0008Nq-67
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 09:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3ALIKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 03:10:18 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:57548 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab3ALIKR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 03:10:17 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so1158837wge.34
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 00:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=AqzgTiNEQKDLbZO9jOM22cp44IAxuTiJ6qpneEtOJu8=;
        b=wvYMeLsbmv/NhAs8sUCvZTYZoGVaP25aoUr108RZvlS+IKa4J8ZoRx9doBU5i7lG51
         cEPoaTDn6VCZkzAk6R0jWKHhxmKvDCQxcoTrSI+PMAuZwq42oRCL6cizcPL1MzbakcSO
         CSZc90K7TiVhjr/zSnXffiMGUBH7m44ayPe8MsSFo4Ng8hD4YV3GnlWhbFlAyXUr3muU
         pdA+FQ4rx7mP1MeQFLBINcia+4LIYDtBH0eeoB32vE9hPXdQ0Q6fplYPXdFGl/kjklgU
         u+JnzTG7CkYBQ/qkcZpw27Zgb1A3raf83oPBcSxD9AdGmeLH1SGQgtqjRNvz3tw5od5s
         DDAw==
X-Received: by 10.180.33.44 with SMTP id o12mr2839219wii.28.1357978215828;
 Sat, 12 Jan 2013 00:10:15 -0800 (PST)
Received: by 10.194.118.167 with HTTP; Sat, 12 Jan 2013 00:09:35 -0800 (PST)
In-Reply-To: <7vliby98r7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213275>

Step 1:

jweyrich@pharao:test_clone1 [* master]$ git remote -v
origin /Volumes/sandbox/test (fetch)
origin /Volumes/sandbox/test (push)

jweyrich@pharao:test_clone1 [* master]$ git config -l | grep '^remote\.=
origin'
remote.origin.url=3D/Volumes/sandbox/test
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*

Step 3:

jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add
--push origin /Volumes/sandbox/test_clone2
origin /Volumes/sandbox/test (fetch)
origin /Volumes/sandbox/test_clone2/ (push)

jweyrich@pharao:test_clone1 [* master]$ git config -l | grep '^remote\.=
origin'
remote.origin.url=3D/Volumes/sandbox/test
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
remote.origin.pushurl=3D/Volumes/sandbox/test_clone2/


After that, if I do a commit in test_clone1 and try to push to origin,
it pushes only to the test_clone2 rather than pushing to both test and
test_clone2 (it's a bare repo, sorry for using a misleading name).

Is `remote.<remote_name>.pushurl` required for the primary URL as
well? If not, then git-push is not handling that information as it
should.

On Sat, Jan 12, 2013 at 5:10 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jardel Weyrich <jweyrich@gmail.com> writes:
>
>> I believe `remote set-url --add --push` has a bug. Performed tests
>> with v1.8.0.1 and v1.8.1 (Mac OS X).
>>
>> Quoting the relevant part of the documentation:
>>
>>> set-url
>>>     Changes URL remote points to. Sets first URL remote points to m=
atching regex <oldurl> (first URL if no <oldurl> is given) to <newurl>.=
 If <oldurl> doesn=E2=80=99t match any URL, error occurs and nothing is=
 changed.
>>>
>>>     With --push, push URLs are manipulated instead of fetch URLs.
>>>     With --add, instead of changing some URL, new URL is added.
>>>     With --delete, instead of changing some URL, all URLs matching =
regex <url> are deleted. Trying to delete all non-push URLs is an error=
=2E
>>
>> Here are some steps to reproduce:
>>
>> 1. Show the remote URLs
>>
>> jweyrich@pharao:test_clone1 [* master]$ git remote -v
>> origin  /Volumes/sandbox/test (fetch)
>> origin  /Volumes/sandbox/test (push)
>>
>> 2. Add a new push URL for origin
>>
>> jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add --p=
ush origin \
>>     /Volumes/sandbox/test_clone2
>>
>> 3. Check what happened
>>
>> jweyrich@pharao:test_clone1 [* master]$ git remote -v
>> origin  /Volumes/sandbox/test (fetch)
>> origin  /Volumes/sandbox/test_clone2 (push)
>
> The original pushurl was replaced with the additional one, instead
> of being left and the new one getting added.  That looks certainly
> wrong.
>
> However, the result of applying the attached patch (either to
> v1.7.12 or v1.8.1) still passes the test and I do not think it is
> doing anything differently from what you described above.
>
> What do you get from
>
>         git config -l | grep '^remote\.origin'
>
> in steps 1. and 3. in your procedure?  This question is trying to
> tell if your bug is in "git remote -v" or in "git remote set-url".
>
> -- >8 --
> From 0f6cbc67db926e97707ae732b02e790b4604508e Mon Sep 17 00:00:00 200=
1
> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 11 Jan 2013 23:04:16 -0800
> Subject: [PATCH] t5505: adding one pushurl from jweyrich
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5505-remote.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index c03ffdd..b31c5bb 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -901,6 +901,25 @@ test_expect_success 'remote set-url --push --add=
 aaa' '
>         cmp expect actual
>  '
>
> +test_expect_success 'remote set-url --push --add' '
> +       git config remote.jweyrich.url /Volumes/sandbox/test &&
> +       git config remote.jweyrich.pushurl /Volumes/sandbox/test &&
> +       git config remote.jweyrich.fetch "refs/heads/*:refs/remotes/j=
weyrich/*" &&
> +
> +       added=3D/Volumes/sandbox/test_clone2 &&
> +       {
> +               git config -l | grep "^remote\.jweyrich\." &&
> +               echo "remote.jweyrich.pushurl=3D$added"
> +       } | sort >expect &&
> +
> +       git remote set-url --add --push jweyrich "$added" &&
> +       git config -l | grep "^remote\.jweyrich\." | sort >actual &&
> +
> +       test_cmp expect actual &&
> +
> +       git remote -v | grep "^jweyrich" # this is just for debugging
> +'
> +
>  test_expect_success 'remote set-url --push bar aaa' '
>         git remote set-url --push someremote bar aaa &&
>         echo foo >expect &&
> --
> 1.8.1.421.g6236851

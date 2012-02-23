From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH] git-svn.perl: fix a false-positive in the "already
 exists" test
Date: Thu, 23 Feb 2012 18:17:33 -0500
Message-ID: <CAK8d-aJufwFobREQ6R3Oxr=J7hbVtoZ7wvhurb=LQGUFO9tTsw@mail.gmail.com>
References: <20120219105442.GA11889@dcvr.yhbt.net> <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
 <7vk43feho8.fsf@alter.siamese.dyndns.org> <CAK8d-aLXs0yMzYMXm7fKytOGDXesUEx7a8PN_Mg9gw6+Q6OTBA@mail.gmail.com>
 <7vmx8bcv4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: normalperson@yhbt.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 00:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0hvE-0003g4-RK
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 00:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab2BWXRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 18:17:54 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53040 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab2BWXRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 18:17:53 -0500
Received: by yhoo21 with SMTP id o21so903884yho.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 15:17:53 -0800 (PST)
Received-SPF: pass (google.com: domain of stevenrwalter@gmail.com designates 10.236.157.9 as permitted sender) client-ip=10.236.157.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stevenrwalter@gmail.com designates 10.236.157.9 as permitted sender) smtp.mail=stevenrwalter@gmail.com; dkim=pass header.i=stevenrwalter@gmail.com
Received: from mr.google.com ([10.236.157.9])
        by 10.236.157.9 with SMTP id n9mr6741705yhk.96.1330039073303 (num_hops = 1);
        Thu, 23 Feb 2012 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Pj6lWvNzHAfLrhera1tkhazHcMxFq4hm0Cu2KjWf9ec=;
        b=JeuhNpSw2Ko3zNv8BTC78LASLUgfgLOGrnzJ8Jr28JdeuI49mcacdwb/yBbAPDLWD6
         eAuXXFXXHVg9tl5iwExjjNhhcV1lLjUji8zyDPskQf49Jc9Fo/9JdUkNnAs97JlBFKhg
         Cc/cmSe2ZEshtqOsjOBfoSuPk6i51wFYScSf4=
Received: by 10.236.157.9 with SMTP id n9mr5441117yhk.96.1330039073242; Thu,
 23 Feb 2012 15:17:53 -0800 (PST)
Received: by 10.100.96.10 with HTTP; Thu, 23 Feb 2012 15:17:33 -0800 (PST)
In-Reply-To: <7vmx8bcv4u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191403>

Signed-Off-By: Steven Walter <stevenrwalter@gmail.com>

On Wed, Feb 22, 2012 at 12:08 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Steven Walter <stevenrwalter@gmail.com> writes:
>
>>>> + =A0 =A0 test -e "$SVN_TREE"/bar/zzz/yyy ' || true
>>>
>>> Care to explain what this " || true" is doing here, please?
>>
>> Ahh, good catch. =A0I think the answer is that it shouldn't be there=
=2E
>> It was originally there because of the "test_must_fail" line, I thin=
k
>> (at least the other tests that use test_must_fail also have "||
>> true").
>
> Ok, that may explain the copy&paste error.
>
> But I do not think test_must_fail followed by || true makes much sens=
e,
> either. =A0The purpose of "test_must_fail" is to make sure the tested=
 git
> command exits with non-zero status in a controlled way (i.e. not cras=
h)
> so if the tested command that is expected to exit with non-zero statu=
s
> exited with zero status, the test has detected an *error*. =A0E.g. if=
 you
> know that the index and the working tree are different at one point i=
n the
> test sequence, you would say:
>
> =A0 =A0 =A0 =A0... other setup steps ... &&
> =A0 =A0 =A0 =A0test_must_fail git diff --exit-code &&
> =A0 =A0 =A0 =A0... and other tests ...
>
> so that failure by "git diff --exit-code" to exit with non-zero statu=
s
> (i.e. it did not find any difference when it should have) breaks the =
&&
> cascade.
>
> I just took a quick look at t9100 but I think all " || true" can be s=
afely
> removed. =A0None of them is associated with test_must_fail in any way=
=2E =A0For
> whatever reason, these test seem to do
>
> =A0 =A0 =A0 =A0test_expect_success 'label of the test' '
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0body of the test
> =A0 =A0 =A0 =A0' || true
>
> for no good reason.
>
>> Do you want to just fix that up, or a new version of the original pa=
tch,
>> or a fix on top of the original patches?
>
> Eric queued the patch and then had me pull it as part of his history
> already, so it is doubly too late to replace it.
>
> Can you apply this patch and re-test?
>
>
> =A0t/t9100-git-svn-basic.sh | =A0 14 +++++++++-----
> =A01 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 4029f84..749b75e 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -65,7 +65,8 @@ test_expect_success "$name" "
> =A0 =A0 =A0 =A0git update-index --add dir/file/file &&
> =A0 =A0 =A0 =A0git commit -m '$name' &&
> =A0 =A0 =A0 =A0test_must_fail git svn set-tree --find-copies-harder -=
-rmdir \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${remotes_git_svn}..mybranch" || true
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${remotes_git_svn}..mybranch
> +"
>
>
> =A0name=3D'detect node change from directory to file #1'
> @@ -79,7 +80,8 @@ test_expect_success "$name" '
> =A0 =A0 =A0 =A0git update-index --add -- bar &&
> =A0 =A0 =A0 =A0git commit -m "$name" &&
> =A0 =A0 =A0 =A0test_must_fail git svn set-tree --find-copies-harder -=
-rmdir \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${remotes_git_svn}..mybranch2' || true
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${remotes_git_svn}..mybranch2
> +'
>
>
> =A0name=3D'detect node change from file to directory #2'
> @@ -96,7 +98,8 @@ test_expect_success "$name" '
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${remotes_git_svn}..mybranch3 &&
> =A0 =A0 =A0 =A0svn_cmd up "$SVN_TREE" &&
> =A0 =A0 =A0 =A0test -d "$SVN_TREE"/bar/zzz &&
> - =A0 =A0 =A0 test -e "$SVN_TREE"/bar/zzz/yyy ' || true
> + =A0 =A0 =A0 test -e "$SVN_TREE"/bar/zzz/yyy
> +'
>
> =A0name=3D'detect node change from directory to file #2'
> =A0test_expect_success "$name" '
> @@ -109,7 +112,8 @@ test_expect_success "$name" '
> =A0 =A0 =A0 =A0git update-index --add -- dir &&
> =A0 =A0 =A0 =A0git commit -m "$name" &&
> =A0 =A0 =A0 =A0test_must_fail git svn set-tree --find-copies-harder -=
-rmdir \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${remotes_git_svn}..mybranch4' || true
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${remotes_git_svn}..mybranch4
> +'
>
>
> =A0name=3D'remove executable bit from a file'
> @@ -162,7 +166,7 @@ test_expect_success "$name" '
>
> =A0name=3D'modify a symlink to become a file'
> =A0test_expect_success "$name" '
> - =A0 =A0 =A0 echo git help > help || true &&
> + =A0 =A0 =A0 echo git help >help &&
> =A0 =A0 =A0 =A0rm exec-2.sh &&
> =A0 =A0 =A0 =A0cp help exec-2.sh &&
> =A0 =A0 =A0 =A0git update-index exec-2.sh &&



--=20
-Steven Walter <stevenrwalter@gmail.com>

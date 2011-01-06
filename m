From: Albert Dvornik <dvornik+git@gmail.com>
Subject: Re: "git svn fetch" on a branch is broken after "git svn reset"
Date: Thu, 6 Jan 2011 00:00:25 -0500
Message-ID: <AANLkTikMjj1PFRQCs7N58Y+GCruEHv1FZc1OPN4r9Yr1@mail.gmail.com>
References: <AANLkTikhaPP0bHEEeFf_2RgK_bdE-i+gaCKopfQjqgHP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c104e398830049926613a
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 06:01:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PahyN-0007XH-Kh
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 06:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950Ab1AFFA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 00:00:28 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33383 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab1AFFA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 00:00:27 -0500
Received: by eye27 with SMTP id 27so7040457eye.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 21:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=iP7hTcSO9ThUW7tbHFfkwyqNGEhPFrJm3L+vOXN+GbA=;
        b=yGmE64l8U8i2UV+UpWxXfe0gYJhHRD+jYocXorkLGZF0BnI4mdvW+5up5ycEme/utH
         3xhwIhfIzRpD4uwMmzKn04SodSXbmcDAoIQyxuv9KEvvrBIv+IqttfikNkFIbYgUHr26
         heURfyLk+flwcgwWv++vlawjm4aXWdrBO9Wd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=KdhT2E4B7bmzOzCOVUiZyPuxVK6bez3VM0mxMLf3dtAR4JMfq6tHC7ZgfA3AfzPNCZ
         ufW2qzbbusk1mClrrOQhml9pvdL4QSeAWltNjPtoEAZqjpkM5I3Dxy/IgFzyTSNsiP9Q
         VE7gjLt+zAOU9t7I8kl4PJdiy4x97RZAwq1dk=
Received: by 10.213.33.143 with SMTP id h15mr6115292ebd.95.1294290025809; Wed,
 05 Jan 2011 21:00:25 -0800 (PST)
Received: by 10.213.8.212 with HTTP; Wed, 5 Jan 2011 21:00:25 -0800 (PST)
In-Reply-To: <AANLkTikhaPP0bHEEeFf_2RgK_bdE-i+gaCKopfQjqgHP@mail.gmail.com>
X-Google-Sender-Auth: HBBX_xBFO7djR1fSkHjOcecx53U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164623>

--0015174c104e398830049926613a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here is a reproducer using a very simple public SVN repo.

[I spent a bit of effort on trying to figure out what's going on, but
git-svn code, er, has a learning curve. =3D)  After a reset, fetch_all()
correctly backs up $base when fetching on the trunk, but not on the
branch, because $gs->rev_map_max returns a correctly reset value in
one case but not the other.  This may be because $fetch ALWAYS seems
to refer to the trunk; is that supposed to be the case?]

--bert Dvornik

On Wed, Jan 5, 2011 at 1:22 AM, Albert Dvornik <dvornik+git@gmail.com> wrot=
e:
> The documentation for git svn claims that this should work:
>
> =A0 =A0git svn reset -r2 -p
> =A0 =A0git svn fetch
>
> But when I tried it (using an SVN tree that has recent commits only in
> a branch, not the trunk), it didn't work correctly. =A0"fetch" grabbed
> just the latest version from SVN, and not all revs from <revnum> to
> the head! =A0Note that it matters that this is in an SVN branch-- if I
> repeat the test using revs in the trunk, everything works as expected.
>
> Specifically, what I did was this:
>
> =A0 =A0git co -b testing refs/remotes/test-branch
> =A0 =A0git svn fetch
>
> =A0 =A0git svn reset -r 850
> =A0 =A0# does correctly rewind to rev 850, undoing commits in test-branch
>
> =A0 =A0git svn fetch
> =A0 =A0# oops, only fetches the *head* revision (rev 856) from SVN!
> =A0 =A0# In refs/remotes/test-branch, SVN rev 850 is now followed by 856!
>
> I then tried this again, but between reset and fetching I manually
> edited .git/svn/.metadata and moved back the *-maxRev versions to 850;
> after doing this, the fetch does the right thing. =A0I tried examining
> the logic in git-svn.perl to figure out why this happens and why it
> would be affecting a branch but not the trunk, but I didn't get very
> far.
>
> I can reproduce the problem on Linux (git version 1.7.2.1) and Windows
> (Git for Windows version 1.7.3.2.msysgit.0.4.ga4f3f or Cygwin git
> 1.7.2.3).
>
> Thoughts?
>
> --bert
>

--0015174c104e398830049926613a
Content-Type: application/x-sh; name="svn-reset-test.sh"
Content-Disposition: attachment; filename="svn-reset-test.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gil6r0yh0

IyEvYmluL2Jhc2gNCg0Kc3RhcnRfd2Q9ImBwd2RgIg0KDQpydW5fdGVzdCAoKSB7DQogICAgbG9j
YWwgcnJlcG89IiQxIg0KICAgIGxvY2FsIHJicmFuY2g9IiQyIg0KICAgIGxvY2FsIHJldj0iJDMi
DQogICAgbG9jYWwgcGVlPSIkNCIgIyAnLXAnIG9yICcnDQoNCiAgICBsb2NhbCBscmVwbz0iYGJh
c2VuYW1lICIkcnJlcG8iYCINCg0KICAgIGNkICIkc3RhcnRfd2QiDQoNCiAgICBkaXI9DQogICAg
Zm9yIGkgaW4gJycgLWEgLWIgLWMgLWQgLWUgLWYgLWcgLWggLWkgLWogLWsgLWwgLW0gLW4gLW8g
LXAgLXEgLXIgLXMgLXQ7IGRvDQoJaWYgWyAhIC1lICJzdm4tdGVzdC0kbHJlcG8kaSIgXTsgdGhl
bg0KCSAgICBkaXI9InN2bi10ZXN0LSRscmVwbyRpIjsgYnJlYWsNCglmaQ0KICAgIGRvbmUNCiAg
ICBpZiBbIC16ICIkZGlyIiBdOyB0aGVuIGVjaG8gIioqKiBubyB1bnVzZWQgZGlyZWN0b3J5IiA+
JjI7IGV4aXQgMTsgZmkNCg0KICAgIGdpdCBzdm4gY2xvbmUgLXEgLXMgIiRycmVwbyIgIiRkaXIi
DQogICAgY2QgIiRkaXIiDQoNCiAgICBnaXQgY28gLXEgLWIgdGVzdGluZyByZWZzL3JlbW90ZXMv
IiRyYnJhbmNoIg0KICAgIGxvY2FsIHJldl9yZWFsX2hlYWQ9ImBnaXQgc3ZuIGZpbmQtcmV2IEhF
QURgIg0KICAgIGxvY2FsIHJldl9yZWFsX3BhcmVudD0iYGdpdCBzdm4gZmluZC1yZXYgSEVBRF5g
Ig0KDQogICAgZ2l0IHN2biByZXNldCAtciIkcmV2IiAkcGVlDQogICAgZWNobyAiLS0gcmVzZXQg
ZG9uZSwgdHJ5aW5nIHRvIGZldGNoIC0tIg0KDQogICAgZ2l0IGNvIC1xIC1iIHRlc3RpbmcyIHJl
ZnMvcmVtb3Rlcy8iJHJicmFuY2giDQogICAgIyMgUE9TU0lCTEUgV09SSy1BUk9VTkQ6IHJlc2V0
IGJyYW5jaGVzLW1heFJldiB0byB0aGUgbmV3IEhFQUQgcmV2IG51bWJlci4NCiAgICAjIyAoSXQg
c2VlbXMgdG8gd29yaywgYnV0IEkgZG9uJ3Qga25vdyB3aHkgeWV0LikNCiAgICAjZ2l0IGNvbmZp
ZyAtLWZpbGUgLmdpdC9zdm4vLm1ldGFkYXRhIFwNCiAgICAjICAgIC0taW50IHN2bi1yZW1vdGUu
c3ZuLmJyYW5jaGVzLW1heFJldiBgZ2l0IHN2biBmaW5kLXJldiBIRUFEYA0KDQogICAgZ2l0IHN2
biBmZXRjaA0KDQogICAgbG9jYWwgcmV2X2hlYWQ9ImBnaXQgc3ZuIGZpbmQtcmV2ICIkcmJyYW5j
aCJgIg0KICAgIGxvY2FsIHJldl9wYXJlbnQ9ImBnaXQgc3ZuIGZpbmQtcmV2ICIkcmJyYW5jaCJe
YCINCiAgICBpZiBbICIkcmV2X2hlYWQiIC1uZSAiJHJldl9yZWFsX2hlYWQiIF07IHRoZW4NCgll
Y2hvICIqKiogV0FSTklORzogZmV0Y2ggZ290IHRvICRyZXZfaGVhZCwgbm90ICRyZXZfcmVhbF9o
ZWFkIChiYWQgZmV0Y2gpIg0KICAgIGVsaWYgWyAiJHJldl9wYXJlbnQiIC1uZSAiJHJldl9yZWFs
X3BhcmVudCIgXTsgdGhlbg0KCWVjaG8gIioqKiBXQVJOSU5HOiAkcmV2X3BhcmVudCBpcyBmb2xs
b3dlZCBieSAkcmV2X2hlYWQgKGJhZCBmZXRjaCkiDQogICAgZWxzZQ0KCWVjaG8gIk5vIHByb2Js
ZW0gd2FzIGZvdW5kIChieSBhbiBpZGlvdGljYWxseSBzaW1wbGUgY2hlY2spLiINCiAgICBmaQ0K
ICAgICNnaXRrIEhFQUQgLS1hbGwNCiAgICBlY2hvICI9PT09PSINCn0NCg0KI3J1bl90ZXN0IHN2
bjovL2JlcnQuc2NyaXB0cy5taXQuZWR1L2dpdHRlc3QvdHJ1bmsgIHRydW5rICAgICAgIDYgICMg
T0sNCnJ1bl90ZXN0IHN2bjovL2JlcnQuc2NyaXB0cy5taXQuZWR1L2dpdHRlc3QvYnJhbmNoIHRl
c3QtYnJhbmNoIDYgICMgYmFkICg2IDgpDQojcnVuX3Rlc3Qgc3ZuOi8vYmVydC5zY3JpcHRzLm1p
dC5lZHUvZ2l0dGVzdC9taXhlZDEgdHJ1bmsgICAgICAgNCAgIyBPSz8NCiNydW5fdGVzdCBzdm46
Ly9iZXJ0LnNjcmlwdHMubWl0LmVkdS9naXR0ZXN0L21peGVkMiB0cnVuayAgICAgICA0ICAjIE9L
Pw0KI3J1bl90ZXN0IHN2bjovL2JlcnQuc2NyaXB0cy5taXQuZWR1L2dpdHRlc3QvbWl4ZWQxIHRl
c3QtYnJhbmNoIDUgICMgYmFkIChANSkNCiNydW5fdGVzdCBzdm46Ly9iZXJ0LnNjcmlwdHMubWl0
LmVkdS9naXR0ZXN0L21peGVkMiB0ZXN0LWJyYW5jaCA1ICAjIGJhZCAoNSA5KQ0KDQojcnVuX3Rl
c3Qgc3ZuOi8vYmVydC5zY3JpcHRzLm1pdC5lZHUvZ2l0dGVzdC90cnVuayAgdHJ1bmsgICAgICAg
NiAtcCAjIE9LDQojcnVuX3Rlc3Qgc3ZuOi8vYmVydC5zY3JpcHRzLm1pdC5lZHUvZ2l0dGVzdC9i
cmFuY2ggdGVzdC1icmFuY2ggNiAtcCAjIGJhZCAoNSA4KQ0KI3J1bl90ZXN0IHN2bjovL2JlcnQu
c2NyaXB0cy5taXQuZWR1L2dpdHRlc3QvbWl4ZWQxIHRydW5rICAgICAgIDYgLXAgIyBPSz8NCiNy
dW5fdGVzdCBzdm46Ly9iZXJ0LnNjcmlwdHMubWl0LmVkdS9naXR0ZXN0L21peGVkMiB0cnVuayAg
ICAgICA2IC1wICMgT0s/DQojcnVuX3Rlc3Qgc3ZuOi8vYmVydC5zY3JpcHRzLm1pdC5lZHUvZ2l0
dGVzdC9taXhlZDEgdGVzdC1icmFuY2ggNyAtcCAjIGJhZCAoQDUpDQojcnVuX3Rlc3Qgc3ZuOi8v
YmVydC5zY3JpcHRzLm1pdC5lZHUvZ2l0dGVzdC9taXhlZDIgdGVzdC1icmFuY2ggNyAtcCAjIGJh
ZCAoNSA5KQ0K
--0015174c104e398830049926613a--

From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Wed, 16 Feb 2011 14:22:04 +0100
Message-ID: <AANLkTinsvfXjVhJfLDeZ+g4skev6bBmJgByyxXW7eO39@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364edc02eed441049c662b63
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 14:22:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PphKz-0003gm-B4
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 14:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab1BPNW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 08:22:26 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33098 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1BPNW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 08:22:26 -0500
Received: by qyj19 with SMTP id 19so3640770qyj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 05:22:25 -0800 (PST)
Received: by 10.229.186.7 with SMTP id cq7mr687629qcb.239.1297862544511; Wed,
 16 Feb 2011 05:22:24 -0800 (PST)
Received: by 10.229.225.8 with HTTP; Wed, 16 Feb 2011 05:22:04 -0800 (PST)
In-Reply-To: <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166965>

--0016364edc02eed441049c662b63
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2011 at 1:10 PM, Santi B=E9jar <santi@agolina.net> wrote:
> On Wed, Feb 16, 2011 at 3:03 AM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
>> On Tue, 15 Feb 2011, Junio C Hamano wrote:
>>
>>> Would bisection help to avoid the cost?
>>
>> I don't think the straight-forward use of bisection would work. If the
>> history looks something like below, where 'b' is the branch to rebase
>> and 'u' is the upstream, we have to go through each entry in the
>> reflog to find u@{3}.
>>
>>
>> =A0 =A0 =A0 =A0.-u@{0}
>> =A0 =A0 =A0 /
>> =A0 =A0 =A0.---u@{1}
>> =A0 =A0 /
>> x---y-----u@{2}
>> =A0 =A0 \
>> =A0 =A0 =A0.---u@{3}---b
>> =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0.-u@{4}
>>
>>
>> I have an idea inspired by bisection, Thomas's exponential stride, and
>> what someone (you?) mentioned the other day about virtual merge
>> commits. I haven't tried it out, but let me know what you think. I'll
>> try to explain it using an example only:
>>
>> Exponential stride phase:
>> 1. candidates=3D{ u@{0} }
>> =A0 merge-base b $candidates -> y, _not_ in $candidates
>> 2. candidates=3D{ u@{1} u@{2} }
>> =A0 merge-base b $candidates -> y, _not_ in $candidates
>> 3. candidates=3D{ u@{3} u@{4} u@{5} u@{6} }
>> =A0 merge-base b $candidates -> u@{3}, in $candidates
>
> Doesn't it indicate that u@{3} is the commit we are looking for? I
> haven't found a counterexample...
>
> If this is true the following patch can implement it for git-pull.sh and
> git-rebase.sh (sorry if it is space damaged):
>
> diff --git i/git-pull.sh w/git-pull.sh
> index 2cdea26..09ef0a9 100755
> --- i/git-pull.sh
> +++ w/git-pull.sh
> @@ -189,14 +189,7 @@ test true =3D "$rebase" && {
> =A0 =A0 =A0 =A0. git-parse-remote &&
> =A0 =A0 =A0 =A0remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" =
&&
> =A0 =A0 =A0 =A0oldremoteref=3D"$(git rev-parse -q --verify "$remoteref")"=
 &&
> - =A0 =A0 =A0 for reflog in $(git rev-list -g $remoteref 2>/dev/null)
> - =A0 =A0 =A0 do
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$reflog" =3D "$(git merge-base $re=
flog $curr_branch)"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldremoteref=3D"$reflog"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> - =A0 =A0 =A0 done
> + =A0 =A0 =A0 oldremoteref=3D$(git merge-base $curr_branch $oldremoteref =
$(git
> rev-list -g $remoteref 2>/dev/null))

One thing I forgot to say is that it seems to perform quite well:

Hot cache:

$ git rev-list -g origin/next | wc -l
36
$ git rev-list -g origin/master | wc -l
52
$ time git merge-base $(git rev-list -g origin/next)
3b781df0a25d5ba23bd2603b0e3e9bb4731369df

real	0m0.155s
user	0m0.064s
sys	0m0.044s
$ time git merge-base $(git rev-list -g origin/master)
7811d9600f02e70c9f835719c71156c967a684f7

real	0m0.161s
user	0m0.064s
sys	0m0.040s
$ time git merge-base $(git rev-list -g origin/master origin/master)
7811d9600f02e70c9f835719c71156c967a684f7

real	0m0.175s
user	0m0.076s
sys	0m0.036s

Cold-cache around 1 second. And it's not linear with the number of
reflog entries, but with the number of independent branches, I
suppose.

HTH,
Santi

P.D.: Attached is the patch, in case someone wants to try it.

--0016364edc02eed441049c662b63
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gk89nzn30

ZGlmZiAtLWdpdCBpL2dpdC1wdWxsLnNoIHcvZ2l0LXB1bGwuc2gKaW5kZXggMmNkZWEyNi4uMDll
ZjBhOSAxMDA3NTUKLS0tIGkvZ2l0LXB1bGwuc2gKKysrIHcvZ2l0LXB1bGwuc2gKQEAgLTE4OSwx
NCArMTg5LDcgQEAgdGVzdCB0cnVlID0gIiRyZWJhc2UiICYmIHsKIAkuIGdpdC1wYXJzZS1yZW1v
dGUgJiYKIAlyZW1vdGVyZWY9IiQoZ2V0X3JlbW90ZV9tZXJnZV9icmFuY2ggIiRAIiAyPi9kZXYv
bnVsbCkiICYmCiAJb2xkcmVtb3RlcmVmPSIkKGdpdCByZXYtcGFyc2UgLXEgLS12ZXJpZnkgIiRy
ZW1vdGVyZWYiKSIgJiYKLQlmb3IgcmVmbG9nIGluICQoZ2l0IHJldi1saXN0IC1nICRyZW1vdGVy
ZWYgMj4vZGV2L251bGwpCi0JZG8KLQkJaWYgdGVzdCAiJHJlZmxvZyIgPSAiJChnaXQgbWVyZ2Ut
YmFzZSAkcmVmbG9nICRjdXJyX2JyYW5jaCkiCi0JCXRoZW4KLQkJCW9sZHJlbW90ZXJlZj0iJHJl
ZmxvZyIKLQkJCWJyZWFrCi0JCWZpCi0JZG9uZQorCW9sZHJlbW90ZXJlZj0kKGdpdCBtZXJnZS1i
YXNlICRjdXJyX2JyYW5jaCAkb2xkcmVtb3RlcmVmICQoZ2l0IHJldi1saXN0IC1nICRyZW1vdGVy
ZWYgMj4vZGV2L251bGwpKQogfQogb3JpZ19oZWFkPSQoZ2l0IHJldi1wYXJzZSAtcSAtLXZlcmlm
eSBIRUFEKQogZ2l0IGZldGNoICR2ZXJib3NpdHkgJHByb2dyZXNzICRkcnlfcnVuICRyZWN1cnNl
X3N1Ym1vZHVsZXMgLS11cGRhdGUtaGVhZC1vayAiJEAiIHx8IGV4aXQgMQpkaWZmIC0tZ2l0IGkv
Z2l0LXJlYmFzZS5zaCB3L2dpdC1yZWJhc2Uuc2gKaW5kZXggMGQyNDVmZS4uNGIzZTEzMSAxMDA3
NTUKLS0tIGkvZ2l0LXJlYmFzZS5zaAorKysgdy9naXQtcmViYXNlLnNoCkBAIC00NDgsMTggKzQ0
OCw4IEBAIGVzYWMKIAogcmVxdWlyZV9jbGVhbl93b3JrX3RyZWUgInJlYmFzZSIgIlBsZWFzZSBj
b21taXQgb3Igc3Rhc2ggdGhlbS4iCiAKLXRlc3QgLW4gIiR1cHN0cmVhbV9uYW1lIiAmJiBmb3Ig
cmVmbG9nIGluIFwKLQkkKGdpdCByZXYtbGlzdCAtZyAkdXBzdHJlYW1fbmFtZSAyPi9kZXYvbnVs
bCkKLWRvCi0JaWYgdGVzdCAkcmVmbG9nID0gJChnaXQgbWVyZ2UtYmFzZSAkcmVmbG9nICRvcmln
X2hlYWQpCi0JdGhlbgotCQlpZiB0ZXN0ICRyZWZsb2cgIT0gJChnaXQgbWVyZ2UtYmFzZSAkb250
byAkcmVmbG9nKQotCQl0aGVuCi0JCQl1cHN0cmVhbT0kcmVmbG9nCi0JCWZpCi0JCWJyZWFrCi0J
ZmkKLWRvbmUKK3Rlc3QgLW4gIiR1cHN0cmVhbV9uYW1lIiAmJgordXBzdHJlYW09JChnaXQgbWVy
Z2UtYmFzZSAkb3JpZ19oZWFkICQoZ2l0IHJldi1saXN0IC1nICR1cHN0cmVhbV9uYW1lIDI+L2Rl
di9udWxsKSkKIAogIyBOb3cgd2UgYXJlIHJlYmFzaW5nIGNvbW1pdHMgJHVwc3RyZWFtLi4kb3Jp
Z19oZWFkIChvciB3aXRoIC0tcm9vdCwKICMgZXZlcnl0aGluZyBsZWFkaW5nIHVwIHRvICRvcmln
X2hlYWQpIG9uIHRvcCBvZiAkb250bwpkaWZmIC0tZ2l0IGkvdC90MzQwOC1yZWJhc2UtbXVsdGkt
bGluZS5zaCB3L3QvdDM0MDgtcmViYXNlLW11bHRpLWxpbmUuc2gKaW5kZXggNmI4NGU2MC4uYmVl
NDQ5NCAxMDA3NTUKLS0tIGkvdC90MzQwOC1yZWJhc2UtbXVsdGktbGluZS5zaAorKysgdy90L3Qz
NDA4LXJlYmFzZS1tdWx0aS1saW5lLnNoCkBAIC0xMCw3ICsxMCwxMiBAQCB0ZXN0X2V4cGVjdF9z
dWNjZXNzIHNldHVwICcKIAlnaXQgYWRkIGZpbGUgJiYKIAl0ZXN0X3RpY2sgJiYKIAlnaXQgY29t
bWl0IC1tIGluaXRpYWwgJiYKKwk+ZWxpZiAmJgorCWdpdCBhZGQgZWxpZiAmJgorCXRlc3RfdGlj
ayAmJgorCWdpdCBjb21taXQgLW0gc2Vjb25kICYmCiAKKwlnaXQgY2hlY2tvdXQgLWIgc2lkZSBI
RUFEXgogCWVjaG8gaGVsbG8gPmZpbGUgJiYKIAl0ZXN0X3RpY2sgJiYKIAlnaXQgY29tbWl0IC1h
IC1tICJBIHNhbXBsZSBjb21taXQgbG9nIG1lc3NhZ2UgdGhhdCBoYXMgYSBsb25nCkBAIC0xOCwx
MyArMjMsNyBAQCBzdW1tYXJ5IHRoYXQgc3BpbGxzIG92ZXIgbXVsdGlwbGUgbGluZXMuCiAKIEJ1
dCBvdGhlcndpc2Ugd2l0aCBhIHNhbmUgZGVzY3JpcHRpb24uIiAmJgogCi0JZ2l0IGJyYW5jaCBz
aWRlICYmCi0KLQlnaXQgcmVzZXQgLS1oYXJkIEhFQUReICYmCi0JPmVsaWYgJiYKLQlnaXQgYWRk
IGVsaWYgJiYKLQl0ZXN0X3RpY2sgJiYKLQlnaXQgY29tbWl0IC1tIHNlY29uZAorCWdpdCBjaGVj
a291dCBtYXN0ZXIKIAogJwogCg==
--0016364edc02eed441049c662b63--

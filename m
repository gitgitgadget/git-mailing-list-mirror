From: David Ware <davidw@realtimegenomics.com>
Subject: git subtree bug produces divergent descendants
Date: Mon, 7 Dec 2015 11:09:48 +1300
Message-ID: <CAET=KiVXh2UZwRSpM_+wX_QpfjBsyfdPPUVDSDoCRVe_0wbhCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11439426b56a7b052641ffb3
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 23:09:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5hVD-00080R-Jp
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 23:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbbLFWJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 17:09:51 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34915 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbbLFWJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 17:09:49 -0500
Received: by vkha189 with SMTP id a189so92393961vkh.2
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=TqYE+u/xecXtVTMuUcMh0z+emIHZ8C/l70cAPH/cDUU=;
        b=o1tiGNdXcu5t7/YxnLGV+XvpRY939bXtWXCTAJ3JNcUa+qgXm6JMyN+9BYeWwzDvNf
         S58RTxd98GS2LMvuxTsH8TbiKrS8v3gYTH4sQ1MIW/3WCldLPfhLs6p3re/FtToU37AE
         natsq4Ac6L7P+oyszJk3tm2TCAodZgYb/fwxtC3QyNRTlR4c8ZxxlABVCOqXXXDjbs9A
         f8kfrDu/du4Wc1uAtI/WhaXR2X3Kyomoyccn1LXNLye84U1P23G5Z3CfYGvdFKONFjyL
         z9ZvqQSIrfgPO1A19PhSs6Fm1V5RekxUCRdk/Ke2F/FiFrs6CmKr4fZVH20pc7rTa6ce
         Z1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=TqYE+u/xecXtVTMuUcMh0z+emIHZ8C/l70cAPH/cDUU=;
        b=je2ZeuZ/oHjiFfwwm8sRQGDPkgwFAcFJR6t0nNm1Q1cdBOU4ZSXgjzqM+llJgLBGgl
         0PeTV7TNeIKzrSVLdPHT2phtwPMH+ZUp8hIPWFwhAHVZwMa+E3wIIy5Camp9P+uRJbjX
         xAvrciCmHi9mTeZcPCoN6xXDYAzJyjBDDrIEawyC6eEsbF9DQum2M9xkIKO43jgPQbxT
         BJ8RNIi8E2PUsMJ6wGb9JytaOQKrQgLLyjNGEvyVD0erWQ9SEDop2Rh8WHh1BF1MvcBB
         3UWGQDZHcNa0BCeR7LdkTsrI5SrZAcpAprPJt091yXO8X8+4PLeIF6nnqy7ji9Xd0aP1
         26Lg==
X-Gm-Message-State: ALoCoQmzTYQIf1iVLRyUUF0ge2Q1py1/dscqSelt1NP8oh+17ajtc5d2evSjhcPe6OW2YcuzVJxH
X-Received: by 10.31.192.12 with SMTP id q12mr2697383vkf.96.1449439788349;
 Sun, 06 Dec 2015 14:09:48 -0800 (PST)
Received: by 10.31.236.4 with HTTP; Sun, 6 Dec 2015 14:09:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282065>

--001a11439426b56a7b052641ffb3
Content-Type: text/plain; charset=UTF-8

My group has run into a bug with "git-subtree split". Under some
circumstances a split created from a descendant of another earlier
split is not a descendant of that earlier split (thus blocking
pushes). We originally noticed this on v1.9.1 but have also checked it
on v2.6.3

When scanning the commits to produce the subtree it seems to skip
creating a new commit if any of the parent commits have the same tree
and instead uses that tree in its place. This is fine when the cause
is a branch that did not cause any changes to the subtree.  However it
creates an issue when the cause is both branches ending up with the
same tree through identical alterations (or more likely, one of the
branches has just a subset of the alterations on the other, such as a
branch just containing cherry-picks).

The attached patch (against v2.6.3) includes a test that reproduces
the problem.  The created 'master' branch has had the latest commits
on the 'branch' branch merged into it, so it follows that a subtree on
'folder/' at 'master' (subtree_tip) should contain all the commits of
a subtree on 'folder/' at 'branch' (subtree_branch). Hence it should
be possible to push subtree_tip to subtree_branch.

The attached patch also fixes the issue for the cases we've
encountered, however since we're not particularly familiar with git
internals we may not have approached this optimally. We suspect it
could be improved to also handle the cases where there are more than 2
parents.

Cheers,
Dave Ware

--001a11439426b56a7b052641ffb3
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Fix-bug-in-git-subtree-split.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-bug-in-git-subtree-split.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ihv2y4wc0

RnJvbSBjZTZlMmJjYjIxMTY2MjQwODJiZjQ2NjYzYWEzM2M3MDZmY2FiOTMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIFdhcmUgPGRhdmlkd0BuZXR2YWx1ZS5uZXQubno+CkRh
dGU6IEZyaSwgNCBEZWMgMjAxNSAxNjozMDowMyArMTMwMApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBi
dWcgaW4gZ2l0LXN1YnRyZWUgc3BsaXQuCgpBIGJ1ZyBvY2N1cnMgaW4gJ2dpdC1zdWJ0cmVlIHNw
bGl0JyB3aGVyZSBhIG1lcmdlIGlzIHNraXBwZWQgZXZlbiB3aGVuCmJvdGggcGFyZW50cyBhY3Qg
b24gdGhlIHN1YnRyZWUsIHByb3ZpZGVkIHRoZSBtZXJnZSByZXN1bHRzIGluIGEgdHJlZQppZGVu
dGljYWwgdG8gb25lIG9mIHRoZSBwYXJlbnRzLiBGaXhlZCBieSBjb3B5aW5nIHRoZSBtZXJnZSBp
ZiBhdCBsZWFzdApvbmUgcGFyZW50IGlzIG5vbi1pZGVudGljYWwsIGFuZCB0aGUgbm9uLWlkZW50
aWNhbCBwYXJlbnQgaXMgbm90IGFuCmFuY2VzdG9yIG9mIHRoZSBpZGVudGljYWwgcGFyZW50LgoK
QWxzbyBhZGRpbmcgYSB0ZXN0IGNhc2UsIHRoaXMgY2hlY2tzIHRoYXQgYSBkZXNjZW5kYW50IGNh
biBiZSBwdXNoZWQgdG8KaXQncyBhbmNlc3RvciBpbiB0aGlzIGNhc2UuCi0tLQogY29udHJpYi9z
dWJ0cmVlL2dpdC1zdWJ0cmVlLnNoICAgICAgICAgICB8IDEyICsrKysrLS0KIGNvbnRyaWIvc3Vi
dHJlZS90L3Q3OTAxLXN1YnRyZWUtc3BsaXQuc2ggfCA2MiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNzU1IGNvbnRyaWIvc3VidHJlZS90L3Q3OTAxLXN1YnRyZWUt
c3BsaXQuc2gKCmRpZmYgLS1naXQgYS9jb250cmliL3N1YnRyZWUvZ2l0LXN1YnRyZWUuc2ggYi9j
b250cmliL3N1YnRyZWUvZ2l0LXN1YnRyZWUuc2gKaW5kZXggOWYwNjU3MS4uYjgzNzUzMSAxMDA3
NTUKLS0tIGEvY29udHJpYi9zdWJ0cmVlL2dpdC1zdWJ0cmVlLnNoCisrKyBiL2NvbnRyaWIvc3Vi
dHJlZS9naXQtc3VidHJlZS5zaApAQCAtNDc5LDggKzQ3OSwxNiBAQCBjb3B5X29yX3NraXAoKQog
CQkJcD0iJHAgLXAgJHBhcmVudCIKIAkJZmkKIAlkb25lCi0JCi0JaWYgWyAtbiAiJGlkZW50aWNh
bCIgXTsgdGhlbgorCisJY29weWNvbW1pdD0KKwlpZiBbIC1uICIkaWRlbnRpY2FsIiBdICYmIFsg
LW4gIiRub25pZGVudGljYWwiIF07IHRoZW4KKwkJZXh0cmFzPSQoZ2l0IHJldi1saXN0IC0tYm91
bmRhcnkgJGlkZW50aWNhbC4uJG5vbmlkZW50aWNhbCkKKwkJaWYgWyAtbiAiJGV4dHJhcyIgXTsg
dGhlbgorCQkJIyB3ZSBuZWVkIHRvIHByZXNlcnZlIGhpc3RvcnkgYWxvbmcgdGhlIG90aGVyIGJy
YW5jaAorCQkJY29weWNvbW1pdD0xCisJCWZpCisJZmkKKwlpZiBbIC1uICIkaWRlbnRpY2FsIiBd
ICYmIFsgLXogIiRjb3B5Y29tbWl0IiBdOyB0aGVuCiAJCWVjaG8gJGlkZW50aWNhbAogCWVsc2UK
IAkJY29weV9jb21taXQgJHJldiAkdHJlZSAiJHAiIHx8IGV4aXQgJD8KZGlmZiAtLWdpdCBhL2Nv
bnRyaWIvc3VidHJlZS90L3Q3OTAxLXN1YnRyZWUtc3BsaXQuc2ggYi9jb250cmliL3N1YnRyZWUv
dC90NzkwMS1zdWJ0cmVlLXNwbGl0LnNoCm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAw
MDAuLjBhMWVhNTYKLS0tIC9kZXYvbnVsbAorKysgYi9jb250cmliL3N1YnRyZWUvdC90NzkwMS1z
dWJ0cmVlLXNwbGl0LnNoCkBAIC0wLDAgKzEsNjIgQEAKKyMhL2Jpbi9iYXNoCisKK3Rlc3RfZGVz
Y3JpcHRpb249J1Rlc3QgZm9yIGJ1ZyBpbiBzdWJ0cmVlIGNvbW1pdCBmaWx0ZXJpbmcnCisKKwor
VEVTVF9ESVJFQ1RPUlk9JChwd2QpLy4uLy4uLy4uL3QKK2V4cG9ydCBURVNUX0RJUkVDVE9SWQor
CisuIC4uLy4uLy4uL3QvdGVzdC1saWIuc2gKKworCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdzdWJ0
cmVlIGRlc2NlbmRlbnQgY2hlY2snICcKKyAgbWtkaXIgZ2l0X3N1YnRyZWVfc3BsaXRfY2hlY2sg
JiYKKyAgY2QgZ2l0X3N1YnRyZWVfc3BsaXRfY2hlY2sgJiYKKyAgZ2l0IGluaXQgJiYKKworICBt
a2RpciBmb2xkZXIgJiYKKworICBlY2hvIGEgPiBmb2xkZXIvYSAmJgorICBnaXQgYWRkIC4gJiYK
KyAgZ2l0IGNvbW1pdCAtbSAiZmlyc3QgY29tbWl0IiAmJgorCisgIGdpdCBicmFuY2ggYnJhbmNo
ICYmCisKKyAgZWNobyAwID4gZm9sZGVyLzAgJiYKKyAgZ2l0IGFkZCAuICYmCisgIGdpdCBjb21t
aXQgLW0gImFkZGluZyAwIHRvIGZvbGRlciIgJiYKKworICBlY2hvIGIgPiBmb2xkZXIvYiAmJgor
ICBnaXQgYWRkIC4gJiYKKyAgZ2l0IGNvbW1pdCAtbSAiYWRkaW5nIGIgdG8gZm9sZGVyIiAmJgor
ICBnaXQgcmV2LWxpc3QgSEVBRCAtMSA+IGNoZXJyeS5yZXYgJiYKKworICBnaXQgY2hlY2tvdXQg
YnJhbmNoICYmCisgIGVjaG8gdGV4dCA+IHRleHRCcmFuY2gudHh0ICYmCisgIGdpdCBhZGQgLiAm
JgorICBnaXQgY29tbWl0IC1tICJjb21taXQgdG8gZmlkZGxlIHdpdGggYnJhbmNoOiBicmFuY2gi
ICYmCisKKyAgZ2l0IGNoZXJyeS1waWNrICQoY2F0IGNoZXJyeS5yZXYpICYmCisgIGdpdCBjaGVj
a291dCBtYXN0ZXIgJiYKKyAgZ2l0IG1lcmdlIC1tICJtZXJnZSIgYnJhbmNoICYmCisKKyAgZ2l0
IGJyYW5jaCBub29wX2JyYW5jaCAmJgorCisgIGVjaG8gZCA+IGZvbGRlci9kICYmCisgIGdpdCBh
ZGQgLiAmJgorICBnaXQgY29tbWl0IC1tICJhZGRpbmcgZCB0byBmb2xkZXIiICYmCisKKyAgZ2l0
IGNoZWNrb3V0IG5vb3BfYnJhbmNoICYmCisgIGVjaG8gbW9yZVRleHQgPiBhbm90aGVyVGV4dC50
eHQgJiYKKyAgZ2l0IGFkZCAuICYmCisgIGdpdCBjb21taXQgLW0gImlycmVsZXZhbnQiICYmCisK
KyAgZ2l0IGNoZWNrb3V0IG1hc3RlciAmJgorICBnaXQgbWVyZ2UgLW0gInNlY29uZCBtZXJnZSIg
bm9vcF9icmFuY2ggJiYKKworICBnaXQgc3VidHJlZSBzcGxpdCAtLXByZWZpeCBmb2xkZXIvIC0t
YnJhbmNoIHN1YnRyZWVfdGlwIG1hc3RlciAmJgorICBnaXQgc3VidHJlZSBzcGxpdCAtLXByZWZp
eCBmb2xkZXIvIC0tYnJhbmNoIHN1YnRyZWVfYnJhbmNoIGJyYW5jaCAmJgorICBnaXQgcHVzaCAu
IHN1YnRyZWVfdGlwOnN1YnRyZWVfYnJhbmNoCisgICcKKwordGVzdF9kb25lCi0tIAoxLjkuMQoK
--001a11439426b56a7b052641ffb3--

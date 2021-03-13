Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AC5C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2506E64F0D
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhCMQiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:38:22 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:1572 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234007AbhCMQhx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 11:37:53 -0500
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp6-g21.free.fr (Postfix) with ESMTP id BED26780389
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 17:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1615653441;
        bh=AR750H+o6hyxQatUA2sJ5M6JehLZyLEbzsImkEaRpuM=;
        h=Date:From:To:In-Reply-To:Subject:From;
        b=JsySZ7e8s8TnV2yOiX3gzyq4aOsYWxu7o5xBgB+mCpqzYJeVHMgoCcaJt7szytdHC
         ukhDvpqWIGXomVAecN4O9Bc42fkYlsyJAaW6qd0ytq1x+NaIjbN5D1msJfWbv44pM7
         wjaFzumbrWhutXM+hqcq9N47+g1xurrKpowi4vuBCv0d76eBIGjDm99hEP5uyOwABW
         Ds/sO6hEkmTA+7CrQ9kv+oBG2AxsU1sw9mbXgEcgw9o1LyKfEWJIgTh10UpuQPeneK
         fU5vFk2w1P7HQrhTg1CDZ4J9Al6qTGQXtI8y2hUNiw+/87ml8lSyqg3J8rdvqJTb2y
         Zr6WmBYhCcaRA==
Date:   Sat, 13 Mar 2021 17:37:21 +0100 (CET)
From:   ydirson@free.fr
To:     git <git@vger.kernel.org>
Message-ID: <139173043.431119331.1615653441685.JavaMail.root@zimbra39-e7>
In-Reply-To: <1641138664.431077840.1615652537045.JavaMail.root@zimbra39-e7>
Subject: [RFC] git-rebase-rewind, nested rebases, remembering stgit
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_431119329_103229743.1615653441684"
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------=_Part_431119329_103229743.1615653441684
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello there,

I often find myself doing iterative refactorings, which can lead to
long branches, and while rebasing to edit HEAD~10 realize that I first
need to edit HEAD~20 or to add more commits below that stack.

If you've used stgit when it was a thing, you probably see how it
helped doing that.  While git-rebase has grown to do much more than
stgit in most areas, this is still one area where with a pain point
for me.

Here is a small git-rebase-rewind script I've been using for a few weeks,
starting with my most common use-case: automate worklow "edit git-rebase-todo
to prepend 'pick' commands for the N previous commits, then reset --hard HEAD~N".

As you will see from the new needs revealed by using this script (see in the
script header), I believe it would be valuable to integrate such a mechanism
directly into git-rebase.  Notably, "git rebase -i" itself can be seen as a
form of rewind, and this rewind feature would benefit from all the interactive
rebase work.

Does that sound like reasonable premises ?
-- 
Yann

------=_Part_431119329_103229743.1615653441684
Content-Type: application/x-shellscript; name=git-rebase-rewind
Content-Disposition: attachment; filename=git-rebase-rewind
Content-Transfer-Encoding: base64

IyEvYmluL3NoCnNldCAtZQoKIyBBUkVBUyBPRiBJTVBST1ZFTUVOVDoKIyAtIGZyZXF1ZW50IG5l
ZWQgdG8gY2hhaW4gInJld2luZDsgZWRpdC10b2RvOyBjb250aW51ZSIsIG1heWJlCiMgICBhcyAi
cmViYXNlLXJld2luZCAtaSIgdG8gYmUgc2ltaWxhciB0byAicmViYXNlIC1pIiA/CiMgLSBuZWVk
cyB0byBiZSBpbnRlZ3JhdGVkIGRlZXBlciBpbnRvIGdpdC1yZWJhc2UgZm9yIG1vcmUgYWR2YW5j
ZWQgZmVhdHVyZXM6CiMgICAtIHJld2luZCAtLXJlYmFzZS1tZXJnZXMsIC0tYXV0b3NxdWFzaCwg
LS1leGVjCiMgICAtIHByb3ZpZGluZyAidW5kbyB0byBsYXN0IHJld2luZCIgb24gbGFzdCAtLWNv
bnRpbnVlIChzaW1pbGFyIHRvICJyZWJhc2UgLS1hYm9ydCIsCiMgICAgIGFsdGhvdWdoIG1vcmUg
dHJpY2t5IGFzIHJld2luZHMgY2FuIGJlIG5lc3RlZCkKIyAgICAgPT4gbmVlZHMgdG8gcmVjb3Jk
IGZvciBlYWNoIHJld2luZCB0aGUgb3JpZ2luYWwgSEVBRCBhbmQgZ2l0LXJlYmFzZS10b2RvCiMg
ICAgIEVnLiAtIGtlZXAgYSB2ZXJzaW9ubmVkIGhpc3Rvcnkgb2YgZ2l0LXJlYmFzZS10b2RvIChh
dCBsZWFzdCBvbiByZXdpbmQpCiMgICAgICAgICAtIHJlY29yZCByZXdpbmRzIChlZy4gaW4gcmVi
YXNlLW1lcmdlL2RvbmUgd2l0aCBIRUFEIGFuZCBnaXQtcmViYXNlLXRvZG8gaGFzaGVzKQojICAg
ICBBbHNvIGFsbG93IGFmdGVyIHVuZG8gdG8gcmUtZWRpdCBnaXQtcmViYXNlLXRvZG8gaW5zdGVh
ZAojICAgLSBzaW1pbGFybHkgYnV0IGZpbmVyIGdyYWluZWQ6IHByb3ZpZGluZyAidW5kbyBvbmx5
IGxhc3QgLS1jb250aW51ZSIKIyAgIC0geW91IG5hbWUgaXQKIwojIExJTUlUQVRJT05TOgojIC0g
bmVlZHMgdG8ga25vdyB3aGVuIHBpY2sgY2F1c2VzIGNvbmZsaWN0LCBhbmQgY29uZmxpY3QgZ2V0
cyByZXNvbHZlZCBmb3I6CiMgICAtIGJldHRlciBVSSB0aGFuIGp1c3QgIi1mIgojICAgLSBhY2N1
cmF0ZSByZWNvcmRpbmcgb2YgcmV3aW5kcyBpbiByZWJhc2UtbWVyZ2UvZG9uZQoKZGllKCkgewog
ICAgZWNobyAyPiYxICJFUlJPUjogJEAiCiAgICBleGl0IDEKfQoKIyMKCnVzYWdlKCkgewogICAg
Y2F0IDw8RU9GClVzYWdlOiAkKGJhc2VuYW1lICQwKSBbLWZdIDxSRUY+CkVPRgp9CgpGT1JDRT0w
CmNhc2UgIiQxIiBpbgogICAgLWgpIHVzYWdlOyBleGl0IDAgOzsKICAgIC1mKSBGT1JDRT0xOyBz
aGlmdCA7OwogICAgLSopIHVzYWdlOyBkaWUgIlVua25vd24gZmxhZyAnJDEnIiA7Owplc2FjCgpU
QVJHRVQ9IiR7MTotcmViYXNlLW1lcmdlL29udG99IgpnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5IC1x
ICIkVEFSR0VUXntjb21taXR9IiA+IC9kZXYvbnVsbCB8fCBkaWUgIickVEFSR0VUJyBpcyBub3Qg
YSBjb21taXQiCgojIwoKQ09ORkxJQ1RFRD0KaWYgISBnaXQgZGlmZi1maWxlcyAtLXF1aWV0IC0t
aWdub3JlLXN1Ym1vZHVsZXM7IHRoZW4KICAgIFsgJEZPUkNFID0gMSBdIHx8IGRpZSAidW5zdGFn
ZWQgY2hhbmdlcyBmb3VuZCBpbiB3b3JrdHJlZSIKCiAgICAjIC1mOiBtdXN0IHVuZG8gY29uZmxp
Y3RpbmcgcGljaywgdW5zdXJlIGhldXJpc3RpYwogICAgQ09ORkxJQ1RFRD0kKHRhaWwgLW4xICIk
KGdpdCByZXYtcGFyc2UgLS1naXQtZGlyKS9yZWJhc2UtbWVyZ2UvZG9uZSIpCmZpCgojIEZJWE1F
OiBhc3NlcnQgJFRBUkdFVC4uSEVBRCBjYW4gZmYKIyBGSVhNRTogYXNzZXJ0ICRUQVJHRVQuLkhF
QUQgaGlzdG9yeSBpcyBsaW5lYXIKCiMgdHVybiBjb21taXRzIHRvIGJlIHJld2luZGVkIGludG8g
YSByZWJhc2UtdG9kbyByZWNpcGUKcmVjaXBlPSQobWt0ZW1wIC0tdG1wZGlyIGdpdC1yZWJhc2Ut
cmV3aW5kLlhYWFhYWCkKCiMgaWYgJFRBUkdFVD09SEVBRCwgZXhwbGljaXRseSBkbyBub3RoaW5n
IChncmVwIC12ICdeY29tbWl0JyB3b3VsZCByZXR1cm4gbm9uLXplcm8pCmlmIFsgJChnaXQgcmV2
LXBhcnNlICIkVEFSR0VUIikgIT0gJChnaXQgcmV2LXBhcnNlIEhFQUQpIF07IHRoZW4KICAgIGdp
dCByZXYtbGlzdCAtLXJldmVyc2UgLS1wcmV0dHk9dGZvcm1hdDoncGljayAlaCAlcycgIiRUQVJH
RVQiLi5IRUFEIHwKICAgICAgICBncmVwIC12ICdeY29tbWl0JyA+PiAiJHJlY2lwZSIKZmkKCiMg
YWRkIHRoZSBvbmUgdGhhdCBjYXVzZWQgdGhlIGNvbmZsaWN0IGlmIGFueQpbIC16ICIkQ09ORkxJ
Q1RFRCIgXSB8fCBlY2hvICIkQ09ORkxJQ1RFRCIgPj4gIiRyZWNpcGUiCgojIGluY2x1ZGUgdGhl
IHJlbWFpbmluZyBnaXQtcmViYXNlLXRvZG8gY29udGVudHMsIGFmdGVyIGEgYnJlYWsKZWNobyAi
YnJlYWsiID4+ICIkcmVjaXBlIgpFRElUT1I9ImNhdCA+PiAnJHJlY2lwZSciIGdpdCByZWJhc2Ug
LS1lZGl0LXRvZG8KCiMgaW5qZWN0IHRoZSBuZXcgcmVjaXBlCkVESVRPUj0iY2F0ICckcmVjaXBl
JyA+ICIgZ2l0IHJlYmFzZSAtLWVkaXQtdG9kbwoKIyByZXdpbmQgSEVBRApnaXQgcmVzZXQgLS1o
YXJkICIkVEFSR0VUIgo=
------=_Part_431119329_103229743.1615653441684--

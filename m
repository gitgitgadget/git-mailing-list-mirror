From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Mon, 9 Nov 2015 20:05:25 -0500
Message-ID: <CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
References: <20151026215016.GA17419@sigill.intra.peff.net>
	<xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
	<20151027184702.GB12717@sigill.intra.peff.net>
	<CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
	<20151030001000.GA2123@sigill.intra.peff.net>
	<CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
	<20151030005057.GA23251@sigill.intra.peff.net>
	<CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
	<20151030210849.GA7149@sigill.intra.peff.net>
	<CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
	<20151109155342.GB27224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ec13a0ff73e0524254e8f
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 02:06:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvxNp-0007Ct-DZ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 02:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbbKJBF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 20:05:27 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:33523 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbKJBF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 20:05:26 -0500
Received: by iodd200 with SMTP id d200so205256579iod.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 17:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MjOkBHWwGAPRefZXKWtNqXE2t4BJtfsbY5oAMua0LNQ=;
        b=ijWGvhL7FiJ243/yLFIlJcr9+LZNly6S63NIxDQ6J+EBlVMaDJdlAxjf/hVJf4V7Oy
         szmaW/Ot+b9u3NSv3SrPlrGt5n8hvPVsKZWwpMWJNM9q8bpSNVvfYNX14JvPZHsqhnM0
         vucKILMIqHW8ZnoqR8ZHgeC0Mzijod8WltM84+aSI2F6w++5TWwk8Vu5yT+KTT3lsQL+
         yJy6xW+7HD8fRKcYKIXUHXybjWuehjFQy98G/ifVy3h42sOW4gBMkMpFotdANc1cpvfb
         QHlAgSJxQrlO/p6wdyulJ8rFrZftRVIqqGD5kHf2l/hV/kkRre7kDhhFAAhoERDMZrAl
         5c0w==
X-Received: by 10.107.130.167 with SMTP id m39mr1364256ioi.18.1447117525601;
 Mon, 09 Nov 2015 17:05:25 -0800 (PST)
Received: by 10.79.119.2 with HTTP; Mon, 9 Nov 2015 17:05:25 -0800 (PST)
In-Reply-To: <20151109155342.GB27224@sigill.intra.peff.net>
X-Google-Sender-Auth: sv_YM1onrFRFpyLx6OTVirStFGY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281087>

--001a113ec13a0ff73e0524254e8f
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 9, 2015 at 10:53 AM, Jeff King <peff@peff.net> wrote:
> Yes, but with a proper commit message, and an update to
> Documentation/config.txt. :)

Right, see attached.

>
> Automated tests would be nice, but I suspect it may be too complicated
> to be worth it.

I attempted

test_ignore_sighup ()
{
    mkdir "$HOME/.git-credential-cache" &&
    chmod 0700 "$HOME/.git-credential-cache" &&
    git -c credentialCache.ignoreSIGHUP=true credential-cache--daemon
"$HOME/.git-credential-cache/socket" &
    kill -SIGHUP $! &&
    ps $!
}

test_expect_success 'credentialCache.ignoreSIGHUP works' 'test_ignore_sighup'

but it does't pass (testing manually by running
./git-credential-cache--daemon $HOME/.git-credential-cache/test-socket
& and then kill -HUP does work).

>
> I don't think we should use the credential.X.* namespace here. That is
> already reserved for credential setup for URLs matching "X".
>
> Probably "credentialCache.ignoreSIGHUP" would be better. Or maybe
> "credential-cache". We usually avoid dashes in our config names, but
> in this case it matches the program name.

I went with "credentialCache.ignoreSIGHUP".

>
> Also, we usually spell config names as all-lowercase in the code. The
> older callback-interface config code needed this (since we just strcmp'd
> the keys against a normalized case). I think git_config_get_bool() will
> normalize the key we feed it, but I'd rather stay consistent.

Oh, I didn't even realize git config names were case insensitive.

> I don't think you need to pop the tempfile handler here. You can simply
> sigchain_push() the SIG_IGN, and since we won't ever pop and propagate
> that, it doesn't matter what is under it.

Yup.

--001a113ec13a0ff73e0524254e8f
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-credential-cache-new-option-to-ignore-sighup.patch"
Content-Disposition: attachment; 
	filename="0001-credential-cache-new-option-to-ignore-sighup.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_igsoedck0

RnJvbSA1ZmM5NWI2ZTJmOTU2NDAzZGE2ODQ1ZmMzY2VkODNiMjFiZWU3YmIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBNb24sIDkgTm92IDIwMTUgMTk6MjY6MjkgLTA1MDAKU3ViamVjdDog
W1BBVENIXSBjcmVkZW50aWFsLWNhY2hlOiBuZXcgb3B0aW9uIHRvIGlnbm9yZSBzaWdodXAKCklu
dHJvZHVjZSBuZXcgb3B0aW9uICJjcmVkZW50aWFsQ2FjaGUuaWdub3JlU0lHSFVQIiB3aGljaCBz
dG9wcwpnaXQtY3JlZGVudGlhbC1jYWNoZS0tZGFlbW9uIGZyb20gcXVpdHRpbmcgb24gU0lHSFVQ
LiAgVGhpcyBpcyB1c2VmdWwKd2hlbiAiZ2l0IHB1c2giIGlzIHN0YXJ0ZWQgZnJvbSBFbWFjcywg
YmVjYXVzZSBhbGwgY2hpbGQKcHJvY2Vzc2VzIChpbmNsdWRpbmcgdGhlIGRhZW1vbikgd2lsbCBy
ZWNlaXZlIGEgU0lHSFVQIHdoZW4gImdpdCBwdXNoIgpleGl0cy4KLS0tCiBEb2N1bWVudGF0aW9u
L2NvbmZpZy50eHQgICB8IDMgKysrCiBjcmVkZW50aWFsLWNhY2hlLS1kYWVtb24uYyB8IDcgKysr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9jb25maWcudHh0IGIvRG9jdW1lbnRhdGlvbi9jb25maWcudHh0CmluZGV4IDRk
M2NiMTAuLjQ0NDRlNWIgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dAorKysg
Yi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQKQEAgLTExMjIsNiArMTEyMiw5IEBAIGNyZWRlbnRp
YWwuPHVybD4uKjo6CiAJZXhhbXBsZS5jb20uIFNlZSBsaW5rZ2l0OmdpdGNyZWRlbnRpYWxzWzdd
IGZvciBkZXRhaWxzIG9uIGhvdyBVUkxzIGFyZQogCW1hdGNoZWQuCiAKK2NyZWRlbnRpYWxDYWNo
ZS5pZ25vcmVTSUdIVVA6OgorCVRlbGwgZ2l0LWNyZWRlbnRpYWwtY2FjaGUtLWRhZW1vbiB0byBp
Z25vcmUgU0lHSFVQLCBpbnN0ZWFkIG9mIHF1aXR0aW5nLgorCiBpbmNsdWRlOjpkaWZmLWNvbmZp
Zy50eHRbXQogCiBkaWZmdG9vbC48dG9vbD4ucGF0aDo6CmRpZmYgLS1naXQgYS9jcmVkZW50aWFs
LWNhY2hlLS1kYWVtb24uYyBiL2NyZWRlbnRpYWwtY2FjaGUtLWRhZW1vbi5jCmluZGV4IGVlZjZm
Y2UuLjZjZGE5YzAgMTAwNjQ0Ci0tLSBhL2NyZWRlbnRpYWwtY2FjaGUtLWRhZW1vbi5jCisrKyBi
L2NyZWRlbnRpYWwtY2FjaGUtLWRhZW1vbi5jCkBAIC0yNTYsNiArMjU2LDkgQEAgaW50IG1haW4o
aW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQogCQlPUFRfRU5EKCkKIAl9OwogCisJaW50IGln
bm9yZV9zaWdodXAgPSAwOworCWdpdF9jb25maWdfZ2V0X2Jvb2woImNyZWRlbnRpYWxjYWNoZS5p
Z25vcmVzaWdodXAiLCAmaWdub3JlX3NpZ2h1cCk7CisKIAlhcmdjID0gcGFyc2Vfb3B0aW9ucyhh
cmdjLCBhcmd2LCBOVUxMLCBvcHRpb25zLCB1c2FnZSwgMCk7CiAJc29ja2V0X3BhdGggPSBhcmd2
WzBdOwogCkBAIC0yNjQsNiArMjY3LDEwIEBAIGludCBtYWluKGludCBhcmdjLCBjb25zdCBjaGFy
ICoqYXJndikKIAogCWNoZWNrX3NvY2tldF9kaXJlY3Rvcnkoc29ja2V0X3BhdGgpOwogCXJlZ2lz
dGVyX3RlbXBmaWxlKCZzb2NrZXRfZmlsZSwgc29ja2V0X3BhdGgpOworCisJaWYgKGlnbm9yZV9z
aWdodXApCisJCXNpZ25hbChTSUdIVVAsIFNJR19JR04pOworCiAJc2VydmVfY2FjaGUoc29ja2V0
X3BhdGgsIGRlYnVnKTsKIAlkZWxldGVfdGVtcGZpbGUoJnNvY2tldF9maWxlKTsKIAotLSAKMi42
LjEKCg==
--001a113ec13a0ff73e0524254e8f--

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 09:04:42 -0700
Message-ID: <CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
References: <1376900499-662-1-git-send-email-prohaska@zib.de>
	<1376926879-30846-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b343f1a32dc0404e44f1921
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 19 18:04:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBRwn-0004mu-AV
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 18:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab3HSQEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 12:04:45 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:38342 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3HSQEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 12:04:44 -0400
Received: by mail-vc0-f180.google.com with SMTP id gf11so3050658vcb.25
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gacuDf66y7nZ56TlBeYmb4glW9XgCSx1f4DSwE7UH2I=;
        b=g1Ti+PvvAmQ4hmx7hDr9RZvPdKq2TDDACSniJb8wTSM5/QaUriIeHx0t92+sdPvngd
         FkRr2zXsaOsa+PX/2boLzjr8A+wENdR0IKt0lXdK4XMJ17p65VPyovYH/MGGf6+kWpsK
         HYA7mGQrOoGij5M8EkeWZJyMCHfYF5S1OTGPF5GlvbyfGqXF1LhEk+5XH+xhcTg+LXNN
         j6xEyfy2FU1M6A3uFSPhLa5on2wDJEw95stk7yt141CR5ykFFou2Jp4EZE89XleoqZnY
         hIjBG2aTFfYH3bAs0FR8lZzZyrat9gB5a5nOVSJkJEyye01gqiXoOhMclkyGbuQQct+v
         mh/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gacuDf66y7nZ56TlBeYmb4glW9XgCSx1f4DSwE7UH2I=;
        b=K7pKVfd7DsK3L80X6kfJjwYdiT5ysG6lkyz3CkFBukcArn8eDJIGs/eNo8urJ7tso1
         2u84LHjM1fS3RnPK76DkU2jvVnHvI7kmLZIBcZignK1A+ABAdmtCZl1nxvTDxK8sql14
         AH8HhYMYiew6dLL1dh3D72jSCz5gNdQmQwnlk=
X-Received: by 10.220.91.16 with SMTP id k16mr3720962vcm.21.1376928283153;
 Mon, 19 Aug 2013 09:04:43 -0700 (PDT)
Received: by 10.220.3.137 with HTTP; Mon, 19 Aug 2013 09:04:42 -0700 (PDT)
In-Reply-To: <1376926879-30846-1-git-send-email-prohaska@zib.de>
X-Google-Sender-Auth: k78GqZcXPOvTVxTm3aZKFkYIK0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232548>

--047d7b343f1a32dc0404e44f1921
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 19, 2013 at 8:41 AM, Steffen Prohaska <prohaska@zib.de> wrote:
>
> The reason was that read() immediately returns with EINVAL if nbyte >=
> 2GB.  According to POSIX [1], if the value of nbyte passed to read() is
> greater than SSIZE_MAX, the result is implementation-defined.

Yeah, the OS X filesystem layer is an incredible piece of shit. Not
only doesn't it follow POSIX, it fails *badly*. Because OS X kernel
engineers apparently have the mental capacity of a retarded rodent on
crack.

Linux also refuses to actually read more than a maximum value in one
go (because quite frankly, doing more than 2GB at a time is just not
reasonable, especially in unkillable disk wait), but at least Linux
gives you the partial read, so that the usual "read until you're
happy" works (which you have to do anyway with sockets, pipes, NFS
intr mounts, etc etc). Returning EINVAL is a sign of a diseased mind.

I hate your patch for other reasons, though:

> The problem for read() is addressed in a similar way by introducing
> a wrapper function in compat that always reads less than 2GB.

Why do you do that? We already _have_ wrapper functions for read(),
namely xread().  Exactly because you basically have to, in order to
handle signals on interruptible filesystems (which aren't POSIX
either, but at least sanely so) or from other random sources. And to
handle the "you can't do reads that big" issue.

So why isn't the patch much more straightforward? Like the attached
totally untested one that just limits the read/write size to 8MB
(which is totally arbitrary, but small enough to not have any latency
issues even on slow disks, and big enough that any reasonable IO
subsystem will still get good throughput).

And by "totally untested" I mean that it actually passes the git test
suite, but since I didn't apply your patch nor do I have OS X
anywhere, I can't actually test that it fixes *your* problem. But it
should.


                   Linus

--047d7b343f1a32dc0404e44f1921
Content-Type: application/octet-stream; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkjvevsh0

IHdyYXBwZXIuYyB8IDEzICsrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dyYXBwZXIuYyBiL3dyYXBwZXIu
YwppbmRleCA2YTAxNWRlNWYwNTYuLmU5OTZmM2RhZTQ2NyAxMDA2NDQKLS0tIGEvd3JhcHBlci5j
CisrKyBiL3dyYXBwZXIuYwpAQCAtMTMxLDYgKzEzMSwxMyBAQCB2b2lkICp4Y2FsbG9jKHNpemVf
dCBubWVtYiwgc2l6ZV90IHNpemUpCiB9CiAKIC8qCisgKiBEb2luZyBJTyBpbiBodWdlIGNodW5r
cyBvbmx5IHJlc3VsdHMgaW4gcGFpbi4gT1MgWCBpcyBidWdneSwKKyAqIGFuZCBldmVuIGluIHRo
ZSBhYnNlbnNlIG9mIGJ1Z3MgaXQgY2FuIHJlc3VsdCBpbiBiYWQgbGF0ZW5jaWVzCisgKiB3aGVu
IHlvdSBkZWNpZGUgdG8ga2lsbCB0aGUgcHJvY2Vzcy4KKyAqLworI2RlZmluZSBNQVhfSU9fU0la
RSAoOCoxMDI0KjEwMjQpCisKKy8qCiAgKiB4cmVhZCgpIGlzIHRoZSBzYW1lIGEgcmVhZCgpLCBi
dXQgaXQgYXV0b21hdGljYWxseSByZXN0YXJ0cyByZWFkKCkKICAqIG9wZXJhdGlvbnMgd2l0aCBh
IHJlY292ZXJhYmxlIGVycm9yIChFQUdBSU4gYW5kIEVJTlRSKS4geHJlYWQoKQogICogRE9FUyBO
T1QgR1VBUkFOVEVFIHRoYXQgImxlbiIgYnl0ZXMgaXMgcmVhZCBldmVuIGlmIHRoZSBkYXRhIGlz
IGF2YWlsYWJsZS4KQEAgLTEzOSw3ICsxNDYsOCBAQCBzc2l6ZV90IHhyZWFkKGludCBmZCwgdm9p
ZCAqYnVmLCBzaXplX3QgbGVuKQogewogCXNzaXplX3QgbnI7CiAJd2hpbGUgKDEpIHsKLQkJbnIg
PSByZWFkKGZkLCBidWYsIGxlbik7CisJCW5yID0gbGVuIDwgTUFYX0lPX1NJWkUgPyBsZW4gOiBN
QVhfSU9fU0laRTsKKwkJbnIgPSByZWFkKGZkLCBidWYsIG5yKTsKIAkJaWYgKChuciA8IDApICYm
IChlcnJubyA9PSBFQUdBSU4gfHwgZXJybm8gPT0gRUlOVFIpKQogCQkJY29udGludWU7CiAJCXJl
dHVybiBucjsKQEAgLTE1NSw3ICsxNjMsOCBAQCBzc2l6ZV90IHh3cml0ZShpbnQgZmQsIGNvbnN0
IHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikKIHsKIAlzc2l6ZV90IG5yOwogCXdoaWxlICgxKSB7Ci0J
CW5yID0gd3JpdGUoZmQsIGJ1ZiwgbGVuKTsKKwkJbnIgPSBsZW4gPCBNQVhfSU9fU0laRSA/IGxl
biA6IE1BWF9JT19TSVpFOworCQluciA9IHdyaXRlKGZkLCBidWYsIG5yKTsKIAkJaWYgKChuciA8
IDApICYmIChlcnJubyA9PSBFQUdBSU4gfHwgZXJybm8gPT0gRUlOVFIpKQogCQkJY29udGludWU7
CiAJCXJldHVybiBucjsK
--047d7b343f1a32dc0404e44f1921--

From: Filipe Cabecinhas <filcab@gmail.com>
Subject: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Tue, 9 Apr 2013 15:31:31 -0700
Message-ID: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e014954b280ac0204d9f51d3b
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 00:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPh4j-0007uG-0k
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 00:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934348Ab3DIWbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 18:31:33 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:33692 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab3DIWbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 18:31:32 -0400
Received: by mail-qa0-f45.google.com with SMTP id i20so1661630qad.11
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=ulP3c84UhyxNSxc46/Ym84XkD6igd1kXNDEcnr7Cx9M=;
        b=r2F+9Ni7+xdaxuRSNExtzuXZKQKz4CLLJFKy4sB8p3NwQkcv61e1xQ+3YUDKP8A/gh
         jr4XqYToTg6qqFxRjRYPhrwhxEZh8LYwRXuu8cGdJ4EabDA89I8bT5vTyjAlsNjdKjoP
         mIYfJNpmIlCjEmtPd53brj7bdVqB+in2wTzfz3tg3X6hTtXAFtNSHORrEht++rlEQSiB
         LqderzcKbBI5+aBRraKTn+dBBikuJjHF8WmzFTenxSJp3S3nyfH5BSfa+0MuqSl3uHSh
         HHPGpBXciXskc3aLf++OhMJlI+VLT986k88PxsnEG7wBpMw9/9g1GcTAZpg1GEh7DbmL
         BpEQ==
X-Received: by 10.224.11.200 with SMTP id u8mr11924925qau.76.1365546692027;
 Tue, 09 Apr 2013 15:31:32 -0700 (PDT)
Received: by 10.229.128.218 with HTTP; Tue, 9 Apr 2013 15:31:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220647>

--089e014954b280ac0204d9f51d3b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,


While =E2=80=9Cgit svn fetch=E2=80=9Ding a subversion repository (private, =
sorry),
I've encoutered a bug that appears in several git versions (always
with the same symptoms):

git from master (from 2013-04-08)
git version 1.8.2.1 (compiled from homebrew)
git version 1.7.12.4 (Apple Git-37)

The only symptom is git blowing up with the error:
fatal: write error: Invalid argument

Problems showed up when this happened (in the SVN repo):
rev A: File F with 110K is replaced with a 9G file (don't ask=E2=80=A6)
intermediate revs: files got added and changed, not touching file F
rev B: File F finally got reverted to the state before rev A

I can git svn fetch up to rev B-1, but svn fetching rev B will throw
the previously mentioned error.

I traced it down to write() returning <0 and setting errno to EINVAL
if nbytes > INT_MAX:
http://fxr.watson.org/fxr/source/bsd/kern/sys_generic.c?v=3Dxnu-2050.18.24#=
L573
(the write() will eventually call dofilewrite, which has that check).

Testing with dd bs=3DINT_MAX+1 count=3D1 also gets me an =E2=80=9CInvalid
argument=E2=80=9D error, while bs=3DINT_MAX will do what's expected.

I have a preliminary patch that fixes it, but it may not be the
preferred way. The code is not ifdef'ed out and I'm doing the fix in
write_in_full(), while it may be preferred to do the fix in xwrite().

A radar bug has been submitted to Apple about this, but I think git
could tolerate the bug while it isn't fixed, by working around it.

Thank you,

  Filipe

--089e014954b280ac0204d9f51d3b
Content-Type: application/octet-stream; name="git-darwin-bigwrites.patch"
Content-Disposition: attachment; filename="git-darwin-bigwrites.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hfbn8oq30

ZGlmZiAtLWdpdCBhL3dyYXBwZXIuYyBiL3dyYXBwZXIuYwppbmRleCBiYWM1OWQyLi40NzRkNzYw
IDEwMDY0NAotLS0gYS93cmFwcGVyLmMKKysrIGIvd3JhcHBlci5jCkBAIC0xODcsNyArMTg3LDEy
IEBAIHNzaXplX3Qgd3JpdGVfaW5fZnVsbChpbnQgZmQsIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90
IGNvdW50KQogCXNzaXplX3QgdG90YWwgPSAwOwogCiAJd2hpbGUgKGNvdW50ID4gMCkgewotCQlz
c2l6ZV90IHdyaXR0ZW4gPSB4d3JpdGUoZmQsIHAsIGNvdW50KTsKKwkJc3NpemVfdCB3cml0dGVu
ID0gMDsKKyAgICAgICAgaWYgKGNvdW50ID49IElOVF9NQVgpCisJCQl3cml0dGVuID0geHdyaXRl
KGZkLCBwLCBJTlRfTUFYLTEpOworICAgICAgICBlbHNlCisJCQl3cml0dGVuID0geHdyaXRlKGZk
LCBwLCBjb3VudCk7CisKIAkJaWYgKHdyaXR0ZW4gPCAwKQogCQkJcmV0dXJuIC0xOwogCQlpZiAo
IXdyaXR0ZW4pIHsK
--089e014954b280ac0204d9f51d3b--

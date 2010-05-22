From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [tig PATCH] fix off-by-one on parent selection
Date: Sat, 22 May 2010 13:19:12 -0400
Message-ID: <AANLkTim8cQ-1oBE-BOwbjTlyn2E2V64NvM_6Drs3kTAS@mail.gmail.com>
References: <20100510085504.GA2283@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64a98a6df6405048732021e
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 22 19:19:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFsMO-0001Ye-DW
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 19:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767Ab0EVRTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 13:19:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51881 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0EVRTe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 13:19:34 -0400
Received: by iwn6 with SMTP id 6so2359292iwn.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=HlOhuVzScLwUUjI+HQVX82sl2J47emXQhKTpk7Qccmw=;
        b=MBnVRdQiLwJixoxzn5xMcTdYbKHI//zZfbjkDgyI7r5XRZ8Lzpp4LDVdU/5kxyz96K
         aLlPwkMiMmVyyV284akJJaY5JOc1kOzmYUGXuvY08uDGPCsVNwdstkM2KgGaW1rOLC2S
         7GCFqLn0gh4O8baTHljCvDMAFOXJQXeA5OAxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=CVPFQdOwxjn9oeBZUm0EoDltuM9xDGh2w+ffJujBW+KzKqnXCInRh9zmNLZ9Zzy01d
         SwWjLglZdMe6xn9rZE3TZUTovRJrO9N7A52rQMV7EDY1eDutuicKi+3peBya9hz0VMDn
         fxKp1aNh/cLLIuu2Wpsfn+8Hz3UVF14HDHLas=
Received: by 10.231.125.223 with SMTP id z31mr2137467ibr.78.1274548773151; 
	Sat, 22 May 2010 10:19:33 -0700 (PDT)
Received: by 10.231.207.15 with HTTP; Sat, 22 May 2010 10:19:12 -0700 (PDT)
In-Reply-To: <20100510085504.GA2283@coredump.intra.peff.net>
X-Google-Sender-Auth: H29oOsvHBkIv_UBWi2dA4TdNYuo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147535>

--0016e64a98a6df6405048732021e
Content-Type: text/plain; charset=UTF-8

On Mon, May 10, 2010 at 04:55, Jeff King <peff@peff.net> wrote:
> This patch fixes it by explicitly selecting the 0th parent
> for the single parent case.
> [...]
> This is an old bug, but I finally got a chance to track it down.

Thanks for fixing it.

> There is a related buglet elsewhere in select_commit_parent. Now that we
> ask git to print only the parents, we will get no output at all for a
> parent-less commit. This will cause iobuf_read to return an error, and
> we will print "Failed to get parent information" instead of "The
> selected commit has no parents" (or "Path '%s' does not exist" if we are
> blaming the parent of a commit that introduced a file).
>
> AFAICT, fixing it would mean improving iobuf_read to differentiate "no
> output" from "there were errors". I'll leave that sort of infrastructure
> refactoring to you if you want to do it. The resulting bug is quite
> minor.

The spaced damaged patch below fixes the first error.
--- >8 --- >8 --- >8 ---
diff --git a/tig.c b/tig.c
index 35b0cfa..f5bb1b9 100644
--- a/tig.c
+++ b/tig.c
@@ -1028,7 +1028,7 @@ io_read_buf(struct io *io, char buf[], size_t bufsize)
                string_ncopy_do(buf, bufsize, result, strlen(result));
        }

-       return io_done(io) && result;
+       return io_done(io) && !io_error(io);
 }

 static bool
--- 8< --- 8< --- 8< ---

However, it seems that the output of the command that was previously
used for fetching parents and the current one pretty printing using
the %P flag is also the cause of the breakage.

In the tig repository, trying to "blame" the parent of b801d8b2b shows
reproduces the problem. Commit b801d8b2b replaced cgit.c with tig.c,
which means there is no parent blame to show.

Before:
> git rev-list -1 --parents b801d8b2b -- tig.c
b801d8b2bc1a6aac6b9744f21f7a10a51e16c53e
.. i.e no parents as expected.

Now:
> git log --no-color -1 --pretty=format:%P b801d8b2b -- tig.c
a7bc4b1447f974fbbe400c3657d9ec3d0fda133e
.. i.e. the parent of b801d8b2b, but where tig.c does not exist.

The attached patch addresses this problem by reverting back to the
command used before.

A related question is why the hell I chose to switch to using %P in
commit 0a4694191613f887151a52f0c70e6b6181ea5fb6 ...

--
Jonas Fonseca

--0016e64a98a6df6405048732021e
Content-Type: application/octet-stream; name="fix-parent-blame.patch"
Content-Disposition: attachment; filename="fix-parent-blame.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9ip8wxx1

IHRpZy5jIHwgICAxMiArKysrLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RpZy5jIGIvdGlnLmMKaW5kZXggMzVi
MGNmYS4uYjJkYmNhNyAxMDA2NDQKLS0tIGEvdGlnLmMKKysrIGIvdGlnLmMKQEAgLTM5OTUsMTcg
KzM5OTUsMTUgQEAgc2VsZWN0X2NvbW1pdF9wYXJlbnQoY29uc3QgY2hhciAqaWQsIGNoYXIgcmV2
W1NJWkVPRl9SRVZdLCBjb25zdCBjaGFyICpwYXRoKQogewogCWNoYXIgYnVmW1NJWkVPRl9TVFIg
KiA0XTsKIAljb25zdCBjaGFyICpyZXZsaXN0X2FyZ3ZbXSA9IHsKLQkJImdpdCIsICJsb2ciLCAi
LS1uby1jb2xvciIsICItMSIsCi0JCQkiLS1wcmV0dHk9Zm9ybWF0OiVQIiwgaWQsICItLSIsIHBh
dGgsIE5VTEwKKwkJImdpdCIsICJyZXYtbGlzdCIsICItMSIsICItLXBhcmVudHMiLCBpZCwgIi0t
IiwgcGF0aCwgTlVMTAogCX07CiAJaW50IHBhcmVudHM7CiAKLQlpZiAoIWlvX3J1bl9idWYocmV2
bGlzdF9hcmd2LCBidWYsIHNpemVvZihidWYpKSB8fAotCSAgICAocGFyZW50cyA9IHN0cmxlbihi
dWYpIC8gNDApIDwgMCkgeworCWlmICghaW9fcnVuX2J1ZihyZXZsaXN0X2FyZ3YsIGJ1Ziwgc2l6
ZW9mKGJ1ZikpKSB7CiAJCXJlcG9ydCgiRmFpbGVkIHRvIGdldCBwYXJlbnQgaW5mb3JtYXRpb24i
KTsKIAkJcmV0dXJuIEZBTFNFOwogCi0JfSBlbHNlIGlmIChwYXJlbnRzID09IDApIHsKKwl9IGVs
c2UgaWYgKChwYXJlbnRzID0gKHN0cmxlbihidWYpIC8gNDApIC0gMSkgPD0gMCkgewogCQlpZiAo
cGF0aCkKIAkJCXJlcG9ydCgiUGF0aCAnJXMnIGRvZXMgbm90IGV4aXN0IGluIHRoZSBwYXJlbnQi
LCBwYXRoKTsKIAkJZWxzZQpAQCAtNDAxMyw5ICs0MDExLDcgQEAgc2VsZWN0X2NvbW1pdF9wYXJl
bnQoY29uc3QgY2hhciAqaWQsIGNoYXIgcmV2W1NJWkVPRl9SRVZdLCBjb25zdCBjaGFyICpwYXRo
KQogCQlyZXR1cm4gRkFMU0U7CiAJfQogCi0JaWYgKHBhcmVudHMgPT0gMSkKLQkJcGFyZW50cyA9
IDA7Ci0JZWxzZSBpZiAoIW9wZW5fY29tbWl0X3BhcmVudF9tZW51KGJ1ZiwgJnBhcmVudHMpKQor
CWlmIChwYXJlbnRzID4gMSAmJiAhb3Blbl9jb21taXRfcGFyZW50X21lbnUoYnVmLCAmcGFyZW50
cykpCiAJCXJldHVybiBGQUxTRTsKIAogCXN0cmluZ19jb3B5X3JldihyZXYsICZidWZbNDEgKiBw
YXJlbnRzXSk7Cg==
--0016e64a98a6df6405048732021e--

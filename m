From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix unterminated string in set_work_tree and improve error handling
Date: Fri, 3 Aug 2007 07:47:24 +0200
Message-ID: <81b0412b0708022247s1116f66al1e8751f33bcae581@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_65026_10730913.1186120044120"
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 07:48:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGq1L-0006k6-ML
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 07:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757025AbXHCFrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 01:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbXHCFrb
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 01:47:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:62376 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbXHCFr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 01:47:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so194066nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 22:47:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=fy4mBWeEFBMuy0nTQHsPMfsOEmhj3hRYBKVLOEws8LBt24KUobinLKPpFL6qSisGJiy2+3I6TxNn+1Gh8ydn7DmCOQT+jfriaPDmWqLw721T4UvGvb+PU7Ups+SZcRfH33vzACjS9Gky8nCqUdiuQ651igAYcQl6sE/QOF5/JBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Wrwx1YKA0OH4cA6mE7Y558iBoV6B3V/md3JcJwHHX6kK/DPfGj/UNbngafcONNxfUT6slyayeEBdk29iM6RLMjN1XnWTezg/heaC3BHfmZRIeocpU6LWgFV5f3S9Z9kboYlAeOURD6E/BzhS07ZeJ2PTCE4UjjoPLgQ9nvJMqU4=
Received: by 10.78.37.7 with SMTP id k7mr728983huk.1186120044148;
        Thu, 02 Aug 2007 22:47:24 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 2 Aug 2007 22:47:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54669>

------=_Part_65026_10730913.1186120044120
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Also, check if it fits in the temporary dir_buffer and can be chdir-ed into.
Die for errors.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 setup.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

On 8/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
> > Junio C Hamano, Thu, Aug 02, 2007 23:58:41 +0200:
> >> "Alex Riesen" <raa.lkml@gmail.com> writes:
> >> > +          if (chdir(dir))
> >> > +                  rel = NULL;
> > ...
> >>
> >> Shouldn't it die() instead, though?
> >
> > Dunno. Don't like dying.
>
> I do not understand your reasoning.  Why is it better to use
> mysteriously truncated path, which may result in doing something
> the user did not ask you to, rather than saying "No, my
> temporary buffer is not equipped to handle such an insanely long
> pathname"?

AFAIU, it is not only a truncated path which is a problem for chdir,
but any failure to chdir, for any reason. And, if I understand
set_work_tree returning NULL correctly (I assign rel NULL,
which should be returned) - it is an error, and can be handled in
the caller. But...
Hmm... Looking at the code again, rel==NULL just means there
is no prefix! You're right, better let it die.

> >> Consolidating two of your patches, would this be Ok?
> >
> > Yes, but you may consider replacing strncpy with strlcpy:
> >
> >> +            memcpy(dir_buffer, dir, len - suffix_len);
> >> +            dir_buffer[len - suffix_len] = '\0';
> >
> > strlcpy(dir_buffer, dir, len - suffix_len + 1);
>
> Does that buy us that much?  Before going to that codepath, we
> have made sure the result fits, haven't we?

No, we haven't. The code just checks if the given work tree path
is longer than "/.git", to be able to cut off that safely.

------=_Part_65026_10730913.1186120044120
Content-Type: text/plain; 
	name=0001-Check-if-the-given-dir-fits-in-the-temporary-dir_buffe.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4w9axc9
Content-Disposition: attachment; filename="0001-Check-if-the-given-dir-fits-in-the-temporary-dir_buffe.txt"

RnJvbSA3ZTU1ZDRlZDg0ZTU4NjdiMjE3YzllMGJjMTk2NDQ0NGYxM2VhZWYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBGcmksIDMgQXVnIDIwMDcgMDc6NDE6MjYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXggdW50
ZXJtaW5hdGVkIHN0cmluZyBpbiBzZXRfd29ya190cmVlIGFuZCBpbXByb3ZlIGVycm9yIGhhbmRs
aW5nCgoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0t
CiBzZXR1cC5jIHwgICAxMiArKysrKysrKy0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NldHVwLmMgYi9zZXR1cC5jCmlu
ZGV4IDM2NTMwOTIuLjYwMDZmYzUgMTAwNjQ0Ci0tLSBhL3NldHVwLmMKKysrIGIvc2V0dXAuYwpA
QCAtMjAxLDE1ICsyMDEsMTggQEAgaW50IGlzX2luc2lkZV93b3JrX3RyZWUodm9pZCkKICAqLwog
Y29uc3QgY2hhciAqc2V0X3dvcmtfdHJlZShjb25zdCBjaGFyICpkaXIpCiB7Ci0JY2hhciBkaXJf
YnVmZmVyW1BBVEhfTUFYXTsKLQlzdGF0aWMgY2hhciBidWZmZXJbUEFUSF9NQVggKyAxXSwgKnJl
bCA9IE5VTEw7CisJY2hhciBkaXJfYnVmZmVyW1BBVEhfTUFYXSwgKnJlbCA9IE5VTEw7CisJc3Rh
dGljIGNoYXIgYnVmZmVyW1BBVEhfTUFYICsgMV07CiAJaW50IGxlbiwgcG9zdGZpeF9sZW4gPSBz
dHJsZW4oREVGQVVMVF9HSVRfRElSX0VOVklST05NRU5UKSArIDE7CiAKIAkvKiBzdHJpcCB0aGUg
dmFyaWFibGUgJ2Rpcicgb2YgdGhlIHBvc3RmaXggIi8uZ2l0IiBpZiBpdCBoYXMgaXQgKi8KIAls
ZW4gPSBzdHJsZW4oZGlyKTsKIAlpZiAobGVuID4gcG9zdGZpeF9sZW4gJiYgIXN0cmNtcChkaXIg
KyBsZW4gLSBwb3N0Zml4X2xlbiwKIAkJCQkiLyIgREVGQVVMVF9HSVRfRElSX0VOVklST05NRU5U
KSkgewotCQkJc3RybmNweShkaXJfYnVmZmVyLCBkaXIsIGxlbiAtIHBvc3RmaXhfbGVuKTsKKwkJ
aWYgKGxlbiAtIHBvc3RmaXhfbGVuIDwgc2l6ZW9mKGRpcl9idWZmZXIpKQorCQkJc3RybGNweShk
aXJfYnVmZmVyLCBkaXIsIGxlbiAtIHBvc3RmaXhfbGVuICsgMSk7CisJCWVsc2UKKwkJCWRpZSgi
JXMgaXMgdG9vIGxvbmciLCBkaXIpOwogCiAJCS8qIGFyZSB3ZSBpbnNpZGUgdGhlIGRlZmF1bHQg
d29yayB0cmVlPyAqLwogCQlyZWwgPSBnZXRfcmVsYXRpdmVfY3dkKGJ1ZmZlciwgc2l6ZW9mKGJ1
ZmZlciksIGRpcl9idWZmZXIpOwpAQCAtMjE5LDcgKzIyMiw4IEBAIGNvbnN0IGNoYXIgKnNldF93
b3JrX3RyZWUoY29uc3QgY2hhciAqZGlyKQogCQlpZiAoIWlzX2Fic29sdXRlX3BhdGgoZGlyKSkK
IAkJCXNldF9naXRfZGlyKG1ha2VfYWJzb2x1dGVfcGF0aChkaXIpKTsKIAkJZGlyID0gZGlyX2J1
ZmZlcjsKLQkJY2hkaXIoZGlyKTsKKwkJaWYgKGNoZGlyKGRpcikpCisJCQlkaWUoImNhbm5vdCBj
aGRpciB0byAlczogJXMiLCBkaXIsIHN0cmVycm9yKGVycm5vKSk7CiAJCXN0cmNhdChyZWwsICIv
Iik7CiAJCWluc2lkZV9naXRfZGlyID0gMDsKIAl9IGVsc2UgewotLSAKMS41LjMucmMzLjE0NS5n
NGQ5Y2RiCgo=
------=_Part_65026_10730913.1186120044120--

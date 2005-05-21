From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 00:36:15 -0400 (EDT)
Message-ID: <4966.10.10.10.24.1116650175.squirrel@linux1>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
    <428EB444.7010200@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050521003615_50114"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 06:35:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZLht-0008Rt-0e
	for gcvg-git@gmane.org; Sat, 21 May 2005 06:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEUEgW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 00:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVEUEgW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 00:36:22 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:59790 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261260AbVEUEgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 00:36:16 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521043616.OBXN1005.simmts12-srv.bellnexxia.net@linux1>;
          Sat, 21 May 2005 00:36:16 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4L4aF2B013420;
	Sat, 21 May 2005 00:36:15 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 00:36:15 -0400 (EDT)
In-Reply-To: <428EB444.7010200@pobox.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050521003615_50114
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sat, May 21, 2005 12:08 am, Jeff Garzik said:

> Pretty good.  You'll probably want some additional changes:
>
> 1) eliminate
> +       case ARGP_KEY_ARG:      state->next = state->argc; break;
>
> This will cause option processing to stop at the first unknown argument.
>
> 2) Pass-by-reference a variable to argp_parse(), which will store the
> index of the argument where processing stopped.  This is the first
> hash/file/etc. non-option argument.
>

Thanks Jeff, that's pretty cool.  Here's an updated patch.

With this updated patch, options following or even intermingled with the
SHA1 list also are picked up, for example:

$ git-fsck-cache 804c64ea864d0a8ee13f3de0b74158a3e9c3166d -crudt


fsck-cache.c |   66
+++++++++++++++++++++++++++++++++++------------------------
1 files changed, 40 insertions(+), 26 deletions(-)

Sean

------=_20050521003615_50114
Content-Type: application/octet-stream; name="fsck-cache-argp-v2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fsck-cache-argp-v2.patch"

ZnNjay1jYWNoZS5jOiBuZWVkcyB1cGRhdGUKSW5kZXg6IGZzY2stY2FjaGUuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSA1ODc0MWM2OTU3MDcwNTgwMWRiNGI3ODU2ODE3OTBkNjM2NDc1Njk1L2ZzY2stY2FjaGUu
YyAgKG1vZGU6MTAwNjQ0KQorKysgdW5jb21taXR0ZWQvZnNjay1jYWNoZS5jICAobW9kZToxMDA2
NDQpCkBAIC0xLDUgKzEsNyBAQAogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPGRp
cmVudC5oPgorI2luY2x1ZGUgPGFyZ3AuaD4KK2NvbnN0IGNoYXIgKmFyZ3BfcHJvZ3JhbV92ZXJz
aW9uID0gImdpdCAxLjAiOwogCiAjaW5jbHVkZSAiY2FjaGUuaCIKICNpbmNsdWRlICJjb21taXQu
aCIKQEAgLTQwNywzNiArNDA5LDQ4IEBACiAJZmluZF9maWxlX29iamVjdHMoZ2l0X2RpciwgInJl
ZnMiKTsKIH0KIAorI2RlZmluZSBPX1VOUkVBQ0ggJ3UnCisjZGVmaW5lIE9fVEFHUyAndCcKKyNk
ZWZpbmUgT19ST09UICdyJworI2RlZmluZSBPX0RFTFRBICdkJworI2RlZmluZSBPX0NBQ0hFICdj
JworCitzdGF0aWMgY29uc3QgY2hhciBkb2NbXSA9ICJQZXJmb3JtIHJlcG9zaXRvcnkgY29uc2lz
dGVuY3kgY2hlY2siOworCitzdGF0aWMgc3RydWN0IGFyZ3Bfb3B0aW9uIG9wdGlvbnNbXSA9IHsK
KyB7InVucmVhY2hhYmxlIiwgT19VTlJFQUNILCAwLCAwLCAiU2hvdyBtaXNzaW5nIG9iamVjdHMg
b3IgZGVsdGFzIn0sCisgeyJ0YWdzIiwgT19UQUdTLCAwLCAwLCAiU2hvdyByZXZpc2lvbiB0YWdz
In0sCisgeyJyb290IiwgT19ST09ULCAwLCAwLCAiU2hvdyByb290IG9iamVjdHMsIGllLiB0aG9z
ZSB3aXRob3V0IHBhcmVudHMifSwKKyB7ImRlbHRhLWRlcHRoIiwgT19ERUxUQSwgMCwgMCwgIlNo
b3cgdGhlIG1heGltdW0gbGVuZ3RoIG9mIGRlbHRhIGNoYWlucyJ9LAorIHsiY2FjaGUiLCBPX0NB
Q0hFLCAwLCAwLCAiTWFyayBhbGwgb2JqZWN0cyByZWZlcmVuY2VkIGJ5IGNhY2hlIGFzIHJlYWNo
YWJsZSJ9LAorIHsgfQorfTsKKworc3RhdGljIGVycm9yX3QgcGFyc2Vfb3B0IChpbnQga2V5LCBj
aGFyICphcmcsIHN0cnVjdCBhcmdwX3N0YXRlICpzdGF0ZSkKK3sKKyAgICAgICAgc3dpdGNoIChr
ZXkpIHsKKyAgICAgICAgY2FzZSBPX1VOUkVBQ0g6CQlzaG93X3VucmVhY2hhYmxlID0gMTsgYnJl
YWs7CisgICAgICAgIGNhc2UgT19UQUdTOgkJc2hvd190YWdzID0gMTsgYnJlYWs7CisgICAgICAg
IGNhc2UgT19ST09UOgkJc2hvd19yb290ID0gMTsgYnJlYWs7CisgICAgICAgIGNhc2UgT19ERUxU
QToJCXNob3dfbWF4X2RlbHRhX2RlcHRoID0gMTsgYnJlYWs7CisgICAgICAgIGNhc2UgT19DQUNI
RToJCWtlZXBfY2FjaGVfb2JqZWN0cyA9IDE7IGJyZWFrOworICAgICAgICBkZWZhdWx0OgkJcmV0
dXJuIEFSR1BfRVJSX1VOS05PV047CisgICAgICAgIH0KKyAgICAgICAgcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXJncCBhcmdwID0geyBvcHRpb25zLCBwYXJzZV9vcHQsICJb
SEVBRC1TSEExLi4uXSIsIGRvYyB9OworCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
CiB7CiAJaW50IGksIGhlYWRzOwogCWNoYXIgKnNoYTFfZGlyOworCWludCBpZHg7CiAKLQlmb3Ig
KGkgPSAxOyBpIDwgYXJnYzsgaSsrKSB7Ci0JCWNvbnN0IGNoYXIgKmFyZyA9IGFyZ3ZbaV07Ci0K
LQkJaWYgKCFzdHJjbXAoYXJnLCAiLS11bnJlYWNoYWJsZSIpKSB7Ci0JCQlzaG93X3VucmVhY2hh
YmxlID0gMTsKLQkJCWNvbnRpbnVlOwotCQl9Ci0JCWlmICghc3RyY21wKGFyZywgIi0tdGFncyIp
KSB7Ci0JCQlzaG93X3RhZ3MgPSAxOwotCQkJY29udGludWU7Ci0JCX0KLQkJaWYgKCFzdHJjbXAo
YXJnLCAiLS1yb290IikpIHsKLQkJCXNob3dfcm9vdCA9IDE7Ci0JCQljb250aW51ZTsKLQkJfQot
CQlpZiAoIXN0cmNtcChhcmcsICItLWRlbHRhLWRlcHRoIikpIHsKLQkJCXNob3dfbWF4X2RlbHRh
X2RlcHRoID0gMTsKLQkJCWNvbnRpbnVlOwotCQl9Ci0JCWlmICghc3RyY21wKGFyZywgIi0tY2Fj
aGUiKSkgewotCQkJa2VlcF9jYWNoZV9vYmplY3RzID0gMTsKLQkJCWNvbnRpbnVlOwotCQl9Ci0J
CWlmICgqYXJnID09ICctJykKLQkJCXVzYWdlKCJnaXQtZnNjay1jYWNoZSBbLS10YWdzXSBbWy0t
dW5yZWFjaGFibGVdIFstLWNhY2hlXSA8aGVhZC1zaGExPipdIik7CisJZXJyb3JfdCByYyA9IGFy
Z3BfcGFyc2UoJmFyZ3AsIGFyZ2MsIGFyZ3YsIDAsICZpZHgsIE5VTEwpOworCWlmIChyYykgewor
CQlmcHJpbnRmKHN0ZGVyciwgImFyZ3VtZW50IGZhaWxlZDogJXNcbiIsIHN0cmVycm9yKHJjKSk7
CisJCXJldHVybiAxOwogCX0KIAogCXNoYTFfZGlyID0gZ2V0X29iamVjdF9kaXJlY3RvcnkoKTsK
QEAgLTQ1MCw3ICs0NjQsNyBAQAogCWV4cGFuZF9kZWx0YXMoKTsKIAogCWhlYWRzID0gMDsKLQlm
b3IgKGkgPSAxOyBpIDwgYXJnYzsgaSsrKSB7CisJZm9yIChpID0gaWR4OyBpIDwgYXJnYzsgaSsr
KSB7CiAJCWNvbnN0IGNoYXIgKmFyZyA9IGFyZ3ZbaV07IAogCiAJCWlmICgqYXJnID09ICctJykK
------=_20050521003615_50114--



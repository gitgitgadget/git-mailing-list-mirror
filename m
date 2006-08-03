From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: [PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
Date: Thu, 3 Aug 2006 19:26:20 +0100
Message-ID: <000101c6b72a$51601a80$c47eedc1@ramsay1.demon.co.uk>
References: <7v4pwvuhlo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0002_01C6B732.B3248280"
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 03 20:26:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8htt-0004Ue-FR
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 20:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWHCS0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 14:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWHCS0Y
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 14:26:24 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:64007 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S964817AbWHCS0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 14:26:23 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with smtp (Exim 4.42)
	id 1G8hta-000CNR-Kt; Thu, 03 Aug 2006 18:26:22 +0000
To: "Junio C Hamano" <junkio@cox.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
In-Reply-To: <7v4pwvuhlo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24743>

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C6B732.B3248280
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


On Wed 2006-08-02 at 19:18, Junio C Hamano wrote:
> 
> Martin Waitz <tali@admingilde.org> writes:
> 
> > On Wed, Aug 02, 2006 at 02:03:44AM +0100, Ramsay Jones wrote:
> >>  builtin-help.c |   54
> >> +++++++++++++++++++++++-------------------------------
> >>  builtin.h      |    7 ++-----
> >>  git.c          |    7 +++++--
> >>  3 files changed, 30 insertions(+), 38 deletions(-)
> >
> > this patch is at the tip of "master" now, but with one more change:
> >...
> > diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> > index bf1d638..34a3ccd 100755
> > --- a/t/t9100-git-svn-basic.sh
> > +++ b/t/t9100-git-svn-basic.sh
> >...
> > this looks strange.
> 
> Ramsay's patch to cmd_help() broke this test because the test
> relied on the details of output from "git help", which the patch
> subtly changed.
> 
> I considered making the fix for broken test a separate commit,
> but the fix for the test was simple enough, so I rolled it in,
> with the additional comment in the log to explain what was going
> on -- I suspect the explanation was not clear enough.
> 
> I could have committed the fix for the test first and then this
> one.
> 

I was surprised and concerned to read that (how did I miss the
failing test?), until I found that I didn't have this test! (Phew)
I assume this is a post 1.4.1 test, and from the name, I suppose
they would have mostly failed for me anyway since I don't have
svn installed.

In any event, I'm sorry to have broken your test, I should have
documented the changed behaviour. The change should be limited to
a lower-case usage prefix and a change in exit code from 1 to 129.
The change from "Usage:" to "usage:" was for consistency with every
other command (ignoring the test-delta program). The exit code
change only applies to one of the four original cmd_usage() call
sites; namely the one changed to a usage() call.  Hmmm, should
the other three "call sites" change to exit(129) as well?

Any other change in behavior was unintentional. Did I miss
something?

Speaking of consistency, I noticed some inconsistent command
names in various usage strings. I attach a patch (p0011.txt)
for your consideration.

During one of my "grep-fests", I also noticed some calls to
die(usage_string) rather than usage(usage_string). Calling die()
rather than usage() means that a "fatal: " (rather than "usage: ")
prefix is output prior the usage string, and the exit code
is 128 (rather than 129).

It looks like to choice of die() was deliberate, particularly in
builtin-rm.c and hash-object.c since they call both die() and
usage(). However, It's not clear to me why this choice was made.
(Which is not to say there isn't a perfectly good reason for the
choice; it's just that I don't see it.)

I attach a patch (p0012.txt) which replaces these calls to die()
with usage(). Since it is possible, however unlikely, that there
are some scripts out there that depend on the current behavior,
you may not want to apply it.

Cheers,

Ramsay

------=_NextPart_000_0002_01C6B732.B3248280
Content-Type: text/plain;
	name="P0011.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0011.TXT"

RnJvbSA1NjRkMTFjZDU1Mzg4ZjZhOGRlODJiMzRiMzYyNTQzZjczZTAwOTZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBUaHUsIDMgQXVnIDIwMDYgMTY6Mzg6MzkgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBGaXh1cCBjb21tYW5kIG5hbWVzIGluIHNvbWUgdXNhZ2Ugc3RyaW5ncy4KCk1vc3Qg
dXNhZ2Ugc3RyaW5ncywgc3VjaCBhcyBmb3IgY29tbWFuZCB4eHgsIHN0YXJ0IHdpdGggImdpdC14
eHgiLgpUaGlzIHVwZGF0ZXMgdGhlIHJlYmVscyB0byBjb25mb3JtIHRvIHRoZSBnZW5lcmFsIHBh
dHRlcm4uCihUaGUgZ2l0IHdyYXBwZXIgaXMgYW4gZXhjZXB0aW9uIHRvIHRoaXMsIG9mIGNvdXJz
ZSAuLi4pCgpTaWduZWQtb2ZmLWJ5OiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkx
LmRlbW9uLmNvLnVrPgotLS0KIGJsYW1lLmMgICAgICAgIHwgICAgMiArLQogYnVpbHRpbi1kaWZm
LmMgfCAgICAyICstCiBidWlsdGluLXB1c2guYyB8ICAgIDIgKy0KIG1rdGFnLmMgICAgICAgIHwg
ICAgMiArLQogbWt0cmVlLmMgICAgICAgfCAgICAyICstCiA1IGZpbGVzIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibGFtZS5jIGIvYmxhbWUu
YwppbmRleCBjODZlMmZkLi4yZjE5YjRkIDEwMDY0NAotLS0gYS9ibGFtZS5jCisrKyBiL2JsYW1l
LmMKQEAgLTIwLDcgKzIwLDcgQEAgI2luY2x1ZGUgInhkaWZmLWludGVyZmFjZS5oIgogCiAjZGVm
aW5lIERFQlVHIDAKIAotc3RhdGljIGNvbnN0IGNoYXIgYmxhbWVfdXNhZ2VbXSA9ICJbLWNdIFst
bF0gWy10XSBbLVMgPHJldnMtZmlsZT5dIFstLV0gZmlsZSBbY29tbWl0XVxuIgorc3RhdGljIGNv
bnN0IGNoYXIgYmxhbWVfdXNhZ2VbXSA9ICJnaXQtYmxhbWUgWy1jXSBbLWxdIFstdF0gWy1TIDxy
ZXZzLWZpbGU+XSBbLS1dIGZpbGUgW2NvbW1pdF1cbiIKIAkiICAtYywgLS1jb21wYWJpbGl0eSBV
c2UgdGhlIHNhbWUgb3V0cHV0IG1vZGUgYXMgZ2l0LWFubm90YXRlIChEZWZhdWx0OiBvZmYpXG4i
CiAJIiAgLWwsIC0tbG9uZyAgICAgICAgU2hvdyBsb25nIGNvbW1pdCBTSEExIChEZWZhdWx0OiBv
ZmYpXG4iCiAJIiAgLXQsIC0tdGltZSAgICAgICAgU2hvdyByYXcgdGltZXN0YW1wIChEZWZhdWx0
OiBvZmYpXG4iCmRpZmYgLS1naXQgYS9idWlsdGluLWRpZmYuYyBiL2J1aWx0aW4tZGlmZi5jCmlu
ZGV4IDk5YTJmNzYuLmY5MzRkYzAgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tZGlmZi5jCisrKyBiL2J1
aWx0aW4tZGlmZi5jCkBAIC0yMyw3ICsyMyw3IEBAIHN0cnVjdCBibG9iaW5mbyB7CiB9OwogCiBz
dGF0aWMgY29uc3QgY2hhciBidWlsdGluX2RpZmZfdXNhZ2VbXSA9Ci0iZGlmZiA8b3B0aW9ucz4g
PHJldj57MCwyfSAtLSA8cGF0aD4qIjsKKyJnaXQtZGlmZiA8b3B0aW9ucz4gPHJldj57MCwyfSAt
LSA8cGF0aD4qIjsKIAogc3RhdGljIGludCBidWlsdGluX2RpZmZfZmlsZXMoc3RydWN0IHJldl9p
bmZvICpyZXZzLAogCQkJICAgICAgaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQpkaWZmIC0t
Z2l0IGEvYnVpbHRpbi1wdXNoLmMgYi9idWlsdGluLXB1c2guYwppbmRleCA2NmI5NDA3Li41N2Ri
NDg5IDEwMDY0NAotLS0gYS9idWlsdGluLXB1c2guYworKysgYi9idWlsdGluLXB1c2guYwpAQCAt
OCw3ICs4LDcgQEAgI2luY2x1ZGUgImJ1aWx0aW4uaCIKIAogI2RlZmluZSBNQVhfVVJJICgxNikK
IAotc3RhdGljIGNvbnN0IGNoYXIgcHVzaF91c2FnZVtdID0gImdpdCBwdXNoIFstLWFsbF0gWy0t
dGFnc10gWy0tZm9yY2VdIDxyZXBvc2l0b3J5PiBbPHJlZnNwZWM+Li4uXSI7CitzdGF0aWMgY29u
c3QgY2hhciBwdXNoX3VzYWdlW10gPSAiZ2l0LXB1c2ggWy0tYWxsXSBbLS10YWdzXSBbLS1mb3Jj
ZV0gPHJlcG9zaXRvcnk+IFs8cmVmc3BlYz4uLi5dIjsKIAogc3RhdGljIGludCBhbGwgPSAwLCB0
YWdzID0gMCwgZm9yY2UgPSAwLCB0aGluID0gMTsKIHN0YXRpYyBjb25zdCBjaGFyICpleGVjdXRl
ID0gTlVMTDsKZGlmZiAtLWdpdCBhL21rdGFnLmMgYi9ta3RhZy5jCmluZGV4IGJlNDE1MTMuLjFk
MGNiMTcgMTAwNjQ0Ci0tLSBhL21rdGFnLmMKKysrIGIvbWt0YWcuYwpAQCAtMTIzLDcgKzEyMyw3
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAl1bnNpZ25lZCBjaGFyIHJlc3Vs
dF9zaGExWzIwXTsKIAogCWlmIChhcmdjICE9IDEpCi0JCXVzYWdlKCJjYXQgPHNpZ25hdHVyZWZp
bGU+IHwgZ2l0LW1rdGFnIik7CisJCXVzYWdlKCJnaXQtbWt0YWcgPCBzaWduYXR1cmVmaWxlIik7
CiAKIAlzZXR1cF9naXRfZGlyZWN0b3J5KCk7CiAKZGlmZiAtLWdpdCBhL21rdHJlZS5jIGIvbWt0
cmVlLmMKaW5kZXggYWI2M2NkOS4uOWE2ZjBkMiAxMDA2NDQKLS0tIGEvbWt0cmVlLmMKKysrIGIv
bWt0cmVlLmMKQEAgLTcxLDcgKzcxLDcgQEAgc3RhdGljIHZvaWQgd3JpdGVfdHJlZSh1bnNpZ25l
ZCBjaGFyICpzaAogCXdyaXRlX3NoYTFfZmlsZShidWZmZXIsIG9mZnNldCwgdHJlZV90eXBlLCBz
aGExKTsKIH0KIAotc3RhdGljIGNvbnN0IGNoYXIgbWt0cmVlX3VzYWdlW10gPSAibWt0cmVlIFst
el0iOworc3RhdGljIGNvbnN0IGNoYXIgbWt0cmVlX3VzYWdlW10gPSAiZ2l0LW1rdHJlZSBbLXpd
IjsKIAogaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpCiB7Ci0tIAoxLjQuMQoK

------=_NextPart_000_0002_01C6B732.B3248280
Content-Type: text/plain;
	name="P0012.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0012.TXT"

RnJvbSBkNWMzYzg1MDAzNmYwNmMzNTQxNmI4YTUxNTY1MmMyNDhiZjRhNzNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBUaHUsIDMgQXVnIDIwMDYgMTY6NDg6NDEgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBSZXBsYWNlIHNvbWUgY2FsbHMgdG8gZGllKHVzYWdlX3N0cikgd2l0aCB1c2FnZSh1
c2FnZV9zdHIpLgoKVGhlIG9ubHkgY2hhbmdlIGluIGJlaGF2aW91ciBzaG91bGQgYmUgaGF2aW5n
IGEgInVzYWdlOiAiIHByZWZpeApvbiB0aGUgb3V0cHV0IHN0cmluZyByYXRoZXIgdGhhbiAiZmF0
YWw6ICIsIGFuZCBhbiBleGl0IGNvZGUgb2YKMTI5IHJhdGhlciB0aGFuIDEyOC4KClNpZ25lZC1v
ZmYtYnk6IFJhbXNheSBBbGxhbiBKb25lcyA8cmFtc2F5QHJhbXNheTEuZGVtb24uY28udWs+Ci0t
LQogYnVpbHRpbi1hZGQuYyAgICAgICAgfCAgICAyICstCiBidWlsdGluLWluaXQtZGIuYyAgICB8
ICAgIDIgKy0KIGJ1aWx0aW4tcm0uYyAgICAgICAgIHwgICAgMiArLQogYnVpbHRpbi13cml0ZS10
cmVlLmMgfCAgICAyICstCiBoYXNoLW9iamVjdC5jICAgICAgICB8ICAgIDQgKystLQogNSBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YnVpbHRpbi1hZGQuYyBiL2J1aWx0aW4tYWRkLmMKaW5kZXggYmZiYmIxYi4uY2VkODRlYSAxMDA2
NDQKLS0tIGEvYnVpbHRpbi1hZGQuYworKysgYi9idWlsdGluLWFkZC5jCkBAIC0xNTgsNyArMTU4
LDcgQEAgaW50IGNtZF9hZGQoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LAogCQkJdmVyYm9z
ZSA9IDE7CiAJCQljb250aW51ZTsKIAkJfQotCQlkaWUoYnVpbHRpbl9hZGRfdXNhZ2UpOworCQl1
c2FnZShidWlsdGluX2FkZF91c2FnZSk7CiAJfQogCWdpdF9jb25maWcoZ2l0X2RlZmF1bHRfY29u
ZmlnKTsKIAlwYXRoc3BlYyA9IGdldF9wYXRoc3BlYyhwcmVmaXgsIGFyZ3YgKyBpKTsKZGlmZiAt
LWdpdCBhL2J1aWx0aW4taW5pdC1kYi5jIGIvYnVpbHRpbi1pbml0LWRiLmMKaW5kZXggN2ZkZDJm
YS4uODVhMmFmZCAxMDA2NDQKLS0tIGEvYnVpbHRpbi1pbml0LWRiLmMKKysrIGIvYnVpbHRpbi1p
bml0LWRiLmMKQEAgLTI2Nyw3ICsyNjcsNyBAQCBpbnQgY21kX2luaXRfZGIoaW50IGFyZ2MsIGNv
bnN0IGNoYXIgKiphCiAJCWVsc2UgaWYgKCFzdHJuY21wKGFyZywgIi0tc2hhcmVkPSIsIDkpKQog
CQkJc2hhcmVkX3JlcG9zaXRvcnkgPSBnaXRfY29uZmlnX3Blcm0oImFyZyIsIGFyZys5KTsKIAkJ
ZWxzZQotCQkJZGllKGluaXRfZGJfdXNhZ2UpOworCQkJdXNhZ2UoaW5pdF9kYl91c2FnZSk7CiAJ
fQogCiAJLyoKZGlmZiAtLWdpdCBhL2J1aWx0aW4tcm0uYyBiL2J1aWx0aW4tcm0uYwppbmRleCA0
ZDU2YTFmLi5iZmFjYmIyIDEwMDY0NAotLS0gYS9idWlsdGluLXJtLmMKKysrIGIvYnVpbHRpbi1y
bS5jCkBAIC04MSw3ICs4MSw3IEBAIGludCBjbWRfcm0oaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiph
cmd2LCAKIAkJCWZvcmNlID0gMTsKIAkJCWNvbnRpbnVlOwogCQl9Ci0JCWRpZShidWlsdGluX3Jt
X3VzYWdlKTsKKwkJdXNhZ2UoYnVpbHRpbl9ybV91c2FnZSk7CiAJfQogCWlmIChhcmdjIDw9IGkp
CiAJCXVzYWdlKGJ1aWx0aW5fcm1fdXNhZ2UpOwpkaWZmIC0tZ2l0IGEvYnVpbHRpbi13cml0ZS10
cmVlLmMgYi9idWlsdGluLXdyaXRlLXRyZWUuYwppbmRleCA3MGU5YjZmLi5iYmUxZjA3IDEwMDY0
NAotLS0gYS9idWlsdGluLXdyaXRlLXRyZWUuYworKysgYi9idWlsdGluLXdyaXRlLXRyZWUuYwpA
QCAtNzQsNyArNzQsNyBAQCBpbnQgY21kX3dyaXRlX3RyZWUoaW50IGFyZ2MsIGNvbnN0IGNoYXIg
CiAJCWVsc2UgaWYgKCFzdHJuY21wKGFyZywgIi0tcHJlZml4PSIsIDkpKQogCQkJcHJlZml4ID0g
YXJnICsgOTsKIAkJZWxzZQotCQkJZGllKHdyaXRlX3RyZWVfdXNhZ2UpOworCQkJdXNhZ2Uod3Jp
dGVfdHJlZV91c2FnZSk7CiAJCWFyZ2MtLTsgYXJndisrOwogCX0KIApkaWZmIC0tZ2l0IGEvaGFz
aC1vYmplY3QuYyBiL2hhc2gtb2JqZWN0LmMKaW5kZXggNDNiZDkzYi4uYmYwYjQ5MiAxMDA2NDQK
LS0tIGEvaGFzaC1vYmplY3QuYworKysgYi9oYXNoLW9iamVjdC5jCkBAIC00Niw3ICs0Niw3IEBA
IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJaWYgKCFub19tb3JlX2ZsYWdzICYm
IGFyZ3ZbaV1bMF0gPT0gJy0nKSB7CiAJCQlpZiAoIXN0cmNtcChhcmd2W2ldLCAiLXQiKSkgewog
CQkJCWlmIChhcmdjIDw9ICsraSkKLQkJCQkJZGllKGhhc2hfb2JqZWN0X3VzYWdlKTsKKwkJCQkJ
dXNhZ2UoaGFzaF9vYmplY3RfdXNhZ2UpOwogCQkJCXR5cGUgPSBhcmd2W2ldOwogCQkJfQogCQkJ
ZWxzZSBpZiAoIXN0cmNtcChhcmd2W2ldLCAiLXciKSkgewpAQCAtNjYsNyArNjYsNyBAQCBpbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCQkJaGFzaF9zdGRpbih0eXBlLCB3cml0ZV9v
YmplY3QpOwogCQkJfQogCQkJZWxzZQotCQkJCWRpZShoYXNoX29iamVjdF91c2FnZSk7CisJCQkJ
dXNhZ2UoaGFzaF9vYmplY3RfdXNhZ2UpOwogCQl9IAogCQllbHNlIHsKIAkJCWNvbnN0IGNoYXIg
KmFyZyA9IGFyZ3ZbaV07Ci0tIAoxLjQuMQoK

------=_NextPart_000_0002_01C6B732.B3248280--

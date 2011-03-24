From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
Date: Wed, 23 Mar 2011 22:23:18 -0700
Message-ID: <AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
	<1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0022158dfae3d9591f049f33ac9d
Cc: git@vger.kernel.org, jnareb@gmail.com, gitster@pobox.com
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 06:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2d17-0002Yq-Bo
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 06:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab1CXFXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 01:23:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46193 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1CXFXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 01:23:20 -0400
Received: by fxm17 with SMTP id 17so8026782fxm.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZNAwVTy/afzkMIWGCFbaTZ9g5jCgF2SvpvF8aYoG3yU=;
        b=fbZKBt7RoxMhI3b47p9iOjiphTYR2s0B+w3B2DttbdZd/hFgXZzQiLMG455CakiABL
         kQhsB3optanNiVHBLCQBdVEpcSDlD8BAeyMA0++SGAlM+BqaItNJsB9ekz1TQkFW8Jnf
         LC+HCWZM+5JBc9XUBPwQCOeDXa1lxKsT/JOco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FWXPISlPZUpJEP/kAizYEKFWmlEqXyKbzstdgc1RVPvziBIvwI3oDI/QU3JZW3Vw9u
         KVv2dDnoMWB2QzcbflybEHuXq1FSrAysDPgRCtj5tkEL4k8BnTdSe2gTs4iZJDsA5O4V
         Yd9VK2OZfpULPNi/AGgZXnJwchIrWXdOwqjk0=
Received: by 10.223.148.147 with SMTP id p19mr840353fav.140.1300944198915;
 Wed, 23 Mar 2011 22:23:18 -0700 (PDT)
Received: by 10.223.145.131 with HTTP; Wed, 23 Mar 2011 22:23:18 -0700 (PDT)
In-Reply-To: <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169891>

--0022158dfae3d9591f049f33ac9d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2011 at 5:08 PM, John 'Warthog9' Hawley
<warthog9@eaglescrag.net> wrote:
> This patch takes the same basic goal, display the appropriate times
> in a given timezone, and implements it in Javascript. =C2=A0This requires
> adding / using a new class, dtcommit, which is based on the
> dtstart/dtend microformats. =C2=A0Appropriate commit dates are wrapped in
> a span with this class, and a title of the time in ISO8601 format.

John,

Thanks for coding this up.  I tested it on a couple of different
browsers and wanted to share my observations with you.

First, the easy stuff:

1) "git am" complains about whitespace violations

2) HH:MM:SS times need zero padding; otherwise you see:

Tue, 8 Mar 2011 20:29:9 -0700

3) Some of the Javascript functions are double-indented, others single-inde=
nted.

4) IE6 does not seem to like ISO 8601 format:

x =3D new Date("2011-03-09T03:29:09Z");

This sets all fields to NaN.  I suspect that getTime() values
(milliseconds since 1970-01-01) are more portable.

I have attached a trivial patch for these four items; it applies on
top of your original submission.


Some other things that popped up:

5) Some timezone offsets are not a whole number of hours.  Bangalore
time is GMT +0530, for instance.

6) Most U.S. timezones honor daylight savings, so they could be
something like -0700 for part of the year, and -0800 for the rest of
the year.  Picking the "local" option would automatically adjust for
this, but DST limits the usefulness of permanently storing a fixed TZ
offset in the cookie.

7) Looking at a pre-DST commit after DST (or vice versa) can be a
little confusing:

Tue, 8 Mar 2011 20:29:09 -0700 + (19:29 -0800)

I'm not sure which time to believe.  (Although it's likely that a few
weeks after a commit, the exact hour doesn't matter.)

8) The " + " popup menu is a little quirky.  On FF 3.6 it partially
collapses after selecting a value from the dropdown.  On IE6 it shows
"Error in parsing value for 'display'" and does not render.  On Opera
11 it seemed to work OK.

Firefox breakage: http://img217.imageshack.us/f/firefoxa.png/

I'm wondering if there might be a better place on the page to put the
TZ selection.  It isn't immediately obvious to the user what the extra
" + " does, and it seems to cause some issues.

If you decide to keep it where it is, you might want to consider
absolute or fixed positioning so that other elements do not wrap
around it.  IOW it would work more like the dropdown menus on many
sites.

The timezone fixup javascript seemed to work reasonably well, except
for the hiccup with IE6.  Maybe it would be worth splitting this into
two patches: one to rewrite the timestamps, and a second one to add
the TZ selection interface.

--0022158dfae3d9591f049f33ac9d
Content-Type: application/octet-stream; 
	name="0001-gitweb-minor-fixups-to-javascript-localtime-feature.patch"
Content-Disposition: attachment; 
	filename="0001-gitweb-minor-fixups-to-javascript-localtime-feature.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gln7yft20

RnJvbSBmZThkNWJhMWQzOTIyY2QzNjg2OTFkNDdiYjVmNjA1YjllMmJlZDU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZXZpbiBDZXJuZWtlZSA8Y2VybmVrZWVAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDIzIE1hciAyMDExIDIyOjAwOjMxIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gZ2l0
d2ViOiBtaW5vciBmaXh1cHMgdG8gamF2YXNjcmlwdCBsb2NhbHRpbWUgZmVhdHVyZQoKRml4IHdo
aXRlc3BhY2UsIGluZGVudGF0aW9uLCBISDpNTTpTUyB6ZXJvIHBhZGRpbmcsIElFNiBjb21wYXRp
YmlsaXR5LgoKU2lnbmVkLW9mZi1ieTogS2V2aW4gQ2VybmVrZWUgPGNlcm5la2VlQGdtYWlsLmNv
bT4KLS0tCiBnaXR3ZWIvZ2l0d2ViLnBlcmwgICAgICAgfCAgIDExICsrKystLS0KIGdpdHdlYi9z
dGF0aWMvanMvZGF0ZS5qcyB8ICAgNjMgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDMzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3ZWIu
cGVybAppbmRleCBkZmNlYWY2Li4xZDVlOTcwIDEwMDc1NQotLS0gYS9naXR3ZWIvZ2l0d2ViLnBl
cmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBAIC0yNjIsOSArMjYyLDkgQEAgb3VyICVoaWdo
bGlnaHRfZXh0ID0gKAogKTsKIAogCi0jIEVuYWJsZSAvIERpc2FibGUgdGhlIGFiaWxpdHkgZm9y
IGdpdHdlYiB0byB1c2UgYSBzbWFsbCBhbW91bnQgb2YgCisjIEVuYWJsZSAvIERpc2FibGUgdGhl
IGFiaWxpdHkgZm9yIGdpdHdlYiB0byB1c2UgYSBzbWFsbCBhbW91bnQgb2YKICMgamF2YXNjcmlw
dCwgYWxvbmcgd2l0aCBhIGphdmFzY3JpcHQgY29va2llLCB0byBkaXNwbGF5IGNvbW1pdAotIyB0
aW1lcyBpbiB0aGUgcHJlZmZlcmVkIHRpbWV6b25lLiAgVGltZSB6b25lcyBjYW4gYmUgcHJlLXNl
dCAKKyMgdGltZXMgaW4gdGhlIHByZWZlcnJlZCB0aW1lem9uZS4gIFRpbWUgem9uZXMgY2FuIGJl
IHByZS1zZXQKICMgYnkgc3BlY2lmeWluZyBpdCBpbiAkanNsb2NhbHRpbWUgd2l0aCBvbmUgb2Yg
dGhlIGZvbGxvd2luZzoKICMKICMJdXRjCkBAIC0yOTU2LDYgKzI5NTYsNyBAQCBzdWIgcGFyc2Vf
ZGF0ZSB7CiAJICAgICAgICAgICAgICAgICAgICAgJG1kYXksICRtb250aHNbJG1vbl0sICRob3Vy
ICwkbWluOwogCSRkYXRleydpc28tODYwMSd9ICA9IHNwcmludGYgIiUwNGQtJTAyZC0lMDJkVCUw
MmQ6JTAyZDolMDJkWiIsCiAJICAgICAgICAgICAgICAgICAgICAgMTkwMCskeWVhciwgMSskbW9u
LCAkbWRheSwgJGhvdXIgLCRtaW4sICRzZWM7CisJJGRhdGV7J2dldFRpbWUnfSAgID0gJGVwb2No
ICogMTAwMDsKIAogCSR0eiA9fiBtL14oWytcLV1bMC05XVswLTldKShbMC05XVswLTldKSQvOwog
CW15ICRsb2NhbCA9ICRlcG9jaCArICgoaW50ICQxICsgKCQyLzYwKSkgKiAzNjAwKTsKQEAgLTQw
MTMsNyArNDAxNCw3IEBAIHN1YiBnaXRfcHJpbnRfYXV0aG9yc2hpcCB7CiAJbXkgJWFkID0gcGFy
c2VfZGF0ZSgkY28tPnsnYXV0aG9yX2Vwb2NoJ30sICRjby0+eydhdXRob3JfdHonfSk7CiAJcHJp
bnQgIjwkdGFnIGNsYXNzPVwiYXV0aG9yX2RhdGVcIj4iIC4KIAkgICAgICBmb3JtYXRfc2VhcmNo
X2F1dGhvcigkYXV0aG9yLCAiYXV0aG9yIiwgZXNjX2h0bWwoJGF1dGhvcikpIC4KLQkgICAgICAi
IFs8c3BhbiBjbGFzcz1cImR0Y29tbWl0XCIgdGl0bGU9XCIkYWR7J2lzby04NjAxJ31cIj4kYWR7
J3JmYzI4MjInfTwvc3Bhbj4iOworCSAgICAgICIgWzxzcGFuIGNsYXNzPVwiZHRjb21taXRcIiB0
aXRsZT1cIiRhZHsnZ2V0VGltZSd9XCI+JGFkeydyZmMyODIyJ308L3NwYW4+IjsKIAlwcmludF9s
b2NhbF90aW1lKCVhZCkgaWYgKCRvcHRzey1sb2NhbHRpbWV9KTsKIAlwcmludCAiXSIgLiBnaXRf
Z2V0X2F2YXRhcigkY28tPnsnYXV0aG9yX2VtYWlsJ30sIC1wYWRfYmVmb3JlID0+IDEpCiAJCSAg
LiAiPC8kdGFnPlxuIjsKQEAgLTQwNDAsNyArNDA0MSw3IEBAIHN1YiBnaXRfcHJpbnRfYXV0aG9y
c2hpcF9yb3dzIHsKIAkJICAgICAgZ2l0X2dldF9hdmF0YXIoJGNvLT57IiR7d2hvfV9lbWFpbCJ9
LCAtc2l6ZSA9PiAnZG91YmxlJykgLgogCQkgICAgICAiPC90ZD48L3RyPlxuIiAuCiAJCSAgICAg
ICI8dHI+IiAuCi0JCSAgICAgICI8dGQ+PC90ZD48dGQ+IDxzcGFuIGNsYXNzPVwiZHRjb21taXRc
IiB0aXRsZT1cIiR3ZHsnaXNvLTg2MDEnfVwiPiR3ZHsncmZjMjgyMid9PC9zcGFuPiI7CisJCSAg
ICAgICI8dGQ+PC90ZD48dGQ+IDxzcGFuIGNsYXNzPVwiZHRjb21taXRcIiB0aXRsZT1cIiR3ZHsn
Z2V0VGltZSd9XCI+JHdkeydyZmMyODIyJ308L3NwYW4+IjsKIAkJcHJpbnRfbG9jYWxfdGltZSgl
d2QpOwogCQlwcmludCAiPC90ZD4iIC4KIAkJICAgICAgIjwvdHI+XG4iOwpAQCAtNTQ1NCw3ICs1
NDU1LDcgQEAgc3ViIGdpdF9zdW1tYXJ5IHsKIAkgICAgICAiPHRyIGlkPVwibWV0YWRhdGFfb3du
ZXJcIj48dGQ+b3duZXI8L3RkPjx0ZD4iIC4gZXNjX2h0bWwoJG93bmVyKSAuICI8L3RkPjwvdHI+
XG4iOwogCWlmIChkZWZpbmVkICRjZHsncmZjMjgyMid9KSB7CiAJCXByaW50ICI8dHIgaWQ9XCJt
ZXRhZGF0YV9sY2hhbmdlXCI+PHRkPmxhc3QgY2hhbmdlPC90ZD5cbiI7Ci0JCXByaW50ICI8dGQ+
PHNwYW4gY2xhc3M9XCJkdGNvbW1pdFwiIHRpdGxlPVwiJGNkeydpc28tODYwMSd9XCI+JGNkeydy
ZmMyODIyJ308L3NwYW4+PC90ZD48L3RyPlxuIjsKKwkJcHJpbnQgIjx0ZD48c3BhbiBjbGFzcz1c
ImR0Y29tbWl0XCIgdGl0bGU9XCIkY2R7J2dldFRpbWUnfVwiPiRjZHsncmZjMjgyMid9PC9zcGFu
PjwvdGQ+PC90cj5cbiI7CiAJfQogCiAJIyB1c2UgcGVyIHByb2plY3QgZ2l0IFVSTCBsaXN0IGlu
ICRwcm9qZWN0cm9vdC8kcHJvamVjdC9jbG9uZXVybApkaWZmIC0tZ2l0IGEvZ2l0d2ViL3N0YXRp
Yy9qcy9kYXRlLmpzIGIvZ2l0d2ViL3N0YXRpYy9qcy9kYXRlLmpzCmluZGV4IGE2ZDZmODEuLjE3
MjhiZGEgMTAwNjQ0Ci0tLSBhL2dpdHdlYi9zdGF0aWMvanMvZGF0ZS5qcworKysgYi9naXR3ZWIv
c3RhdGljL2pzL2RhdGUuanMKQEAgLTEyLDE1ICsxMiwxNSBAQCBmdW5jdGlvbiBvbmxvYWRUWlNl
dHVwKCl7CiB9CiAKIGZ1bmN0aW9uIGFkZENoYW5nZVRaKCkgewotCQl2YXIgdHh0Q2xhc3Nlc0Zv
dW5kID0gIiI7Ci0JCXZhciBjbGFzc2VzRm91bmQgPSBmaW5kRWxlbWVudHNCeUNsYXNzTmFtZSgg
ImR0Y29tbWl0IiApOwotCQl0eHRDbGFzc2VzRm91bmQgKz0gIkxlbmd0aDogIisgY2xhc3Nlc0Zv
dW5kLmxlbmd0aCArIjxicj5cbiI7Ci0JCWZvciAoIHggPSAwOyB4IDwgY2xhc3Nlc0ZvdW5kLmxl
bmd0aDsgeCsrKXsKLQkJCWN1ckVsZW1lbnQgPSBjbGFzc2VzRm91bmRbeF07Ci0JCQl0eHRDbGFz
c2VzRm91bmQgKz0gIjxicj5cbiIrIHggKyIgLSAiKyBjdXJFbGVtZW50Lm5vZGVOYW1lICArIiAt
ICIrIGN1ckVsZW1lbnQudGl0bGUgKyIgLSAiKyBjdXJFbGVtZW50LmlubmVySFRNTCArIjxicj5c
biI7Ci0JCQl2YXIgc3RyRXh0cmEgPSAiIDxzcGFuIG9uY2xpY2s9XCJjbGlja0RhdGUoZXZlbnQu
dGFyZ2V0KTtcIiB0aXRsZT1cIitcIj4rPC9zcGFuPiIKLQkJCWN1ckVsZW1lbnQuaW5uZXJIVE1M
ID0gY3VyRWxlbWVudC5pbm5lckhUTUwgKyBzdHJFeHRyYTsKLQkJfQorCXZhciB0eHRDbGFzc2Vz
Rm91bmQgPSAiIjsKKwl2YXIgY2xhc3Nlc0ZvdW5kID0gZmluZEVsZW1lbnRzQnlDbGFzc05hbWUo
ICJkdGNvbW1pdCIgKTsKKwl0eHRDbGFzc2VzRm91bmQgKz0gIkxlbmd0aDogIisgY2xhc3Nlc0Zv
dW5kLmxlbmd0aCArIjxicj5cbiI7CisJZm9yICggeCA9IDA7IHggPCBjbGFzc2VzRm91bmQubGVu
Z3RoOyB4KyspeworCQljdXJFbGVtZW50ID0gY2xhc3Nlc0ZvdW5kW3hdOworCQl0eHRDbGFzc2Vz
Rm91bmQgKz0gIjxicj5cbiIrIHggKyIgLSAiKyBjdXJFbGVtZW50Lm5vZGVOYW1lICArIiAtICIr
IGN1ckVsZW1lbnQudGl0bGUgKyIgLSAiKyBjdXJFbGVtZW50LmlubmVySFRNTCArIjxicj5cbiI7
CisJCXZhciBzdHJFeHRyYSA9ICIgPHNwYW4gb25jbGljaz1cImNsaWNrRGF0ZShldmVudC50YXJn
ZXQpO1wiIHRpdGxlPVwiK1wiPis8L3NwYW4+IgorCQljdXJFbGVtZW50LmlubmVySFRNTCA9IGN1
ckVsZW1lbnQuaW5uZXJIVE1MICsgc3RyRXh0cmE7CisJfQogfQogCiBmdW5jdGlvbiBjaGVja1Ra
Q29va2llKCl7CkBAIC0zNSwxOCArMzUsMjYgQEAgZnVuY3Rpb24gY2hlY2tUWkNvb2tpZSgpewog
fQogCiBmdW5jdGlvbiBmb3JtYXRUWiggdHpPZmZzZXQgKSB7Ci0JCXZhciBwb3NOZWcgPSAiKyI7
Ci0JCWlmKCB0ek9mZnNldCA8IDAgKXsKLQkJCXBvc05lZyA9ICItIjsKLQkJfQotCQl0ek9mZnNl
dCA9IE1hdGguc3FydCggTWF0aC5wb3coIHR6T2Zmc2V0LCAyICkgKTsKLQkJaWYoIHR6T2Zmc2V0
IDwgMTAwICl7Ci0JCQl0ek9mZnNldCA9IHR6T2Zmc2V0ICogMTAwOwotCQl9Ci0JCWZvciggeSA9
IHR6T2Zmc2V0LnRvU3RyaW5nKCkubGVuZ3RoICsgMTsgeSA8PSA0OyB5KysgKXsKLQkJCXR6T2Zm
c2V0ID0gIjAiKyB0ek9mZnNldDsKLQkJfQotCQlyZXR1cm4gcG9zTmVnICsgdHpPZmZzZXQ7CisJ
dmFyIHBvc05lZyA9ICIrIjsKKwlpZiggdHpPZmZzZXQgPCAwICl7CisJCXBvc05lZyA9ICItIjsK
Kwl9CisJdHpPZmZzZXQgPSBNYXRoLnNxcnQoIE1hdGgucG93KCB0ek9mZnNldCwgMiApICk7CisJ
aWYoIHR6T2Zmc2V0IDwgMTAwICl7CisJCXR6T2Zmc2V0ID0gdHpPZmZzZXQgKiAxMDA7CisJfQor
CWZvciggeSA9IHR6T2Zmc2V0LnRvU3RyaW5nKCkubGVuZ3RoICsgMTsgeSA8PSA0OyB5KysgKXsK
KwkJdHpPZmZzZXQgPSAiMCIrIHR6T2Zmc2V0OworCX0KKwlyZXR1cm4gcG9zTmVnICsgdHpPZmZz
ZXQ7Cit9CisKK2Z1bmN0aW9uIHBhZFRpbWUoIHZhbCApIHsKKwlpZiggdmFsIDwgMTAgKXsKKwkJ
cmV0dXJuICIwIiArIHZhbC50b1N0cmluZygpOworCX0gZWxzZSB7CisJCXJldHVybiB2YWwudG9T
dHJpbmcoKTsKKwl9CiB9CiAKIGZ1bmN0aW9uIGRhdGVPdXRwdXQoIG9iakRhdGUgKSB7CkBAIC02
Miw3ICs3MCw3IEBAIGZ1bmN0aW9uIGRhdGVPdXRwdXRUWiggb2JqRGF0ZSwgdHpPZmZzZXQgKSB7
CiAJCXR6T2Zmc2V0ID0gMDsKIAl9ZWxzZSBpZiggdHpPZmZzZXQgPT0gImxvY2FsIiApewogCQl2
YXIgdGVtcERhdGUgPSBuZXcgRGF0ZSgpOwotCQl0ek9mZnNldCA9IHRlbXBEYXRlLmdldFRpbWV6
b25lT2Zmc2V0KCkgKiAtMSAvIDYwICogMTAwOyAKKwkJdHpPZmZzZXQgPSB0ZW1wRGF0ZS5nZXRU
aW1lem9uZU9mZnNldCgpICogLTEgLyA2MCAqIDEwMDsKIAkJdHpPZmZzZXQgPSBmb3JtYXRUWigg
dHpPZmZzZXQgKTsKIAl9CiAKQEAgLTc2LDkgKzg0LDkgQEAgZnVuY3Rpb24gZGF0ZU91dHB1dFRa
KCBvYmpEYXRlLCB0ek9mZnNldCApIHsKIAlzdHJEYXRlICs9IHRvRGF0ZVRpbWUuZ2V0VVRDRGF0
ZSgpICsiICI7CiAJc3RyRGF0ZSArPSBtb250aHNPZllyWyB0b0RhdGVUaW1lLmdldFVUQ01vbnRo
KCkgXSArIiAiOwogCXN0ckRhdGUgKz0gdG9EYXRlVGltZS5nZXRVVENGdWxsWWVhcigpICsiICI7
Ci0Jc3RyRGF0ZSArPSB0b0RhdGVUaW1lLmdldFVUQ0hvdXJzKCkgKyI6IjsKLQlzdHJEYXRlICs9
IHRvRGF0ZVRpbWUuZ2V0VVRDTWludXRlcygpICsiOiI7Ci0Jc3RyRGF0ZSArPSB0b0RhdGVUaW1l
LmdldFVUQ1NlY29uZHMoKSArIiAiOworCXN0ckRhdGUgKz0gcGFkVGltZSh0b0RhdGVUaW1lLmdl
dFVUQ0hvdXJzKCkpICsiOiI7CisJc3RyRGF0ZSArPSBwYWRUaW1lKHRvRGF0ZVRpbWUuZ2V0VVRD
TWludXRlcygpKSArIjoiOworCXN0ckRhdGUgKz0gcGFkVGltZSh0b0RhdGVUaW1lLmdldFVUQ1Nl
Y29uZHMoKSkgKyIgIjsKIAogCXN0ckRhdGUgKz0gdHpPZmZzZXQ7CiAKQEAgLTk4LDcgKzEwNiw3
IEBAIGZ1bmN0aW9uIHR6Q2hhbmdlU05TKCB0ek9mZnNldCwgc2V0ICl7CiAJdmFyIGNsYXNzZXNG
b3VuZCA9IGZpbmRFbGVtZW50c0J5Q2xhc3NOYW1lKCAiZHRjb21taXQiICk7CiAJZm9yICggeCA9
IDA7IHggPCBjbGFzc2VzRm91bmQubGVuZ3RoOyB4KyspewogCQljdXJFbGVtZW50ID0gY2xhc3Nl
c0ZvdW5kW3hdOwotCQl2YXIgb3JpZ0RhdGVUaW1lID0gbmV3IERhdGUoIGN1ckVsZW1lbnQudGl0
bGUgKTsKKwkJdmFyIG9yaWdEYXRlVGltZSA9IG5ldyBEYXRlKCBwYXJzZUludChjdXJFbGVtZW50
LnRpdGxlKSApOwogCQljdXJFbGVtZW50LmlubmVySFRNTCA9IGRhdGVPdXRwdXRUWihvcmlnRGF0
ZVRpbWUsIHR6T2Zmc2V0KTsKIAl9CiAJdmFyIHR6RXhwRGF0ZSA9IG5ldyBEYXRlKCk7CkBAIC0x
MTQsNyArMTIyLDcgQEAgZnVuY3Rpb24gY2xpY2tEYXRlKCBjbGtFdmVudCApIHsKIAkJY2xrRXZl
bnQudGl0bGU9Ii0iOwogCiAJCXZhciBwcmVTZXRUWiA9IGdldENvb2tpZSggZ2V0d2ViQ29va2ll
VFpPZmZzZXQgKTsKLQkJCisKIAkJdmFyIGFyclNlbGVjdGVkID0gbmV3IEFycmF5KCk7CiAJCXZh
ciBvZmZzZXRBcnIgPSAxNDsKIAkJYXJyU2VsZWN0ZWRbMF0gPSAiICI7CkBAIC0xNTcsNCArMTY1
LDMgQEAgZnVuY3Rpb24gY2xpY2tEYXRlKCBjbGtFdmVudCApIHsKIAkJY2xrRXZlbnQucGFyZW50
Tm9kZS5pbm5lckhUTUwgPSAiKyI7CiAJfQogfQotCi0tIAoxLjcuNC4xCgo=
--0022158dfae3d9591f049f33ac9d--

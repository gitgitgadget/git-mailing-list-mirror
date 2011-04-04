From: Ciaran <ciaranj@gmail.com>
Subject: p4Merge bundled command and the behaviour with files (same name)
 added on different branches.
Date: Mon, 4 Apr 2011 09:55:41 +0100
Message-ID: <BANLkTimpsg=26C0mq=feVT7mt0nwZBoBUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd148f4a21bfe04a013ec5a
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 10:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6fZn-0008Nm-ER
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 10:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab1DDIzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 04:55:43 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:61153 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab1DDIzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 04:55:42 -0400
Received: by pxi2 with SMTP id 2so1827254pxi.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Y85Fg+uK8SSqV7V+oPS8/EBbZaRMQkaz3379R/anKU8=;
        b=Om9b3VW48bsgLdHB1bfhSQTVOIuvixKFtMSOxt3xGpCxjND8kXJbEEyrpCHwwh4Arn
         IJNCVTzYWQ7p8h88N5cmRICTATInDwakFXRTfGZmNqGz8A5JTO+7FxTebrkKiepgStDR
         0lDUHtSwwGWqjiU62+1ebvpPCAR5Wfw6YOiSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aDrVvrr2Caid17B+l1M/1lgrZq11ML4RcC0cgoSpuvmLY8pEshllg45F6pD1AwTkOZ
         kHTgNONSjkg43BPQuWvrt8tjDadMNBIM2vAZBDCpQrwaMT6qlShKJNEOWTuSsTQ0U9mW
         LrJP3LmvwodVlYEhMfp1t+Z2fmqBgLqb8/Iio=
Received: by 10.142.127.17 with SMTP id z17mr1705361wfc.110.1301907341712;
 Mon, 04 Apr 2011 01:55:41 -0700 (PDT)
Received: by 10.68.40.134 with HTTP; Mon, 4 Apr 2011 01:55:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170797>

--000e0cd148f4a21bfe04a013ec5a
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

Hopefully a quick question.  Given the following scenario

mkdir git_repo
cd git_repo
git init
echo foo > foo.txt
git add foo.txt
git commit -m "Initial commit"
git checkout -b other
echo bar > bar.txt
git add bar.txt
git commit -m "other commit"
git checkout master
echo barbarella > bar.txt
git add bar.txt
git commit -m "master commit"
git merge other

We would expect a 'both added' merge conflict (both the other branch,
and the master branch added the file named bar.txt, but with different
content.)  This is all good and right.  So in a system configured to
use p4merge as the mergetool, one fires up with 'git mergetool'

What happens now is p4merge starts and tells us:

Base: bar.txt.LOCAL.<num1>.txt
Left: bar.txt.LOCAL.<num1>.txt Differences from base: 0
Right: bar.txt.LOCAL.<num2>.txt Differences from base: 1
Merge: bar.txt Conflicts:0

Presenting the left + right options on top of each other in the result
window (which may be correct) and leaving the save button disabled
(grayed out)

If at this point one closes the window without editing the presented
(apparently merged) file, then nothing will be saved to disk and we
will see:

bar.txt seems unchanged.
Was the merge successful? [y/n]

In the console.  Which Git wise is correct, that is exactly right, the
p4merge tool hasn't made any actual changes to the underlying file.

This behaviour seems confusing to me (the p4merge client behaviour,
*not* Git's)   I believe it is because in the case where there is no
logical base between two files the local one is arbritrarily chosen,
and p4merge *thinks* that this is equal to the merge result and has
nothing to persist.

I have attached a patch that resolves the issue for me (e.g.
introduces the behaviour I expect) by passing a reference to an empty
file in the case where there is no meaningful base.  Unfortunately I
don't understand enough to say whether this change is correct or not
and would value feedback on it.

Many thanks
 - Cj.

--000e0cd148f4a21bfe04a013ec5a
Content-Type: application/octet-stream; 
	name="0001-Modified-the-p4merge-client-command-to-pass-a-refere.patch"
Content-Disposition: attachment; 
	filename="0001-Modified-the-p4merge-client-command-to-pass-a-refere.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gm3610kp0

RnJvbSA4ZWI1MDdhYzg2Zjk1MmJmNDcwMGQ5NGNhYTM2MWIxNjMyYWIwMWE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBjaWFyYW5qIDxjaWFyYW5qQGdtYWlsLmNvbT4KRGF0ZTogTW9u
LCA0IEFwciAyMDExIDA5OjI0OjE4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gTW9kaWZpZWQgdGhl
IHA0bWVyZ2UgY2xpZW50IGNvbW1hbmQgdG8gcGFzcyBhIHJlZmVyZW5jZSB0byBhbiBlbXB0eSBm
aWxlIGluc3RlYWQgb2YgdGhlIGxvY2FsIGZpbGUgd2hlbiBubyBiYXNlIHJldmlzaW9uIGF2YWls
YWJsZS4KCkluIHRoZSBzaXR1YXRpb24gd2hlcmUgYSBtZXJnZSB0cmllcyB0byBhZGQgYSBmaWxl
IGZyb20gb25lIGJyYW5jaCBpbnRvIGEgYnJhbmNoIHRoYXQgYWxyZWFkeSBjb250YWlucyB0aGF0
IGZpbGUgKGJ5IG5hbWUpLCBwNG1lcmdlCmN1cnJlbnRseSBzZWVtcyB0byBoYXZlIHN1Y2Nlc3Nm
dWxseSBhdXRvbWF0aWNhbGx5IHJlc29sdmVkIHRoZSAnY29uZmxpY3QnIHdoZW4gaXQgaXMgb3Bl
bmVkIChjb3JyZWN0bHkgaWYgdGhlIGZpbGVzIGRpZmZlcmVkIGJ5Cmp1c3Qgd2hpdGVzcGFjZSBm
b3IgZXhhbXBsZSkgYnV0IGxlYXZlcyB0aGUgc2F2ZSBidXR0b24gZGlzYWJsZWQuIFRoaXMgbWVh
bnMgdGhlIHVzZXIgb2YgdGhlIHA0bWVyZ2UgY2xpZW50IGNhbm5vdCBjb21taXQgdGhlIHJlc29s
dmVkCmNoYW5nZXMgYmFjayB0byBkaXNrIGFuZCBtZXJlbHkgZXhpdHMsIGxlYXZpbmcgdGhlIG9y
aWdpbmFsIChtZXJnZS1jb25mbGljdGVkKSBmaWxlIGluLXRhY3Qgb24gdGhlIGRpc2suCgpJZiB0
aGUgdXNlciBpcyBub3QgcGF5aW5nIGF0dGVudGlvbiB0aGlzIGZpbGUgY2FuIGdldCBjb21taXR0
ZWQgOigKCldpdGggdGhpcyBjaGFuZ2UsIHA0bWVyZ2UgYXBwZWFycyB0byBiZWhhdmUgZmFyIG1v
cmUgYXMgZXhwZWN0ZWQsIGZvciBleGFtcGxlIGxlYXZpbmcgdGhlIHNhdmUgYnV0dG9uIGVuYWJs
ZWQgYWxsb3dpbmcgb25lIHRvIHNhdmUgdGhlCnJlc29sdmVkIGZpbGUgdG8gZGlzay4KLS0tCiBn
aXQtbWVyZ2V0b29sLS1saWIuc2ggfCAgICA0ICsrKy0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1tZXJnZXRvb2wtLWxp
Yi5zaCBiL2dpdC1tZXJnZXRvb2wtLWxpYi5zaAppbmRleCBmYjNmNTJiLi4zZTQ4NmRjIDEwMDY0
NAotLS0gYS9naXQtbWVyZ2V0b29sLS1saWIuc2gKKysrIGIvZ2l0LW1lcmdldG9vbC0tbGliLnNo
CkBAIC0yNjIsNyArMjYyLDkgQEAgcnVuX21lcmdlX3Rvb2wgKCkgewogCQkJaWYgJGJhc2VfcHJl
c2VudDsgdGhlbgogCQkJCSIkbWVyZ2VfdG9vbF9wYXRoIiAiJEJBU0UiICIkTE9DQUwiICIkUkVN
T1RFIiAiJE1FUkdFRCIKIAkJCWVsc2UKLQkJCQkiJG1lcmdlX3Rvb2xfcGF0aCIgIiRMT0NBTCIg
IiRMT0NBTCIgIiRSRU1PVEUiICIkTUVSR0VEIgorCQkJCXRvdWNoICIuZW1wdHkiCisJCQkJIiRt
ZXJnZV90b29sX3BhdGgiICIuZW1wdHkiICIkTE9DQUwiICIkUkVNT1RFIiAiJE1FUkdFRCIKKwkJ
CQlybSAiLmVtcHR5IgogCQkJZmkKIAkJCWNoZWNrX3VuY2hhbmdlZAogCQllbHNlCi0tIAoxLjcu
My40Cgo=
--000e0cd148f4a21bfe04a013ec5a--

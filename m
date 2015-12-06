From: David Ware <davidw@realtimegenomics.com>
Subject: git subtree bug produces divergent descendants
Date: Mon, 7 Dec 2015 09:41:24 +1300
Message-ID: <CAET=KiVReZMyJmPMMB8eVSqYP9ZF2td-9qdB5KQRTrJSoUt9Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1143637894f537052640c35b
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 21:41:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5g7j-0002Kv-B7
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 21:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbbLFUl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 15:41:26 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33515 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbbLFUlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 15:41:25 -0500
Received: by vkca188 with SMTP id a188so92767377vkc.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 12:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3pfY5lHkA2tHc5gx7WyHRLxFhU0FT4VTUbODI0DUow4=;
        b=qt5jqLVu7JYQ/17SgrX39AHpQboin9zmx468vbJuhW6Fe189AhgJdekyCt+X2agfHe
         9JH+ldzY+e5N4vm7LGPJivL4lZ+LQrd3WwS4XXnPt0gh1W5Z2kXLoAYYPZ113xyLrx4v
         nZCNACmqAxcpAh8VZrUk0vt0/FLbcLFzbUsODqPqgx7KmjRkEFeZj0RsLb/x0KgJ2TwK
         FXib0fdgQRNqXGUgJW4Hu7c6o7+3tlu/0QxO8sRDgyKlSPYn+dIqKKnKjLyAjUiPpa+a
         EFy7c8dT+4Kwpkc3WH2CwCkgfbdI6MDtmqkmX7rxUVBnJyFLwrXb/Bh3Hn5TAhaNw5d7
         Ib9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=3pfY5lHkA2tHc5gx7WyHRLxFhU0FT4VTUbODI0DUow4=;
        b=cbjETPuApK2pv63sldg683F3DIMBhtwKBF49KFsjUZe6PV3nm9ZSxLbzL9Tu+tbFPH
         1v51Mh5PH48Rzt2AkBdQiokxcXXTwx/SbUdBOwVKI9pfpmTLYkhZmdw/fkB4qgUAl0DK
         Pg3go6WxjARCbQlcXCOXi6LeNfs27J/n4yPjskS6+aB3usAn+PWt8gs0Hd7aGTK3YlyV
         p3YO6AD0vklVklSJ3kwRGiWmN6w8inFQA9PzhVo1cVGF0MHATBR43PyYyDIhzuP0XsKs
         vP09M/yLGE9lD1bhUnwzqr0kWIS6zH21bS876LEdr7eAlWTejLr9d12S1e+mJPSByC9R
         ESVA==
X-Gm-Message-State: ALoCoQmgIqD9G8z/X6/eMGGsV8ukXvGqPlbzrJe6rwIqf4u8AXxoa7+vsCxYY7PTNbxPN0ySs47q
X-Received: by 10.31.16.197 with SMTP id 66mr17896659vkq.143.1449434484623;
 Sun, 06 Dec 2015 12:41:24 -0800 (PST)
Received: by 10.31.236.4 with HTTP; Sun, 6 Dec 2015 12:41:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282062>

--001a1143637894f537052640c35b
Content-Type: text/plain; charset=UTF-8

My group has run into a bug with "git-subtree split". Under some
circumstances a split created from a descendant of another earlier
split is not a descendant of that earlier split (thus blocking
pushes). We originally noticed this on v1.9.1 but have also checked it
on v2.6.3

When scanning the commits to produce the subtree it seems to skip
creating a new commit if any of the parent commits have the same tree
and instead uses that tree in its place. This is fine when the cause
is a branch that did not cause any changes to the subtree.  However it
creates an issue when the cause is both branches ending up with the
same tree through identical alterations (or more likely, one of the
branches has just a subset of the alterations on the other, such as a
branch just containing cherry-picks).

The attached bash script (makerepo.sh) reproduces the problem. To use
create an empty directory and run the script in it. The resulting
'master' branch has had the latest commits on the 'branch' branch
merged into it, so it follows that a subtree on 'folder/' at 'master'
should contain all the commits of a subtree on 'folder/' at 'branch'.
(These subtrees have been produced at 'subtree_tip' and
'subtree_branch' respectively.)

The attached patch (against v2.6.3) fixes the issue for the cases
we've encountered, however since we're not particularly familiar with
git internals we may not have approached this optimally. We suspect it
could be improved to also handle the cases where there are more than 2
parents.

Cheers,
Dave Ware

--001a1143637894f537052640c35b
Content-Type: application/x-sh; name="makerepo.sh"
Content-Disposition: attachment; filename="makerepo.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ihuzp2w10

IyEvYmluL2Jhc2gKCmdpdCBpbml0CgojY3JlYXRlIG1lcmdlIHdoaWNoIGNhdXNlcyBwcm9ibGVt
IChpLmUuIGl0IHNob3VsZG4ndCBiZSBza2lwcGVkKQpta2RpciBmb2xkZXIKCmVjaG8gYSA+IGZv
bGRlci9hCmdpdCBhZGQgLgpnaXQgY29tbWl0IC1tICJmaXJzdCBjb21taXQiCgpnaXQgYnJhbmNo
IGJyYW5jaAoKZWNobyAwID4gZm9sZGVyLzAKZ2l0IGFkZCAuCmdpdCBjb21taXQgLW0gImFkZGlu
ZyAwIHRvIGZvbGRlciIKCmVjaG8gYiA+IGZvbGRlci9iCmdpdCBhZGQgLgpnaXQgY29tbWl0IC1t
ICJhZGRpbmcgYiB0byBmb2xkZXIiCmNoZXJyeT0kKGdpdCByZXYtbGlzdCBIRUFEIC0xKQoKZ2l0
IGNoZWNrb3V0IGJyYW5jaAplY2hvIHRleHQgPiB0ZXh0QnJhbmNoLnR4dApnaXQgYWRkIC4KZ2l0
IGNvbW1pdCAtbSAiY29tbWl0IHRvIGZpZGRsZSB3aXRoIGJyYW5jaDogYnJhbmNoIgoKZ2l0IGNo
ZXJyeS1waWNrICRjaGVycnkKZ2l0IGNoZWNrb3V0IG1hc3RlcgpnaXQgbWVyZ2UgLW0gIm1lcmdl
IiBicmFuY2gKCiNjcmVhdGUgY29uZGl0aW9uIHdoZXJlIG1lcmdlIHNob3VsZCBiZSBza2lwcGVk
CmdpdCBicmFuY2ggbm9vcF9icmFuY2gKCmVjaG8gZCA+IGZvbGRlci9kCmdpdCBhZGQgLgpnaXQg
Y29tbWl0IC1tICJhZGRpbmcgZCB0byBmb2xkZXIiCgpnaXQgY2hlY2tvdXQgbm9vcF9icmFuY2gK
ZWNobyBtb3JlVGV4dCA+IGFub3RoZXJUZXh0LnR4dApnaXQgYWRkIC4KZ2l0IGNvbW1pdCAtbSAi
aXJyZWxldmFudCIKCmdpdCBjaGVja291dCBtYXN0ZXIKZ2l0IG1lcmdlIC1tICJzZWNvbmQgbWVy
Z2UiIG5vb3BfYnJhbmNoCgoKZ2l0IHN1YnRyZWUgc3BsaXQgLS1wcmVmaXggZm9sZGVyLyAtLWJy
YW5jaCBzdWJ0cmVlX3RpcCBtYXN0ZXIKZ2l0IHN1YnRyZWUgc3BsaXQgLS1wcmVmaXggZm9sZGVy
LyAtLWJyYW5jaCBzdWJ0cmVlX2JyYW5jaCBicmFuY2gK
--001a1143637894f537052640c35b
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Fix-bug-in-git-subtree-split.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-bug-in-git-subtree-split.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ihuzprlr1

RnJvbSA0YmRjZDc0MmU1ZjIxZDdhZjU3ZGUzZTMwNzc0MWVmZWRlN2QyYzZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIFdhcmUgPGRhdmlkd0BuZXR2YWx1ZS5uZXQubno+CkRh
dGU6IEZyaSwgNCBEZWMgMjAxNSAxNjozMDowMyArMTMwMApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBi
dWcgaW4gZ2l0LXN1YnRyZWUgc3BsaXQuCgpBIGJ1ZyBvY2N1cnMgaW4gJ2dpdC1zdWJ0cmVlIHNw
bGl0JyB3aGVyZSBhIG1lcmdlIGlzIHNraXBwZWQgZXZlbiB3aGVuCmJvdGggcGFyZW50cyBhY3Qg
b24gdGhlIHN1YnRyZWUsIHByb3ZpZGVkIHRoZSBtZXJnZSByZXN1bHRzIGluIGEgdHJlZQppZGVu
dGljYWwgdG8gb25lIG9mIHRoZSBwYXJlbnRzLiBGaXhlZCBieSBjb3B5aW5nIHRoZSBtZXJnZSBp
ZiBhdCBsZWFzdApvbmUgcGFyZW50IGlzIG5vbi1pZGVudGljYWwsIGFuZCB0aGUgbm9uLWlkZW50
aWNhbCBwYXJlbnQgaXMgbm90IGFuCmFuY2VzdG9yIG9mIHRoZSBpZGVudGljYWwgcGFyZW50Lgot
LS0KIGNvbnRyaWIvc3VidHJlZS9naXQtc3VidHJlZS5zaCB8IDEyICsrKysrKysrKystLQogMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvY29udHJpYi9zdWJ0cmVlL2dpdC1zdWJ0cmVlLnNoIGIvY29udHJpYi9zdWJ0cmVlL2dpdC1z
dWJ0cmVlLnNoCmluZGV4IDlmMDY1NzEuLmI4Mzc1MzEgMTAwNzU1Ci0tLSBhL2NvbnRyaWIvc3Vi
dHJlZS9naXQtc3VidHJlZS5zaAorKysgYi9jb250cmliL3N1YnRyZWUvZ2l0LXN1YnRyZWUuc2gK
QEAgLTQ3OSw4ICs0NzksMTYgQEAgY29weV9vcl9za2lwKCkKIAkJCXA9IiRwIC1wICRwYXJlbnQi
CiAJCWZpCiAJZG9uZQotCQotCWlmIFsgLW4gIiRpZGVudGljYWwiIF07IHRoZW4KKworCWNvcHlj
b21taXQ9CisJaWYgWyAtbiAiJGlkZW50aWNhbCIgXSAmJiBbIC1uICIkbm9uaWRlbnRpY2FsIiBd
OyB0aGVuCisJCWV4dHJhcz0kKGdpdCByZXYtbGlzdCAtLWJvdW5kYXJ5ICRpZGVudGljYWwuLiRu
b25pZGVudGljYWwpCisJCWlmIFsgLW4gIiRleHRyYXMiIF07IHRoZW4KKwkJCSMgd2UgbmVlZCB0
byBwcmVzZXJ2ZSBoaXN0b3J5IGFsb25nIHRoZSBvdGhlciBicmFuY2gKKwkJCWNvcHljb21taXQ9
MQorCQlmaQorCWZpCisJaWYgWyAtbiAiJGlkZW50aWNhbCIgXSAmJiBbIC16ICIkY29weWNvbW1p
dCIgXTsgdGhlbgogCQllY2hvICRpZGVudGljYWwKIAllbHNlCiAJCWNvcHlfY29tbWl0ICRyZXYg
JHRyZWUgIiRwIiB8fCBleGl0ICQ/Ci0tIAoxLjkuMQoK
--001a1143637894f537052640c35b--

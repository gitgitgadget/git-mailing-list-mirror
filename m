From: "Holl, Marcus" <marcus.holl@sap.com>
Subject: [git-p4] import with labels fails when commit is not transferred
Date: Tue, 30 Jun 2015 08:45:23 +0000
Message-ID: <A24B2157A13A04409644C1456B5AE27F1CE4B663@DEWDFEMB19A.global.corp.sap>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24B2157A13A04409644C1456B5AE27F1CE4B663DEWDFEMB19Aglob_"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 30 10:45:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9rAe-0003n4-9e
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 10:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbbF3Ipb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 04:45:31 -0400
Received: from smtpgw03.sap-ag.de ([155.56.66.98]:34414 "EHLO smtpgw.sap-ag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbbF3IpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 04:45:25 -0400
Thread-Topic: [git-p4] import with labels fails when commit is not
 transferred
Thread-Index: AdCzERBBf8IrhzcNTC+BFpdRXBOafQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.21.40.91]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273034>

--_002_A24B2157A13A04409644C1456B5AE27F1CE4B663DEWDFEMB19Aglob_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I have an issue with the git p4 tooling regarding import of labels.

My git version is 2.4.5

I try to transform a perforce repository. My command line is:
git p4 clone --verbose --detect-branches --import-local --import-labels --d=
estination <DESTINATION> //depot@all


The relevant parts in the gitconfig is:
[git-p4]
                branchUser =3D <USERNAME>
               =20
               =20
For that user there is a branch mapping defined with a lot of entries like:
//depot/trunk/... //depot/branches/ipro-status-8-2--branch/...
//depot/trunk/... //depot/branches/9-0-preview/...
//depot/trunk/... //depot/branches/release-8-0-0-branch/...
//depot/trunk/... //depot/branches/release-8-1-0-branch/...
//depot/trunk/... //depot/branches/release-8-2-0-branch/...
//depot/trunk/... //depot/branches/release-8-3-0-branch/...
//depot/trunk/... //depot/branches/release-8-4-branch/...
//depot/trunk/... //depot/branches/release-8-5-branch/...
...


The import fails with the log output that can be found at the bottom of thi=
s mail.

git log -all -grep "\[git-p4:.*change\ =3D\ 69035\]" reports nothing. The c=
ommit is not contained in the git repository.

p4 describe for changelist 69035 returns a reasonable result. This change c=
ontains one file located at a path in the perforce folder structure that co=
mes without corresponding entry in the perforce branch mapping.=20

According to the given branch mapping it looks reasonable to me that the ch=
ange is omitted in the git repository. But in my opinion the import should =
not fail in such a case.

A reasonable behavior would be to blacklist the label (add it to git-p4.ign=
oredP4Labels) and to continue with the next label.

Attached is a proposal for a fix that needs to be carefully reviews since I=
'm not that experienced with python.

Other proposals for resolving this issue are highly appreciated.

Thanks a lot and best regards,
Marcus Holl


Log output:

Reading pipe: ['git', 'rev-list', '--max-count=3D1', '--reverse', ':/\\[git=
-p4:.*change =3D 69035\\]']
fatal: ambiguous argument ':/\[git-p4:.*change =3D 69035\]': unknown revisi=
on or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
ied with change: 69078, original Date: 2010-04-22T09:07:24.000000Z\n', 'Upd=
ate': '2013/11/02 07:40:31', 'Label': 'release-8-1-0-976', 'Access': '2015/=
06/26 14:50:15', 'Owner': 'svn_p4_converter', 'Options': 'unlocked noautore=
load'}
p4 label release-8-1-0-976 mapped to git commit 82a11809928b86a7bde03cf4864=
28de52ab3380f
writing tag release-9-0-0-179 for commit fb8370cd04806686c567ad720d065436f2=
334b4a
labelDetails=3D {'code': 'stat', 'Description': 'Created or modified with c=
hange: 96984, original Date: 2011-12-22T16:01:25.681427Z\n', 'Update': '201=
3/11/02 15:15:50', 'Label': 'release-9-0-0-179', 'Access': '2015/06/26 14:5=
0:16', 'Owner': 'build', 'Options': 'unlocked noautoreload'}
p4 label release-9-0-0-179 mapped to git commit fb8370cd04806686c567ad720d0=
65436f2334b4a
Traceback (most recent call last):
  File "/usr/lib/git/git-p4", line 3297, in <module>
    main()
  File "/usr/lib/git/git-p4", line 3291, in main
    if not cmd.run(args):
  File "/usr/lib/git/git-p4", line 3165, in run
    if not P4Sync.run(self, depotPaths):
  File "/usr/lib/git/git-p4", line 3045, in run
    self.importP4Labels(self.gitStream, missingP4Labels)
  File "/usr/lib/git/git-p4", line 2421, in importP4Labels
    "--reverse", ":/\[git-p4:.*change =3D %d\]" % changelist])
  File "/usr/lib/git/git-p4", line 138, in read_pipe
    die('Command failed: %s' % str(c))
  File "/usr/lib/git/git-p4", line 106, in die
    raise Exception(msg)
Exception: Command failed: ['git', 'rev-list', '--max-count=3D1', '--revers=
e', ':/\\[git-p4:.*change =3D 69035\\]']

--_002_A24B2157A13A04409644C1456B5AE27F1CE4B663DEWDFEMB19Aglob_
Content-Type: application/octet-stream;
	name="0001-git-p4-Do-not-fail-on-not-found-commit-when-importin.patch"
Content-Description: 0001-git-p4-Do-not-fail-on-not-found-commit-when-importin.patch
Content-Disposition: attachment;
	filename="0001-git-p4-Do-not-fail-on-not-found-commit-when-importin.patch";
	size=1552; creation-date="Tue, 30 Jun 2015 08:13:46 GMT";
	modification-date="Tue, 30 Jun 2015 08:13:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NzE0ZmIyMzg4NTI3ODk2M2RiMDlhYTNiN2E0MjZkYjFlYmQ1YmU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJjdXMgSG9sbCA8bWFyY3VzLmhvbGxAc2FwLmNvbT4KRGF0
ZTogVHVlLCAzMCBKdW4gMjAxNSAxMDoxMDoxMiArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIFtnaXQt
cDRdIERvIG5vdCBmYWlsIG9uIG5vdCBmb3VuZCBjb21taXQgd2hlbiBpbXBvcnRpbmcKIGxhYmVs
cwoKV2hlbiBhIGNvbW1pdCBpcyBub3QgdHJhbnNmZXJyZWQgZnJvbSBwZXJmb3JjZSB0byBnaXQg
c2luY2UgaXQgaXMgbG9jYXRlZAppbiB0aGUgcGVyZm9yY2UgZm9sZGVyIGxheW91dCBpbiBhIHBs
YWNlIHRoYXQgZG9lcyBub3QgbWF0Y2ggdGhlIGJyYW5jaGVzCmFjY29yZGluZyB0byBhIGdpdmVu
IGJyYW5jaCBtYXBwaW5nIHRoZSBpbXBvcnQgZmFpbHMuCldpdGggdGhpcyBjaGFuZ2UgdGhlIGNv
cnJlc3BvbmRpbmcgbGFiZWwgaXMgYWRkZWQgdG8gZ2l0LXA0Lmlnbm9yZWRQNExhYmVscwphbmQg
aXQgaXMgY29udGludWVkIHdpdGggdGhlIG5leHQgbGFiZWwuCi0tLQogZ2l0LXA0LnB5IHwgOCAr
KysrKystLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9naXQtcDQucHkgYi9naXQtcDQucHkKaW5kZXggNTQ5MDIyZS4uZjNjOGM2
ZiAxMDA3NTUKLS0tIGEvZ2l0LXA0LnB5CisrKyBiL2dpdC1wNC5weQpAQCAtMjQxNyw4ICsyNDE3
LDEyIEBAIGNsYXNzIFA0U3luYyhDb21tYW5kLCBQNFVzZXJNYXApOgogICAgICAgICAgICAgaWYg
Y2hhbmdlLmhhc19rZXkoJ2NoYW5nZScpOgogICAgICAgICAgICAgICAgICMgZmluZCB0aGUgY29y
cmVzcG9uZGluZyBnaXQgY29tbWl0OyB0YWtlIHRoZSBvbGRlc3QgY29tbWl0CiAgICAgICAgICAg
ICAgICAgY2hhbmdlbGlzdCA9IGludChjaGFuZ2VbJ2NoYW5nZSddKQotICAgICAgICAgICAgICAg
IGdpdENvbW1pdCA9IHJlYWRfcGlwZShbImdpdCIsICJyZXYtbGlzdCIsICItLW1heC1jb3VudD0x
IiwKLSAgICAgICAgICAgICAgICAgICAgICItLXJldmVyc2UiLCAiOi9cW2dpdC1wNDouKmNoYW5n
ZSA9ICVkXF0iICUgY2hhbmdlbGlzdF0pCisgICAgICAgICAgICAgICAgZ2l0Q29tbWl0ID0gIiIK
KyAgICAgICAgICAgICAgICB0cnk6CisgICAgICAgICAgICAgICAgICAgIGdpdENvbW1pdCA9IHJl
YWRfcGlwZShbImdpdCIsICJyZXYtbGlzdCIsICItLW1heC1jb3VudD0xIiwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAiLS1yZXZlcnNlIiwgIjovXFtnaXQtcDQ6LipjaGFuZ2UgPSAlZFxdIiAl
IGNoYW5nZWxpc3RdKQorICAgICAgICAgICAgICAgIGV4Y2VwdDoKKyAgICAgICAgICAgICAgICAg
ICAgcGFzcwogICAgICAgICAgICAgICAgIGlmIGxlbihnaXRDb21taXQpID09IDA6CiAgICAgICAg
ICAgICAgICAgICAgIHByaW50ICJjb3VsZCBub3QgZmluZCBnaXQgY29tbWl0IGZvciBjaGFuZ2Vs
aXN0ICVkIiAlIGNoYW5nZWxpc3QKICAgICAgICAgICAgICAgICBlbHNlOgotLSAKMS45LjMgKEFw
cGxlIEdpdC01MCkKCg==

--_002_A24B2157A13A04409644C1456B5AE27F1CE4B663DEWDFEMB19Aglob_--

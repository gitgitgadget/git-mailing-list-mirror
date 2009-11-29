From: Alex Vandiver <alex@chmrr.net>
Subject: git-svn: SVK merge commits can have >2 parents
Date: Sun, 29 Nov 2009 02:28:39 -0500
Message-ID: <1259479636-sup-573@utwig>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1259479719-289075-30157-6363-1-="
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 08:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEeaO-000621-W1
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 08:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbZK2Hwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 02:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbZK2Hwd
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 02:52:33 -0500
Received: from chmrr.net ([209.67.253.66]:41305 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbZK2Hwc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 02:52:32 -0500
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NEeD1-0007s7-9r; Sun, 29 Nov 2009 02:28:39 -0500
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134001>


--=-1259479719-289075-30157-6363-1-=
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

  Heya,

While converting a mildly complicated svn repository that was managed
with SVK, I ran across the following oddness.  `svk smerge` can only
merge between _two_ branches at once -- however, the way that svk
merge detection works, you can end up with erroneous extra parents
from long-dead branches.  Case in point:

    export SVKROOT=/tmp/svk-testing-$$
    svk mkdir //trunk -m 'trunk'
    svk mkdir //branches -m 'branches'
    svk co //trunk
    svk cp //trunk/ //branches/feature1 -m 'branch for feature1'
    svk cp //trunk/ //branches/feature2 -m 'branch for feature2'
    svk co //branches/feature1
    cd feature1
    echo "foo" >foo
    svk add foo
    svk ci -m 'feature1 development'
    svk sm //branches/feature1 //trunk -m 'merge feature1 to trunk'
    cd ..
    svk co //branches/feature2
    cd feature2
    echo "bar" >bar
    svk add bar
    svk ci -m 'feature2 development'
    svk sm //trunk //branches/feature2 -m 'merge from trunk'
    cd ..

    git svn clone -s file://$SVKROOT/local

The 'feature2' branch will appear to have three parents: r7, r6, _and_
r5.  The r5 parent is extraneous, and only appears because r5 was
previously merged into trunk, as part of r6.

Given this, I'm a little confused why find_extra_svk_parents is
written the way that it is, in seemingly allowing multiple extra
parents to be found.  Since the most recent (i.e., highest-numbered)
change is by definition the only one that can account for all of the
other svk:merge changes, I _believe_ the attached diff to be correct,
but I'm unsure because of the implicit current assumption that smerges
can produce multiple parents.

 - Alex
-- 
Networking -- only one letter away from not working

--=-1259479719-289075-30157-6363-1-=
Content-Disposition: attachment; filename="0001-git-svn-svk-merge-commits-should-only-add-one-exta-p.patch"
Content-Type: application/octet-stream; name="0001-git-svn-svk-merge-commits-should-only-add-one-exta-p.patch"
Content-Transfer-Encoding: base64

RnJvbSBiODZiNGJiMGNlY2I3MGQ4Mjg1NThiMDQ2YWEwYjNlN2I4OTliZjQx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFZhbmRpdmVy
IDxhbGV4QGNobXJyLm5ldD4KRGF0ZTogU3VuLCAyOSBOb3YgMjAwOSAwMjoy
MDoyMSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIGdpdC1zdm46IHN2ayBtZXJn
ZSBjb21taXRzIHNob3VsZCBvbmx5IGFkZCBvbmUgZXh0YSBwYXJlbnQKCldo
ZW4gbWVyZ2luZyBicmFuY2hlcyBiYXNlZCBvbiBzdms6bWVyZ2UgcHJvcGVy
dGllcywgYSBzaW5nbGUgbWVyZ2UKY2FuIGhhdmUgdXBkYXRlZCBvciBhZGRl
ZCBtdWx0aXBsZSBzdms6bWVyZ2UgbGluZXMuICBJZiBzby4gb25seQppbmNs
dWRlIHRoZSBtaW5pbWFsIHNldCBvZiBuZXcgcGFyZW50cy4KClNpZ25lZC1v
ZmYtYnk6IEFsZXggVmFuZGl2ZXIgPGFsZXhAY2htcnIubmV0PgotLS0KIGdp
dC1zdm4ucGVybCB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dp
dC1zdm4ucGVybCBiL2dpdC1zdm4ucGVybAppbmRleCA5NTdkNDRlLi42Njhl
NTBjIDEwMDc1NQotLS0gYS9naXQtc3ZuLnBlcmwKKysrIGIvZ2l0LXN2bi5w
ZXJsCkBAIC0yOTQwLDEwICsyOTQwLDEyIEBAIHN1YiBmaW5kX2V4dHJhX3N2
a19wYXJlbnRzIHsKIAkJCWlmICggbXkgJGNvbW1pdCA9ICRncy0+cmV2X21h
cF9nZXQoJHJldiwgJHV1aWQpICkgewogCQkJCSMgd2FoZXkhICB3ZSBmb3Vu
ZCBpdCwgYnV0IGl0IG1pZ2h0IGJlCiAJCQkJIyBhbiBvbGQgb25lICghKQot
CQkJCXB1c2ggQGtub3duX3BhcmVudHMsICRjb21taXQ7CisJCQkJcHVzaCBA
a25vd25fcGFyZW50cywgWyAkcmV2LCAkY29tbWl0IF07CiAJCQl9CiAJCX0K
IAl9CisJIyBXZSBvbmx5IGNhcmUgYWJvdXQgdGhlIGhpZ2hlc3QtbnVtYmVy
ZWQgYXBwbGljYWJsZSBjb21taXQKKwlAa25vd25fcGFyZW50cyA9IG1hcCB7
JF8tPlsxXX0gc29ydCB7JGItPlswXSA8PT4gJGEtPlswXX0gQGtub3duX3Bh
cmVudHM7CiAJZm9yIG15ICRwYXJlbnQgKCBAa25vd25fcGFyZW50cyApIHsK
IAkJbXkgQGNtZCA9ICgncmV2LWxpc3QnLCAkcGFyZW50LCBtYXAgeyAiXiRf
IiB9IEAkcGFyZW50cyApOwogCQlteSAoJG1zZ19maCwgJGN0eCkgPSBjb21t
YW5kX291dHB1dF9waXBlKEBjbWQpOwpAQCAtMjk1Niw2ICsyOTU4LDcgQEAg
c3ViIGZpbmRfZXh0cmFfc3ZrX3BhcmVudHMgewogCQkJcHJpbnQgU1RERVJS
CiAJCQkgICAgIkZvdW5kIG1lcmdlIHBhcmVudCAoc3ZrOm1lcmdlIHRpY2tl
dCk6ICRwYXJlbnRcbiI7CiAJCQlwdXNoIEAkcGFyZW50cywgJHBhcmVudDsK
KwkJCXJldHVybjsKIAkJfQogCX0KIH0KLS0gCjEuNi42LnJjMC4yNTQuZzcz
NTJkCgo=

--=-1259479719-289075-30157-6363-1-=--

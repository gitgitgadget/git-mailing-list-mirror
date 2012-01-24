From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding all commits which modify a file
Date: Tue, 24 Jan 2012 01:58:36 +0100
Message-ID: <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
 <4F1B4764.3010501@gmail.com> <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec54696a1dcb33204b73ba6a8
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 01:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpUj0-0004Q3-No
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 01:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439Ab2AXA66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 19:58:58 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53479 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2AXA65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 19:58:57 -0500
Received: by pbaa10 with SMTP id a10so1937435pba.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 16:58:57 -0800 (PST)
Received: by 10.68.74.68 with SMTP id r4mr26218527pbv.102.1327366737277; Mon,
 23 Jan 2012 16:58:57 -0800 (PST)
Received: by 10.68.56.164 with HTTP; Mon, 23 Jan 2012 16:58:36 -0800 (PST)
In-Reply-To: <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
X-Gm-Message-State: ALoCoQmxPUpvLQv7/GuwZbIoO13HF0OhBlqqsiWTFt5IZpzy2PnOZFgcaX7W6Fxvqal8O9Y22rp9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189031>

--bcaec54696a1dcb33204b73ba6a8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Note: CC main authors of the code surrounding the patch]

On Mon, Jan 23, 2012 at 5:14 PM, Neal Groothuis <ngroot@lo-cal.org> wrote:
>> On 1/20/2012 3:35 PM, Neal Groothuis wrote:
>>> I'm trying to find /all/ commits that change a file in the
>>> repository...and its proving to be trickier than I thought. :-)
>
> On 1/21/2012 6:16 PM, Neal Kreitzinger wrote:
>> Does git-log --all help?
>
> I don't see how it would. =A0The commits are all reachable from HEAD, whi=
ch
> would seem to be the problem that --all would correct.
>
> What I'm trying to do is find the commits in which a file differs from
> that same file in any of its parents.

If you add parent rewriting (--parent, --graph or see it in gitk, with
--full-history) you'll get your B2 commit as it adds commits to have a
meaningful history. But I don't think this is what you are asking for.

  You could try the following patch (sorry for the whitespace damage,
also attatched):

Subject: [PATCH/RFC] revision: merging branches with different content
is interesting in --full-history

---
 revision.c                                 |    2 +-
 t/t6016-rev-list-graph-simplify-history.sh |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 064e351..db97250 100644
--- a/revision.c
+++ b/revision.c
@@ -492,7 +492,7 @@ static void try_to_simplify_commit(struct rev_info
*revs, struct commit *commit)
                }
                die("bad tree compare for commit %s",
sha1_to_hex(commit->object.sha1));
        }
-       if (tree_changed && !tree_same)
+       if ((tree_changed && !tree_same) || (!revs->simplify_history
&& tree_changed))
                return;
        commit->object.flags |=3D TREESAME;
 }
diff --git a/t/t6016-rev-list-graph-simplify-history.sh
b/t/t6016-rev-list-graph-simplify-history.sh
index f7181d1..50ffcf4 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -168,6 +168,7 @@ test_expect_success '--graph --full-history
--simplify-merges -- bar.txt' '
        echo "|\\  " >> expected &&
        echo "| * $C4" >> expected &&
        echo "* | $A5" >> expected &&
+       echo "* | $A4" >> expected &&
        echo "* | $A3" >> expected &&
        echo "|/  " >> expected &&
        echo "* $A2" >> expected &&

(I could rewrite the condition but I think it is cleaner).

This patch changes the semantics of --full-history to consider all
commits with at least one modified parent as an interesting commit
(even for merges). This is almost as enabling --parent:

git $ git rev-list --full-history HEAD Makefile | wc -l
1769

$ git rev-list --full-history --parents HEAD Makefile | wc -l
6732

git $ ./git rev-list --full-history HEAD Makefile | wc -l
6052

I think that --full-history should list these extra merges as you are
asking for the full history and a merge merging two branches with
different content is an interesting event in this case (full history).
But maybe we should just add an extra flag...

HTH,
Santi

--bcaec54696a1dcb33204b73ba6a8
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-revision-merging-branches-with-different-content-is-.patch"
Content-Disposition: attachment; 
	filename="0001-revision-merging-branches-with-different-content-is-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxs7t7ok1

RnJvbSAzNmEwOWYxYTM5MjEyZWI0YjQ1MjY4MjE1Y2M5YzMzNmE3YWZlYmRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/U2FudGk9MjBCPUMzPUE5amFyPz0gPHNhbnRp
QGFnb2xpbmEubmV0PgpEYXRlOiBUdWUsIDI0IEphbiAyMDEyIDAwOjQ2OjIzICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gcmV2aXNpb246IG1lcmdpbmcgYnJhbmNoZXMgd2l0aCBkaWZmZXJlbnQgY29u
dGVudCBpcyBpbnRlcmVzdGluZyBpbiAtLWZ1bGwtaGlzdG9yeQoKLS0tCiByZXZpc2lvbi5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICstCiB0L3Q2MDE2LXJldi1saXN0
LWdyYXBoLXNpbXBsaWZ5LWhpc3Rvcnkuc2ggfCAgICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3JldmlzaW9uLmMgYi9y
ZXZpc2lvbi5jCmluZGV4IDA2NGUzNTEuLmRiOTcyNTAgMTAwNjQ0Ci0tLSBhL3JldmlzaW9uLmMK
KysrIGIvcmV2aXNpb24uYwpAQCAtNDkyLDcgKzQ5Miw3IEBAIHN0YXRpYyB2b2lkIHRyeV90b19z
aW1wbGlmeV9jb21taXQoc3RydWN0IHJldl9pbmZvICpyZXZzLCBzdHJ1Y3QgY29tbWl0ICpjb21t
aXQpCiAJCX0KIAkJZGllKCJiYWQgdHJlZSBjb21wYXJlIGZvciBjb21taXQgJXMiLCBzaGExX3Rv
X2hleChjb21taXQtPm9iamVjdC5zaGExKSk7CiAJfQotCWlmICh0cmVlX2NoYW5nZWQgJiYgIXRy
ZWVfc2FtZSkKKwlpZiAoKHRyZWVfY2hhbmdlZCAmJiAhdHJlZV9zYW1lKSB8fCAoIXJldnMtPnNp
bXBsaWZ5X2hpc3RvcnkgJiYgdHJlZV9jaGFuZ2VkKSkKIAkJcmV0dXJuOwogCWNvbW1pdC0+b2Jq
ZWN0LmZsYWdzIHw9IFRSRUVTQU1FOwogfQpkaWZmIC0tZ2l0IGEvdC90NjAxNi1yZXYtbGlzdC1n
cmFwaC1zaW1wbGlmeS1oaXN0b3J5LnNoIGIvdC90NjAxNi1yZXYtbGlzdC1ncmFwaC1zaW1wbGlm
eS1oaXN0b3J5LnNoCmluZGV4IGY3MTgxZDEuLjUwZmZjZjQgMTAwNzU1Ci0tLSBhL3QvdDYwMTYt
cmV2LWxpc3QtZ3JhcGgtc2ltcGxpZnktaGlzdG9yeS5zaAorKysgYi90L3Q2MDE2LXJldi1saXN0
LWdyYXBoLXNpbXBsaWZ5LWhpc3Rvcnkuc2gKQEAgLTE2OCw2ICsxNjgsNyBAQCB0ZXN0X2V4cGVj
dF9zdWNjZXNzICctLWdyYXBoIC0tZnVsbC1oaXN0b3J5IC0tc2ltcGxpZnktbWVyZ2VzIC0tIGJh
ci50eHQnICcKIAllY2hvICJ8XFwgICIgPj4gZXhwZWN0ZWQgJiYKIAllY2hvICJ8ICogJEM0IiA+
PiBleHBlY3RlZCAmJgogCWVjaG8gIiogfCAkQTUiID4+IGV4cGVjdGVkICYmCisJZWNobyAiKiB8
ICRBNCIgPj4gZXhwZWN0ZWQgJiYKIAllY2hvICIqIHwgJEEzIiA+PiBleHBlY3RlZCAmJgogCWVj
aG8gInwvICAiID4+IGV4cGVjdGVkICYmCiAJZWNobyAiKiAkQTIiID4+IGV4cGVjdGVkICYmCi0t
IAoxLjcuNC5yYzMuOC5nZDJkNAoK
--bcaec54696a1dcb33204b73ba6a8--

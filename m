From: Jeff King <peff@peff.net>
Subject: Re: git apply --directory broken for new files
Date: Fri, 26 Sep 2008 21:54:22 -0400
Message-ID: <20080927015422.GA31783@coredump.intra.peff.net>
References: <48DBF794.9030809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 03:58:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjP4x-0005YI-Na
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 03:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbYI0By0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 21:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbYI0ByZ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 21:54:25 -0400
Received: from peff.net ([208.65.91.99]:4904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbYI0ByZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 21:54:25 -0400
Received: (qmail 9371 invoked by uid 111); 27 Sep 2008 01:54:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Sep 2008 21:54:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Sep 2008 21:54:22 -0400
Content-Disposition: inline
In-Reply-To: <48DBF794.9030809@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96896>

On Thu, Sep 25, 2008 at 01:41:56PM -0700, H. Peter Anvin wrote:

> Trying with git 1.6.0.1:
>
> : tazenda 124 ; git apply --directory=gpxe/ < /tmp/diff
> fatal: git-apply: bad git-diff - inconsistent new filename on line 105

Hmm. It looks like this is broken for deletion, too. I believe the
problem is just that when sanity checking "diff --git" patches, we
weren't applying the --directory root consistently.

I think this fix is sane, but I would appreciate ACKs from Dscho and
Junio, who wrote the --directory code and the patch sanity checking
code, respectively.

-- >8 --
apply --directory: handle creation and deletion patches

We carefully verify that the input to git-apply is sane,
including cross-checking that the filenames we see in "+++"
headers match what was provided on the command line of "diff
--git". When --directory is used, however, we ended up
comparing the unadorned name to one with the prepended root,
causing us to complain about a mismatch.

We simply need to prepend the root directory, if any, when
pulling the name out of the git header.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-apply.c       |    7 +++++++
 t/t4128-apply-root.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2ab4aba..f9070d5 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -787,6 +787,13 @@ static char *git_header_name(char *line, int llen)
 					break;
 			}
 			if (second[len] == '\n' && !memcmp(name, second, len)) {
+				if (root) {
+					char *ret = xmalloc(root_len + len + 1);
+					strcpy(ret, root);
+					memcpy(ret + root_len, name, len);
+					ret[root_len + len] = '\0';
+					return ret;
+				}
 				return xmemdupz(name, len);
 			}
 		}
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index 2dd0c75..bd1bdf1 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -40,4 +40,39 @@ test_expect_success 'apply --directory -p (2) ' '
 
 '
 
+cat > patch << EOF
+diff --git a/newfile b/newfile
+new file mode 100644
+index 0000000..d95f3ad
+--- /dev/null
++++ b/newfile
+@@ -0,0 +1 @@
++content
+EOF
+
+test_expect_success 'apply --directory (new file)' '
+	git reset --hard initial &&
+	git apply --directory=some/sub/dir/ --index patch &&
+	test content = $(git show :some/sub/dir/newfile) &&
+	test content = $(cat some/sub/dir/newfile)
+'
+
+cat > patch << EOF
+diff --git a/delfile b/delfile
+deleted file mode 100644
+index d95f3ad..0000000
+--- a/delfile
++++ /dev/null
+@@ -1 +0,0 @@
+-content
+EOF
+
+test_expect_success 'apply --directory (delete file)' '
+	git reset --hard initial &&
+	echo content >some/sub/dir/delfile &&
+	git add some/sub/dir/delfile &&
+	git apply --directory=some/sub/dir/ --index patch &&
+	! git ls-files | grep delfile
+'
+
 test_done
-- 
1.6.0.2.517.g8be702.dirty

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fast-export: deal with tag objects that do not have a
 tagger
Date: Thu, 18 Dec 2008 20:45:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302>
References: <20081218164614.GS5691@genesis.frugalware.org> <7vbpv9guqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	scott@canonical.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:47:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDOq5-0006mf-0h
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbYLRTpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbYLRTps
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:45:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:57205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751950AbYLRTps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:45:48 -0500
Received: (qmail invoked by alias); 18 Dec 2008 19:45:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 18 Dec 2008 20:45:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/8/RkHFa/B66C3tmfTi7NrbcgcQiS6u2U7L9tT4
	ebH8W7EbcaUHNF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vbpv9guqd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103484>


When no tagger was found (old Git produced tags like this), a
tagger "No Tagger <no-tagger>" with a tag date of the beginning of
(Unix) time is output, so that fast-import is
still able to import the result.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 18 Dec 2008, Junio C Hamano wrote:

	> Miklos Vajna <vmiklos@frugalware.org> writes:
	> 
	> > Tags created with ancient versions of git have no tagger. The 
	> > udev repo has such tags, for example:
	> >
	> > $ git cat-file tag 4ea98ca6db3b84f5bc16eac8574e5c209ec823ce
	> > object face198a5f21027fefe796dc01e19e349a2d36ce
	> > type commit
	> > tag 062
	> >
	> > fast-export will fail on these repos. From IRC:
	> 
	> Is "fast-export" the only thing that chokes on these tags?

	I think so.  The responsible code is in fast-export.c, in any 
	case.  Of course, fast-import refuses to import a tag without a 
	tagger, so...

 builtin-fast-export.c  |   12 ++++++++----
 t/t9301-fast-export.sh |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 7d5d57a..0af4e6f 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -297,10 +297,14 @@ static void handle_tag(const char *name, struct tag *tag)
 		message_size = strlen(message);
 	}
 	tagger = memmem(buf, message ? message - buf : size, "\ntagger ", 8);
-	if (!tagger)
-		die ("No tagger for tag %s", sha1_to_hex(tag->object.sha1));
-	tagger++;
-	tagger_end = strchrnul(tagger, '\n');
+	if (!tagger) {
+		warning ("No tagger for tag %s", sha1_to_hex(tag->object.sha1));
+		tagger = "tagger No Tagger <no-tagger> 0 +0000";
+		tagger_end = tagger + strlen(tagger);
+	} else {
+		tagger++;
+		tagger_end = strchrnul(tagger, '\n');
+	}
 
 	/* handle signed tags */
 	if (message) {
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 2057435..2312d7a 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -239,4 +239,19 @@ test_expect_success 'fast-export | fast-import when master is tagged' '
 
 '
 
+cat > tag-content << EOF
+object $(git rev-parse HEAD)
+type commit
+tag rosten
+EOF
+
+test_expect_success 'cope with tagger-less tags' '
+
+	TAG=$(git hash-object -t tag -w tag-content) &&
+	git update-ref refs/tags/sonnenschein $TAG &&
+	git fast-export -C -C --signed-tags=strip --all > output &&
+	test $(grep -c "^tag " output) = 4
+
+'
+
 test_done
-- 
1.6.1.rc3.368.g63acc

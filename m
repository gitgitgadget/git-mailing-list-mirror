From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH v3] Support "\" in non-wildcard exclusion entries
Date: Thu, 12 Feb 2009 10:32:50 +0100
Message-ID: <20090212093250.GA9623@pvv.org>
References: <20090210121149.GA1226@pvv.org> <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de> <20090210125800.GA14800@pvv.org> <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de> <20090210142017.GA16478@pvv.org> <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de> <20090210143742.GB16478@pvv.org> <7vab8upb5v.fsf@gitster.siamese.dyndns.org> <7v7i3ynt1z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 10:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXXxg-0006pp-Bg
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 10:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbZBLJcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 04:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbZBLJcz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 04:32:55 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:57914 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbZBLJcy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 04:32:54 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LXXwA-0005QC-67; Thu, 12 Feb 2009 10:32:50 +0100
Content-Disposition: inline
In-Reply-To: <7v7i3ynt1z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109591>

On Tue, Feb 10, 2009 at 08:41:12AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> Oh, by the way, do we really want to add a new test script?  I am
> wondering why the test is not an update to an existing test for the
> exclusion feature, such as t/t3001-ls-files-others-exclude.sh

Ok, here is the final version with your suggested test-modification,
which seems to to the trick!

- Finn Arne

--8<--
Support "\" in non-wildcard exclusion entries

"\" was treated differently in exclude rules depending on whether a
wildcard match was done. For wildcard rules, "\" was de-escaped in
fnmatch, but this was not done for other rules since they used strcmp
instead.  A file named "#foo" would not be excluded by "\#foo", but would
be excluded by "\#foo*".

We now treat all rules with "\" as wildcard rules.

Another solution could be to de-escape all non-wildcard rules as we
read them, but we would have to do the de-escaping exactly as fnmatch
does it to avoid inconsistencies.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 dir.c                              |    2 +-
 t/t3001-ls-files-others-exclude.sh |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index cfd1ea5..2245749 100644
--- a/dir.c
+++ b/dir.c
@@ -137,7 +137,7 @@ int match_pathspec(const char **pathspec, const char *name, int namelen,
 
 static int no_wildcard(const char *string)
 {
-	return string[strcspn(string, "*?[{")] == '\0';
+	return string[strcspn(string, "*?[{\\")] == '\0';
 }
 
 void add_exclude(const char *string, const char *base,
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 85aef12..9be9557 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -19,6 +19,9 @@ do
     >$dir/a.$i
   done
 done
+>"#ignore1"
+>"#ignore2"
+>"#hidden"
 
 cat >expect <<EOF
 a.2
@@ -42,6 +45,9 @@ three/a.8
 EOF
 
 echo '.gitignore
+\#ignore1
+\#ignore2*
+\#hid*n
 output
 expect
 .gitignore
@@ -82,6 +88,7 @@ test_expect_success \
 cat > excludes-file << EOF
 *.[1-8]
 e*
+\#*
 EOF
 
 git config core.excludesFile excludes-file
-- 
1.6.2.rc0.11.g665ed

From: Robert Ewald <robert.ewald@nov.com>
Subject: [PATCH] git-svn: Translate invalid characters in refname
Date: Fri, 27 Jul 2007 16:40:07 +0200
Organization: Nobody is responsible but me
Message-ID: <f8d04a$gvf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 16:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEQzk-0005HD-BL
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 16:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937231AbXG0Okh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 10:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937219AbXG0Okf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 10:40:35 -0400
Received: from main.gmane.org ([80.91.229.2]:33205 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936484AbXG0Okc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 10:40:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEQzM-0000mx-OY
	for git@vger.kernel.org; Fri, 27 Jul 2007 16:40:20 +0200
Received: from static-213.88.188.4.addr.tdcsong.se ([213.88.188.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 16:40:20 +0200
Received: from robert.ewald by static-213.88.188.4.addr.tdcsong.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 16:40:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: static-213.88.188.4.addr.tdcsong.se
User-Agent: KNode/0.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53929>

Hello,

My first patch, please be gentle.

This is a first attempt to get the escaping behavior into git-svn.
I hope I have not screwed up too badly since this I have been looking
at Perl for more or less the first time.

So I would appreciate if any mistakes would be pointed out to me.

The patch works for me during clone, fetch and dcommit. I haven't
tried anything else yet.

Robert

PS: There is a testing script I have used. I suppose it should be put into
the testing infrastructure, something I am not yet familiar with. If
someone is interested I can send it as is.

---

In git some characters are invalid as documented
in git-check-ref-format. In subversion these characters might
be valid, so a translation is required.

This patch does this translation by url escaping characters, that
are not allowed.

Credit for ideas and code snippets goes to Eric Wong, martin f. krafft and
Jan Hudec

Signed-off-by: Robert Ewald <robewald@gmx.net>
---
 git-svn.perl |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6c692a7..68e62ab 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -938,8 +938,8 @@ sub resolve_local_globs {
        foreach (command(qw#for-each-ref --format=%(refname) refs/remotes#)) {
                next unless m#^refs/remotes/$ref->{regex}$#;
                my $p = $1;
-               my $pathname = $path->full_path($p);
-               my $refname = $ref->full_path($p);
+               my $pathname = desanitize_refname($path->full_path($p));
+               my $refname = desanitize_refname($ref->full_path($p));
                if (my $existing = $fetch->{$pathname}) {
                        if ($existing ne $refname) {
                                die "Refspec conflict:\n",
@@ -1239,7 +1239,44 @@ sub new {
        $self;
 }
 
-sub refname { "refs/remotes/$_[0]->{ref_id}" }
+sub refname { 
+        my ($refname) = "refs/remotes/$_[0]->{ref_id}" ;
+
+        # It cannot end with a slash /, we'll throw up on this because
+        # SVN can't have directories with a slash in their name, either:
+        if ($refname =~ m{/$}) {
+                die "ref: '$refname' ends with a trailing slash, this is ",
+                    "not permitted by git nor Subversion\n";
+        }
+
+        # It cannot have ASCII control character space, tilde ~, caret ^,
+        # colon :, question-mark ?, asterisk *, space, or open bracket[
anywhere
+       #
+        # Additionally, % must be escaped because it is used for escaping
+        # and we want our escaped refname to be reversible
+        $refname =~ s{([ \%~\^:\?\*\[\t])}{uc sprintf('%%%02x',ord($1))}eg;
+
+        # no slash-separated component can begin with a dot .
+        # /.* becomes /%2E*
+        $refname =~ s{/\.}{/%2E}g;
+        # It cannot have two consecutive dots .. anywhere
+        # .. becomes %2E%2E
+        $refname =~ s{\.\.}{%2E%2E}g;
+
+        $refname;
+}
+
+sub desanitize_refname {
+    my ($refname) = @_;
+
+    print "bob: desanitized from $refname ";
+
+    $refname =~ s{%(?:([0-9A-F]{2}))}{chr hex($1)}eg;
+
+    print " to $refname \n";
+
+    $refname;
+}
 
 sub svm_uuid {
        my ($self) = @_;
-- 
1.5.3.rc3-dirty

-- 
Robert Ewald

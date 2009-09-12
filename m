From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH v3] gitweb: check given hash before trying to create snapshot
Date: Sat, 12 Sep 2009 12:32:53 -0400
Message-ID: <4AABCD35.9020506@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 18:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmVYL-0005gt-9r
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 18:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbZILQdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 12:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbZILQdA
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 12:33:00 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:60848 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752750AbZILQc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 12:32:59 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8CGWrrQ013346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Sep 2009 12:32:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: a2fb6d92-55b7-4903-9d8a-4517791aa431
X-Miltered: at mailchk-m05 with ID 4AABCD35.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Sat, 12 Sep 2009 12:33:00 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128271>

> [This mail was very strangely wrapped; I fixed this for readability]
Yeah, sorry, format=flowed

> In first test you check that _contents_ contain specific error message,
> but you do not check if HTTP status code matches it (it should, because
> of how die_error works).  In second test you check HTTP status.  If the
> t/t9501-gitweb-standalone-http-status.sh is to be about status, I guess
> that you should check HTTP status, and not contents of the page (which
> is more likely to change, e.g. due to some prettifying).
> 
> In t9501 tests you need, I think, only the HTTP headers part, unless
> you want also to check that the contents matches.  There was some sed
> script shown to extract only HTTP headers.

Yes, t9501 also checks for the specific error message, this was originally
how it had to be done in order to show what trap was being executed for
that first block of checks in the snapshot routine. The header does not
contain the specific error string that gitweb outputs though, only the
standard message (i.e. 404 Not Found), so I check the script output for
negative test cases.


>> Also, right now gitweb will not accept tags for hashes. This seems to be
>> because it passes the --verify option to rev-parse, but the output  
>> from using and not using the verify option seems to be the same (other
>> than also accepting all tree-ishes). Could you let me know if there is
>> a good reason not to take off the --verify option? Otherwise, I would
>> like to take it off in the next version of this patch.
>
> Errr, what?
>
>  $ 5096:[gitweb/web@git]# git rev-parse --verify v1.5.0            
>  6db027ffe03210324939b3dd655c4223ca023b45
>  $ git rev-parse --verify refs/tags/v1.5.0
>  6db027ffe03210324939b3dd655c4223ca023b45
>
> So it works as intended.  The problem must be in some other place.

Let's just say the problem is not in the computer. :(


--
Mark Rada (ferrous26)
marada@uwaterloo.ca


--->8---
Makes things nicer in cases when you hand craft the snapshot URL but
make a typo in defining the hash variable (e.g. netx instead of next);
you will now get an error message instead of a broken tarball.

To maintain backwards compatibility, git_get_head_hash is now a wrapper
for git_get_full_hash, as suggested by Jakub Narebski.

Tests for t9501 are included to demonstrate changed functionality.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl                       |   13 ++++++++++---
 t/t9501-gitweb-standalone-http-status.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..e9cac8d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1983,11 +1983,17 @@ sub quote_command {
 
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
+	return git_get_full_hash(shift, 'HEAD');
+}
+
+# given a project and tree-ish, returns full hash
+sub git_get_full_hash {
 	my $project = shift;
+	my $hash = shift;
 	my $o_git_dir = $git_dir;
 	my $retval = undef;
 	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
+	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', $hash) {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
@@ -5196,8 +5202,9 @@ sub git_snapshot {
 		die_error(403, "Unsupported snapshot format");
 	}
 
-	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
+	my $snapshot = git_get_full_hash($project, $hash);
+	if (!$snapshot) {
+		die_error(404, 'Hash id was not valid');
 	}
 
 	my $name = $project;
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index d0ff21d..632007e 100644
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -75,4 +75,33 @@ test_expect_success \
 test_debug 'cat gitweb.output'
 
 
+# ----------------------------------------------------------------------
+# snapshot hash ids
+
+test_expect_success \
+	'snapshots: good treeish id' \
+	'gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: bad treeish id' \
+	'gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
+	grep "404 - Hash id was not valid" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: good object id' \
+	'ID=`git rev-parse --verify HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: bad object id' \
+	'gitweb_run "p=.git;a=snapshot;h=abcdef01234;sf=tgz" &&
+	grep "404 - Hash id was not valid" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
 test_done
-- 
1.6.4.2

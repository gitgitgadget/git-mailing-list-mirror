From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: gitweb / cg-export
Date: Wed, 16 Aug 2006 16:23:05 +0530
Message-ID: <44E2F911.6060002@gmail.com>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060500090202050606090300"
X-From: git-owner@vger.kernel.org Wed Aug 16 12:53:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDJ1j-0001P9-At
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 12:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWHPKxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 06:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHPKxX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 06:53:23 -0400
Received: from main.gmane.org ([80.91.229.2]:40837 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751104AbWHPKxX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 06:53:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDJ1M-0001Kr-3V
	for git@vger.kernel.org; Wed, 16 Aug 2006 12:53:12 +0200
Received: from palrel2.hp.com ([156.153.255.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 12:53:12 +0200
Received: from aneesh.kumar by palrel2.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 12:53:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: palrel2.hp.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <ebupuk$dgl$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25512>

This is a multi-part message in MIME format.
--------------060500090202050606090300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jakub Narebski wrote:
> Toby White wrote:
> 
>> I was wondering if a feature like the following would be of
>> use to anyone except me: I'd like to be able to download
>> the full source of a given tree from gitweb.
> [...]
> So you want to have snapshot of a tree. Why not snapshot of a commit, 
> or of a tag?
> 
>> I've quickly hacked gitweb to do this for me - patch below.
>>
>> It adds an extra link to the 'commit' page. Next to the link
>> that would lead you to 'tree', there is 'tar.gz' which simply
>> returns the tar.gz of the same tree.
>>
>> The patch is against the version of gitweb currently in
>> Debian, which is, erm, '264-1', apparently, because that's
>> what I had to hand.
> 
> It is really better to hack git with git. And you can use current gitweb
> with old git (well, not always, as current gitweb requires --full-history
> option to git-rev-list to be available).
> 

How about the below on top of latest git 

-aneesh


--------------060500090202050606090300
Content-Type: text/x-patch;
 name="gitweb.snapshot.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitweb.snapshot.diff"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 37a6284..b9b522a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -175,6 +175,7 @@ my %actions = (
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
+	"snapshot" => \&git_snapshot,
 );
 
 $action = 'summary' if (!defined($action));
@@ -1334,6 +1335,7 @@ sub git_shortlog_body {
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
+		      " | " .$cgi->a({-href => "$my_uri/$project.tar.gz?" . esc_param("p=$project;a=snapshot;h=$commit")}, "snapshot") .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
@@ -2097,6 +2099,21 @@ sub git_tree {
 	git_footer_html();
 }
 
+sub git_snapshot {
+	if (!defined $hash) {
+		$hash = git_get_head_hash($project);
+	}
+	print $cgi->header(-type=>'application/x-tar',
+			  -Content-Encoding=>'x-gzip', -status=> '200 OK');
+	open my $fd, "-|", "$GIT tar-tree $hash $project | gzip -c9" or die_error(undef, "Execute git-tar-tree failed.");
+	binmode STDOUT, ':raw';
+	print <$fd>;
+	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	close $fd;
+
+
+}
+
 sub git_log {
 	my $head = git_get_head_hash($project);
 	if (!defined $hash) {

--------------060500090202050606090300--

From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: gitweb / cg-export
Date: Wed, 16 Aug 2006 17:02:36 +0530
Message-ID: <ebuvok$vnv$1@sea.gmane.org>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org> <44E2F911.6060002@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060307070608030805080403"
X-From: git-owner@vger.kernel.org Wed Aug 16 13:34:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDJev-0001YO-G6
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 13:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWHPLdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 07:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWHPLdy
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 07:33:54 -0400
Received: from main.gmane.org ([80.91.229.2]:2242 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751109AbWHPLdx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 07:33:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDJeI-0001OL-Co
	for git@vger.kernel.org; Wed, 16 Aug 2006 13:33:26 +0200
Received: from palrel2.hp.com ([156.153.255.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 13:33:26 +0200
Received: from aneesh.kumar by palrel2.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 13:33:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: palrel2.hp.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <44E2F911.6060002@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25513>

This is a multi-part message in MIME format.
--------------060307070608030805080403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
> Jakub Narebski wrote:
>> Toby White wrote:
>>
>>> I was wondering if a feature like the following would be of
>>> use to anyone except me: I'd like to be able to download
>>> the full source of a given tree from gitweb.
>> [...]
>> So you want to have snapshot of a tree. Why not snapshot of a commit, 
>> or of a tag?
>>
>>> I've quickly hacked gitweb to do this for me - patch below.
>>>
>>> It adds an extra link to the 'commit' page. Next to the link
>>> that would lead you to 'tree', there is 'tar.gz' which simply
>>> returns the tar.gz of the same tree.
>>>
>>> The patch is against the version of gitweb currently in
>>> Debian, which is, erm, '264-1', apparently, because that's
>>> what I had to hand.
>>
>> It is really better to hack git with git. And you can use current gitweb
>> with old git (well, not always, as current gitweb requires --full-history
>> option to git-rev-list to be available).
>>
> 
> How about the below on top of latest git

Add it to git_commit too. The patch contains the pervious changes also.

-aneesh


--------------060307070608030805080403
Content-Type: text/x-patch;
 name="gitweb.snapshot.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitweb.snapshot.diff"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 37a6284..b2e375e 100755
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
@@ -2226,7 +2243,8 @@ sub git_commit {
 	      "<td class=\"sha1\">" .
 	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash), class => "list"}, $co{'tree'}) .
 	      "</td>" .
-	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree") .
+	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree") . " | " .
+	      $cgi->a({-href => "$my_uri/$project.tar.gz?" . esc_param("p=$project;a=snapshot;h=$hash")}, "snapshot") .
 	      "</td>" .
 	      "</tr>\n";
 	my $parents = $co{'parents'};

--------------060307070608030805080403--

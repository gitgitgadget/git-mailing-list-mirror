From: Stas Maximov <smaximov@yahoo.com>
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Mon, 25 Jun 2007 09:23:55 -0700 (PDT)
Message-ID: <961604.41519.qm@web43137.mail.sp1.yahoo.com>
Reply-To: Stas Maximov <smaximov@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1414402915-1182788635=:41519"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 18:24:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2rMF-00040j-RE
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 18:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbXFYQX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 12:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbXFYQX5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 12:23:57 -0400
Received: from web43137.mail.sp1.yahoo.com ([216.252.121.67]:27157 "HELO
	web43137.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751786AbXFYQX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 12:23:56 -0400
Received: (qmail 41632 invoked by uid 60001); 25 Jun 2007 16:23:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=1pPY+MWy7KRJoE0MRRKscF0ZqV7ib4jGbryVFbtLKC+Wvu18B+u62n7XVUlDqupqLSWqNVk9fdy3nRf44iyuTEv18oeHhlbOqjShJrFUk/l58uTAc6/8V6/OBAncJg8JPPqT5II8f9+lMs97jpae0zACUJQpbzCMqqDOTTExg30=;
Received: from [75.33.140.195] by web43137.mail.sp1.yahoo.com via HTTP; Mon, 25 Jun 2007 09:23:55 PDT
X-Mailer: YahooMailRC/651.38 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50906>

--0-1414402915-1182788635=:41519
Content-Type: text/plain; charset=ascii

Hi Junio,

Thank you for a thorough review and good suggestions. New cumulative patch is pasted and attached. 

>From: Junio C Hamano <gitster@pobox.com>
> ...
>> +# Given an SVN revision (string), returns all corresponding GIT revisions.
>> +#
>> +# Note that it is possible that one SVN revision needs to be split into two or
>> +# more GIT commits (revision). For example, this will happen if SVN user
>> +# commits two branches at once.
>> +sub svnrev_to_gitrevs($)
>> ...
>> +    my $svnrev = shift;
>> +    my @gitrevs;
>> +    for my $b (keys(%branches)) {
>> +        push (@gitrevs, $branches{$b}{$svnrev})
>> +            if defined($branches{$b}{$svnrev});
>> +    }
>> +    return @gitrevs;
>> +}
>
>Hmph.  The computation cost for this is proportional to the
>number of branches on the SVN side?  Would that be a problem in
>real-life (not an objection, but am just wondering.  "Not a
>problem, because..." is an acceptable answer).

I chose not to add and maintain an inverted data structure in parallel to %branches for simplicity.

Stas.


>From b17c89b82441dc3c5dc3155acee560a1d7f0149d Mon Sep 17 00:00:00 2001
From: Stas Maximov <smaximov@yahoo.com>
Date: Mon, 25 Jun 2007 09:18:35 -0700
Subject: [PATCH] git-svnimport: added explicit merge graph option -G

Allows explicit merge graph information to be provided. Each line
of merge graph file must contain a pair of SVN revision numbers
separated by space. The first number is child (merged to) SVN rev
number and the second is the parent (merged from) SVN rev number.
Comments can be started with '#' and continue to the end of line.
Empty and space-only lines are allowed and will be ignored.

Signed-off-by: Stas Maximov <smaximov@yahoo.com>
---
 Documentation/git-svnimport.txt |   11 +++++-
 git-svnimport.perl              |   74 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index e97d15e..c902b64 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
         [ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
         [ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
-        [ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
+        [ -s start_chg ] [ -r ]
+        [ -m ] [ -M regex ] [-G merge_graph_file ]
         [ -I <ignorefile_name> ] [ -A <author_file> ]
         [ -R <repack_each_revs>] [ -P <path_from_trunk> ]
         <SVN_repository_URL> [ <path> ]
@@ -102,6 +103,14 @@ repository without -A.
     regex. It can be used with -m to also see the default regexes.
     You must escape forward slashes.
 
+-G <merge_graph_file>::
+    Allows explicit merge graph information to be provided. Each line
+    of merge graph file must contain a pair of SVN revision numbers
+    separated by space. The first number is child (merged to) SVN rev
+    number and the second is the parent (merged from) SVN rev number.
+    Comments can be started with '#' and continue to the end of line.
+    Empty and space-only lines are allowed and will be ignored.
+
 -l <max_rev>::
     Specify a maximum revision number to pull.
 +
diff --git a/git-svnimport.perl b/git-svnimport.perl
index b73d649..ea0bc90 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -32,7 +32,7 @@ $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
     $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,
-    $opt_P,$opt_R);
+    $opt_P,$opt_R,$opt_G);
 
 sub usage() {
     print STDERR <<END;
@@ -40,12 +40,13 @@ Usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
+       [-m] [-M regex] [-G merge_graph_file] [-A author_file]
+       [-S] [-F] [-P project_name] [SVN_URL]
 END
     exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
+getopts("A:b:C:dDFhiI:l:mM:G:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -80,6 +81,44 @@ if ($opt_M) {
     unshift (@mergerx, qr/$opt_M/);
 }
 
+
+# merge_graph will be used for finding all parent SVN revisions for a given SVN
+# revision. It will be implemented as a hash of arrays. Hash will be keyed with
+# the child SVN rev and contain an array of the parent SVN revisions.
+our %merge_graph;
+
+# read-in the explicit merge graph specified with -G option
+if ($opt_G) {
+    open F, '<', $opt_G
+            or die("Cannot open '$opt_G'");
+    while (<F>) {
+        chomp;
+        s/#.*//;
+        next if (/^\s*$/);
+        if (/^\s*(\d+)\s+(\d+)\s*$/) {
+            # $1: child_rev, $2: $parent_rev
+            $merge_graph{$1} ||= [];
+            push @{$merge_graph{$1}}, $2;
+        } else {
+            die "$opt_G:$. :malformed input $_\n";
+        }
+    }
+    close(F);
+}
+
+
+# Given an SVN revision (string), finds all its parent SVN revisions in the
+# merge graph.
+sub merge_graph_get_parents {
+    my $child_svnrev = shift;
+    if (exists $merge_graph{$child_svnrev}) {
+        return @{$merge_graph{$child_svnrev}};
+    }
+    return ();
+}
+
+
+
 # Absolutize filename now, since we will have chdir'ed by the time we
 # get around to opening it.
 $opt_A = File::Spec->rel2abs($opt_A) if $opt_A;
@@ -356,6 +395,23 @@ if ($opt_A) {
 
 open BRANCHES,">>", "$git_dir/svn2git";
 
+
+# Given an SVN revision (string), returns all corresponding GIT revisions.
+#
+# Note that it is possible that one SVN revision needs to be split into two or
+# more GIT commits (revision). For example, this will happen if SVN user
+# commits two branches at once.
+sub svnrev_to_gitrevs($) {
+    my $svnrev = shift;
+    my @gitrevs;
+    for my $b (keys(%branches)) {
+        push (@gitrevs, $branches{$b}{$svnrev})
+            if defined($branches{$b}{$svnrev});
+    }
+    return @gitrevs;
+}
+
+
 sub node_kind($$) {
     my ($svnpath, $revision) = @_;
     my $pool=SVN::Pool->new;
@@ -815,6 +871,18 @@ sub commit {
                     }
                 }
             }
+
+            # add parents from explicit merge graph (-G)
+            {
+                my @svnpars = merge_graph_get_parents($revision);
+                foreach my $svnp (@svnpars) {
+                    my @gitpars = svnrev_to_gitrevs($svnp);
+                    foreach my $gitp (@gitpars) {
+                        push (@parents, $gitp);
+                    }
+                }
+            }
+
             my %seen_parents = ();
             my @unique_parents = grep { ! $seen_parents{$_} ++ } @parents;
             foreach my $bparent (@unique_parents) {
-- 
1.5.1.3








--0-1414402915-1182788635=:41519
Content-Type: application/octet-stream; name="=?utf-8?q?0001-git-svnimport-added-explicit-merge-graph-option-G.patch?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="=?utf-8?q?0001-git-svnimport-added-explicit-merge-graph-option-G.patch?="

RnJvbSBiMTdjODliODI0NDFkYzNjNWRjMzE1NWFjZWU1NjBhMWQ3ZjAxNDlk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGFzIE1heGltb3Yg
PHNtYXhpbW92QHlhaG9vLmNvbT4KRGF0ZTogTW9uLCAyNSBKdW4gMjAwNyAw
OToxODozNSAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGdpdC1zdm5pbXBvcnQ6
IGFkZGVkIGV4cGxpY2l0IG1lcmdlIGdyYXBoIG9wdGlvbiAtRwoKQWxsb3dz
IGV4cGxpY2l0IG1lcmdlIGdyYXBoIGluZm9ybWF0aW9uIHRvIGJlIHByb3Zp
ZGVkLiBFYWNoIGxpbmUKb2YgbWVyZ2UgZ3JhcGggZmlsZSBtdXN0IGNvbnRh
aW4gYSBwYWlyIG9mIFNWTiByZXZpc2lvbiBudW1iZXJzCnNlcGFyYXRlZCBi
eSBzcGFjZS4gVGhlIGZpcnN0IG51bWJlciBpcyBjaGlsZCAobWVyZ2VkIHRv
KSBTVk4gcmV2Cm51bWJlciBhbmQgdGhlIHNlY29uZCBpcyB0aGUgcGFyZW50
IChtZXJnZWQgZnJvbSkgU1ZOIHJldiBudW1iZXIuCkNvbW1lbnRzIGNhbiBi
ZSBzdGFydGVkIHdpdGggJyMnIGFuZCBjb250aW51ZSB0byB0aGUgZW5kIG9m
IGxpbmUuCkVtcHR5IGFuZCBzcGFjZS1vbmx5IGxpbmVzIGFyZSBhbGxvd2Vk
IGFuZCB3aWxsIGJlIGlnbm9yZWQuCgpTaWduZWQtb2ZmLWJ5OiBTdGFzIE1h
eGltb3YgPHNtYXhpbW92QHlhaG9vLmNvbT4KLS0tCiBEb2N1bWVudGF0aW9u
L2dpdC1zdm5pbXBvcnQudHh0IHwgICAxMSArKysrKy0KIGdpdC1zdm5pbXBv
cnQucGVybCAgICAgICAgICAgICAgfCAgIDc0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA4MSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZ2l0LXN2bmltcG9ydC50eHQgYi9Eb2N1bWVudGF0aW9u
L2dpdC1zdm5pbXBvcnQudHh0CmluZGV4IGU5N2QxNWUuLmM5MDJiNjQgMTAw
NjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LXN2bmltcG9ydC50eHQKKysr
IGIvRG9jdW1lbnRhdGlvbi9naXQtc3ZuaW1wb3J0LnR4dApAQCAtMTMsNyAr
MTMsOCBAQCBTWU5PUFNJUwogJ2dpdC1zdm5pbXBvcnQnIFsgLW8gPGJyYW5j
aC1mb3ItSEVBRD4gXSBbIC1oIF0gWyAtdiBdIFsgLWQgfCAtRCBdCiAJCVsg
LUMgPEdJVF9yZXBvc2l0b3J5PiBdIFsgLWkgXSBbIC11IF0gWy1sIGxpbWl0
X3Jldl0KIAkJWyAtYiBicmFuY2hfc3ViZGlyIF0gWyAtVCB0cnVua19zdWJk
aXIgXSBbIC10IHRhZ19zdWJkaXIgXQotCQlbIC1zIHN0YXJ0X2NoZyBdIFsg
LW0gXSBbIC1yIF0gWyAtTSByZWdleCBdCisJCVsgLXMgc3RhcnRfY2hnIF0g
WyAtciBdCisJCVsgLW0gXSBbIC1NIHJlZ2V4IF0gWy1HIG1lcmdlX2dyYXBo
X2ZpbGUgXQogCQlbIC1JIDxpZ25vcmVmaWxlX25hbWU+IF0gWyAtQSA8YXV0
aG9yX2ZpbGU+IF0KIAkJWyAtUiA8cmVwYWNrX2VhY2hfcmV2cz5dIFsgLVAg
PHBhdGhfZnJvbV90cnVuaz4gXQogCQk8U1ZOX3JlcG9zaXRvcnlfVVJMPiBb
IDxwYXRoPiBdCkBAIC0xMDIsNiArMTAzLDE0IEBAIHJlcG9zaXRvcnkgd2l0
aG91dCAtQS4KIAlyZWdleC4gSXQgY2FuIGJlIHVzZWQgd2l0aCAtbSB0byBh
bHNvIHNlZSB0aGUgZGVmYXVsdCByZWdleGVzLgogCVlvdSBtdXN0IGVzY2Fw
ZSBmb3J3YXJkIHNsYXNoZXMuCiAKKy1HIDxtZXJnZV9ncmFwaF9maWxlPjo6
CisJQWxsb3dzIGV4cGxpY2l0IG1lcmdlIGdyYXBoIGluZm9ybWF0aW9uIHRv
IGJlIHByb3ZpZGVkLiBFYWNoIGxpbmUKKwlvZiBtZXJnZSBncmFwaCBmaWxl
IG11c3QgY29udGFpbiBhIHBhaXIgb2YgU1ZOIHJldmlzaW9uIG51bWJlcnMK
KwlzZXBhcmF0ZWQgYnkgc3BhY2UuIFRoZSBmaXJzdCBudW1iZXIgaXMgY2hp
bGQgKG1lcmdlZCB0bykgU1ZOIHJldgorCW51bWJlciBhbmQgdGhlIHNlY29u
ZCBpcyB0aGUgcGFyZW50IChtZXJnZWQgZnJvbSkgU1ZOIHJldiBudW1iZXIu
CisJQ29tbWVudHMgY2FuIGJlIHN0YXJ0ZWQgd2l0aCAnIycgYW5kIGNvbnRp
bnVlIHRvIHRoZSBlbmQgb2YgbGluZS4KKwlFbXB0eSBhbmQgc3BhY2Utb25s
eSBsaW5lcyBhcmUgYWxsb3dlZCBhbmQgd2lsbCBiZSBpZ25vcmVkLgorCiAt
bCA8bWF4X3Jldj46OgogCVNwZWNpZnkgYSBtYXhpbXVtIHJldmlzaW9uIG51
bWJlciB0byBwdWxsLgogKwpkaWZmIC0tZ2l0IGEvZ2l0LXN2bmltcG9ydC5w
ZXJsIGIvZ2l0LXN2bmltcG9ydC5wZXJsCmluZGV4IGI3M2Q2NDkuLmVhMGJj
OTAgMTAwNzU1Ci0tLSBhL2dpdC1zdm5pbXBvcnQucGVybAorKysgYi9naXQt
c3ZuaW1wb3J0LnBlcmwKQEAgLTMyLDcgKzMyLDcgQEAgJEVOVnsnVFonfT0i
VVRDIjsKIAogb3VyKCRvcHRfaCwkb3B0X28sJG9wdF92LCRvcHRfdSwkb3B0
X0MsJG9wdF9pLCRvcHRfbSwkb3B0X00sJG9wdF90LCRvcHRfVCwKICAgICAk
b3B0X2IsJG9wdF9yLCRvcHRfSSwkb3B0X0EsJG9wdF9zLCRvcHRfbCwkb3B0
X2QsJG9wdF9ELCRvcHRfUywkb3B0X0YsCi0gICAgJG9wdF9QLCRvcHRfUik7
CisgICAgJG9wdF9QLCRvcHRfUiwkb3B0X0cpOwogCiBzdWIgdXNhZ2UoKSB7
CiAJcHJpbnQgU1RERVJSIDw8RU5EOwpAQCAtNDAsMTIgKzQwLDEzIEBAIFVz
YWdlOiAke1xiYXNlbmFtZSAkMH0gICAgICMgZmV0Y2gvdXBkYXRlIEdJVCBm
cm9tIFNWTgogICAgICAgIFstbyBicmFuY2gtZm9yLUhFQURdIFstaF0gWy12
XSBbLWwgbWF4X3Jldl0gWy1SIHJlcGFja19lYWNoX3JldnNdCiAgICAgICAg
Wy1DIEdJVF9yZXBvc2l0b3J5XSBbLXQgdGFnbmFtZV0gWy1UIHRydW5rbmFt
ZV0gWy1iIGJyYW5jaG5hbWVdCiAgICAgICAgWy1kfC1EXSBbLWldIFstdV0g
Wy1yXSBbLUkgaWdub3JlZmlsZW5hbWVdIFstcyBzdGFydF9jaGddCi0gICAg
ICAgWy1tXSBbLU0gcmVnZXhdIFstQSBhdXRob3JfZmlsZV0gWy1TXSBbLUZd
IFstUCBwcm9qZWN0X25hbWVdIFtTVk5fVVJMXQorICAgICAgIFstbV0gWy1N
IHJlZ2V4XSBbLUcgbWVyZ2VfZ3JhcGhfZmlsZV0gWy1BIGF1dGhvcl9maWxl
XQorICAgICAgIFstU10gWy1GXSBbLVAgcHJvamVjdF9uYW1lXSBbU1ZOX1VS
TF0KIEVORAogCWV4aXQoMSk7CiB9CiAKLWdldG9wdHMoIkE6YjpDOmRERmhp
STpsOm1NOm86cnM6dDpUOlNQOlI6dXYiKSBvciB1c2FnZSgpOworZ2V0b3B0
cygiQTpiOkM6ZERGaGlJOmw6bU06RzpvOnJzOnQ6VDpTUDpSOnV2Iikgb3Ig
dXNhZ2UoKTsKIHVzYWdlIGlmICRvcHRfaDsKIAogbXkgJHRhZ19uYW1lID0g
JG9wdF90IHx8ICJ0YWdzIjsKQEAgLTgwLDYgKzgxLDQ0IEBAIGlmICgkb3B0
X00pIHsKIAl1bnNoaWZ0IChAbWVyZ2VyeCwgcXIvJG9wdF9NLyk7CiB9CiAK
KworIyBtZXJnZV9ncmFwaCB3aWxsIGJlIHVzZWQgZm9yIGZpbmRpbmcgYWxs
IHBhcmVudCBTVk4gcmV2aXNpb25zIGZvciBhIGdpdmVuIFNWTgorIyByZXZp
c2lvbi4gSXQgd2lsbCBiZSBpbXBsZW1lbnRlZCBhcyBhIGhhc2ggb2YgYXJy
YXlzLiBIYXNoIHdpbGwgYmUga2V5ZWQgd2l0aAorIyB0aGUgY2hpbGQgU1ZO
IHJldiBhbmQgY29udGFpbiBhbiBhcnJheSBvZiB0aGUgcGFyZW50IFNWTiBy
ZXZpc2lvbnMuCitvdXIgJW1lcmdlX2dyYXBoOworCisjIHJlYWQtaW4gdGhl
IGV4cGxpY2l0IG1lcmdlIGdyYXBoIHNwZWNpZmllZCB3aXRoIC1HIG9wdGlv
bgoraWYgKCRvcHRfRykgeworICAgIG9wZW4gRiwgJzwnLCAkb3B0X0cKKyAg
ICAgICAgICAgIG9yIGRpZSgiQ2Fubm90IG9wZW4gJyRvcHRfRyciKTsKKyAg
ICB3aGlsZSAoPEY+KSB7CisgICAgICAgIGNob21wOworICAgICAgICBzLyMu
Ki8vOworICAgICAgICBuZXh0IGlmICgvXlxzKiQvKTsKKyAgICAgICAgaWYg
KC9eXHMqKFxkKylccysoXGQrKVxzKiQvKSB7CisgICAgICAgICAgICAjICQx
OiBjaGlsZF9yZXYsICQyOiAkcGFyZW50X3JldgorICAgICAgICAgICAgJG1l
cmdlX2dyYXBoeyQxfSB8fD0gW107CisgICAgICAgICAgICBwdXNoIEB7JG1l
cmdlX2dyYXBoeyQxfX0sICQyOworICAgICAgICB9IGVsc2UgeworICAgICAg
ICAgICAgZGllICIkb3B0X0c6JC4gOm1hbGZvcm1lZCBpbnB1dCAkX1xuIjsK
KyAgICAgICAgfQorICAgIH0KKyAgICBjbG9zZShGKTsKK30KKworCisjIEdp
dmVuIGFuIFNWTiByZXZpc2lvbiAoc3RyaW5nKSwgZmluZHMgYWxsIGl0cyBw
YXJlbnQgU1ZOIHJldmlzaW9ucyBpbiB0aGUKKyMgbWVyZ2UgZ3JhcGguCitz
dWIgbWVyZ2VfZ3JhcGhfZ2V0X3BhcmVudHMgeworICAgIG15ICRjaGlsZF9z
dm5yZXYgPSBzaGlmdDsKKyAgICBpZiAoZXhpc3RzICRtZXJnZV9ncmFwaHsk
Y2hpbGRfc3ZucmV2fSkgeworICAgICAgICByZXR1cm4gQHskbWVyZ2VfZ3Jh
cGh7JGNoaWxkX3N2bnJldn19OworICAgIH0KKyAgICByZXR1cm4gKCk7Cit9
CisKKworCiAjIEFic29sdXRpemUgZmlsZW5hbWUgbm93LCBzaW5jZSB3ZSB3
aWxsIGhhdmUgY2hkaXInZWQgYnkgdGhlIHRpbWUgd2UKICMgZ2V0IGFyb3Vu
ZCB0byBvcGVuaW5nIGl0LgogJG9wdF9BID0gRmlsZTo6U3BlYy0+cmVsMmFi
cygkb3B0X0EpIGlmICRvcHRfQTsKQEAgLTM1Niw2ICszOTUsMjMgQEAgaWYg
KCRvcHRfQSkgewogCiBvcGVuIEJSQU5DSEVTLCI+PiIsICIkZ2l0X2Rpci9z
dm4yZ2l0IjsKIAorCisjIEdpdmVuIGFuIFNWTiByZXZpc2lvbiAoc3RyaW5n
KSwgcmV0dXJucyBhbGwgY29ycmVzcG9uZGluZyBHSVQgcmV2aXNpb25zLgor
IworIyBOb3RlIHRoYXQgaXQgaXMgcG9zc2libGUgdGhhdCBvbmUgU1ZOIHJl
dmlzaW9uIG5lZWRzIHRvIGJlIHNwbGl0IGludG8gdHdvIG9yCisjIG1vcmUg
R0lUIGNvbW1pdHMgKHJldmlzaW9uKS4gRm9yIGV4YW1wbGUsIHRoaXMgd2ls
bCBoYXBwZW4gaWYgU1ZOIHVzZXIKKyMgY29tbWl0cyB0d28gYnJhbmNoZXMg
YXQgb25jZS4KK3N1YiBzdm5yZXZfdG9fZ2l0cmV2cygkKSB7CisgICAgbXkg
JHN2bnJldiA9IHNoaWZ0OworICAgIG15IEBnaXRyZXZzOworICAgIGZvciBt
eSAkYiAoa2V5cyglYnJhbmNoZXMpKSB7CisgICAgICAgIHB1c2ggKEBnaXRy
ZXZzLCAkYnJhbmNoZXN7JGJ9eyRzdm5yZXZ9KQorICAgICAgICAgICAgaWYg
ZGVmaW5lZCgkYnJhbmNoZXN7JGJ9eyRzdm5yZXZ9KTsKKyAgICB9CisgICAg
cmV0dXJuIEBnaXRyZXZzOworfQorCisKIHN1YiBub2RlX2tpbmQoJCQpIHsK
IAlteSAoJHN2bnBhdGgsICRyZXZpc2lvbikgPSBAXzsKIAlteSAkcG9vbD1T
Vk46OlBvb2wtPm5ldzsKQEAgLTgxNSw2ICs4NzEsMTggQEAgc3ViIGNvbW1p
dCB7CiAJCQkJCX0KIAkJCQl9CiAJCQl9CisKKyAgICAgICAgICAgICMgYWRk
IHBhcmVudHMgZnJvbSBleHBsaWNpdCBtZXJnZSBncmFwaCAoLUcpCisgICAg
ICAgICAgICB7CisgICAgICAgICAgICAgICAgbXkgQHN2bnBhcnMgPSBtZXJn
ZV9ncmFwaF9nZXRfcGFyZW50cygkcmV2aXNpb24pOworICAgICAgICAgICAg
ICAgIGZvcmVhY2ggbXkgJHN2bnAgKEBzdm5wYXJzKSB7CisgICAgICAgICAg
ICAgICAgICAgIG15IEBnaXRwYXJzID0gc3ZucmV2X3RvX2dpdHJldnMoJHN2
bnApOworICAgICAgICAgICAgICAgICAgICBmb3JlYWNoIG15ICRnaXRwIChA
Z2l0cGFycykgeworICAgICAgICAgICAgICAgICAgICAgICAgcHVzaCAoQHBh
cmVudHMsICRnaXRwKTsKKyAgICAgICAgICAgICAgICAgICAgfQorICAgICAg
ICAgICAgICAgIH0KKyAgICAgICAgICAgIH0KKwogCQkJbXkgJXNlZW5fcGFy
ZW50cyA9ICgpOwogCQkJbXkgQHVuaXF1ZV9wYXJlbnRzID0gZ3JlcCB7ICEg
JHNlZW5fcGFyZW50c3skX30gKysgfSBAcGFyZW50czsKIAkJCWZvcmVhY2gg
bXkgJGJwYXJlbnQgKEB1bmlxdWVfcGFyZW50cykgewotLSAKMS41LjEuMwoK


--0-1414402915-1182788635=:41519--

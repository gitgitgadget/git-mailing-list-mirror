From: Stas Maximov <smaximov@yahoo.com>
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Sun, 24 Jun 2007 16:10:42 -0700 (PDT)
Message-ID: <437777.72821.qm@web43141.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-4142210-1182726642=:72821"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 01:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2bEE-0001J7-3w
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 01:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbXFXXKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 19:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbXFXXKo
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 19:10:44 -0400
Received: from web43141.mail.sp1.yahoo.com ([216.252.121.71]:39853 "HELO
	web43141.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752134AbXFXXKn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 19:10:43 -0400
Received: (qmail 73524 invoked by uid 60001); 24 Jun 2007 23:10:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=CGvQkUtD8/fDmavaYRvlS9Nv+dnaWNsa9FlPM+RayeTQ3dZ7yCgfMVcipqvN6ghp/yr5JKM5nO2bKyrnP4fdWMHQ4WpqiqiaAmIKhU6GEEowG1cXMQ/AI6UVaSkkdXVojTDXBkPLIeVwADIpTLmlaBYBFDlAc0wesJC1olVkp50=;
X-YMail-OSG: 6YWAQBsVM1moCrZH3Pu5SBfJ1jB5f3ODeDlG7i7n8.S7XMl2OjL4AExEX7F7LPHpdQJshTmN8g--
Received: from [75.35.6.113] by web43141.mail.sp1.yahoo.com via HTTP; Sun, 24 Jun 2007 16:10:42 PDT
X-Mailer: YahooMailRC/651.38 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50841>

--0-4142210-1182726642=:72821
Content-Type: text/plain; charset=ascii

Junio,

Below is what I got with 

git-format-patch -p -M -s  --stdout origin

I hope this is acceptable. I checked, I do not have a MUA which preserves whitespaces such that the result is suitable for applying the patch. So I am pasting the patch below for discussion and also attaching to be suitable for applying.

Stas.

>From fd83a4e003802b6cb4dc8a2d058310f235f65e17 Mon Sep 17 00:00:00 2001
From: Stas Maximov <smaximov@yahoo.com>
Date: Sat, 23 Jun 2007 09:06:30 -0700
Subject: [PATCH] git-svnimport: added explicit merge graph option -G

Allows explicit merge graph information to be provided. Each line
of merge graph file must contain a pair of SVN revision numbers
separated by space. The first number is child (merged to) SVN rev
number and the second is the parent (merged from) SVN rev number.
Comments can be started with '#' and continue to the end of line.
Empty and space-only lines are allowed and will be ignored.

Signed-off-by: Stas Maximov <smaximov@yahoo.com>

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
old mode 100644
new mode 100755
index e97d15e..c902b64
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
index f459762..113b252 100755
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
@@ -80,6 +81,39 @@ if ($opt_M) {
     unshift (@mergerx, qr/$opt_M/);
 }
 
+
+# merge_graph will be used for finding all parent SVN revisions for a given SVN
+# revision. It will be implemented as a hash of hashes. First level hash will
+# be keyed with the child SVN rev and contain a hash keyed with the parent SVN
+# revisions. Values of the second level hash are not important (1 will be
+# used). The keys will be used to store the parent revs for uniqueness.
+our %merge_graph;
+
+
+# read-in the explicit merge graph specified with -G option
+if ($opt_G) {
+    open(F,"cat $opt_G | sed -e 's/#.*\$//' -e '/^\$/d' |") or
+        die("Can not open $opt_G");
+    while(<F>) {
+        chomp;
+        die "ERROR: invalid line in $opt_G: $_" unless /^\s*(\d+)\s+(\d+)\s*$/;
+        # $merge_graph{child_rev}{parent_rev} = 1;
+        $merge_graph{$1}{$2} = 1;
+    }
+    close(F);
+}
+
+
+# Given an SVN revision (string), finds all its parent SVN revisions in the
+# merge graph.
+sub merge_graph_get_parents($)
+{
+    my $child_svnrev = shift;
+    my @parents = keys(%{$merge_graph{$child_svnrev}});
+    return @parents;
+}
+
+
 # Absolutize filename now, since we will have chdir'ed by the time we
 # get around to opening it.
 $opt_A = File::Spec->rel2abs($opt_A) if $opt_A;
@@ -356,6 +390,24 @@ if ($opt_A) {
 
 open BRANCHES,">>", "$git_dir/svn2git";
 
+
+# Given an SVN revision (string), returns all corresponding GIT revisions.
+#
+# Note that it is possible that one SVN revision needs to be split into two or
+# more GIT commits (revision). For example, this will happen if SVN user
+# commits two branches at once.
+sub svnrev_to_gitrevs($)
+{
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
@@ -815,6 +867,19 @@ sub commit {
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
+                        #print OUT "MG: $svnp -merge-> $revision\n";
+                    }
+                }
+            }
+
             my %seen_parents = ();
             my @unique_parents = grep { ! $seen_parents{$_} ++ } @parents;
             foreach my $bparent (@unique_parents) {
-- 
1.5.1.3


>From 7008a13f1fe00fdbd90be6a12ad1197dceedaebb Mon Sep 17 00:00:00 2001
From: Stas Maximov <smaximov@yahoo.com>
Date: Sun, 24 Jun 2007 14:23:29 -0700
Subject: [PATCH] Fixed permissions of Documentation/git-svnimport.txt


Signed-off-by: Stas Maximov <smaximov@yahoo.com>

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
old mode 100755
new mode 100644
-- 
1.5.1.3





----- Original Message ----
From: Junio C Hamano <gitster@pobox.com>
To: Stas Maximov <smaximov@yahoo.com>
Cc: git@vger.kernel.org; Peter Baumann <waste.manager@gmx.de>
Sent: Sunday, June 24, 2007 3:17:05 PM
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G

Stas Maximov <smaximov@yahoo.com> writes:

> Attached are two patches:
>
> 1. resubmission of the original patch with proper sign-off; and 
> 2. patch with permissions fix (thanks to Alex Reisen for pointing out);

As you are assuming that the original patch was rejected (by
resending that as the first one here), I do not think these
changes should be in two separate commits.  Please redo them as
a single patch.

Also please do not "Attach".  When you have N patches to send,
send N e-mail messages, numbered from [PATCH 1/N] to [PATCH
N/N], each with one patch in the message itself.

Please see Documentation/SubmittingPatches.




--0-4142210-1182726642=:72821
Content-Type: application/octet-stream; name="=?utf-8?q?0001-git-svnimport-added-explicit-merge-graph-option-G.patch?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="=?utf-8?q?0001-git-svnimport-added-explicit-merge-graph-option-G.patch?="

RnJvbSBmZDgzYTRlMDAzODAyYjZjYjRkYzhhMmQwNTgzMTBmMjM1ZjY1ZTE3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGFzIE1heGltb3Yg
PHNtYXhpbW92QHlhaG9vLmNvbT4KRGF0ZTogU2F0LCAyMyBKdW4gMjAwNyAw
OTowNjozMCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGdpdC1zdm5pbXBvcnQ6
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
eGltb3YgPHNtYXhpbW92QHlhaG9vLmNvbT4KCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2dpdC1zdm5pbXBvcnQudHh0IGIvRG9jdW1lbnRhdGlvbi9n
aXQtc3ZuaW1wb3J0LnR4dApvbGQgbW9kZSAxMDA2NDQKbmV3IG1vZGUgMTAw
NzU1CmluZGV4IGU5N2QxNWUuLmM5MDJiNjQKLS0tIGEvRG9jdW1lbnRhdGlv
bi9naXQtc3ZuaW1wb3J0LnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2dpdC1z
dm5pbXBvcnQudHh0CkBAIC0xMyw3ICsxMyw4IEBAIFNZTk9QU0lTCiAnZ2l0
LXN2bmltcG9ydCcgWyAtbyA8YnJhbmNoLWZvci1IRUFEPiBdIFsgLWggXSBb
IC12IF0gWyAtZCB8IC1EIF0KIAkJWyAtQyA8R0lUX3JlcG9zaXRvcnk+IF0g
WyAtaSBdIFsgLXUgXSBbLWwgbGltaXRfcmV2XQogCQlbIC1iIGJyYW5jaF9z
dWJkaXIgXSBbIC1UIHRydW5rX3N1YmRpciBdIFsgLXQgdGFnX3N1YmRpciBd
Ci0JCVsgLXMgc3RhcnRfY2hnIF0gWyAtbSBdIFsgLXIgXSBbIC1NIHJlZ2V4
IF0KKwkJWyAtcyBzdGFydF9jaGcgXSBbIC1yIF0KKwkJWyAtbSBdIFsgLU0g
cmVnZXggXSBbLUcgbWVyZ2VfZ3JhcGhfZmlsZSBdCiAJCVsgLUkgPGlnbm9y
ZWZpbGVfbmFtZT4gXSBbIC1BIDxhdXRob3JfZmlsZT4gXQogCQlbIC1SIDxy
ZXBhY2tfZWFjaF9yZXZzPl0gWyAtUCA8cGF0aF9mcm9tX3RydW5rPiBdCiAJ
CTxTVk5fcmVwb3NpdG9yeV9VUkw+IFsgPHBhdGg+IF0KQEAgLTEwMiw2ICsx
MDMsMTQgQEAgcmVwb3NpdG9yeSB3aXRob3V0IC1BLgogCXJlZ2V4LiBJdCBj
YW4gYmUgdXNlZCB3aXRoIC1tIHRvIGFsc28gc2VlIHRoZSBkZWZhdWx0IHJl
Z2V4ZXMuCiAJWW91IG11c3QgZXNjYXBlIGZvcndhcmQgc2xhc2hlcy4KIAor
LUcgPG1lcmdlX2dyYXBoX2ZpbGU+OjoKKwlBbGxvd3MgZXhwbGljaXQgbWVy
Z2UgZ3JhcGggaW5mb3JtYXRpb24gdG8gYmUgcHJvdmlkZWQuIEVhY2ggbGlu
ZQorCW9mIG1lcmdlIGdyYXBoIGZpbGUgbXVzdCBjb250YWluIGEgcGFpciBv
ZiBTVk4gcmV2aXNpb24gbnVtYmVycworCXNlcGFyYXRlZCBieSBzcGFjZS4g
VGhlIGZpcnN0IG51bWJlciBpcyBjaGlsZCAobWVyZ2VkIHRvKSBTVk4gcmV2
CisJbnVtYmVyIGFuZCB0aGUgc2Vjb25kIGlzIHRoZSBwYXJlbnQgKG1lcmdl
ZCBmcm9tKSBTVk4gcmV2IG51bWJlci4KKwlDb21tZW50cyBjYW4gYmUgc3Rh
cnRlZCB3aXRoICcjJyBhbmQgY29udGludWUgdG8gdGhlIGVuZCBvZiBsaW5l
LgorCUVtcHR5IGFuZCBzcGFjZS1vbmx5IGxpbmVzIGFyZSBhbGxvd2VkIGFu
ZCB3aWxsIGJlIGlnbm9yZWQuCisKIC1sIDxtYXhfcmV2Pjo6CiAJU3BlY2lm
eSBhIG1heGltdW0gcmV2aXNpb24gbnVtYmVyIHRvIHB1bGwuCiArCmRpZmYg
LS1naXQgYS9naXQtc3ZuaW1wb3J0LnBlcmwgYi9naXQtc3ZuaW1wb3J0LnBl
cmwKaW5kZXggZjQ1OTc2Mi4uMTEzYjI1MiAxMDA3NTUKLS0tIGEvZ2l0LXN2
bmltcG9ydC5wZXJsCisrKyBiL2dpdC1zdm5pbXBvcnQucGVybApAQCAtMzIs
NyArMzIsNyBAQCAkRU5WeydUWid9PSJVVEMiOwogCiBvdXIoJG9wdF9oLCRv
cHRfbywkb3B0X3YsJG9wdF91LCRvcHRfQywkb3B0X2ksJG9wdF9tLCRvcHRf
TSwkb3B0X3QsJG9wdF9ULAogICAgICRvcHRfYiwkb3B0X3IsJG9wdF9JLCRv
cHRfQSwkb3B0X3MsJG9wdF9sLCRvcHRfZCwkb3B0X0QsJG9wdF9TLCRvcHRf
RiwKLSAgICAkb3B0X1AsJG9wdF9SKTsKKyAgICAkb3B0X1AsJG9wdF9SLCRv
cHRfRyk7CiAKIHN1YiB1c2FnZSgpIHsKIAlwcmludCBTVERFUlIgPDxFTkQ7
CkBAIC00MCwxMiArNDAsMTMgQEAgVXNhZ2U6ICR7XGJhc2VuYW1lICQwfSAg
ICAgIyBmZXRjaC91cGRhdGUgR0lUIGZyb20gU1ZOCiAgICAgICAgWy1vIGJy
YW5jaC1mb3ItSEVBRF0gWy1oXSBbLXZdIFstbCBtYXhfcmV2XSBbLVIgcmVw
YWNrX2VhY2hfcmV2c10KICAgICAgICBbLUMgR0lUX3JlcG9zaXRvcnldIFst
dCB0YWduYW1lXSBbLVQgdHJ1bmtuYW1lXSBbLWIgYnJhbmNobmFtZV0KICAg
ICAgICBbLWR8LURdIFstaV0gWy11XSBbLXJdIFstSSBpZ25vcmVmaWxlbmFt
ZV0gWy1zIHN0YXJ0X2NoZ10KLSAgICAgICBbLW1dIFstTSByZWdleF0gWy1B
IGF1dGhvcl9maWxlXSBbLVNdIFstRl0gWy1QIHByb2plY3RfbmFtZV0gW1NW
Tl9VUkxdCisgICAgICAgWy1tXSBbLU0gcmVnZXhdIFstRyBtZXJnZV9ncmFw
aF9maWxlXSBbLUEgYXV0aG9yX2ZpbGVdCisgICAgICAgWy1TXSBbLUZdIFst
UCBwcm9qZWN0X25hbWVdIFtTVk5fVVJMXQogRU5ECiAJZXhpdCgxKTsKIH0K
IAotZ2V0b3B0cygiQTpiOkM6ZERGaGlJOmw6bU06bzpyczp0OlQ6U1A6Ujp1
diIpIG9yIHVzYWdlKCk7CitnZXRvcHRzKCJBOmI6QzpkREZoaUk6bDptTTpH
Om86cnM6dDpUOlNQOlI6dXYiKSBvciB1c2FnZSgpOwogdXNhZ2UgaWYgJG9w
dF9oOwogCiBteSAkdGFnX25hbWUgPSAkb3B0X3QgfHwgInRhZ3MiOwpAQCAt
ODAsNiArODEsMzkgQEAgaWYgKCRvcHRfTSkgewogCXVuc2hpZnQgKEBtZXJn
ZXJ4LCBxci8kb3B0X00vKTsKIH0KIAorCisjIG1lcmdlX2dyYXBoIHdpbGwg
YmUgdXNlZCBmb3IgZmluZGluZyBhbGwgcGFyZW50IFNWTiByZXZpc2lvbnMg
Zm9yIGEgZ2l2ZW4gU1ZOCisjIHJldmlzaW9uLiBJdCB3aWxsIGJlIGltcGxl
bWVudGVkIGFzIGEgaGFzaCBvZiBoYXNoZXMuIEZpcnN0IGxldmVsIGhhc2gg
d2lsbAorIyBiZSBrZXllZCB3aXRoIHRoZSBjaGlsZCBTVk4gcmV2IGFuZCBj
b250YWluIGEgaGFzaCBrZXllZCB3aXRoIHRoZSBwYXJlbnQgU1ZOCisjIHJl
dmlzaW9ucy4gVmFsdWVzIG9mIHRoZSBzZWNvbmQgbGV2ZWwgaGFzaCBhcmUg
bm90IGltcG9ydGFudCAoMSB3aWxsIGJlCisjIHVzZWQpLiBUaGUga2V5cyB3
aWxsIGJlIHVzZWQgdG8gc3RvcmUgdGhlIHBhcmVudCByZXZzIGZvciB1bmlx
dWVuZXNzLgorb3VyICVtZXJnZV9ncmFwaDsKKworCisjIHJlYWQtaW4gdGhl
IGV4cGxpY2l0IG1lcmdlIGdyYXBoIHNwZWNpZmllZCB3aXRoIC1HIG9wdGlv
bgoraWYgKCRvcHRfRykgeworICAgIG9wZW4oRiwiY2F0ICRvcHRfRyB8IHNl
ZCAtZSAncy8jLipcJC8vJyAtZSAnL15cJC9kJyB8Iikgb3IKKyAgICAgICAg
ZGllKCJDYW4gbm90IG9wZW4gJG9wdF9HIik7CisgICAgd2hpbGUoPEY+KSB7
CisgICAgICAgIGNob21wOworICAgICAgICBkaWUgIkVSUk9SOiBpbnZhbGlk
IGxpbmUgaW4gJG9wdF9HOiAkXyIgdW5sZXNzIC9eXHMqKFxkKylccysoXGQr
KVxzKiQvOworICAgICAgICAjICRtZXJnZV9ncmFwaHtjaGlsZF9yZXZ9e3Bh
cmVudF9yZXZ9ID0gMTsKKyAgICAgICAgJG1lcmdlX2dyYXBoeyQxfXskMn0g
PSAxOworICAgIH0KKyAgICBjbG9zZShGKTsKK30KKworCisjIEdpdmVuIGFu
IFNWTiByZXZpc2lvbiAoc3RyaW5nKSwgZmluZHMgYWxsIGl0cyBwYXJlbnQg
U1ZOIHJldmlzaW9ucyBpbiB0aGUKKyMgbWVyZ2UgZ3JhcGguCitzdWIgbWVy
Z2VfZ3JhcGhfZ2V0X3BhcmVudHMoJCkKK3sKKyAgICBteSAkY2hpbGRfc3Zu
cmV2ID0gc2hpZnQ7CisgICAgbXkgQHBhcmVudHMgPSBrZXlzKCV7JG1lcmdl
X2dyYXBoeyRjaGlsZF9zdm5yZXZ9fSk7CisgICAgcmV0dXJuIEBwYXJlbnRz
OworfQorCisKICMgQWJzb2x1dGl6ZSBmaWxlbmFtZSBub3csIHNpbmNlIHdl
IHdpbGwgaGF2ZSBjaGRpcidlZCBieSB0aGUgdGltZSB3ZQogIyBnZXQgYXJv
dW5kIHRvIG9wZW5pbmcgaXQuCiAkb3B0X0EgPSBGaWxlOjpTcGVjLT5yZWwy
YWJzKCRvcHRfQSkgaWYgJG9wdF9BOwpAQCAtMzU2LDYgKzM5MCwyNCBAQCBp
ZiAoJG9wdF9BKSB7CiAKIG9wZW4gQlJBTkNIRVMsIj4+IiwgIiRnaXRfZGly
L3N2bjJnaXQiOwogCisKKyMgR2l2ZW4gYW4gU1ZOIHJldmlzaW9uIChzdHJp
bmcpLCByZXR1cm5zIGFsbCBjb3JyZXNwb25kaW5nIEdJVCByZXZpc2lvbnMu
CisjCisjIE5vdGUgdGhhdCBpdCBpcyBwb3NzaWJsZSB0aGF0IG9uZSBTVk4g
cmV2aXNpb24gbmVlZHMgdG8gYmUgc3BsaXQgaW50byB0d28gb3IKKyMgbW9y
ZSBHSVQgY29tbWl0cyAocmV2aXNpb24pLiBGb3IgZXhhbXBsZSwgdGhpcyB3
aWxsIGhhcHBlbiBpZiBTVk4gdXNlcgorIyBjb21taXRzIHR3byBicmFuY2hl
cyBhdCBvbmNlLgorc3ViIHN2bnJldl90b19naXRyZXZzKCQpCit7CisgICAg
bXkgJHN2bnJldiA9IHNoaWZ0OworICAgIG15IEBnaXRyZXZzOworICAgIGZv
ciBteSAkYiAoa2V5cyglYnJhbmNoZXMpKSB7CisgICAgICAgIHB1c2ggKEBn
aXRyZXZzLCAkYnJhbmNoZXN7JGJ9eyRzdm5yZXZ9KQorICAgICAgICAgICAg
aWYgZGVmaW5lZCgkYnJhbmNoZXN7JGJ9eyRzdm5yZXZ9KTsKKyAgICB9Cisg
ICAgcmV0dXJuIEBnaXRyZXZzOworfQorCisKIHN1YiBub2RlX2tpbmQoJCQp
IHsKIAlteSAoJHN2bnBhdGgsICRyZXZpc2lvbikgPSBAXzsKIAlteSAkcG9v
bD1TVk46OlBvb2wtPm5ldzsKQEAgLTgxNSw2ICs4NjcsMTkgQEAgc3ViIGNv
bW1pdCB7CiAJCQkJCX0KIAkJCQl9CiAJCQl9CisKKyAgICAgICAgICAgICMg
YWRkIHBhcmVudHMgZnJvbSBleHBsaWNpdCBtZXJnZSBncmFwaCAoLUcpCisg
ICAgICAgICAgICB7CisgICAgICAgICAgICAgICAgbXkgQHN2bnBhcnMgPSBt
ZXJnZV9ncmFwaF9nZXRfcGFyZW50cygkcmV2aXNpb24pOworICAgICAgICAg
ICAgICAgIGZvcmVhY2ggbXkgJHN2bnAgKEBzdm5wYXJzKSB7CisgICAgICAg
ICAgICAgICAgICAgIG15IEBnaXRwYXJzID0gc3ZucmV2X3RvX2dpdHJldnMo
JHN2bnApOworICAgICAgICAgICAgICAgICAgICBmb3JlYWNoIG15ICRnaXRw
IChAZ2l0cGFycykgeworICAgICAgICAgICAgICAgICAgICAgICAgcHVzaCAo
QHBhcmVudHMsICRnaXRwKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICNw
cmludCBPVVQgIk1HOiAkc3ZucCAtbWVyZ2UtPiAkcmV2aXNpb25cbiI7Cisg
ICAgICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAgICAgICB9CisgICAg
ICAgICAgICB9CisKIAkJCW15ICVzZWVuX3BhcmVudHMgPSAoKTsKIAkJCW15
IEB1bmlxdWVfcGFyZW50cyA9IGdyZXAgeyAhICRzZWVuX3BhcmVudHN7JF99
ICsrIH0gQHBhcmVudHM7CiAJCQlmb3JlYWNoIG15ICRicGFyZW50IChAdW5p
cXVlX3BhcmVudHMpIHsKLS0gCjEuNS4xLjMKCgpGcm9tIDcwMDhhMTNmMWZl
MDBmZGJkOTBiZTZhMTJhZDExOTdkY2VlZGFlYmIgTW9uIFNlcCAxNyAwMDow
MDowMCAyMDAxCkZyb206IFN0YXMgTWF4aW1vdiA8c21heGltb3ZAeWFob28u
Y29tPgpEYXRlOiBTdW4sIDI0IEp1biAyMDA3IDE0OjIzOjI5IC0wNzAwClN1
YmplY3Q6IFtQQVRDSF0gRml4ZWQgcGVybWlzc2lvbnMgb2YgRG9jdW1lbnRh
dGlvbi9naXQtc3ZuaW1wb3J0LnR4dAoKClNpZ25lZC1vZmYtYnk6IFN0YXMg
TWF4aW1vdiA8c21heGltb3ZAeWFob28uY29tPgoKZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZ2l0LXN2bmltcG9ydC50eHQgYi9Eb2N1bWVudGF0aW9u
L2dpdC1zdm5pbXBvcnQudHh0Cm9sZCBtb2RlIDEwMDc1NQpuZXcgbW9kZSAx
MDA2NDQKLS0gCjEuNS4xLjMKCg==

--0-4142210-1182726642=:72821--

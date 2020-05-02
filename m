Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B5C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 09:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8F42137B
	for <git@archiver.kernel.org>; Sat,  2 May 2020 09:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgEBJfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 05:35:55 -0400
Received: from smtp3.goneo.de ([85.220.129.37]:40896 "EHLO smtp3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgEBJfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 05:35:55 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 May 2020 05:35:52 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 7509923F8A5;
        Sat,  2 May 2020 11:29:51 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jp9Vyx0bnP06; Sat,  2 May 2020 11:29:49 +0200 (CEST)
Received: from [192.168.177.59] (ip-94-114-210-38.unity-media.net [94.114.210.38])
        by smtp3.goneo.de (Postfix) with ESMTPA id 870EA23F113;
        Sat,  2 May 2020 11:29:49 +0200 (CEST)
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
From:   Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
Subject: [PATCH]v2 GitSVN: Multi line support of ignore-path, include-paths
 and skiping of empty commits
Message-ID: <9e582571-4b82-a46f-5eb2-14d80a4c865e@lpl-mind.de>
Date:   Sat, 2 May 2020 11:29:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2DDA6C20FEEE0157E76789ED"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------2DDA6C20FEEE0157E76789ED
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric,

I used the ignore-paths option to ignore a lot of stuff I don’t need. 
The ignore pattern works well, but it could and up in empty commits. So 
just the message without any modifications / changes. The patch below 
skip a commit if all changes are ignored by the ignore-paths option. In 
order to use this feature I includes the option to read configuration 
for ignore-path, include-paths in several lines. So that the user is not 
limited by the max. char. per line definition.
In Addition this patch includes the optimizations which are mansion from 
your side.


Signed-off-by: Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>

---

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 4b28b87784..fa87687306 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1188,6 +1188,22 @@ sub find_parent_branch {
      return undef;
  }

+############################################################
+
+=item do_fetch()
+
+Fetch an Commit and returns a log entry
+
+Input:  $path - array of strings (Paths) in a commit
+        $rev - Revision number
+
+Output: $log_entry if successfull
+        null if skipped
+        (die) on fetch error
+
+=cut
+
+############################################################
  sub do_fetch {
      my ($self, $paths, $rev) = @_;
      my $ed;
@@ -1212,6 +1228,11 @@ sub do_fetch {
          }
          $ed = Git::SVN::Fetcher->new($self);
      }
+    my $skip = $ed->is_empty_commit($paths);
+    if ($skip){
+        print "skip commit $rev\n";
+        return;
+    }
      unless ($self->ra->gs_do_update($last_rev, $rev, $self, $ed)) {
          die "SVN connection failed somewhere...\n";
      }
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 64e900a0e9..c414aa879f 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -31,15 +31,17 @@ sub new {
      # override options set in an [svn-remote "..."] section
      $repo_id = $git_svn->{repo_id};
      my $k = "svn-remote.$repo_id.ignore-paths";
-    my $v = eval { command_oneline('config', '--get', $k) };
-    $self->{ignore_regex} = $v;
+    my @config = eval { command('config', '--get-all', $k) };
+    chomp(@config); # Replace all \n\r on the end
+    $self->{ignore_regex} = join('', @config);

      $k = "svn-remote.$repo_id.include-paths";
-    $v = eval { command_oneline('config', '--get', $k) };
-    $self->{include_regex} = $v;
+    @config = eval { command_oneline('config', '--get-all', $k) };
+    chomp(@config); # Replace all \n\r on the end
+    $self->{include_regex} = join('', @config);

      $k = "svn-remote.$repo_id.preserve-empty-dirs";
-    $v = eval { command_oneline('config', '--get', '--bool', $k) };
+    my $v = eval { command_oneline('config', '--get', '--bool', $k) };
      if ($v && $v eq 'true') {
          $_preserve_empty_dirs = 1;
          $k = "svn-remote.$repo_id.placeholder-filename";
@@ -137,6 +139,37 @@ sub is_path_ignored {
      return 0;
  }

+############################################################
+
+=item is_empty_commit()
+
+Return 1 if all given $paths are ignored, so that this commit end up in 
an empty commit
+
+Input:  $path - array of strings (Paths) in a commit
+
+Output: { 1 if true, 0 if false }
+
+=cut
+
+############################################################
+sub is_empty_commit{
+    my ($self, $paths) = @_;
+    my $path = "";
+    unless (defined($self->{include_regex})){
+        return 0;
+    }
+
+    foreach $path (keys %$paths){
+        unless (defined $path && -d $path ){
+            my $ignored = $self->is_path_ignored($path);
+            if (!$ignored){
+                return 0;
+            }
+        }
+    }
+    return 1;
+}
+
  sub set_path_strip {
      my ($self, $path) = @_;
      $self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 56ad9870bc..63be69dc12 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -475,6 +475,8 @@ sub gs_fetch_loop_common {
                  my $log_entry = $gs->do_fetch($paths, $r);
                  if ($log_entry) {
                      $gs->do_git_commit($log_entry);
+                }else{
+                    next;
                  }
                  $Git::SVN::INDEX_FILES{$gs->{index}} = 1;
              }


--------------2DDA6C20FEEE0157E76789ED
Content-Type: text/plain; charset=UTF-8;
 name="Git-SVN-EmptyCommits.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Git-SVN-EmptyCommits.diff"

ZGlmZiAtLWdpdCBhL3BlcmwvR2l0L1NWTi5wbSBiL3BlcmwvR2l0L1NWTi5wbQppbmRleCA0
YjI4Yjg3Nzg0Li5mYTg3Njg3MzA2IDEwMDY0NAotLS0gYS9wZXJsL0dpdC9TVk4ucG0KKysr
IGIvcGVybC9HaXQvU1ZOLnBtCkBAIC0xMTg4LDYgKzExODgsMjIgQEAgc3ViIGZpbmRfcGFy
ZW50X2JyYW5jaCB7CiAJcmV0dXJuIHVuZGVmOwogfQogCisjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKKworPWl0ZW0gZG9f
ZmV0Y2goKQorCitGZXRjaCBhbiBDb21taXQgYW5kIHJldHVybnMgYSBsb2cgZW50cnkKKwor
SW5wdXQ6ICAkcGF0aCAtIGFycmF5IG9mIHN0cmluZ3MgKFBhdGhzKSBpbiBhIGNvbW1pdAor
CQkkcmV2IC0gUmV2aXNpb24gbnVtYmVyCisKK091dHB1dDogJGxvZ19lbnRyeSBpZiBzdWNj
ZXNzZnVsbAorCQludWxsIGlmIHNraXBwZWQKKwkJKGRpZSkgb24gZmV0Y2ggZXJyb3IKKwor
PWN1dAorCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKIHN1YiBkb19mZXRjaCB7CiAJbXkgKCRzZWxmLCAkcGF0aHMsICRy
ZXYpID0gQF87CiAJbXkgJGVkOwpAQCAtMTIxMiw2ICsxMjI4LDExIEBAIHN1YiBkb19mZXRj
aCB7CiAJCX0KIAkJJGVkID0gR2l0OjpTVk46OkZldGNoZXItPm5ldygkc2VsZik7CiAJfQor
CW15ICRza2lwID0gJGVkLT5pc19lbXB0eV9jb21taXQoJHBhdGhzKTsKKwlpZiAoJHNraXAp
eworCQlwcmludCAic2tpcCBjb21taXQgJHJldlxuIjsKKwkJcmV0dXJuOworCX0KIAl1bmxl
c3MgKCRzZWxmLT5yYS0+Z3NfZG9fdXBkYXRlKCRsYXN0X3JldiwgJHJldiwgJHNlbGYsICRl
ZCkpIHsKIAkJZGllICJTVk4gY29ubmVjdGlvbiBmYWlsZWQgc29tZXdoZXJlLi4uXG4iOwog
CX0KZGlmZiAtLWdpdCBhL3BlcmwvR2l0L1NWTi9GZXRjaGVyLnBtIGIvcGVybC9HaXQvU1ZO
L0ZldGNoZXIucG0KaW5kZXggNjRlOTAwYTBlOS4uYzQxNGFhODc5ZiAxMDA2NDQKLS0tIGEv
cGVybC9HaXQvU1ZOL0ZldGNoZXIucG0KKysrIGIvcGVybC9HaXQvU1ZOL0ZldGNoZXIucG0K
QEAgLTMxLDE1ICszMSwxNyBAQCBzdWIgbmV3IHsKIAkjIG92ZXJyaWRlIG9wdGlvbnMgc2V0
IGluIGFuIFtzdm4tcmVtb3RlICIuLi4iXSBzZWN0aW9uCiAJJHJlcG9faWQgPSAkZ2l0X3N2
bi0+e3JlcG9faWR9OwogCW15ICRrID0gInN2bi1yZW1vdGUuJHJlcG9faWQuaWdub3JlLXBh
dGhzIjsKLQlteSAkdiA9IGV2YWwgeyBjb21tYW5kX29uZWxpbmUoJ2NvbmZpZycsICctLWdl
dCcsICRrKSB9OwotCSRzZWxmLT57aWdub3JlX3JlZ2V4fSA9ICR2OworCW15IEBjb25maWcg
PSBldmFsIHsgY29tbWFuZCgnY29uZmlnJywgJy0tZ2V0LWFsbCcsICRrKSB9OworCWNob21w
KEBjb25maWcpOyAjIFJlcGxhY2UgYWxsIFxuXHIgb24gdGhlIGVuZAorCSRzZWxmLT57aWdu
b3JlX3JlZ2V4fSA9IGpvaW4oJycsIEBjb25maWcpOwogCiAJJGsgPSAic3ZuLXJlbW90ZS4k
cmVwb19pZC5pbmNsdWRlLXBhdGhzIjsKLQkkdiA9IGV2YWwgeyBjb21tYW5kX29uZWxpbmUo
J2NvbmZpZycsICctLWdldCcsICRrKSB9OwotCSRzZWxmLT57aW5jbHVkZV9yZWdleH0gPSAk
djsKKwlAY29uZmlnID0gZXZhbCB7IGNvbW1hbmRfb25lbGluZSgnY29uZmlnJywgJy0tZ2V0
LWFsbCcsICRrKSB9OworCWNob21wKEBjb25maWcpOyAjIFJlcGxhY2UgYWxsIFxuXHIgb24g
dGhlIGVuZAorCSRzZWxmLT57aW5jbHVkZV9yZWdleH0gPSBqb2luKCcnLCBAY29uZmlnKTsK
IAogCSRrID0gInN2bi1yZW1vdGUuJHJlcG9faWQucHJlc2VydmUtZW1wdHktZGlycyI7Ci0J
JHYgPSBldmFsIHsgY29tbWFuZF9vbmVsaW5lKCdjb25maWcnLCAnLS1nZXQnLCAnLS1ib29s
JywgJGspIH07CisJbXkgJHYgPSBldmFsIHsgY29tbWFuZF9vbmVsaW5lKCdjb25maWcnLCAn
LS1nZXQnLCAnLS1ib29sJywgJGspIH07CiAJaWYgKCR2ICYmICR2IGVxICd0cnVlJykgewog
CQkkX3ByZXNlcnZlX2VtcHR5X2RpcnMgPSAxOwogCQkkayA9ICJzdm4tcmVtb3RlLiRyZXBv
X2lkLnBsYWNlaG9sZGVyLWZpbGVuYW1lIjsKQEAgLTEzNyw2ICsxMzksMzcgQEAgc3ViIGlz
X3BhdGhfaWdub3JlZCB7CiAJcmV0dXJuIDA7CiB9CiAKKyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIworCis9aXRlbSBpc19l
bXB0eV9jb21taXQoKQorCitSZXR1cm4gMSBpZiBhbGwgZ2l2ZW4gJHBhdGhzIGFyZSBpZ25v
cmVkLCBzbyB0aGF0IHRoaXMgY29tbWl0IGVuZCB1cCBpbiBhbiBlbXB0eSBjb21taXQKKwor
SW5wdXQ6ICAkcGF0aCAtIGFycmF5IG9mIHN0cmluZ3MgKFBhdGhzKSBpbiBhIGNvbW1pdAor
CitPdXRwdXQ6IHsgMSBpZiB0cnVlLCAwIGlmIGZhbHNlIH0KKworPWN1dAorCisjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
K3N1YiBpc19lbXB0eV9jb21taXR7CisJbXkgKCRzZWxmLCAkcGF0aHMpID0gQF87CisJbXkg
JHBhdGggPSAiIjsKKwl1bmxlc3MgKGRlZmluZWQoJHNlbGYtPntpbmNsdWRlX3JlZ2V4fSkp
eworCQlyZXR1cm4gMDsKKwl9CisKKwlmb3JlYWNoICRwYXRoIChrZXlzICUkcGF0aHMpewor
CQl1bmxlc3MgKGRlZmluZWQgJHBhdGggJiYgLWQgJHBhdGggKXsKKwkJCW15ICRpZ25vcmVk
ID0gJHNlbGYtPmlzX3BhdGhfaWdub3JlZCgkcGF0aCk7CisJCQlpZiAoISRpZ25vcmVkKXsK
KwkJCQlyZXR1cm4gMDsKKwkJCX0KKwkJfQorCX0KKwlyZXR1cm4gMTsKK30KKwogc3ViIHNl
dF9wYXRoX3N0cmlwIHsKIAlteSAoJHNlbGYsICRwYXRoKSA9IEBfOwogCSRzZWxmLT57cGF0
aF9zdHJpcH0gPSBxci9eXFEkcGF0aFxFKFwvfCQpLyBpZiBsZW5ndGggJHBhdGg7CmRpZmYg
LS1naXQgYS9wZXJsL0dpdC9TVk4vUmEucG0gYi9wZXJsL0dpdC9TVk4vUmEucG0KaW5kZXgg
NTZhZDk4NzBiYy4uNjNiZTY5ZGMxMiAxMDA2NDQKLS0tIGEvcGVybC9HaXQvU1ZOL1JhLnBt
CisrKyBiL3BlcmwvR2l0L1NWTi9SYS5wbQpAQCAtNDc1LDYgKzQ3NSw4IEBAIHN1YiBnc19m
ZXRjaF9sb29wX2NvbW1vbiB7CiAJCQkJbXkgJGxvZ19lbnRyeSA9ICRncy0+ZG9fZmV0Y2go
JHBhdGhzLCAkcik7CiAJCQkJaWYgKCRsb2dfZW50cnkpIHsKIAkJCQkJJGdzLT5kb19naXRf
Y29tbWl0KCRsb2dfZW50cnkpOworCQkJCX1lbHNleworCQkJCQluZXh0OwogCQkJCX0KIAkJ
CQkkR2l0OjpTVk46OklOREVYX0ZJTEVTeyRncy0+e2luZGV4fX0gPSAxOwogCQkJfQo=
--------------2DDA6C20FEEE0157E76789ED--

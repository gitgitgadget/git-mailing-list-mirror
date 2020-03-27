Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAE9C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06120714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgC0INd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:13:33 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:49480 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgC0INc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 04:13:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id D8C4F23EFE7;
        Fri, 27 Mar 2020 09:13:29 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AgGEaWkp-KfO; Fri, 27 Mar 2020 09:13:28 +0100 (CET)
Received: from [192.168.177.59] (ip-88-153-12-55.hsi04.unitymediagroup.de [88.153.12.55])
        by smtp3.goneo.de (Postfix) with ESMTPA id 7497323F9E6;
        Fri, 27 Mar 2020 09:13:28 +0100 (CET)
Subject: git-svn: Skip commit if all items of a commit are ignored by ignore
 configuration
References: <b20ed6ca-1283-fb6d-a00c-94557218e01c@lpl-mind.de>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, normalperson@yhbt.net
From:   Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
X-Forwarded-Message-Id: <b20ed6ca-1283-fb6d-a00c-94557218e01c@lpl-mind.de>
Message-ID: <1467670a-a9eb-f230-4ec0-bd6d54411a69@lpl-mind.de>
Date:   Fri, 27 Mar 2020 09:13:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b20ed6ca-1283-fb6d-a00c-94557218e01c@lpl-mind.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I used the ignore-paths option to ignore a lot of stuff I don’t need. 
The ignore pattern works well, but it could and up in empty commits. So 
just the message without any modifications / changes. The patch below 
skip a commit if all changes are ignored by the ignore-paths option.


Signed-off-by: Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>

---
  perl/Git/SVN/Ra.pm | 32 +++++++++++++++++++++++++++++---
  1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 56ad9870bc..a5a6c0b774 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -457,13 +457,22 @@ sub gs_fetch_loop_common {
              $find_trailing_edge = 0;
          }
          $SVN::Error::handler = $err_handler;
-
+
          my %exists = map { $_->path => $_ } @$gsv;
          foreach my $r (sort {$a <=> $b} keys %revs) {
              my ($paths, $logged) = @{delete $revs{$r}};
-
              foreach my $gs ($self->match_globs(\%exists, $paths,
                                                 $globs, $r)) {
+
+
+                my $fetcher=Git::SVN::Fetcher->new($gs);
+
+                my $skip=$self->is_empty_commit($paths,$fetcher);
+                if ($skip){
+                    print "skip commit $r\n";
+                    next;
+                }
+                $fetcher->close_edit();
                  if ($gs->rev_map_max >= $r) {
                      next;
                  }
@@ -506,6 +517,21 @@ sub gs_fetch_loop_common {
Git::SVN::gc();
  }

+sub is_empty_commit{
+    my ($self, $paths,$fetcher) = @_;
+    my $path="";
+    foreach $path (keys %$paths){
+        unless (defined $path && -d $path ){
+            my $ignored=$fetcher->is_path_ignored($path);
+            if (!$ignored){
+                return 0;
+            }
+        }
+    }
+    return 1;
+}
+
+
  sub get_dir_globbed {
      my ($self, $left, $depth, $r) = @_;

-- 
2.25.1.windows.1


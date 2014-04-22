From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 04:16:22 -0700
Message-ID: <475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 13:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcYgu-0004Gw-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 13:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbaDVLQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 07:16:35 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:55930 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260AbaDVLQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 07:16:33 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so4792906pbc.6
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B7n+86w3ASo+4xW/tMEdoGoLNH+j4W46CRRu2zGudx8=;
        b=Z48kccZNv6lc4Kg8KxoKVoxH3jhXFoWehWtSAYMKhMnEkGDhdhuvIq/QueN7urB+E+
         b5I5hx3gFXlt67HM9f75WfJ1SGqOn2q3K8eNzfl2hSAoBAFfpXseKMlmoQGEwHMHFv1S
         xnCVYXWxiprkrQGU9eQns/tLpLzltqXnE7CMyEHte6kvgs1ijegwi4pX4ptZwh0swyMd
         kL5xHTr0O3tdMOYQ4Mh5P4DoJRdEJzOUD7uP3MWyImPlUgkJilaV2kOeAeczHSps2El9
         B3+gZSLhp9B8Vg3nE0tkNdlbvuCeuhG4CaTYf1lzJB4X8JFxzzAcxZQCiF8KTFxIWSEE
         Tanw==
X-Received: by 10.68.190.163 with SMTP id gr3mr43457326pbc.103.1398165392432;
        Tue, 22 Apr 2014 04:16:32 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kl1sm84181282pbd.73.2014.04.22.04.16.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 04:16:31 -0700 (PDT)
In-Reply-To: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246730>

On Apr 18, 2014, at 12:37, Junio C Hamano wrote:
> An early preview release Git v2.0.0-rc0 is now available for
> testing at the usual places.

I have run into the following test failures with v2.0.0-rc0:

Test Summary Report
-------------------
t9117-git-svn-init-clone.sh              (Wstat: 256 Tests: 11 Failed: 2)
   Failed tests:  10-11
   Non-zero exit status: 1
Files=658, Tests=11878, 3684 wallclock secs
Result: FAIL

The cause of the failure in both tests is this:

  $ git svn init -s "$svnrepo"/project project --prefix=""
  Option prefix requires an argument

The problem with --prefix="" is this (from the Getopt::Long CHANGES file):

Changes in version 2.37
-----------------------

 * Bugfix: With gnu_compat, --foo= will no longer trigger "Option
   requires an argument" but return the empty string.

The system I ran the tests on happens to have Getopt::Long version 2.35.

The --prefix="" option can be rewritten --prefix "" in both tests and then  
they pass.

Alternatively this change can be made in git-svn.perl:

|diff --git a/git-svn.perl b/git-svn.perl
|index 7349ffea..284f458a 100755
|--- a/git-svn.perl
|+++ b/git-svn.perl
|@@ -149,7 +149,7 @@ my ($_trunk, @_tags, @_branches, $_stdlayout);
  my %icv;
  my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                    'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
-                  'branches|b=s@' => \@_branches, 'prefix=s' => \$_prefix,
+                  'branches|b=s@' => \@_branches, 'prefix:s' => \$_prefix,
                    'stdlayout|s' => \$_stdlayout,
                    'minimize-url|m!' => \$Git::SVN::_minimize_url,
                   'no-metadata' => sub { $icv{noMetadata} = 1 },

Which makes the argument to --prefix optional (in which case it is set  
to "").

I'm not really sure what the best thing to do here is.  I thought the  
documentation talked somewhere about using --prefix="" (or just --prefix=)
to get the old behavior, but now I can't find that.  In that  
case I think probably just changing the tests to use --prefix ""  
instead of --prefix="" should take care of it especially since the log  
message for fe191fca (which actually changes the default) talks about  
using --prefix "" and not --prefix="".  I have attached a patch below  
(against master) to make that change to the two affected subtests of t9117.

--Kyle

---- >8 ----
Subject: [PATCH] t9117: use --prefix "" instead of --prefix=""

Versions of Perl's Getopt::Long module before 2.37 do not contain
this fix that first appeared in Getopt::Long version 2.37:

* Bugfix: With gnu_compat, --foo= will no longer trigger "Option
  requires an argument" but return the empty string.

Instead of using --prefix="" use --prefix "" when testing an
explictly empty prefix string in order to work with older versions
of Perl's Getopt::Long module.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 t/t9117-git-svn-init-clone.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index dfed76fe..a66f43c6 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -101,18 +101,18 @@ test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
 	rm -f warning
 	'
 
-test_expect_success 'init with -s/-T/-b/-t and --prefix="" still works' '
+test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
 	test ! -d project &&
-	git svn init -s "$svnrepo"/project project --prefix="" 2>warning &&
+	git svn init -s "$svnrepo"/project project --prefix "" 2>warning &&
 	test_must_fail grep -q prefix warning &&
 	test_svn_configured_prefix "" &&
 	rm -rf project &&
 	rm -f warning
 	'
 
-test_expect_success 'clone with -s/-T/-b/-t and --prefix="" still works' '
+test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
 	test ! -d project &&
-	git svn clone -s "$svnrepo"/project --prefix="" 2>warning &&
+	git svn clone -s "$svnrepo"/project --prefix "" 2>warning &&
 	test_must_fail grep -q prefix warning &&
 	test_svn_configured_prefix "" &&
 	rm -rf project &&
-- 
1.8.5

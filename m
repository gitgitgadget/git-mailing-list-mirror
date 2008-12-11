From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3 (edit v2)] gitweb: Cache $parent_commit info in git_blame()
Date: Thu, 11 Dec 2008 01:33:29 +0100
Message-ID: <200812110133.33124.jnareb@gmail.com>
References: <20081209224622.28106.89325.stgit@localhost.localdomain> <200812101439.18526.jnareb@gmail.com> <7v7i67zsgj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Luben Tuikov <ltuikov@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZWP-0004H5-Ab
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbYLKAdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbYLKAdh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:33:37 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:55042 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbYLKAdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:33:36 -0500
Received: by ewy10 with SMTP id 10so1102535ewy.13
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 16:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GxpmH/V3f6mEpEENroSaLAZPzGxlssjfJey5Qd5yHN8=;
        b=JtvsA1qcgDCh72i6JYSgGIFZouztpWo8iKGCh87olSwY2XFJY1T5Xh8PM9B00DdUBs
         29MHK96ri9T90SL7/UMwFc3UWACSL+oj8qkq3QVJunTWxU+LusyO+iZjJamQyggQ8X3W
         kM4fhRkI+rno8rEwTbDCIl8tNaqzdgJIINzfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kuHonSOVS08peqSLPOhykMpV7Zqg1jdJdiSEi+etmTBWMpsvKog7UPcAKOYqMaVV0q
         B4Hj5U4WWc/xl9ehdeVwQpCyW1+cN/HvO1mGH737/uJGHnijQ9GrvdIAYUMTuE5jrvPV
         4S9If3nvvV4qsNH4je5ZUzQHhAy0LbLcVKDKo=
Received: by 10.210.124.8 with SMTP id w8mr2420962ebc.92.1228955614114;
        Wed, 10 Dec 2008 16:33:34 -0800 (PST)
Received: from ?192.168.1.11? (abxf60.neoplus.adsl.tpnet.pl [83.8.255.60])
        by mx.google.com with ESMTPS id 5sm32863eyh.47.2008.12.10.16.33.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 16:33:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7i67zsgj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102754>

Luben Tuikov changed 'lineno' link from leading to commit which gave
current version of given block of lines, to leading to parent of this
commit in 244a70e (Blame "linenr" link jumps to previous state at
"orig_lineno").  This made possible data mining using 'blame' view.

The current implementation calls rev-parse once per each blamed line
to find parent revision of blamed commit, even when the same commit
appears more than once, which is inefficient.

This patch attempts to mitigate this issue by storing (caching)
$parent_commit info in %metainfo, which makes gitweb call
git-rev-parse only once per each unique commit in blame output.


In the tables below you can see simple benchmark comparing gitweb
performance before and after this patch

File               | L[1] | C[2] || Time0[3] | Before[4] | After[4]
====================================================================
blob.h             |   18 |    4 || 0m1.727s |  0m2.545s |  0m2.474s
GIT-VERSION-GEN    |   42 |   13 || 0m2.165s |  0m2.448s |  0m2.071s
README             |   46 |    6 || 0m1.593s |  0m2.727s |  0m2.242s
revision.c         | 1923 |  121 || 0m2.357s | 0m30.365s |  0m7.028s
gitweb/gitweb.perl | 6291 |  428 || 0m8.080s | 1m37.244s | 0m20.627s

File               | L/C  | Before/After
=========================================
blob.h             |  4.5 |         1.03
GIT-VERSION-GEN    |  3.2 |         1.18
README             |  7.7 |         1.22
revision.c         | 15.9 |         4.32
gitweb/gitweb.perl | 14.7 |         4.71

As you can see the greater ratio of lines in file to unique commits
in blame output, the greater gain from the new implementation.

Footnotes:
~~~~~~~~~~
[1] Lines:
    $ wc -l <file>
[2] Individual commits in blame output:
    $ git blame -p <file> | grep author-time | wc -l
[3] Time for running "git blame -p" (user time, single run):
    $ time git blame -p <file> >/dev/null
[4] Time to run gitweb as Perl script from command line:
    $ gitweb-run.sh "p=.git;a=blame;f=<file>" > /dev/null 2>&1

The gitweb-run.sh script includes slightly modified (with adjusted
pathnames) code from gitweb_run() function from the test script
t/t9500-gitweb-standalone-no-errors.sh; gitweb config file
gitweb_config.perl contents (again up to adjusting pathnames; in
particular $projectroot variable should point to top directory of git
repository) can be found in the same place.


Alternate solutions:
~~~~~~~~~~~~~~~~~~~~
Alternate solution would be to open bidi pipe to "git cat-file
--batch-check", (like in Git::Repo in gitweb caching by Lea Wiemann),
feed $long_rev^ to it, and parse its output which has the following
form:

  926b07e694599d86cec668475071b32147c95034 commit 637

This would mean one call to git-cat-file for the whole 'blame' view,
instead of one call to git-rev-parse per each unique commit in blame
output.


Yet another solution would be to change use of validate_refname() to
validate_revision() when checking script parameters (CGI query or
path_info), with validate_revision being something like the following:

  sub validate_revision {
        my $rev = shift;
        return validate_refname(strip_rev_suffixes($rev));
  }

so we don't need to calculate $long_rev^, but can pass "$long_rev^" as
'hb' parameter.

This solution has the advantage that it can be easily adapted to
future incremental blame output.

Acked-by: Luben Tuikov <ltuikov@yahoo.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Wed, 10 Dec 2008, Junio C Hamano wrote:

> To recap, I think the commit log for this patch would have been much
> easier to read if it were presented in this order:
> 
>         a paragraph to establish the context;
> 
>         a paragraph to state what problem it tries to solve;
> 
>         a paragraph (or more) to explain the solution; and finally
> 
>         a paragraph to discuss possible future enhancements.

Like this?

Only commit message has changed.

 gitweb/gitweb.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b800f4..916396a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4657,11 +4657,17 @@ HTML
 			              esc_html($rev));
 			print "</td>\n";
 		}
-		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-			or die_error(500, "Open git-rev-parse failed");
-		my $parent_commit = <$dd>;
-		close $dd;
-		chomp($parent_commit);
+		my $parent_commit;
+		if (!exists $meta->{'parent'}) {
+			open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
+				or die_error(500, "Open git-rev-parse failed");
+			$parent_commit = <$dd>;
+			close $dd;
+			chomp($parent_commit);
+			$meta->{'parent'} = $parent_commit;
+		} else {
+			$parent_commit = $meta->{'parent'};
+		}
 		my $blamed = href(action => 'blame',
 		                  file_name => $meta->{'filename'},
 		                  hash_base => $parent_commit);
-- 
1.6.0.4

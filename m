From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be
 cached
Date: Wed, 13 Aug 2008 13:38:23 -0700
Message-ID: <7vskt8mz0g.fsf@gitster.siamese.dyndns.org>
References: <489DBB8A.2060207@griep.us>
 <1218470035-13864-1-git-send-email-marcus@griep.us>
 <1218470035-13864-2-git-send-email-marcus@griep.us>
 <48A33E70.8060804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTN85-0002Dk-KL
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYHMUie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYHMUie
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:38:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYHMUid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:38:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A5235876B;
	Wed, 13 Aug 2008 16:38:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 04B8B5875B; Wed, 13 Aug 2008 16:38:25 -0400 (EDT)
In-Reply-To: <48A33E70.8060804@gmail.com> (Lea Wiemann's message of "Wed, 13
 Aug 2008 22:05:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CACD23DE-6977-11DD-AA0D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92267>

Lea Wiemann <lewiemann@gmail.com> writes:

> Marcus Griep wrote:
>> diff --git a/perl/Git.pm b/perl/Git.pm
>>
>> +require File::Spec;
>
> This makes Git.pm dependent on Perl 5.6.1.

Ouch.  Thanks for being extra careful.

Unfortunately I've already pulled these changes via Eric.

Among the existing Perl scripts, cvsexportcommit and cvsimport already do
use it, so do svnimport and cidaemon in contrib.

> ...  Hence to avoid
> complaints about failing tests, I suggest that you add a check for
> File::Spec availability at the beginning of any test that (indirectly)
> uses Git.pm.

Hmm, wouldn't something like this (untested) be more contained?

---
 perl/Git.pm |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 405f68f..2a92945 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -95,14 +95,26 @@ increase notwithstanding).
 
 =cut
 
+my $tmpdir;
 
 use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path);
 use IPC::Open2 qw(open2);
 use File::Temp ();
-require File::Spec;
 use Fcntl qw(SEEK_SET SEEK_CUR);
+
+	eval { require File::Spec; };
+	if ($@) {
+		for (@ENV{qw(TMPDIR TEMP TMP)}, "/tmp") {
+			if (test -d $_) {
+				$tmpdir = $_;
+				last;
+			}
+		}
+	} else {
+		$tmpdir = File::Spec->tmpdir;
+	}
 }
 
 
@@ -1023,7 +1035,7 @@ sub _temp_cache {
 		}
 		$$temp_fd = File::Temp->new(
 			TEMPLATE => 'Git_XXXXXX',
-			DIR => File::Spec->tmpdir
+			DIR => $tmpdir,
 			) or throw Error::Simple("couldn't open new temp file");
 		$$temp_fd->autoflush;
 		binmode $$temp_fd;

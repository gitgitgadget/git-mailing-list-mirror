From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] diff: disable compaction heuristic for now
Date: Fri, 10 Jun 2016 13:48:58 -0700
Message-ID: <xmqqoa78epmt.fsf_-_@gitster.mtv.corp.google.com>
References: <20160610075043.GA13411@sigill.intra.peff.net>
	<20160610083102.GA14192@sigill.intra.peff.net>
	<xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
	<CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
	<xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
	<20160610203026.GA21464@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:49:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBTMc-0004Hf-4i
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbcFJUtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:49:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932300AbcFJUtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:49:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF04A2289A;
	Fri, 10 Jun 2016 16:49:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hr2lJRahY89gTz6nSRy7M5/SoVA=; b=cdnnFy
	SMfm/S1kunLXbac5+jPfkExBcLNZGlxhttvHj3AozCV2+KNdeRldfVcw7osXu7In
	iRyMSLhbTxztVRyjDt2iMIE4tJvXoV1MjMh5/K27YHMKE6suPZYi/uC1+EG4rBd0
	YK6d62tXifwOS+56Efp5iNS7vhopzAkffYmDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FLCv3xtWtJLtq8PFxMxh3p0p55qkQ2IT
	djkq1bWySK2QEg+5AHt/XLpWy3vUNJA8TI82ZmiSpZDr8lcJ3PXYqFe/pwt0g7De
	CmmuD/iOOKvoFQGnzj08l7v4LQhhmrFjkJ2/2HedfnTE2VoGm2DlpWDegsjWmouE
	pM9NhNcCrTo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A01122898;
	Fri, 10 Jun 2016 16:49:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCFD522897;
	Fri, 10 Jun 2016 16:48:59 -0400 (EDT)
In-Reply-To: <20160610203026.GA21464@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 10 Jun 2016 16:30:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1E71A7E-2F4C-11E6-9415-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297071>

http://lkml.kernel.org/g/20160610075043.GA13411@sigill.intra.peff.net
reports that a change to add a new "function" with common ending
with the existing one at the end of the file is shown like this:

    def foo
      do_foo_stuff()

   +  common_ending()
   +end
   +
   +def bar
   +  do_bar_stuff()
   +
      common_ending()
    end

when the new heuristic is in use.  In reality, the change is to add
the blank line before "def bar" and everything below, which is what
the code without the new heuristic shows.

Disable the heuristics by default, and resurrect the documentation
for the option and the configuration variables, while clearly
marking the feature as still experimental.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Jeff King <peff@peff.net> writes:

    > We probably want a patch to the release notes to note that it's not on
    > by default. And we may want to advertise the experimental knob so
    > that people actually try it (otherwise we won't get feedback from the
    > masses).

    OK, I think that is sensible.  The interdiff is not a strict
    reversion of 77085a61 (diff: undocument the compaction heuristic
    knobs for experimentation, 2016-05-02) but stresses that the
    feature is off by default and is experimental.

 Documentation/diff-config.txt  | 5 +++++
 Documentation/diff-options.txt | 7 +++++++
 diff.c                         | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6eaa452..6fb70c5 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -166,6 +166,11 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
+diff.compactionHeuristic::
+	Set this option to `true` to enable an experimental heuristic that
+	shifts the hunk boundary in an attempt to make the resulting
+	patch easier to read.
+
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
 +
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3ad6404..9baf1ad 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,6 +63,13 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
+--compaction-heuristic::
+--no-compaction-heuristic::
+	These are to help debugging and tuning an experimental
+	heuristic (which is off by default) that shifts the hunk
+	boundary in an attempt to make the resulting patch easier
+	to read.
+
 --minimal::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
diff --git a/diff.c b/diff.c
index 05ca3ce..9116d9d 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_compaction_heuristic = 1;
+static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
-- 
2.9.0-rc2-285-ge226c12

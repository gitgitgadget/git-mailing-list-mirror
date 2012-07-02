From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame gives an ambiguous short revision
Date: Mon, 02 Jul 2012 00:54:00 -0700
Message-ID: <7v8vf238fb.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1207010825370.1873@hadrien>
 <7vipe63a4r.fsf@alter.siamese.dyndns.org>
 <7vehou39mk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julia Lawall <julia.lawall@lip6.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 09:54:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlbSU-0006If-GK
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 09:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab2GBHyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 03:54:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab2GBHyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 03:54:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ECA5689B;
	Mon,  2 Jul 2012 03:54:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=28pSNgg6ug9vHOxJfJGtDnQyXGA=; b=msKbjY
	wPlvGXcEvEAixNd2PKYTZqvl4Nj0wLSH4e77e2/RsDvSf2qyFHnRTIgn/jGRajsL
	JUz7CbfNa7ycBtUtCwnWdaw2m5DRFW17SL300UoYrqUngu44cvTM+zyKLWL0RyjK
	iA4/EH3UmuJ3UG37WZyYOWJqjmZR4TSCBiK9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wxi7xit3ekp+DOdm0L0Cn8wmeJ7ecai+
	sfXQdN5hTWaah2TgAoUgPrLi1hXAMyWRRMHdvqivERJbTsf4AbrSaZaqTY/FDV+f
	Ny7I8Lr6Ecgtjk7X/QkMHrMkjDW/9Fp+koGarc4ROp8/NzfxyJTRKcINZQRpoBox
	Tz5J58mp4WU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84E186899;
	Mon,  2 Jul 2012 03:54:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F138D6898; Mon,  2 Jul 2012
 03:54:01 -0400 (EDT)
In-Reply-To: <7vehou39mk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 Jul 2012 00:28:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1696FDBA-C41B-11E1-8728-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200849>

Junio C Hamano <gitster@pobox.com> writes:

> Something like this, perhaps, but I didn't test the patch beyond "it
> compiles".

OK, now I tested it ;-)  I'll queue this and eventually merge down
to older maintenance releases.

-- >8 --
Subject: [PATCH] blame: compute abbreviation width that ensures uniqueness

Julia Lawall noticed that in linux-next repository the commit object
60d5c9f5 (shown with the default abbreviation width baked into "git
blame") in output from

  $ git blame -L 3675,3675 60d5c9f5b -- \
      drivers/staging/brcm80211/brcmfmac/wl_iw.c

is no longer unique in the repository, which results in "short SHA1
60d5c9f5 is ambiguous".

Compute the minimum abbreviation width that ensures uniqueness when
the user did not specify the --abbrev option to avoid this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Incidentally, "git show v2.6.39-rc4-181-g60d5c9f5" is resolved
correctly with the recent "prolong the shelf-life of decribed name"
topic that will hopefully be ready by the next release, and it
resolves even shorter "v2.6.39-rc4-181-g60d5c" just fine ;-).

 builtin/blame.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 3e1f7e1..f13ec32 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1828,6 +1828,16 @@ static int read_ancestry(const char *graft_file)
 	return 0;
 }
 
+static int update_auto_abbrev(int auto_abbrev, struct origin *suspect)
+{
+	const char *uniq = find_unique_abbrev(suspect->commit->object.sha1,
+					      auto_abbrev);
+	int len = strlen(uniq);
+	if (auto_abbrev < len)
+		return len;
+	return auto_abbrev;
+}
+
 /*
  * How many columns do we need to show line numbers in decimal?
  */
@@ -1850,12 +1860,16 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	int longest_dst_lines = 0;
 	unsigned largest_score = 0;
 	struct blame_entry *e;
+	int compute_auto_abbrev = (abbrev < 0);
+	int auto_abbrev = default_abbrev;
 
 	for (e = sb->ent; e; e = e->next) {
 		struct origin *suspect = e->suspect;
 		struct commit_info ci;
 		int num;
 
+		if (compute_auto_abbrev)
+			auto_abbrev = update_auto_abbrev(auto_abbrev, suspect);
 		if (strcmp(suspect->path, sb->path))
 			*option |= OUTPUT_SHOW_NAME;
 		num = strlen(suspect->path);
@@ -1883,6 +1897,10 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	max_orig_digits = lineno_width(longest_src_lines);
 	max_digits = lineno_width(longest_dst_lines);
 	max_score_digits = lineno_width(largest_score);
+
+	if (compute_auto_abbrev)
+		/* one more abbrev length is needed for the boundary commit */
+		abbrev = auto_abbrev + 1;
 }
 
 /*
@@ -2360,10 +2378,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
-	if (abbrev == -1)
-		abbrev = default_abbrev;
-	/* one more abbrev length is needed for the boundary commit */
-	abbrev++;
+	if (0 < abbrev)
+		/* one more abbrev length is needed for the boundary commit */
+		abbrev++;
 
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
-- 
1.7.11.1.212.g52fe12e

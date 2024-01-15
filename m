Received: from tilde.club (tilde.club [142.44.150.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AD18C03
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tilde.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tilde.club
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tilde.club header.i=@tilde.club header.b="amuw6xd/"
Received: from tilde.club (v220231110654243279.goodsrv.de [188.172.229.15])
	by tilde.club (Postfix) with ESMTPSA id 49675221446D7
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 19:40:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 49675221446D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
	t=1705347655; bh=a5L+g8GYz7P+WiIQ4FonPVKHmc1VO/wubBALEE6Wnao=;
	h=Date:From:To:Subject:From;
	b=amuw6xd/SBYTMIYJSRljpd+6N112NkieO3gmonnScBImqcr2/ySY6s1VkH2wl3Nrg
	 YDBMlt5/djKQd3S5aNJ6i219C9vcusy0+GjeR7Icr+qXSDGWVP3PPvYv2WkXw30Gz/
	 SIVSg4gFbypU9NcEBuFKdXl9JnzjZmqQqOHRq42k=
Date: Mon, 15 Jan 2024 19:40:36 +0000
From: Gwyneth Morgan <gwymor@tilde.club>
To: git@vger.kernel.org
Subject: git-range-diff ignoring commit message changes
Message-ID: <ZaWKNI5qLPf4P75A@tilde.club>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Is there a way to make git-range-diff to ignore commit messages when
considering if commits are identical? When range-diffing long series
there are cases where I would like to check at a glance whether the code
has changed, and only when the code has changed do I want to see the
change in commit message too.

It seems I can approximate what I want by tweaking range-diff's source
like this but I couldn't tell if there was an actual option:

diff --git a/range-diff.c b/range-diff.c
index c45b6d849c..fd421b7b99 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -59,7 +59,7 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--output-indicator-old=<",
 		     "--output-indicator-context=#",
 		     "--no-abbrev-commit",
-		     "--pretty=medium",
+		     "--pretty=format:commit %H",
 		     "--show-notes-by-default",
 		     NULL);
 	strvec_push(&cp.args, range);

This ignores commit message changes entirely, but it would be nice to
have an option to only see commit message changes when the code diff has
changed. It would also be convenient to have a way to only consider
changes in the title of commits but ignore the message body (equivalent
to "--pretty=short" above).

You could get some of this information with git-cherry, but that is
suited for different uses (only cares about new commits on one side,
doesn't show diffs) and would take more effort than just ignoring the
commit messages in the current range-diff output.

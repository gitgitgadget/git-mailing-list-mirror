From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/clone.c: detect a clone starting at a tag correctly
Date: Mon, 23 Jun 2014 14:32:51 -0700
Message-ID: <xmqqk387b9bw.fsf_-_@gitster.dls.corp.google.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618194417.GD22622@sigill.intra.peff.net>
	<xmqq1tufcvfl.fsf@gitster.dls.corp.google.com>
	<20140623210755.GA15766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 23:33:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzBrL-0004M7-RB
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 23:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaFWVc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 17:32:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59485 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbaFWVc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 17:32:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0A3323776;
	Mon, 23 Jun 2014 17:32:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TdhbXTJR3BfEC1p9YVOngfG0Ssc=; b=Z/PwFJ
	6uKqw5EBZXcZti98iiScEAi9kmvxQsPxZLRvLGf32rUA93b2d+z1OPIbwgDa1Kjd
	s9PxXZvCrtIqrWc2ih8+LHUqBMbcgB2Tik+9LSS8OzUKZ2Y0yzmYh5+MkY0fJjKw
	Im7bmk8vDrOJoefjTDEO0Y4S/AkU5bmTjyTl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qcrK5H4nAQpHFxcU0qA5lO8WsXfNdu2j
	4frj2izRhdut+RA1TASD1OKJo2dcXaWN7UMHY938qAr8zlAo3AIoqGyPN07TqxsK
	r2X9ZvxBEOxs1pdM5fDkPvmQ1DW6StL49fMUwEZMekUbEV2SoivJdlftlQcyOdcR
	WBpB+Y7kB4A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D716723775;
	Mon, 23 Jun 2014 17:32:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 16E6723772;
	Mon, 23 Jun 2014 17:32:49 -0400 (EDT)
In-Reply-To: <20140623210755.GA15766@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 23 Jun 2014 17:07:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EC7630DC-FB1D-11E3-B09F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252371>

31b808a0 (clone --single: limit the fetch refspec to fetched branch,
2012-09-20) tried to see if the given "branch" to follow is actually
a tag at the remote repository by checking with "refs/tags/" but it
incorrectly used strstr(3); it is actively wrong to treat a "branch"
"refs/heads/refs/tags/foo" and use the logic for the "refs/tags/"
ref hierarchy.  What the code really wanted to do is to see if it
starts with "refs/tags/".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Jeff King <peff@peff.net> writes:

  >> Because the pattern is not anchored to the left with a slash, it is
  >> clear that the original cannot even claim that it was trying to
  >> munge "foo/refs/tags/" as well.
  >
  > Yeah, the strstr seems very wrong there. Even with the "/", why would
  > you want to match "refs/heads/refs/tags/"?
  >
  >> Which means this is trivially correct, but at the same time I wonder
  >> what it means for our-head to point at a ref in refs/tags/ hierarchy.
  >
  > I think it is for "git clone --branch=v1.0". We create a refspec pulling
  > v1.0 to its local tag in that case (as opposed to to something in
  > "refs/remotes/origin/").  So I really think this does want to be
  > starts_with.

  Thanks; here is what I'm gonna queue.

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9b3c04d..545105a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -695,7 +695,7 @@ static void write_refspec_config(const char* src_ref_prefix,
 	if (option_mirror || !option_bare) {
 		if (option_single_branch && !option_mirror) {
 			if (option_branch) {
-				if (strstr(our_head_points_at->name, "refs/tags/"))
+				if (starts_with(our_head_points_at->name, "refs/tags/"))
 					strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
 						our_head_points_at->name);
 				else
-- 
2.0.0-637-g8ac8cc9

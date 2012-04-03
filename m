From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Tue, 03 Apr 2012 16:23:47 -0700
Message-ID: <7vk41wbdrw.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vlimhk7rz.fsf@alter.siamese.dyndns.org>
 <20120403205906.GB24815@sigill.intra.peff.net>
 <7vsjgkbga9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:23:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFD4t-0008Un-Sq
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab2DCXXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 19:23:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab2DCXXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 19:23:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 145E9669B;
	Tue,  3 Apr 2012 19:23:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LddYaDdoln2IzGELbQE68JcGovg=; b=x6aJwM
	gkkwfiLRTMeviqXzYAIUqL1efea78HCbVKsDt0wCzgFSq0IGjIKp0cDbGp0RQfRK
	+yTBDNFG5lINS3wkdkilScT+0JzgDXrDpYGxQXXF4QofcEAZBjPxiunXvfZJitRt
	uQOrhqBtY2Uf07Zci1jmDW8i5jiuVmhxd9uMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d6CAI7GdF2iT3vgjNCvUABOIY+j8DwDy
	chV3JDJE9Kzcj91PE4qWkxNQUoO0hNola+MAL7fWEPQWZtlryxkuFzAadgrChLEG
	FoJw/BtdHWhnPzu7rPPa03c77ZFqxsOtmwrzr2YSeKyheHEZw6HbFmqijJ3sNXiA
	lpktqPjiMTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BADD669A;
	Tue,  3 Apr 2012 19:23:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 943FA6699; Tue,  3 Apr 2012
 19:23:48 -0400 (EDT)
In-Reply-To: <7vsjgkbga9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 03 Apr 2012 15:29:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10D426D2-7DE4-11E1-BCE9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194672>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> Hmm. So this will actually detect "git push $URL" when $URL matches the
>> remote's configured URL. I feel like this distinction has come up
>> before, and we decided not to equate the two. But now I can't remember
>> where (maybe it when fetching via URL versus via remote?).
>
> This is me merely try to be extra nice without succeeding.

An obvious patch to remove the misguided "be nice and try to see if URLs
are the same" bit should look like this.

 builtin/push.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3e18cd3..765b19c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -97,17 +97,10 @@ static void setup_push_upstream(struct remote *remote)
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
-	if (strcmp(branch->remote_name, remote->name)) {
-		struct remote *branch_dest = remote_get(branch->remote_name);
-		const char **branch_dest_url, **dest_url;
-
-		if (!push_url_of_remote(remote, &dest_url) ||
-		    !push_url_of_remote(branch_dest, &branch_dest_url) ||
-		    strcmp(dest_url[0], branch_dest_url[0]))
-			die(_("You are pushing to remote '%s', which is not the "
-			      "upstream of your\ncurrent branch '%s'.\n"),
-			    remote->name, branch->name);
-	}
+	if (strcmp(branch->remote_name, remote->name))
+		die(_("You are pushing to remote '%s', which is not the "
+		      "upstream of your\ncurrent branch '%s'.\n"),
+		    remote->name, branch->name);
 
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 04 Oct 2012 14:16:33 -0700
Message-ID: <7v391ux7im.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:58:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtiH-00033L-1B
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab2JDVQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 17:16:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757542Ab2JDVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 17:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8653C9FB3;
	Thu,  4 Oct 2012 17:16:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PhdlJwTLo2n/3Opw+bVgi0zHR08=; b=L3QHfO
	3WRWIRjsFNBxYM3Ua8HkEhbcfL/gv94RZQ/WawqfWLT6Whdb9RdxDT+9cwoEGMl7
	hiramyB5QgX46Hx5E3yelOmAwVjr5nNX5vqT20+06eSJYU3prwNAfd+KiP1NtsGd
	GvS3CT36QJNsZqQ4OR4yTeGwMHvoRpkm80B00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nyTmtCc+nQHpQluGA6t/JP+AFfPV8BMr
	GPDbcK/VoDMwOGwPUpQvx2Zu7ApY102VSla30TMePChAOn4O1W1Ca47htAlksyzU
	OR3OKGUiioVDXJBJ3pWdFqq/OGOqZrjuPVDMq2Suq5YTTmqG5zgCDJVN8lp8Tb4K
	ES6+3EI8tRs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 734139FB2;
	Thu,  4 Oct 2012 17:16:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4F539FAD; Thu,  4 Oct 2012
 17:16:34 -0400 (EDT)
In-Reply-To: <20121004184314.GA15389@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 14:43:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6C65234-0E68-11E2-B141-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207038>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 04, 2012 at 04:14:54PM +0200, Markus Trippelsdorf wrote:
>
>> with current trunk I get the following on an up-to-date Linux tree:
>> 
>> markus@x4 linux % time git pull
>> Already up-to-date.
>> git pull  7.84s user 0.26s system 92% cpu 8.743 total
>> 
>> git version 1.7.12 is much quicker:
>> 
>> markus@x4 linux % time git pull
>> Already up-to-date.
>> git pull  0.10s user 0.02s system 16% cpu 0.740 total
>
> Yikes. I can easily reproduce here. Bisecting between master and
> v1.7.12 gives a curious result: the slowdown first occurs with the merge
> commit 34f5130 (Merge branch 'jc/merge-bases', 2012-09-11). But neither
> of its parents is slow. I don't see anything obviously suspect in the
> merge, though.

I think the following is likely to be the correct solution to this.

 commit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git i/commit.c w/commit.c
index 0246767..e1dd5b9 100644
--- i/commit.c
+++ w/commit.c
@@ -733,6 +733,9 @@ static int remove_redundant(struct commit **array, int cnt)
 	int *filled_index;
 	int i, j, filled;
 
+	if (cnt < 2)
+		return cnt;
+
 	work = xcalloc(cnt, sizeof(*work));
 	redundant = xcalloc(cnt, 1);
 	filled_index = xmalloc(sizeof(*filled_index) * (cnt - 1));

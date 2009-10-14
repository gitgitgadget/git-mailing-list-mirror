From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysgit? bug] CRLF in info/grafts causes parse error
Date: Wed, 14 Oct 2009 11:51:03 -0700
Message-ID: <7vbpk9ermw.fsf@alter.siamese.dyndns.org>
References: <ecf590a0d9e21f480529f64e465825c5.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:54:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8zL-0007sb-Ss
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761785AbZJNSvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761726AbZJNSvw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:51:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761592AbZJNSvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:51:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89A8577E76;
	Wed, 14 Oct 2009 14:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTvYqVJFpScOupCKJzwEIs+TYDk=; b=pmOQ9/
	oHR3QDxWmkFGaJG3XYz7OGyuN++mzOjAlAmMiO1uD8O631HaSGT0qriMtzwhFT/U
	3vmeormat/P2LDSDVPsugtJdkS4qnbRcnYAsoqPtTSnA1IeqL4ugsEKcdWDPaTYa
	GzbDJY+L7YuPkzc0EE+6TzrUQrQROlrfkrrTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4BUAIkZgePXdazUrvdokjW/O04bZ44k
	pBSX6DwCfXpTzYXgIKvMdLLvp4izxNOk6jLDdA8N90g7Zn9c4Gn6ZEChZH7GG+2k
	3CGwnlvgOYaWndUrqfmpPgY5RqvdZikEIpieXU1Xcd2AJRxW67M/1x44TTIKQjV3
	d19740MLaSI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C1E177E75;
	Wed, 14 Oct 2009 14:51:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5166E77E71; Wed, 14 Oct 2009
 14:51:04 -0400 (EDT)
In-Reply-To: <ecf590a0d9e21f480529f64e465825c5.squirrel@intranet.linagora.com> (Yann
 Dirson's message of "Wed\, 14 Oct 2009 16\:07\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88C5EC52-B8F2-11DE-850B-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130321>

"Yann Dirson" <ydirson@linagora.com> writes:

> When creating an info/grafts under windows, one typically gets a CRLF file.
> Then:
>
> * gitk loudly complains about "bad graft data"
> * "git log > /dev/null" does not report any problem
> * "git log > foo" does report the problem on sdterr, but exit code is still 0
>
> Recreating the graft as a LF file (eg with "echo" or "printf") causes the
> graft to be properly interpreted.

I do not see any reason to forbid trailing CR at the end of the line (for
that matter, any trailing whitespaces) in the said file.

How about doing this?

 commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index fedbd5e..0db2124 100644
--- a/commit.c
+++ b/commit.c
@@ -132,8 +132,8 @@ struct commit_graft *read_graft_line(char *buf, int len)
 	int i;
 	struct commit_graft *graft = NULL;
 
-	if (buf[len-1] == '\n')
-		buf[--len] = 0;
+	while (isspace(buf[len-1]))
+		buf[--len] = '\0';
 	if (buf[0] == '#' || buf[0] == '\0')
 		return NULL;
 	if ((len + 1) % 41) {

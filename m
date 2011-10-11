From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 11:07:59 -0700
Message-ID: <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 20:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgkS-0007cq-9P
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 20:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab1JKSIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 14:08:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879Ab1JKSIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 14:08:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 556205B5A;
	Tue, 11 Oct 2011 14:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tVu6vjWJvxz+md4bSbJFa2Isndg=; b=fxltLU
	rwgfwjVHVPTr3x6PrQJXvvuiBaAcgHSRbV0MedbSc6yYJ0f2uSbvSVE2XA2uShgy
	3PQQMOags9CrdMEvsmUdC2mmpP13+7trtHN7ze2a3Dgk/XgesUytbgOWmNd+5pzO
	yLw6gWdk/vHqqZ1ePAHuY+nWZrPXzEIsgc7dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S/oJozaoY4P166byGPBGZXiyvz2j9ebo
	v129qJz5e77Ch+jz1H+WTXasxy0glaQ76DUfREEr45nNlXfVRY49+ObeK+y+erTU
	XCPKaaVUQ0YkWfn38+l8oHl8omp8IW66ezqukgUukJID2OcCkDAU8nUz6EB4hPM1
	pi3CN9rH4Dw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B36045B58;
	Tue, 11 Oct 2011 14:08:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5E5A5B53; Tue, 11 Oct 2011
 14:08:02 -0400 (EDT)
In-Reply-To: <7vr52jfm8i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 11 Oct 2011 10:53:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F605D8A8-F433-11E0-851A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183315>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I wonder if the right solution is for us to be more picky about what can
>> be found in $GIT_DIR. Maybe matching all-uppercase, or starting with
>> "refs/", which I think would match existing convention?
>
> I think we've discussed tightening it a few years ago already.
>
> HEAD, MERGE_HEAD, FETCH_HEAD, etc. all are "^[_A-Z]*$" and it may even be
> a good idea to insist "^[_A-Z]*HEAD$" or even "^([A-Z][A-Z]*_)?HEAD$".

Perhaps like this? Only compile tested...

 sha1_name.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index ba976b4..5effb1a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -261,6 +261,23 @@ static char *substitute_branch_name(const char **string, int *len)
 	return NULL;
 }
 
+static int is_kind_of_head(const char *str)
+{
+	int len = strlen(str) - 4;
+	if (len < 0 || strcmp(str + len, "HEAD"))
+		return 0;
+	if (!len)
+		return 1;
+	if (str[--len] != '_' || !len)
+		return 0;
+	while (len) {
+		char ch = str[--len];
+		if (ch < 'A' || 'Z' < ch)
+			return 0;
+	}
+	return 1;
+}
+
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
@@ -274,6 +291,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 		unsigned char *this_result;
 		int flag;
 
+		if (p == ref_rev_parse_rules && !is_kind_of_head(str))
+			continue;
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
 		r = resolve_ref(fullref, this_result, 1, &flag);
@@ -302,6 +321,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		char path[PATH_MAX];
 		const char *ref, *it;
 
+		if (p == ref_rev_parse_rules && !is_kind_of_head(str))
+			continue;
 		mksnpath(path, sizeof(path), *p, len, str);
 		ref = resolve_ref(path, hash, 1, NULL);
 		if (!ref)

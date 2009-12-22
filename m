From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prevent git blame from segfaulting on a missing author
 name
Date: Mon, 21 Dec 2009 23:25:15 -0800
Message-ID: <7viqbz4gis.fsf@alter.siamese.dyndns.org>
References: <4B304993.2040600@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 08:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMz7Z-0002cC-SF
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 08:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbZLVHZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 02:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZLVHZY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 02:25:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZLVHZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 02:25:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6720AA8128;
	Tue, 22 Dec 2009 02:25:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HvB+JEkCv4FEeFAa2qw++/ccB2E=; b=siySle
	NeiS5Vpo2EsXtx8SblUbDxeQIUGzfstZmUZ0UDG/HvrKVPlPr7lKt3LBn8ezozdu
	D23RiI52CTjiZBhhXodGZSe+47sQJcdsWTmL791wHRz9B9WvqhL76h13V7yM7Oyj
	wWI8tgQwYTpB6z348FaS8fmYUAaABDTl0v2Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TFXYLI+MLF4ygTt+9qsd47qgb/dGdXyL
	wZqRoM5cG89mV8OFxXcDXUB8oOrSoJuCLLV9Yhcatar1P6k5cxblkroJOxVNckQr
	IbnfgI4V4NbRMua6nTgxo265LcVk5Juz7/J+9OxW7p3QdLbIbk3t4IxMQCetUqRw
	fQxUzqjboJw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 448FFA8125;
	Tue, 22 Dec 2009 02:25:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C460A8122; Tue, 22 Dec 2009
 02:25:16 -0500 (EST)
In-Reply-To: <4B304993.2040600@facebook.com> (David Reiss's message of "Mon\,
 21 Dec 2009 20\:22\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2910924E-EECB-11DE-A5A1-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135573>

David Reiss <dreiss@facebook.com> writes:

> The author name should never be missing in a valid commit, but
> git shouldn't segfault no matter what is in the object database.
>
> Signed-off-by: David Reiss <dreiss@facebook.com>
> ---
> git blame was segfaulting on a repro produced by piping mtn git_export
> from the Pidgin repository to git fast-import.  This was the most obvious
> fix, but I'm not sure if it is the best solution.

Thanks.

While it is _unusual_ not to have a human readable name, if the commits
come from foreign systems (e.g. CVS/SVN), there often are not sufficient
information in the source to fabricate names, so we should tolerate them.

We might want to also teach fast-import to warn when asked (i.e. when we
are feeding from a foreign interface that is designed to read from a
source that is capable of recording real names), but we shouldn't prevent
it from creating such a commit.

> Here's a script that reproduces the segfault.

Please make that into a new test in an existing test suite somewhere in t/
directory.


I think we probably should prepare ourselves to be fed with even more
broken commits, perhaps like this, if we are fixing it..

 builtin-blame.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index d4e25a5..14830a3 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1305,6 +1305,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	error_out:
 		/* Ugh */
 		*tz = "(unknown)";
+		strcpy(person, *tz);
 		strcpy(mail, *tz);
 		*time = 0;
 		return;
@@ -1314,20 +1315,26 @@ static void get_ac_line(const char *inbuf, const char *what,
 	tmp = person;
 	tmp += len;
 	*tmp = 0;
-	while (*tmp != ' ')
+	while (person < tmp && *tmp != ' ')
 		tmp--;
+	if (tmp == person)
+		goto error_out;
 	*tz = tmp+1;
 	tzlen = (person+len)-(tmp+1);
 
 	*tmp = 0;
-	while (*tmp != ' ')
+	while (person < tmp && *tmp != ' ')
 		tmp--;
+	if (tmp == person)
+		goto error_out;
 	*time = strtoul(tmp, NULL, 10);
 	timepos = tmp;
 
 	*tmp = 0;
-	while (*tmp != ' ')
+	while (person < tmp && *tmp != ' ')
 		tmp--;
+	if (tmp <= person)
+		return;
 	mailpos = tmp + 1;
 	*tmp = 0;
 	maillen = timepos - tmp;

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] clone-local fixup
Date: Tue, 23 Aug 2011 09:26:28 -0700
Message-ID: <7vzkj0rt57.fsf@alter.siamese.dyndns.org>
References: <7vliulun2a.fsf@alter.siamese.dyndns.org>
 <1314061516-24964-1-git-send-email-gitster@pobox.com>
 <4E5321C9.4080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 18:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvtoC-00030y-EH
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 18:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab1HWQ0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 12:26:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab1HWQ0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 12:26:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60D444883;
	Tue, 23 Aug 2011 12:26:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWX2K0nXDpuNsRpzEKg6U4i90uY=; b=a7nhoA
	zsc84VfRsXnEOGEZoDDvlkwYaVB/oj8q3c8tAfYCoGRgJCW59q9ARbGDUNPKa/np
	W+Agvu2vdTYf5iPzE8ilLOD5ZWxYyqt6nZ6A54L3gDWWV+doyxGokg+ArqwKMYcO
	CMb6dDVD1pOHwoXaT3AXZmJ8fOLrqMegN7GXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PKZ/LdX0kEjIcIoABX1/raRiYeJbLX6w
	/9VscfvVjB+J5r+8Z6OSxUjWl+cZuHlStsY/6x2NsQPwmxwl2HEQCYmQgaq4wNvo
	b3kuxsW+CCxZrZcRWJzh9tagz3jLIciNyW0YeFuRp7cf6AVkeKPoZpPyLtam52Y3
	I4Ix/KmqJhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57BF04882;
	Tue, 23 Aug 2011 12:26:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFE20487F; Tue, 23 Aug 2011
 12:26:29 -0400 (EDT)
In-Reply-To: <4E5321C9.4080301@gmail.com> (Hui Wang's message of "Tue, 23 Aug
 2011 11:43:05 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7F518BE-CDA4-11E0-9AD5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179946>

Hui Wang <jason77.wang@gmail.com> writes:

> This patch series solved the problem from the root cause. :-)
>
> But there is a little problem in the second patch, i provide an
> incremental patch basing on your second patch, if it is fine to you,
> it is OK to squash this patch to your second patch.

Thanks. We also need the following fix-up, as I changed the semantics of
add_to_alternates_file() to take the path to the "objects" directory.

diff --git a/builtin/clone.c b/builtin/clone.c
index 284e325..63c34d0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -336,14 +336,17 @@ static const struct ref *clone_local(const char *src_repo,
 				     const char *dest_repo)
 {
 	const struct ref *ret;
-	struct strbuf src = STRBUF_INIT;
-	struct strbuf dest = STRBUF_INIT;
 	struct remote *remote;
 	struct transport *transport;
 
-	if (option_shared)
-		add_to_alternates_file(src_repo);
-	else {
+	if (option_shared) {
+		struct strbuf alt = STRBUF_INIT;
+		strbuf_addf(&alt, "%s/objects", src_repo);
+		add_to_alternates_file(alt.buf);
+		strbuf_release(&alt);
+	} else {
+		struct strbuf src = STRBUF_INIT;
+		struct strbuf dest = STRBUF_INIT;
 		strbuf_addf(&src, "%s/objects", src_repo);
 		strbuf_addf(&dest, "%s/objects", dest_repo);
 		copy_or_link_directory(&src, &dest, src_repo, src.len);

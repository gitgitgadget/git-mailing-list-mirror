From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache.h: move remote/connect API out of it
Date: Mon, 08 Jul 2013 14:35:57 -0700
Message-ID: <7vwqp0ybsy.fsf@alter.siamese.dyndns.org>
References: <7v1u78zrko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 23:36:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwJ6M-0001pl-RY
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 23:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab3GHVgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 17:36:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab3GHVgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 17:36:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2335C2FD96;
	Mon,  8 Jul 2013 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8u+IidQulQ+NUziPdoEPDjktG2A=; b=ri4rk0
	x+FS8yGG6w+IB6CTVTPy4BxccvYBEOYtvBvVdIv8sxCIee45U7zZeERQqyuuza8N
	hUlmhrVdJmyoDUQU0njTi8FjO5VRjVXS51uOqxe1IBkkb1Wr6bP0ggu88mbPBQWW
	LnLS9PrFgWR8q1Ge/cMrKI91mjMrwPJy+v9Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ow7Di2X+gXO1sVCYpmIEdInFebq/2F/N
	wj7ut4JRruImqSSwVuimZyvt9LoKX9ewkoI1ML5eCaC6WXhwcSiUMvoNrKbdsgVA
	qSdWCelwg4RYinazTSoBTuHMlxzj2qZCmNHSjBvJRneAsqZ5DuLnU+uV9iZZ1dUF
	QbVoZpOFizo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 189DE2FD95;
	Mon,  8 Jul 2013 21:36:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74BA72FD91;
	Mon,  8 Jul 2013 21:35:59 +0000 (UTC)
In-Reply-To: <7v1u78zrko.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 08 Jul 2013 14:09:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 615B9480-E816-11E2-BC66-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229895>

Junio C Hamano <gitster@pobox.com> writes:

> The definition of "struct ref" in "cache.h", a header file so
> central to the system, always confused me.  This structure is not
> about the local ref used by sha1-name API to name local objects.
>
> It is what refspecs are expanded into, after finding out what refs
> the other side has, to define what refs are updated after object
> transfer succeeds to what values.  It belongs to "remote.h" together
> with "struct refspec".
>
> While we are at it, also move the types and functions related to the
> Git transport connection to a new header file connect.h
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * I hate to to this kind of code-movement in the middle of the
>    cycle, but every time I follow the push->transport codepath, I
>    become disoriented by these "struct ref"s.

>
>  builtin/fetch-pack.c   |  2 ++
>  builtin/receive-pack.c |  1 +
>  builtin/send-pack.c    |  1 +
>  cache.h                | 62 --------------------------------------------------
>  connect.c              |  1 +
>  fetch-pack.c           |  1 +
>  fetch-pack.h           |  1 +
>  refs.c                 |  8 -------
>  remote.c               |  8 +++++++
>  remote.h               | 54 +++++++++++++++++++++++++++++++++++++++++++
>  send-pack.c            |  1 +
>  transport.c            |  2 ++
>  transport.h            |  1 +
>  upload-pack.c          |  1 +
>  14 files changed, 74 insertions(+), 70 deletions(-)

Of course, I should have noticed that the math does not work out
without this part:

 connect.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/connect.h b/connect.h
new file mode 100644
index 0000000..9dff25c
--- /dev/null
+++ b/connect.h
@@ -0,0 +1,13 @@
+#ifndef CONNECT_H
+#define CONNECT_H
+
+#define CONNECT_VERBOSE       (1u << 0)
+extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
+extern int finish_connect(struct child_process *conn);
+extern int git_connection_is_socket(struct child_process *conn);
+extern int server_supports(const char *feature);
+extern int parse_feature_request(const char *features, const char *feature);
+extern const char *server_feature_value(const char *feature, int *len_ret);
+extern const char *parse_feature_value(const char *feature_list, const char *feature, int *len_ret);
+
+#endif

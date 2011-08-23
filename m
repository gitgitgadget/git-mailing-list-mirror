From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] lifetime rule for url parameter to transport_get()?
Date: Mon, 22 Aug 2011 17:34:54 -0700
Message-ID: <7vipppt175.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 02:35:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvexN-0007U7-03
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 02:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab1HWAfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 20:35:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab1HWAe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 20:34:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A548D421E;
	Mon, 22 Aug 2011 20:34:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=f
	ThVfFe90l/aDDv9XUtQqCH+qz8=; b=uXAWkFho7wfubTfydoPghrXfftbJVVPrr
	8iwRIGhpD73Th4JPc7IPx9zC/HY7iIO+8ifSUZX6+MQQ6J33w1tGSOKefoHjJrrw
	874Iv0PQfLnJAJubkz6gaHywdMBhxxE7h9K201d6vqwIMA0dhnxJTtdLIl8gTnIE
	g33SxBP128=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=bMFzbNs4bqczc0IB0JU3nKU5J4As8VKOWBT0USkTLiR5H+HFbTmrZxB9
	bzjLDcGbEepWAjo/cBbufFNXICvvycfDEY8OBAtzVGsa8LmFRv1FPAxX1F1XEGEx
	1XGvkzS1+LoV3Ev0LKAiBDfZ5pyLfGT07xZxjfwjEOOXTCSpFB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CF78421D;
	Mon, 22 Aug 2011 20:34:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 244A5421A; Mon, 22 Aug 2011
 20:34:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B98997EC-CD1F-11E0-9F25-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179904>

Does anybody remember why we use a copied string of "ref_git_copy" in
builtin/clone.c::setup_reference()?

	ref_git = real_path(option_reference);
	...
	ref_git_copy = xstrdup(ref_git);
	add_to_alternates_file(ref_git_copy);
	remote = remote_get(ref_git_copy);
	transport = transport_get(remote, ref_git_copy);
	for (extra = transport_get_remote_refs(transport); extra;
	     extra = extra->next)
		add_extra_ref(extra->name, extra->old_sha1, 0);
	transport_disconnect(transport);
	free(ref_git_copy);

The three functions add_to_alternates_file(), remote_get(), and
transport_get() all get "const char *" so I do not think the copy was done
to avoid "option_reference" from getting clobbered by these functions. The
only thing I can think of is that transport_get() does this:

    struct transport *transport_get(struct remote *remote, const char *url)
    {
            const char *helper;
            struct transport *ret = xcalloc(1, sizeof(*ret));

            ...
            if (!url && remote->url)
                    url = remote->url[0];
            ret->url = url;
	    ...
	    return ret;
    }

holding onto "url" without making a copy for its own use. But then freeing
that copy by the caller after calling transport_disconnect() does not make
much sense to me---we could have just gave it the original option_reference,
have transport use it while it runs ls-remote equivalent, and then called
transport_disconnect(), without using any extra copy.

What I am missing?

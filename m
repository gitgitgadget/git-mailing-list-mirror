From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] connect: learn to parse capabilities with values
Date: Fri, 10 Aug 2012 13:01:11 -0700
Message-ID: <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 22:01:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzvOa-0000Nf-Kn
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 22:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab2HJUBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 16:01:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913Ab2HJUBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 16:01:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE069314;
	Fri, 10 Aug 2012 16:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KiaAC8otLbOQe2smZa9UPdtNItg=; b=jCeTiu
	3PBZ8TpMw7X/gcyPpO9c78KhSR4SR3/ONck7sn8h2HBAg8uqe3RtK113UZE9QTc1
	OBO8nhGvfpWiXf83EJJannJrQs4AmzP6klDgs2L2mx8Tg22TKuMSZ+eAP3SuK8zu
	zcF7Rqrd9vVq6nKW2Dee7VWpxvp1YXk49Ftfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BEq06G5bpIvFcWpVUgzq6fsjuxPkNgbn
	wBVadfVxXUE519ANP8oO52MA1gmTk17nRtFYGTkfJMEHD+ae8PKJUUApS7jy4ViQ
	omflnr/1TM9weBGxyC4AloRUb8XAFbx9PcwxVFsWajyWecbwpYG1+BUcXdJc7qGN
	K0tK/Vdyer8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 885069313;
	Fri, 10 Aug 2012 16:01:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E073F9312; Fri, 10 Aug 2012
 16:01:12 -0400 (EDT)
In-Reply-To: <20120810075816.GC8399@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 03:58:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22C2B352-E326-11E1-A466-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203254>

Jeff King <peff@peff.net> writes:

> +/*
> + * Parse features of the form "feature=value".  Returns NULL if the feature
> + * does not exist, the empty string if it exists but does not have an "=", or
> + * the content to the right of the "=" until the first space (or end of
> + * string).  The cannot contain literal spaces; double-quoting or similar
> + * schemes would break compatibility, since older versions of git treat the
> + * space as a hard-delimiter without any context.
> + *
> + * The return value (if non-NULL) is newly allocated on the heap and belongs to
> + * the caller.
> + */
> +char *parse_feature_request_value(const char *feature_list, const char *feature)
> +{
> +	const char *start = parse_feature_request(feature_list, feature);
> +	const char *end;
> +
> +	if (!start || prefixcmp(start, feature))
> +		return NULL;
> +	start += strlen(feature);
> +
> +	if (*start == '=')
> +		start++;
> +	end = strchrnul(start, ' ');
> +
> +	return xmemdupz(start, end - start);
> +}

Having to run strlen(feature) three times in this function (once in
parse_feature_request() as part of strstr() and the edge check of
the found string, once as part of prefixcmp() here, and then an
explicit strlen() to skip it) makes me feel dirty.

It is not wrong per-se, but it is likely that the caller has a
constant string as the feature when it called this function, so
perhaps just changing the function signature of server_supports,
i.e.

    const char *server_supports(const char *feature)
    {
	return parse_feature_request(server_capabilities, feature);
    }

to return "var=val " would be more than sufficient.

Then the existing callers can keep doing

	if (server_supports("thin-pack"))
        if (!server_supports("quiet"))

and a new caller can do something like

	agent = server_supports("agent");
        if (!agent || !agent[5])
        	... no agent ...
	else {
        	int span = strcspn(agent + 6, " \t\n");
                printf("I found agent=<%.*s>!\n", span, agent + 6);
	}

which doesn't look too bad.

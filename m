From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/5] Implement line-history search (git log -L)
Date: Thu, 21 Mar 2013 12:05:37 -0700
Message-ID: <7vr4j8a7zy.fsf@alter.siamese.dyndns.org>
References: <cover.1363865444.git.trast@student.ethz.ch>
 <b8cabd5ca63a17577fca524891046e5a3d3dfc60.1363865444.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 21 20:06:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIkoS-0007kg-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 20:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab3CUTFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 15:05:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab3CUTFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 15:05:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53684A5C0;
	Thu, 21 Mar 2013 15:05:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GgfQ+7/9VyavU2/gI6iiQdU9gZA=; b=MvkFmH
	V98gHL1+9vkBTB4tfv9wYSjIiqwlH6RBXEJLKhrZRbuakxJA6J7WqBLk092uHhV3
	lfwHc8EjMH7gRB394dc8JbYg0MNnJfYhUP+9+5UoZxgwjKSZJsFwS/8Q/H6fdXXl
	sbZebBEErAxgvGbD1phe9IR85d9GTplbOZtqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VLzJQ+gYcB0KzXnnHn732xg7pOICgiOy
	pUMhlzW3kRDX6T5gjD6rtpBdGBCdVK3QfsgdD/ro3m0eDEFuWIdHSwnLQncORK7i
	FJidJAAAlpdEZSo3IyZbk2pn1C+djLuvl4hS/tFwEcGwQLCZfUmFTUwbVpulYOMM
	vjNVwpXl0Rw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A2BA5BE;
	Thu, 21 Mar 2013 15:05:39 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9111EA5BA; Thu, 21 Mar 2013
 15:05:38 -0400 (EDT)
In-Reply-To: <b8cabd5ca63a17577fca524891046e5a3d3dfc60.1363865444.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 21 Mar 2013 13:52:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51777CA8-925A-11E2-B8A1-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218747>

Thomas Rast <trast@student.ethz.ch> writes:

> +void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args)
> +{
> +	struct commit *commit = NULL;
> +	struct line_log_data *range;
> +
> +	commit = check_single_commit(rev);
> +	range = parse_lines(commit, prefix, args);
> +	add_line_range(rev, commit, range);
> +
> +	if (!rev->diffopt.detect_rename) {
> +		int i, count = 0;
> +		struct line_log_data *r = range;
> +		const char **paths;
> +		while (r) {
> +			count++;
> +			r = r->next;
> +		}
> +		paths = xmalloc((count+1)*sizeof(char *));
> +		r = range;
> +		for (i = 0; i < count; i++) {
> +			paths[i] = xstrdup(r->spec->path);
> +			r = r->next;
> +		}
> +		paths[count] = NULL;
> +		init_pathspec(&rev->diffopt.pathspec, paths);
> +		free(paths);
> +	}
> +}

Why not do the pathspec limitation under "-M"?

It is not like you are picking up origins of blocks of lines copied
or moved from other files like "blame -C" does, so I suspect it
would be simpler to mimic what --follow does, which is to (1) use
the pathspec to follow the paths you care about, and then (2) when
you find one or more of the paths you were following disappear in a
commit, only at that point you re-check to see if there are other
paths that existed in the parent that the disappeared paths were
renamed from, and match with that one.

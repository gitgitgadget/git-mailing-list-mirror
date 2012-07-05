From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] gitweb: Cleanup git_print_log()
Date: Thu, 05 Jul 2012 15:22:42 -0700
Message-ID: <7vhatlrgp9.fsf@alter.siamese.dyndns.org>
References: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Namhyung Kim <namhyung@kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 00:22:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuRn-00057g-DI
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957Ab2GEWWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:22:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738Ab2GEWWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 18:22:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AE748DD8;
	Thu,  5 Jul 2012 18:22:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=74ZzG/yUI7QhqgRa8Zo/6e2LISc=; b=X61bjm
	UWw/MT8QGAJj/3qL38UXNKJ9ya+7XoBpDA9XPlGbs+lAOQLvE5FcFShZzA7ZVT2n
	SvZCyEgxw/1XpQnChQwSVWosdMnVLPSEn8z0WkR+OayFWEAEysustx/gp2KUtBS2
	1H+ZlbSRPZyNzaXdEzkeNq2cShUOjXOsMvFz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W1wLkjFqyb/NJCISHGrX0Y7lB2mDoPDP
	StAdvik3+0PpuVTZsdwpOpA84j2O4wNiAzkdFm29zxwK/YlvhQeLiyP6aCusg06d
	Oqy0v8+qYoal/ywFThSHHx+Tqf3l94wxMHjJ7I4IL5OpcOfyLvnfQtnjQLJ9R9pB
	cuVtmjbfjNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 513898DD6;
	Thu,  5 Jul 2012 18:22:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA0188DD4; Thu,  5 Jul 2012
 18:22:43 -0400 (EDT)
In-Reply-To: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
 (Namhyung Kim's message of "Wed, 4 Jul 2012 11:47:24 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0C9F542-C6EF-11E1-BA43-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201070>

Namhyung Kim <namhyung@kernel.org> writes:

> If $signoff set to 1, the $line would be handled in
> the if statement for the both cases. So the outer of
> the conditional always sees the $signoff always set
> to 0 and no need to check it. Thus we can finally get
> rid of it.
>
> Also rename $empty to more clear $skip_blank_line as
> suggested by Junio.

Thanks.  It does not make it clear that you fixed a bug in the
original, so let me rephrase it like so:

-- >8 --
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 4 Jul 2012 11:47:24 +0900
Subject: [PATCH] gitweb: Cleanup git_print_log()

When we see a signed-off-by line (and its friends), we set $signoff
to true, but then we process the next line after we are done without
giving control to the rest of the loop.  And when the line we saw is
not a signed-off-by line, we reset $signoff to false before running
the remainder of the loop.

Hence, the check for $signoff that attempts to remove an extra empty
line between two signed-off-by line was not doing anything useful.

Rename $empty to a more explicit name $skip_blank_line to tell us to
skip a blank line when we see one, set it after we see and emit a
blank line (to avoid showing more than one empty lines in a raw) or
after we handle a signed-off-by line (to avoid empty lines after
such a line), to fix this bug, and get rid of the $signoff variable
that is not useful.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement git remote rename
Date: Fri, 24 Oct 2008 16:33:28 -0700
Message-ID: <7v63nh1sc7.fsf@gitster.siamese.dyndns.org>
References: <1224766597-16034-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 01:34:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtWBG-0004di-SH
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 01:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYJXXdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 19:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYJXXdn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 19:33:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbYJXXdn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 19:33:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 880038F7A6;
	Fri, 24 Oct 2008 19:33:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7044A8F7A3; Fri, 24 Oct 2008 19:33:29 -0400 (EDT)
In-Reply-To: <1224766597-16034-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Thu, 23 Oct 2008 14:56:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E9BCA20-A224-11DD-9061-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99083>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +static int mv(int argc, const char **argv)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	struct remote *oldremote, *newremote;
> +	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
> +	struct string_list remote_branches = { NULL, 0, 0, 0 };
> +	struct rename_info rename;
> +	int i;
> +
> +	if (argc != 3)
> +		usage_with_options(builtin_remote_usage, options);
> +
> +	rename.old = argv[1];
> +	rename.new = argv[2];
> +	rename.remote_branches = &remote_branches;
> +
> +	oldremote = remote_get(rename.old);
> +	if (!oldremote)
> +		die("No such remote: %s", rename.old);
> +
> +	newremote = remote_get(rename.new);
> +	if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_nr))
> +		die("remote %s already exists.", rename.new);
> +
> +	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
> +	if (!valid_fetch_refspec(buf.buf))
> +		die("'%s' is not a valid remote name", rename.new);
> +
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "remote.%s", rename.old);
> +	strbuf_addf(&buf2, "remote.%s", rename.new);
> +	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
> +		return error("Could not rename config section '%s' to '%s'",
> +				buf.buf, buf2.buf);

Hmm, remote_get() can read from all three supported places that you can
define remotes.  Could you explain what happens if the old remote is read
from say $GIT_DIR/remotes/origin and you are renaming it to "upstream"
with "git remote rename origin upstream"?

I suspect that if you record where you read the configuration from in
"struct remote" and add necessary code to remove the original when
rename.old is *not* coming from in-config definition, you would make it
possible for repositories initialized with older git that has either
$GIT_DIR/branches/origin or $GIT_DIR/remotes/origin to be migrated to the
in-config format using "git remote rename origin origin".

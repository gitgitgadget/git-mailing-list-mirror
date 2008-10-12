From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply --directory broken for new files
Date: Sat, 11 Oct 2008 20:18:39 -0700
Message-ID: <7vk5ceijqo.fsf@gitster.siamese.dyndns.org>
References: <48DBF794.9030809@zytor.com>
 <20080927015422.GA31783@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 05:27:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Korbw-0004Zp-1R
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 05:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYJLDTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 23:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYJLDS7
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 23:18:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYJLDS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 23:18:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 13E9A89147;
	Sat, 11 Oct 2008 23:18:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CBE8F89142; Sat, 11 Oct 2008 23:18:42 -0400 (EDT)
In-Reply-To: <20080927015422.GA31783@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 26 Sep 2008 21:54:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 817D6F40-980C-11DD-A269-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97998>

Jeff King <peff@peff.net> writes:

> apply --directory: handle creation and deletion patches
>
> We carefully verify that the input to git-apply is sane, including
> cross-checking that the filenames we see in "+++" headers match what was
> provided on the command line of "diff --git". When --directory is used,
> however, we ended up comparing the unadorned name to one with the
> prepended root, causing us to complain about a mismatch.
>
> We simply need to prepend the root directory, if any, when pulling the
> name out of the git header.

Thanks.

c4730f3 (Teach "git apply" to prepend a prefix with "--root=<root>",
2008-07-01) did a half-baked job to teach find_name() which is used to
parse traditional diff and also is used to set patch->old_name and
patch->new_name by gitdiff_verify_name() when parsing "copy from", "copy
to", "rename from", and "rename to".  The caller of git_header_name() uses
the return value to set patch->def_name that is used when "deleted file"
and "new file" are parsed, which should have been taught this trick by the
same commit.

However,...

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 2ab4aba..f9070d5 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -787,6 +787,13 @@ static char *git_header_name(char *line, int llen)
>  					break;
>  			}
>  			if (second[len] == '\n' && !memcmp(name, second, len)) {
> +				if (root) {
> +					char *ret = xmalloc(root_len + len + 1);
> +					strcpy(ret, root);
> +					memcpy(ret + root_len, name, len);
> +					ret[root_len + len] = '\0';
> +					return ret;
> +				}
>  				return xmemdupz(name, len);
>  			}
>  		}

I suspect this is only half of the story, because the code to parse:

 	diff --git "a/f\244o/bar.c" "b/f\244o/bar.c"

in the same function before the part you patched needs similar
treatment.  There are two return of strbuf_detach(&first, NULL)
in the if(){} block, and the return value needs to be prefixed with the
value of --directory when given.

It would be easier to do this --directory prefixing in the sole caller of
git_header_name(), though.

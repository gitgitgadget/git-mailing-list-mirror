From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] blame: new option to better handle merged cherry-picks
Date: Thu, 02 Jan 2014 12:29:43 -0800
Message-ID: <xmqqlhyyp1oo.fsf@gitster.dls.corp.google.com>
References: <20140102175529.GA4669@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyotv-0005OU-BK
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbaABU3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:29:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaABU3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:29:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 159BB5F65B;
	Thu,  2 Jan 2014 15:29:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KOwzQpZjqwxYC35Ip4XtZZdDGz8=; b=vivKYD
	GggMtqhSImq0CyF9WWjWelmOwAoDHJOOwsN6RxFXBQZIxSfgEcU+/wcwjp8mc+ro
	s7xVz/MhAKpVf3R5PBbT+9HR90oxxS2jqKWZ4RJOJDAT09Ybtwg0lDSImCwcyvev
	F/xBlylRFNoDrT9bfOcNs2QckQBzR/m0dIfXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YVcluEUvvbgcg0zBprdEvs92AAsrHf5M
	mCysvSYT5lKRz7fbidxc2QgZoEY+O1cOwcfV7WVcbrcQgyF4ttIO813LiwgxgmF+
	NYXzZtZU3px9vWPxvdMoHLnQSElXmNnysEotb3v1zqJm/PE8gfQ2dwrBLlJqzXB8
	ZhgRPwx4Syg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E60D5F659;
	Thu,  2 Jan 2014 15:29:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 836DB5F658;
	Thu,  2 Jan 2014 15:29:48 -0500 (EST)
In-Reply-To: <20140102175529.GA4669@client.brlink.eu> (Bernhard R. Link's
	message of "Thu, 2 Jan 2014 18:55:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A006053C-73EC-11E3-8024-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239871>

"Bernhard R. Link" <brl+git@mail.brlink.eu> writes:

> Allows to disable the git blame optimization of assuming that if there is a
> parent of a merge commit that has the exactly same file content, then
> only this parent is to be looked at.

I think this is what we usually call --full-history in "git log"
family, but more importantly, I do not think this is solving a valid
problem.

> This optimization, while being faster in the usual case, means that in
> the case of cherry-picks the blamed commit depends on which other commits
> touched a file.
>
> If for example one commit A modified both files b and c. And there are
> commits B and C, B only modifies file b and C only modifies file c
> (so that no conflicts happen), and assume A is cherry-picked as A'
> and the two branches then merged:
>
> --o-----B---A
>    \         \
>     ---C---A'--M---

So the contents of b at M is as the same as in A, so following 'b'
will see A and B changed that path, which is correct.

The contents of c at M is?  It is different from A because at A c
lacks the change made to it at C.  The merged result at M would
match C in A', no?  So following 'c' will see A' and C changed that
path, no?

So what is wrong about it?  If the original history were like this
instead, and A' were a cherry-pick of A, then what should happen?

> --o-----B---A'
>    \         \
>     ---C---A---M---

Don't we want to see c blamed the same way?

Also, when handling a merge, we have to handle parents sequencially,
checking the difference between M with its first parent first, and
then passing blame for the remaining common lines to the remaining
parents.  If you flip the order of parents of M when you merge A and
A' in your original history, and with your patch, what would you
see when you blame c?  Wouldn't it notice that M:c is identical to c
in its first parent (now A') and pass the whole blame to A' anyway
with or without your change?



> Then without this new option git blame blames the A|A' changes of
> file b to A while blaming the changes of c to A'.
> With the new option --no-parent-shortcut it blames both changes to the
> same commit.
>
> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> ---
>  Documentation/blame-options.txt | 6 ++++++
>  builtin/blame.c                 | 5 ++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 0cebc4f..55dd12b 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -48,6 +48,12 @@ include::line-range-format.txt[]
>  	Show the result incrementally in a format designed for
>  	machine consumption.
>  
> +--no-parent-shortcut::
> +	Always look at all parents of a merge and do not shortcut
> +	to the first parent with no changes to the file looked at.
> +	This takes more time but produces more reliable results
> +	if branches with cherry-picked commits were merged.
> +
>  --encoding=<encoding>::
>  	Specifies the encoding used to output author names
>  	and commit summaries. Setting it to `none` makes blame
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4916eb2..dab2c36 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -45,6 +45,7 @@ static int incremental;
>  static int xdl_opts;
>  static int abbrev = -1;
>  static int no_whole_file_rename;
> +static int no_parent_shortcut;
>  
>  static enum date_mode blame_date_mode = DATE_ISO8601;
>  static size_t blame_date_width;
> @@ -1248,7 +1249,8 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
>  			porigin = find(sb, p, origin);
>  			if (!porigin)
>  				continue;
> -			if (!hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
> +			if (!no_parent_shortcut &&
> +			    !hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
>  				pass_whole_blame(sb, origin, porigin);
>  				origin_decref(porigin);
>  				goto finish;
> @@ -2247,6 +2249,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	static const char *contents_from = NULL;
>  	static const struct option options[] = {
>  		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
> +		OPT_BOOL(0, "no-parent-shortcut", &no_parent_shortcut, N_("Don't take shortcuts in some merges but handle cherry-picks better")),
>  		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
>  		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
>  		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),

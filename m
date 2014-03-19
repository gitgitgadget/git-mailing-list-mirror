From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote-hg: do not fail on invalid bookmarks
Date: Wed, 19 Mar 2014 14:51:37 -0700
Message-ID: <xmqqpplh26xi.fsf@gitster.dls.corp.google.com>
References: <1395265366-85650-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:51:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQOOo-0005ju-8o
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbaCSVvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:51:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbaCSVvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:51:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12BCF75060;
	Wed, 19 Mar 2014 17:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZTFHubgnMh+dPX5auX1NkHCfrJw=; b=Eqdxcp
	Tf5cQfolZbaH6nFRN8Cj4Ii/8k8W3chiRfiKSI/Q5mf8o3lqmW91G0FwWBhFdpxt
	TxOHQZxE1mUzAqBxNYxYtOisd+vQqKMxmNIoyE7zuq7gZshYAj1w9hUxJcjUcWWL
	Jg4a0LvjiYSfcWQJzKc0b+NhI5bcNEZh8//pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDQkFjfVN8S01o/+2vRCeSHGGEt/Lrei
	OWwJ0v7Fw4kjQ3GOM2efOwcIAE6aZAtHj9QpUDRr3TGlpbMX2GLs0w6NiEb+NPQ0
	TzRRh3speyH/ZYlJAseN2/mqs9JlXV7dY7K4wbYl0gFp8Eb2TA4naxcckIfu5PFP
	IPTz0asXc2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB9F7505D;
	Wed, 19 Mar 2014 17:51:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5457675048;
	Wed, 19 Mar 2014 17:51:39 -0400 (EDT)
In-Reply-To: <1395265366-85650-1-git-send-email-max@quendi.de> (Max Horn's
	message of "Wed, 19 Mar 2014 22:42:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A67D0E42-AFB0-11E3-A65D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244500>

Max Horn <max@quendi.de> writes:

> Mercurial can have bookmarks pointing to "nullid" (the empty root
> revision), while Git can not have references to it.
> When cloning or fetching from a Mercurial repository that has such a
> bookmark, the import will fail because git-remote-hg will not be able to
> create the corresponding reference.
>
> Warn the user about the invalid reference, and continue the import,
> instead of stopping right away.

The text above is identical to what Antoine wrote in e8d48743
(remote-hg: do not fail on invalid bookmarks, 2013-12-29); I'd
assume that this is to replace it.

But the code seems to do more, and I think that is related to the
detailed analysis you dug up from the archive earlier and then
summarised in your $gmane/244440.  Can you say a bit more about
these fake-bmark and bmark checking like you did in that original
3-patch series?

Thanks.

> Also add some test cases for this issue.
>
> Reported-by: Antoine Pelisse <apelisse@gmail.com>
> Signed-off-by: Max Horn <max@quendi.de>
> ---
>  contrib/remote-helpers/git-remote-hg |  6 +++++
>  contrib/remote-helpers/test-hg.sh    | 48 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index eb89ef6..49b2c2e 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -625,6 +625,12 @@ def list_head(repo, cur):
>  def do_list(parser):
>      repo = parser.repo
>      for bmark, node in bookmarks.listbookmarks(repo).iteritems():
> +        if node == '0000000000000000000000000000000000000000':
> +            if fake_bmark == 'default' and bmark == 'master':
> +                pass
> +            else:
> +                warn("Ignoring invalid bookmark '%s'", bmark)
> +                continue
>          bmarks[bmark] = repo[node]
>  
>      cur = repo.dirstate.branch()
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
> index a933b1e..8d01b32 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -772,4 +772,52 @@ test_expect_success 'remote double failed push' '
>  	)
>  '
>  
> +test_expect_success 'clone remote with master null bookmark' '
> +	test_when_finished "rm -rf gitrepo* hgrepo*" &&
> +
> +	(
> +	hg init hgrepo &&
> +	cd hgrepo &&
> +	echo a >a &&
> +	hg add a &&
> +	hg commit -m a &&
> +	hg bookmark -r null master
> +	) &&
> +
> +	git clone "hg::hgrepo" gitrepo &&
> +	check gitrepo HEAD a
> +'
> +
> +test_expect_success 'clone remote with default null bookmark' '
> +	test_when_finished "rm -rf gitrepo* hgrepo*" &&
> +
> +	(
> +	hg init hgrepo &&
> +	cd hgrepo &&
> +	echo a >a &&
> +	hg add a &&
> +	hg commit -m a &&
> +	hg bookmark -r null -f default
> +	) &&
> +
> +	git clone "hg::hgrepo" gitrepo &&
> +	check gitrepo HEAD a
> +'
> +
> +test_expect_success 'clone remote with generic null bookmark' '
> +	test_when_finished "rm -rf gitrepo* hgrepo*" &&
> +
> +	(
> +	hg init hgrepo &&
> +	cd hgrepo &&
> +	echo a >a &&
> +	hg add a &&
> +	hg commit -m a &&
> +	hg bookmark -r null bmark
> +	) &&
> +
> +	git clone "hg::hgrepo" gitrepo &&
> +	check gitrepo HEAD a
> +'
> +
>  test_done

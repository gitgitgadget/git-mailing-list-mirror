From: Raphael Kubo da Costa <rakuco@FreeBSD.org>
Subject: Re: [PATCH v3] for-each-ref: Always check stat_tracking_info()'s return value.
Date: Sat, 03 Jan 2015 21:19:23 +0200
Message-ID: <868uhjzn7o.fsf@FreeBSD.org>
References: <1420232513-13867-1-git-send-email-raphael.kubo.da.costa@intel.com>
	<20150103114113.GC27793@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 20:25:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7UKA-0000TC-Rs
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 20:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbACTZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2015 14:25:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:52857 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbbACTZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 14:25:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Y7UJr-0000QZ-Ju
	for git@vger.kernel.org; Sat, 03 Jan 2015 20:25:03 +0100
Received: from a91-154-115-217.elisa-laajakaista.fi ([91.154.115.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 20:25:03 +0100
Received: from rakuco by a91-154-115-217.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 20:25:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-154-115-217.elisa-laajakaista.fi
User-Agent: Gnus/5.130012 (Ma Gnus v0.12) Emacs/24.4 (berkeley-unix)
Cancel-Lock: sha1:QXi5WhrLtHFW6KkIauBmNIdkHz8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261998>

Jeff King <peff@peff.net> writes:

> I think you could minimize this quite a bit as:
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index cba3454..f259c22 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -340,12 +340,11 @@ cat >expected <<EOF
>  EOF
>  
>  test_expect_success 'Check that :track[short] works when upstream is gone' '
> -	git branch --track to_delete master &&
> -	git branch --track parent_gone to_delete &&
> -	test_when_finished "git branch -D parent_gone" &&
> -	git branch -D to_delete &&
> -	git for-each-ref --format="%(upstream:track)" refs/heads/parent_gone >actual &&
> -	git for-each-ref --format="%(upstream:trackshort)" refs/heads/parent_gone >>actual &&
> +	test_when_finished "git config branch.master.merge refs/heads/master" &&
> +	git config branch.master.merge refs/heads/does-not-exist &&
> +	git for-each-ref \
> +		--format="%(upstream:track)$LF%(upstream:trackshort)" \
> +		refs/heads/master >actual &&
>  	test_cmp expected actual
>  '

Thanks Jeff (and Eric!) for the reviews so far. That does look much
better (the original test case was a reduction of a failure in a
Chromium test case).

One question about this suggestion: this test case actually depends on
the remote manipulations done in the setup test to work, as otherwise we
don't even test stat_tracking_info() because populate_value() would bail
out earlier on branch_get() returning NULL due to the branch's remote
not being set. Is it OK to continue assuming that?

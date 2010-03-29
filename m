From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] refs.c: Write reflogs for notes just like for branch heads
Date: Mon, 29 Mar 2010 16:25:22 +0200
Message-ID: <201003291625.22977.johan@herland.net>
References: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net> <0f06a30f395c14307066d0e4365fc61a294997db.1269867675.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 29 16:26:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwFuv-0000AK-JY
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 16:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab0C2O0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 10:26:07 -0400
Received: from smtp.opera.com ([213.236.208.81]:48529 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab0C2O0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 10:26:06 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o2TEPN7O031553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Mar 2010 14:25:28 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <0f06a30f395c14307066d0e4365fc61a294997db.1269867675.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143477>

On Monday 29 March 2010, Michael J Gruber wrote:
> The notes code intends to write reflog entries, but currently they
> are not written because log_ref_write() checks for the refname path
> explicitly.
>
> Add refs/notes to the list of allowed paths so that notes references
> are treated just like branch heads, i.e. according to
> core.logAllRefUpdates and core.bare.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Both patches are

Acked-by: Johan Herland <johan@herland.net>

> ---
> This is actually inspired by Jeff's novel notes use. I think there
> are use cases where a notes log makes sense (notes on commits) and
> those where it does not (metadata/textconv). In both cases having a
> reflog is useful. So, the next step is really to allow notes trees
> without history, which also takes care of the pruning issue. I know
> how to do this, I just have to decide about the configuration
> options.

I noticed that Jeff's proof-of-concept wrote notes trees without making 
notes commits, and although it seemed like a bug at first, it does - as 
you say - provide a rather nice way to store notes trees without 
history.

Note that I haven't explicitly designed the notes feature with this in 
mind, so it's wise to add testcases for expected behaviour once we 
start use history-less notes trees.

Thinking about it, the notes code itself (notes.h/.c) only wants a notes 
_tree_ object, so will probably work fine with history-less notes 
trees. But builtin/notes.c with its public commit_notes() function may 
be another story...


...Johan


>  refs.c           |    1 +
>  t/t3301-notes.sh |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 0f24c8d..d3db15a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1276,6 +1276,7 @@ static int log_ref_write(const char *ref_name,
> const unsigned char *old_sha1, if (log_all_ref_updates &&
>  	    (!prefixcmp(ref_name, "refs/heads/") ||
>  	     !prefixcmp(ref_name, "refs/remotes/") ||
> +	     !prefixcmp(ref_name, "refs/notes/") ||
>  	     !strcmp(ref_name, "HEAD"))) {
>  		if (safe_create_leading_directories(log_file) < 0)
>  			return error("unable to create directory for %s",
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 5410a6d..b2e7b07 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -69,7 +69,7 @@ cat >expect <<EOF
>  d423f8c refs/notes/commits@{0}: notes: Notes added by 'git notes
> add' EOF
>
> -test_expect_failure 'create reflog entry' '
> +test_expect_success 'create reflog entry' '
>  	git reflog show refs/notes/commits >output &&
>  	test_cmp expect output
>  '



-- 
Johan Herland, <johan@herland.net>
www.herland.net

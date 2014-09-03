From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] cache-tree: do not try to use an invalidated subtree
 info to build a tree
Date: Tue, 02 Sep 2014 22:56:31 -0400
Organization: Twitter
Message-ID: <1409712991.3057.10.camel@leckie>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	 <20140831120703.GA1240@serenity.lan>
	 <xmqqfvg9zqw9.fsf@gitster.dls.corp.google.com>
	 <xmqq8um1zq1q.fsf@gitster.dls.corp.google.com>
	 <xmqq4mwpzpfw.fsf_-_@gitster.dls.corp.google.com>
	 <xmqqvbp5y7ef.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 04:57:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP0kn-0001Ah-AX
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 04:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbaICC4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 22:56:35 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:63769 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbaICC4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 22:56:34 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so7751594qgd.9
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 19:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=i451gTODa2ts5VAUHL3aaw9MWAGzfzh8MIZGoCcj6Hg=;
        b=KeMVNySvo48rszZkz1hgxEP9gd2EPfI1UudN8lvXXokl7+ikaOq1cXd0N6VpuWqJBE
         HEVA1Ssa3qFKiAesg90QlnVqRfbW794fc+VHr+qMh8CKx5tGX1VhMb6OleF/mdx9WX/J
         eRcSdEfURHiR1rzxrr8Jj2bC7GyG5F+q9rL6Os0VVX7V4YwC9mYUi/J9iBKxKDZyK3hw
         bFvYupEcY1aIKBMckKrGlCbRDPsI42w0fOEmu18KOGJI/+i2bABB71/0oUr44iz2+uu5
         zFKIyMfNrSzsLphFIisDqEtdSeJdfz8U9imXH/BfHGbDlgXWROsXH6nmP3giJhXp1vpt
         2HcQ==
X-Gm-Message-State: ALoCoQmC3fZ8LF0e+1cjgn6NaTu3WpEiE5pImtON88V5rVwRliEOSo2trvVefdK32RqZmy6uxRVT
X-Received: by 10.229.38.3 with SMTP id z3mr61858941qcd.17.1409712993637;
        Tue, 02 Sep 2014 19:56:33 -0700 (PDT)
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id d3sm14335111qar.42.2014.09.02.19.56.32
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 19:56:32 -0700 (PDT)
In-Reply-To: <xmqqvbp5y7ef.fsf_-_@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256376>

On Tue, 2014-09-02 at 15:39 -0700, Junio C Hamano wrote:
> We punt from repairing the cache-tree during a branch switching if
> it involves having to create a new tree object that does not yet
> exist in the object store.  "mkdir dir && >dir/file && git add dir"
> followed by "git checkout" is one example, when a tree that records
> the state of such "dir/" is not in the object store.
> 
> However, after discovering that we do not have a tree object that
> records the state of "dir/", the caller failed to remember the fact
> that it noticed the cache-tree entry it received for "dir/" is
> invalidated, it already knows it should not be populating the level
> callchain to stop the code to attempt populating the level that has
> "dir/" as its immediate subdirectory, and it is not an error at all
> for the sublevel cache-tree entry gave it a bogus object name it
> shouldn't even look at.
> 
> This led the caller detect and report a non-existent error.  The end
> result was the same and we avoided stuffing a non-existent tree to
> the cache-tree, but we shouldn't have issued an alarming error
> message to the user.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Second try.  The level that has intent-to-add entries needs to be
>    kept invalidated but the level above it needs to treat as if the
>    i-t-a entries do not exist and build the whole tree; a directory
>    that does not yet have corresponding tree object while repairing
>    the cache-tree needs to invalidate itself *and* propagate the
>    (in)validity upwards.  They have to be treated differently but
>    the first attempt failed to do so.
> 
>  cache-tree.c          | 7 ++++++-
>  t/t0090-cache-tree.sh | 8 ++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/cache-tree.c b/cache-tree.c
> index f951d7d..57597ac 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -316,6 +316,7 @@ static int update_one(struct cache_tree *it,
>  		int pathlen, entlen;
>  		const unsigned char *sha1;
>  		unsigned mode;
> +		int expected_missing = 0;
>  
>  		path = ce->name;
>  		pathlen = ce_namelen(ce);
> @@ -332,8 +333,10 @@ static int update_one(struct cache_tree *it,
>  			i += sub->count;
>  			sha1 = sub->cache_tree->sha1;
>  			mode = S_IFDIR;
> -			if (sub->cache_tree->entry_count < 0)
> +			if (sub->cache_tree->entry_count < 0) {
>  				to_invalidate = 1;
> +				expected_missing = 1;
> +			}
>  		}
>  		else {
>  			sha1 = ce->sha1;
> @@ -343,6 +346,8 @@ static int update_one(struct cache_tree *it,
>  		}
>  		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
>  			strbuf_release(&buffer);
> +			if (expected_missing)
> +				return -1;
>  			return error("invalid object %06o %s for '%.*s'",
>  				mode, sha1_to_hex(sha1), entlen+baselen, path);
>  		}
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 48c4240..f9648a8 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -210,4 +210,12 @@ test_expect_success 'partial commit gives cache-tree' '
>  	test_cache_tree
>  '
>  
> +test_expect_success 'no phantom error when switching trees' '
> +	mkdir newdir &&
> +	>newdir/one &&
> +	git add newdir/one &&
> +	git checkout 2>errors &&
> +	! test -s errors
> +'
> +
>  test_done

LGTM.

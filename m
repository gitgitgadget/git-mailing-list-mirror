Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2130E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 00:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOANa (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 19:13:30 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:37052 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfKOANa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Nov 2019 19:13:30 -0500
Received: from [80.153.18.91] (helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1iVPEs-00051d-1r; Fri, 15 Nov 2019 01:13:26 +0100
Subject: Re: rev-list and "ambiguous" IDs
To:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
 <20191114055906.GA10643@sigill.intra.peff.net>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
Date:   Fri, 15 Nov 2019 01:12:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191114055906.GA10643@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1573776809;60c1c848;
X-HE-SMSGID: 1iVPEs-00051d-1r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.11.2019 um 06:59 schrieb Jeff King:

[...]

> You can also set core.disambiguate to "committish" (or even "commit").
> At the time we added that option (and started reporting the list of
> candidates), we pondered whether it might make sense to make that the
> default.

I did not know this setting. Thanks!

> That would probably help in a lot of cases, but the argument
> against it is that when it goes wrong, it may be quite confusing (so
> we're better off with the current message, which punts back to the
> user).

Just out of curiosity: Is there a use case for inspecting non-commit
objects with git log?

If I do (in the git repo)

$ git log 1231

I get

error: short SHA1 1231 is ambiguous
hint: The candidates are:
hint:   123139fc89 tree
hint:   12316a1673 tree
hint:   123144fe8a blob
fatal: ambiguous argument '1231': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

with
$ git --version
git version 2.24.0.windows.2

and all of these candidates are no commits.

> I think it also comes up fairly rarely these days, as short sha1s we
> print have some headroom built in (as you can see above; the one you've
> input is really quite short compared to anything Git would have printed
> in that repo).
> 
>> Also, while considering this, I noticed that `git rev-list
>> dc41e11ee18` (the blob from the output above) doesn't fail. It
>> silently exits, nothing written to stdout or stderr, with 0 status. A
>> little surprising; I would have expected rev-list to complain that
>> dc41e11ee18 isn't a valid commit-ish value.
> 
> Yeah, this is a separate issue. If the revision machinery has pending
> trees or blobs but isn't asked to show them via "--objects", then it
> just ignores them.
> 
> I've been running with the patch below for several years; it just adds a
> warning when we ignore such an object. I've been tempted to send it for
> inclusion, but it has some rough edges:
> 
>   - there are some fast-export calls in the test scripts that trigger
>     this. I don't remember the details, and what the fix would look
>     like.
> 
>   - it makes wildcards like "rev-list --all" complain, because they may
>     add a tag-of-blob, for example (in git.git, junio-gpg-pub triggers
>     this). Things like "--all" would probably need to get smarter, and
>     avoid adding non-commits in the first place (when --objects is not
>     in use, of course)
> 
> ---
>  revision.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 0e39b2b8a5..7dc2d9a822 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -393,6 +393,16 @@ void add_pending_oid(struct rev_info *revs, const char *name,
>  	add_pending_object(revs, object, name);
>  }
>  
> +static void warn_ignored_object(struct object *object, const char *name)
> +{
> +	if (object->flags & UNINTERESTING)
> +		return;
> +
> +	warning(_("ignoring %s object in traversal: %s"),
> +		type_name(object->type),
> +		(name && *name) ? name : oid_to_hex(&object->oid));
> +}
> +
>  static struct commit *handle_commit(struct rev_info *revs,
>  				    struct object_array_entry *entry)
>  {
> @@ -458,8 +468,10 @@ static struct commit *handle_commit(struct rev_info *revs,
>  	 */
>  	if (object->type == OBJ_TREE) {
>  		struct tree *tree = (struct tree *)object;
> -		if (!revs->tree_objects)
> +		if (!revs->tree_objects) {
> +			warn_ignored_object(object, name);
>  			return NULL;
> +		}
>  		if (flags & UNINTERESTING) {
>  			mark_tree_contents_uninteresting(revs->repo, tree);
>  			return NULL;
> @@ -472,8 +484,10 @@ static struct commit *handle_commit(struct rev_info *revs,
>  	 * Blob object? You know the drill by now..
>  	 */
>  	if (object->type == OBJ_BLOB) {
> -		if (!revs->blob_objects)
> +		if (!revs->blob_objects) {
> +			warn_ignored_object(object, name);
>  			return NULL;
> +		}
>  		if (flags & UNINTERESTING)
>  			return NULL;
>  		add_pending_object_with_path(revs, object, name, mode, path);
> 


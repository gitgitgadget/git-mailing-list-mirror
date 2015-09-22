From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/4] worktree: add functions to get worktree details
Date: Tue, 22 Sep 2015 11:10:34 -0700
Message-ID: <xmqqio72495x.fsf@gitster.mtv.corp.google.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
	<1442583027-47653-4-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeS1g-0008Np-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299AbbIVSKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:10:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33240 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757961AbbIVSKh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:10:37 -0400
Received: by pacex6 with SMTP id ex6so15808326pac.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=O0GIuOTXMUfWxd90D3U34bjJSdA6wzqQVkVie4j0Wko=;
        b=gPeJUo3jiHCU10k3G3lfov5bf9oP3iTKArL6mcgxJDA4x9ZXYCSN6gnMdxDgZW6kuP
         /yD0q+zz+8oQh40QqqpPSGd2LzBvImRNXuk2YB0H79yaZR7Yc0kVDAHcfVC2Ju4uUGFq
         gQ+PZt+XG6ehg5gR+exF9JnsSGCCEkdVKKgMyq96kx9YzCA7iTDynXhymS+RSBNzeVyJ
         gK+1FDBA768NBSxHwGINDNme9asNrC/KaBHfzYLOBw8+SE1GkIKYGSuu8sWmnpldrO1T
         n+LT3pcmexV1RnDwQ/gXeFf+EtpmWlPtxg5XEE9ObPjlbGuIq/1bZoIvU9IhhRajS1fg
         fFtQ==
X-Received: by 10.68.65.104 with SMTP id w8mr32745795pbs.48.1442945436923;
        Tue, 22 Sep 2015 11:10:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id jw6sm3480180pbb.86.2015.09.22.11.10.34
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 11:10:35 -0700 (PDT)
In-Reply-To: <1442583027-47653-4-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 18 Sep 2015 09:30:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278407>

Michael Rappazzo <rappazzo@gmail.com> writes:

> +/**
> + * get the main worktree
> + */
> +static struct worktree *get_main_worktree()

static struct worktree *get_main_worktree(void)

> +{
> +	struct worktree *worktree = NULL;
>  	struct strbuf path = STRBUF_INIT;
> +	struct strbuf worktree_path = STRBUF_INIT;
> +	struct strbuf git_dir = STRBUF_INIT;
> +	struct strbuf head_ref = STRBUF_INIT;
> +	int is_bare = 0;
> +	int is_detached = 0;
>  
> +	strbuf_addf(&git_dir, "%s", absolute_path(get_git_common_dir()));
> +	strbuf_addf(&worktree_path, "%s", absolute_path(get_git_common_dir()));

Why not strbuf_add(&git_dir, absolute_path(get_git_common_dir()))
followed by strbuf_addbuf(&git_dir, &worktree_path)?

> +	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> +	if (is_bare)
> +		strbuf_strip_suffix(&worktree_path, "/.");

Hmm, it is not immediately obvious which part is meant to be a
faithful translations from the old find_main_symref() that grab the
same kind of information the old code used to discover (and record
in a new mechanism that is "struct worktree"), and which part is a
new code that is needed to grab new pieces of information.  The
effort in [PATCH 2/4] to make it easier to follow sort of lost by
this rewrite.

I presume that discovery of the git_dir is from the original and
everything else including is_bare bit, head_ref, is_detached are
new?

Splitting this patch further into two may help showing the changes
better.  First move to the "grab information into an element of the
worktree array" code structure without adding new information, and
then "now make the worktree structure richer" as a follow up,
perhaps?

> +/**
> + * get the estimated worktree count for use in sizing the worktree array
> + * Note that the minimum count should be 2 (main worktree + NULL).  Using the
> + * file count in $GIT_COMMON_DIR/worktrees includes '.' and '..' so the
> + * minimum is satisfied by counting those entries.
> + */
> +static int get_estimated_worktree_count()
> +{
> +...
>  }

This is new.  My gut-feeling is that we would probably not want to
do this (see below).

> +struct worktree **get_worktrees(void)
>  {
> +	struct worktree **list = NULL;
>  	struct strbuf path = STRBUF_INIT;
>  	DIR *dir;
>  	struct dirent *d;
> -	char *existing;
> +	int counter = 0;
> +
> +	list = xmalloc(get_estimated_worktree_count() * sizeof(struct worktree *));

Here you scanned the directory to see how many possible worktrees
there are "at this moment".

Time passes.

How do you know that nobody added more worktrees in the meantime?
You don't.

>  
> -	if ((existing = find_main_symref(symref, target)))
> -		return existing;
> +	if ((list[counter] = get_main_worktree()))
> +		counter++;
>  
>  	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
>  	dir = opendir(path.buf);
>  	strbuf_release(&path);
> +	if (dir) {
> +		while ((d = readdir(dir)) != NULL) {
> +			struct worktree *linked = NULL;
> +			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +				continue;
> +
> +			if ((linked = get_linked_worktree(d->d_name))) {
> +				list[counter++] = linked;

Which means that nothing stops you from overrunning the list[] with
this iteration.

By the way, when the body of "if" and "else" both consists of a
single statement, we tend to drop braces.

> +			}

And in order to avoid overrunning, you would need to do the usual
ALLOC_GROW() dance on list[] _anyway_.  So there is no much point,
other than to optimize for a case where you have thousands of
worktrees and the usual ALLOC_GROW() approach would have to do
realloc(3) too many times, to have the initial "guestimate" scan.

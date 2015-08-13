From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/2 v4] worktree: add 'for_each_worktree' function
Date: Thu, 13 Aug 2015 15:23:15 -0400
Organization: Twitter
Message-ID: <1439493795.8855.16.camel@twopensource.com>
References: <1439490739-9361-1-git-send-email-rappazzo@gmail.com>
	 <1439490739-9361-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, sunshine@sunshineco.com, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPy65-0006hK-IE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbbHMTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:23:21 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33865 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbbHMTXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:23:17 -0400
Received: by qgeg42 with SMTP id g42so38302641qge.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=XPLmDEjjpJCzMzl0AiPwPo+/BRPf55m7nr/oq7lvv9Q=;
        b=DJTuJqkJuLliuzLoNucZj8ho8DyXYNedBPk9DCdiqV4vOkccgvEf8a6HvLtwtIQDtY
         2NlqIRtVOiJ1dm6h1FRS2OvssLjnYttgaeoBohzLNx0GZd/Xvaq/FlF+9GwHoH0ZLJcg
         BtbKqUJarVxYMMXiJQ7gjRVQfOeKWaoX3JZ88hE9+BVGV5Jo1bKWzTPCXRub6OiHp0+1
         h8bUYYu+B/1JsUdPGZt/LCnIFcqP4mkDPJoV5LHS8k8aSCFCjpxQHSr0irPOzIzbt6wZ
         T3c8FoK3mAdHZPSHY4yJvJDZrcfHNO6jyuXz8UGxJvctGJTGl+WNahnX8a1GLxS8vtlJ
         AeRg==
X-Gm-Message-State: ALoCoQnkgmAaiDZxM8Bh0jrcTHmk6dBt4Jt9U5u6zzVffCl7fFOzTSUAobgp3HNF7NChjwjM6dh2
X-Received: by 10.140.23.80 with SMTP id 74mr20537800qgo.18.1439493796474;
        Thu, 13 Aug 2015 12:23:16 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b92sm1648877qkh.17.2015.08.13.12.23.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 12:23:15 -0700 (PDT)
In-Reply-To: <1439490739-9361-2-git-send-email-rappazzo@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275888>

On Thu, 2015-08-13 at 14:32 -0400, Michael Rappazzo wrote:
> for_each_worktree iterates through each worktree and invokes a callback
> function.  The main worktree (if not bare) is always encountered first,
> followed by worktrees created by `git worktree add`.

Thanks!  This will be super-useful!  I particularly appreciate the
detailed function documentation.

More comments below.

> If the callback function returns a non-zero value, iteration stops, and
> the callback's return value is returned from the for_each_worktree
> function.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  builtin/worktree.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 430b51e..a43e360 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -26,6 +26,14 @@ static int show_only;
>  static int verbose;
>  static unsigned long expire;
>  
> +/*
> + * The signature for the callback function for the for_each_worktree()
> + * function below.  The memory pointed to by the callback arguments
> + * is only guaranteed to be valid for the duration of a single
> + * callback invocation.
> + */
> +typedef int each_worktree_fn(const char *path, const char *git_dir, void *cb_data);
> +
>  static int prune_worktree(const char *id, struct strbuf *reason)
>  {
>  	struct stat st;
> @@ -358,6 +366,82 @@ static int add(int ac, const char **av, const char *prefix)
>  
>  	return add_worktree(path, branch, &opts);
>  }
> +/*

nit: newline above this line

> + * Iterate through each worktree and invoke the callback function.  If
> + * the callback function returns non-zero, the iteration stops, and
> + * this function returns that return value
> + */
> +static int for_each_worktree(each_worktree_fn fn, void *cb_data)
> +{
> +	struct strbuf main_path = STRBUF_INIT;
> +	struct dirent *d;


The scope of d can be smaller; move it down to the place I've marked
below

> +	struct stat st;
> +	struct strbuf worktree_path = STRBUF_INIT;
> +	struct strbuf worktree_git = STRBUF_INIT;
> +	const char *common_dir;
> +	DIR *dir;

ditto

> +	int main_is_bare = 0;
> +	int ret = 0;
> +
> +	common_dir = get_git_common_dir();
> +	if (!strcmp(common_dir, get_git_dir())) {
> +		/* simple case - this is the main repo */
> +		main_is_bare = is_bare_repository();
> +		if (!main_is_bare) {
> +			strbuf_addstr(&main_path, get_git_work_tree());
> +		} else {
> +			strbuf_addstr(&main_path, common_dir);
> +		}
> +	} else {
> +		strbuf_addstr(&main_path, common_dir);
> +		strbuf_strip_suffix(&main_path, "/.git");
> +		/* If the common_dir DOES NOT end with '/.git', then it is bare */
> +		main_is_bare = !strcmp(common_dir, main_path.buf);

strbuf_strip_suffix returns 1 if the suffix was stripped and 0
otherwise, so there is no need for this strcmp.

I'm a little worried about this path manipulation; it looks like the
config setting core.bare is the actual thing to check?  (Along with
maybe the GIT_WORK_TREE environment var; not sure how that interacts
with worktrees).

> +	}
> +
> +	if (!main_is_bare) {
> +		strbuf_addstr(&worktree_path, main_path.buf);
> +
> +		strbuf_addstr(&main_path, "/.git");
> +		strbuf_addstr(&worktree_git, main_path.buf);
> +
> +		ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
> +		if (ret)
> +			goto done;
> +	}
> +	strbuf_addstr(&main_path, "/worktrees");

Earlier, you said:
		strbuf_addstr(&main_path, common_dir);
		strbuf_strip_suffix(&main_path, "/.git");

Now you are adding /worktrees.  Doesn't this mean, in the non-bare case,
that you'll be looking in $common_dir/worktrees instead of
$common_dir/.git/worktrees ?

> +	if (is_directory(main_path.buf)) {

declare dir here...

> +		dir = opendir(main_path.buf);
> +		if (dir) {

... and d here.

> +			while ((d = readdir(dir)) != NULL) {
> +				if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +					continue;
> +
> +				strbuf_reset(&worktree_git);
> +				strbuf_addf(&worktree_git, "%s/%s/gitdir", main_path.buf, d->d_name);

tioli: main_path never changes, so no need to keep chopping it off and
adding it back on; just truncate worktree_git to main_path.len + 1 here
and then add d->name.

> +				if (stat(worktree_git.buf, &st))
> +					continue;

Do we want to report errors other than ENOENT? (genuine question)

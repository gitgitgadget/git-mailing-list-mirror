Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A971FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbcLEXhj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 5 Dec 2016 18:37:39 -0500
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:51265 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbcLEXhi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:37:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id AB30010002E;
        Mon,  5 Dec 2016 23:37:36 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lcawJR7SzzOw; Mon,  5 Dec 2016 23:37:36 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 98EF48002E;
        Mon,  5 Dec 2016 23:37:36 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 5 Dec 2016 23:37:36 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%25]) with mapi id
 15.00.1156.000; Mon, 5 Dec 2016 23:37:36 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>,
        "bmwill@google.com" <bmwill@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: RE: [RFC PATCHv2 08/17] update submodules: add depopulate_submodule
Thread-Topic: [RFC PATCHv2 08/17] update submodules: add depopulate_submodule
Thread-Index: AQHSTPx8VQFCntYzJk+yRQ3uyrIzxqD5+VEg
Date:   Mon, 5 Dec 2016 23:37:36 +0000
Message-ID: <832dcc3eec0d4237a1e2766e8df690ee@exmbdft7.ad.twosigma.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-9-sbeller@google.com>
In-Reply-To: <20161203003022.29797-9-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Friday, December 02, 2016 7:30 PM
> To: bmwill@google.com; David Turner
> Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; hvoigt@hvoigt.net;
> gitster@pobox.com; Stefan Beller
> Subject: [RFC PATCHv2 08/17] update submodules: add depopulate_submodule
> 
> Implement the functionality needed to enable work tree manipulating
> commands so that a deleted submodule should not only affect the index
> (leaving all the files of the submodule in the work tree) but also to
> remove the work tree of the superproject (including any untracked files).

"including any untracked files" bothers me, I think.  Checkout is not usually willing to overwrite untracked files; it seems odd to me that it would be willing to do so in the submodule case.  I would be OK if they were both untracked and gitignored, I think.

> To do so, we need an equivalent of "rm -rf", which is already found in
> entry.c, so expose that and for clarity add a suffix "_or_dir" to it.
> 
> That will only work properly when the submodule uses a gitfile instead of
> a .git directory and no untracked files are present. Otherwise the removal
> will fail with a warning (which is just what happened until now).
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  cache.h     |  2 ++
>  entry.c     |  5 +++++
>  submodule.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  submodule.h |  1 +
>  4 files changed, 54 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index a50a61a197..b645ca2f9a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -2018,4 +2018,6 @@ void sleep_millisec(int millisec);
>   */
>  void safe_create_dir(const char *dir, int share);
> 
> +extern void remove_directory_or_die(struct strbuf *path);
> +
>  #endif /* CACHE_H */
> diff --git a/entry.c b/entry.c
> index c6eea240b6..02c4ac9f22 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -73,6 +73,11 @@ static void remove_subtree(struct strbuf *path)
>  		die_errno("cannot rmdir '%s'", path->buf);  }
> 
> +void remove_directory_or_die(struct strbuf *path) {
> +	remove_subtree(path);
> +}
> +
>  static int create_file(const char *path, unsigned int mode)  {
>  	mode = (mode & 0100) ? 0777 : 0666;
> diff --git a/submodule.c b/submodule.c
> index 62e9ef3872..7bb64d6c69 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -324,6 +324,52 @@ void prepare_submodule_repo_env(struct argv_array
> *out)
>  	argv_array_push(out, "GIT_DIR=.git");
>  }
> 
> +int depopulate_submodule(const char *path) {
> +	int ret = 0;
> +	struct strbuf pathbuf = STRBUF_INIT;
> +	char *dot_git = xstrfmt("%s/.git", path);
> +
> +	/* Is it populated? */
> +	if (!resolve_gitdir(dot_git))
> +		goto out;
> +
> +	/* Does it have a .git directory? */
> +	if (!submodule_uses_gitfile(path)) {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +
> +		prepare_submodule_repo_env(&cp.env_array);
> +		argv_array_pushl(&cp.args, "submodule--helper",
> +				 "embed-git-dirs", path, NULL);
> +		cp.git_cmd = 1;
> +		if (run_command(&cp)) {
> +			warning(_("Cannot remove submodule '%s'\n"
> +				  "because it (or one of its nested submodules)
> has a git \n"
> +				  "directory in the working tree, which could not
> be embedded\n"
> +				  "the superprojects git directory
> automatically."), path);

What if instead it couldn't run the command because you're out of file descriptors or pids or memory or something?

I think this message should be in submodule--helper --embed-git-dirs instead, and we should just pass it through here.  Or, perhaps, instead of shelling out here, we should just call the functions directly?

> +			ret = -1;
> +			goto out;
> +		}
> +
> +		if (!submodule_uses_gitfile(path)) {
> +			/*
> +			 * We should be using a gitfile by now, let's double

Comma splice.  

> +			 * check as loosing the git dir would be fatal.

s/loosing/losing/

> +			 */
> +			die("BUG: \"git submodule--helper embed git-dirs '%s'\"
> "
> +			    "did not embed the git-dirs recursively for '%s'",
> +			    path, path);
> +		}
> +	}
> +
> +	strbuf_addstr(&pathbuf, path);
> +	remove_directory_or_die(&pathbuf);
> +out:
> +	strbuf_release(&pathbuf);
> +	free(dot_git);
> +	return ret;
> +}
> +
>  /* Helper function to display the submodule header line prior to the full
>   * summary output. If it can locate the submodule objects directory it
> will
>   * attempt to lookup both the left and right commits and put them into
> the diff --git a/submodule.h b/submodule.h index 7d890e0464..d8bb1d4baf
> 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -63,6 +63,7 @@ extern void set_config_update_recurse_submodules(int
> value);
>   */
>  extern int submodule_is_interesting(const char *path);  extern int
> submodules_interesting_for_update(void);
> +extern int depopulate_submodule(const char *path);
>  extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
> extern int fetch_populated_submodules(const struct argv_array *options,
>  			       const char *prefix, int command_line_option,
> --
> 2.11.0.rc2.28.g2673dad


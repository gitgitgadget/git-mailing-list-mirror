From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Thu, 16 Sep 2010 12:29:14 -0700
Message-ID: <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <jens.lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 16 21:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwK95-00018A-1v
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 21:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0IPT3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 15:29:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62619 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0IPT3Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 15:29:16 -0400
Received: by pvg2 with SMTP id 2so439796pvg.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 12:29:16 -0700 (PDT)
Received: by 10.114.110.16 with SMTP id i16mr3922690wac.208.1284665356181;
        Thu, 16 Sep 2010 12:29:16 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id k23sm4959579waf.5.2010.09.16.12.29.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 12:29:15 -0700 (PDT)
In-Reply-To: <4C9221B6.7070807@web.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156348>

Unfortunately, the only effect this had was to change the order of fetches (it now appears to be case-sensitive alphabetical). After applying this patch, this is what I saw (using the same terms as my previous email):

Fetching submodule G
Fetching submodule B
Fetching submodule F
Fetching submodule C
Fetching submodule H
Fetching submodule E
Fetching submodule A
Fetching submodule D

Note that it's still telling me that it's fetching submodule H even though this inside of submodule C rather than at the root level. I also verified this by running `git ls-tree -r HEAD | grep commit` and observed that only submodules A-G show up in that list.

-Kevin Ballard

On Sep 16, 2010, at 6:55 AM, Jens Lehmann wrote:

> In the first version the .gitmodules file was parsed and all submodules
> found there were recursively fetched. This lead to problems when the
> .gitmodules file was not properly set up. "git submodule update" gets
> this information from the index via "git ls-files", lets do the same here.
> 
> Reported-by: Kevin Ballard <kevin@sb.org>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> 
> Could it be that the information in your .gitmodules files is not
> quite right? Then this patch should fix your problems with the
> recursion. Please test it and let me know if the submodules are
> now recursively fetched as they should.
> 
> 
> submodule.c |   25 +++++++++++++++++++------
> 1 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 05661e2..13a694b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -240,7 +240,7 @@ void show_submodule_summary(FILE *f, const char *path,
> 
> int fetch_populated_submodules(int forced)
> {
> -	int result = 0;
> +	int i, result = 0;
> 	struct child_process cp;
> 	const char *argv[] = {
> 		"fetch",
> @@ -251,6 +251,10 @@ int fetch_populated_submodules(int forced)
> 	if (!work_tree)
> 		return 0;
> 
> +	if (!the_index.initialized)
> +		if (read_cache() < 0)
> +			die("index file corrupt");
> +
> 	memset(&cp, 0, sizeof(cp));
> 	cp.argv = argv;
> 	cp.env = local_repo_env;
> @@ -258,25 +262,34 @@ int fetch_populated_submodules(int forced)
> 	cp.no_stdin = 1;
> 	cp.out = -1;
> 
> -	for_each_string_list_item(name_for_path, &config_name_for_path) {
> +	for (i = 0; i < active_nr; i++) {
> 		struct strbuf submodule_path = STRBUF_INIT;
> 		struct strbuf submodule_git_dir = STRBUF_INIT;
> -		const char *git_dir;
> +		struct cache_entry *ce = active_cache[i];
> +		const char *git_dir, *name;
> +
> +		if (!S_ISGITLINK(ce->ce_mode))
> +			continue;
> +
> +		name = ce->name;
> +		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
> +		if (name_for_path)
> +			name = name_for_path->util;
> 
> 		if (!forced) {
> 			struct string_list_item *fetch_option;
> -			fetch_option = unsorted_string_list_lookup(&config_fetch_for_name, name_for_path->util);
> +			fetch_option = unsorted_string_list_lookup(&config_fetch_for_name, name);
> 			if (fetch_option && !fetch_option->util)
> 				continue;
> 		}
> 
> -		strbuf_addf(&submodule_path, "%s/%s", work_tree, name_for_path->string);
> +		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
> 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
> 		git_dir = read_gitfile_gently(submodule_git_dir.buf);
> 		if (!git_dir)
> 			git_dir = submodule_git_dir.buf;
> 		if (is_directory(git_dir)) {
> -			printf("Fetching submodule %s\n", name_for_path->string);
> +			printf("Fetching submodule %s\n", ce->name);
> 			cp.dir = submodule_path.buf;
> 			if (run_command(&cp))
> 				result = 1;
> -- 
> 1.7.3.rc2.232.g3328

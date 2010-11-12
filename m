From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH, maint] setup: make sure git_dir path is in a permanent
	buffer, getenv(3) case
Date: Fri, 12 Nov 2010 17:03:29 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20101112140329.GA29604@tugrik.mns.mnsspb.ru>
References: <1289498903-18413-1-git-send-email-kirr@mns.spb.ru> <20101111181728.GF16972@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 15:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGuCu-0000zD-Ff
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 15:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab0KLOB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 09:01:59 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:57013 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212Ab0KLOB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 09:01:58 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PGuCO-0003B1-4d; Fri, 12 Nov 2010 17:01:52 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PGuDx-00085I-Ot; Fri, 12 Nov 2010 17:03:29 +0300
Content-Disposition: inline
In-Reply-To: <20101111181728.GF16972@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161342>

On Thu, Nov 11, 2010 at 12:17:28PM -0600, Jonathan Nieder wrote:
> Kirill Smelkov wrote:
> 
> > getenv(3) returns not-permanent buffer which may be changed by e.g.
> > putenv(3) call (*).
> 
> Yikes.  Thanks for the example.

Nevermind. However it was not so fun to debug :)

> > --- a/environment.c
> > +++ b/environment.c
> > @@ -88,6 +88,7 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
> >  static void setup_git_env(void)
> >  {
> >  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
> > +	git_dir = git_dir ? xstrdup(git_dir) : NULL;
> >  	if (!git_dir) {
> >  		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> >  		git_dir = git_dir ? xstrdup(git_dir) : NULL;
> 
> Maybe we can avoid (some) repetition like this?
> 
> diff --git a/environment.c b/environment.c
> index de5581f..942f1e4 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -87,25 +87,31 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
>  static void setup_git_env(void)
>  {
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
> -	if (!git_dir) {
> -		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> -		git_dir = git_dir ? xstrdup(git_dir) : NULL;
> -	}
>  	if (!git_dir)
> +		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> +	if (git_dir)
> +		git_dir = xstrdup(git_dir);
> +	else
>  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> +
>  	git_object_dir = getenv(DB_ENVIRONMENT);
> -	if (!git_object_dir) {
> -		git_object_dir = xmalloc(strlen(git_dir) + 9);
> -		sprintf(git_object_dir, "%s/objects", git_dir);
> -	}
> +	if (git_object_dir)
> +		git_object_dir = xstrdup(git_object_dir);
> +	else
> +		git_object_dir = git_pathdup("objects");
> +
>  	git_index_file = getenv(INDEX_ENVIRONMENT);
> -	if (!git_index_file) {
> -		git_index_file = xmalloc(strlen(git_dir) + 7);
> -		sprintf(git_index_file, "%s/index", git_dir);
> -	}
> +	if (git_index_file)
> +		git_index_file = xstrdup(git_index_file);
> +	else
> +		git_index_file = git_pathdup("index");
> +
>  	git_graft_file = getenv(GRAFT_ENVIRONMENT);
> -	if (!git_graft_file)
> +	if (git_graft_file)
> +		git_graft_file = xstrdup(git_graft_file);
> +	else
>  		git_graft_file = git_pathdup("info/grafts");
> +

To me it gets hairy and we don't cover all and even most getenv cases.
Look e.g. in commit.c:

    static void determine_author_info(void)
    {
            char *name, *email, *date;
    
            name = getenv("GIT_AUTHOR_NAME");
            email = getenv("GIT_AUTHOR_EMAIL");
            date = getenv("GIT_AUTHOR_DATE");

            /* ... */

            if (signoff) {
                    struct strbuf sob = STRBUF_INIT;
                    int i;
    
                    strbuf_addstr(&sob, sign_off_header);
                    strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
                                                 getenv("GIT_COMMITTER_EMAIL")));

            /* ... */

notes.c:

    struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
    {
            struct notes_rewrite_cfg *c = xmalloc(sizeof(struct notes_rewrite_cfg));
            const char *rewrite_mode_env = getenv(GIT_NOTES_REWRITE_MODE_ENVIRONMENT);
            const char *rewrite_refs_env = getenv(GIT_NOTES_REWRITE_REF_ENVIRONMENT);


editor.c:

    const char *git_editor(void)
    {
            const char *editor = getenv("GIT_EDITOR");
            const char *terminal = getenv("TERM");

http-backend.c:

    static void run_service(const char **argv)
    {
            const char *encoding = getenv("HTTP_CONTENT_ENCODING");
            const char *user = getenv("REMOTE_USER");
            const char *host = getenv("REMOTE_ADDR");


etc...


To me, it's very unfortunate that subsequent getenv() could overwrite
previous getenv() result, but according to `man 3 getenv` all these
places are buggy.

Maybe we'll need something like our own xgetenv() which will keep vars
in some kind of hash tab so that get/put on other vars do not interfere
with what was originally returned by xgetenv().

I don't know.

Unfortunately I can't afford myself to dive into all this, so please
choose what you like more.


Thanks,
Kirill

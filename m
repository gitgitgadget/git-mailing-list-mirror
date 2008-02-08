From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [Janitors] value could be NULL in config parser
Date: Fri, 8 Feb 2008 11:07:42 -0600
Message-ID: <5d46db230802080907i2a13c4fep6d4c0af436fd9704@mail.gmail.com>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWi3-0007EK-II
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 18:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbYBHRHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 12:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbYBHRHq
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 12:07:46 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:6295 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964812AbYBHRHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 12:07:44 -0500
Received: by rn-out-0910.google.com with SMTP id i24so5272039rng.19
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 09:07:42 -0800 (PST)
Received: by 10.150.123.16 with SMTP id v16mr5393108ybc.76.1202490462379;
        Fri, 08 Feb 2008 09:07:42 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 09:07:42 -0800 (PST)
In-Reply-To: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 6514423e7c72ab31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73113>

On 2/8/08, Junio C Hamano <gitster@pobox.com> wrote:
> If somebody wants to dip his or her toe in git hacking, and is
> tempted to send in a "clean up" patch (e.g. whitespace, coding
> style) that does not really _fix_ anything, please don't.
>
> I have a task of similar complexity (meaning, reasonably easy)
> that is much more useful and appreciated than clean-up patches
> for you.
>
> The callback functions that are passed to git_config() need to
> be audited so that they do not barf when given NULL.  Currently,
> many of them are not safe.
>
> A callback function of git_config() is called when the command
> reads value from .git/config and friends.  The function takes
> two parameters, var and value.  var is never NULL and it is the
> name of the configuration variable found in the file being
> read.  value could be either string or NULL.
>
> A NULL value is boolean "true".  For example, on MS-DOS, you may
> have something like this:
>
>         [core]
>                 autocrlf
>
> and your callback will be called with var = "core.autocrlf" and
> value = NULL in such a case.
>
> If you want to fix them (you do not have to do all of them, and
> if you would like to help, please make one patch per function
> fixed), the procedure is:
>
>  (1) Find calling sites for git_config().  For example, we find
>      one in archive-tar.c::write_tar_archive().
>
>         int write_tar_archive(struct archiver_args *args)
>         {
>                 int plen = args->base ? strlen(args->base) : 0;
>
>                 git_config(git_tar_config);
>
>                 archive_time = args->time;
>                 verbose = args->verbose;
>         ...
>
>  (2) Look at the function that is passed to git_config().
>
>         static int git_tar_config(const char *var, const char *value)
>         {
>                 if (!strcmp(var, "tar.umask")) {
>                         if (!strcmp(value, "user")) {
>                                 tar_umask = umask(0);
>                                 umask(tar_umask);
>                         } else {
>                                 tar_umask = git_config_int(var, value);
>                         }
>                         return 0;
>                 }
>                 return git_default_config(var, value);
>         }
>
>  (3) Let's fix it.  If the user's configuration has:
>
>         [tar]
>                 umask
>
>      it is an illegal configuration, but the code above does not
>      check for NULL, and the second strcmp() would fail.  If we
>      guard that strcmp() with a check against NULL, we would be
>      Ok.  git_config_int() will correctly barf telling the user
>      that "tar.umask" configuration is wrong.
>
>  (4) Then send in a patch.  Again, one patch per fixed function,
>      please.  The message may look like this:
>
> -- >8 --
> [PATCH] archive-tar.c: guard config parser from value=NULL
>
> Signed-off-by: A U Thor <author@example.com>
>
>  archive-tar.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index e1bced5..30aa2e2 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -222,7 +222,7 @@ static void write_global_extended_header(const unsigned char *sha1)
>  static int git_tar_config(const char *var, const char *value)
>  {
>         if (!strcmp(var, "tar.umask")) {
> -               if (!strcmp(value, "user")) {
> +               if (value && !strcmp(value, "user")) {
>                         tar_umask = umask(0);
>                         umask(tar_umask);
>                 } else {
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I can try my hand at that.  I will send some patches later today (after work).

-Govind

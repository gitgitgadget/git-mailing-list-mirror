From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/8] config: Trivial rename in preparation for 
	parseopt.
Date: Tue, 17 Feb 2009 04:42:38 +0200
Message-ID: <94a0d4530902161842s1d1d9fech3786cce1f1a1135d@mail.gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
	 <7v3aedet0j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gerrit Pape <pape@smarden.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZFwY-0000bD-Je
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbZBQCmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbZBQCml
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:42:41 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:36358 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbZBQCml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:42:41 -0500
Received: by bwz5 with SMTP id 5so3595736bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 18:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TIwF6yQlAkaK7D1TNKoB5zsKcBr9XG3xNLm8J+QNZUo=;
        b=eE5ZGRwBQulEujiK/4idxLswp9bGpQczb+KO2iZmZvkK2c/1ZL8EeNhpwSgRsIGPNC
         ql7/AtxwgQ4DAbSeqJYgY5fBMosh4OhRXTyvpDzri53Myrmu7lphfgU2PLf4aLI7Apit
         /JrRnvU/0OwUaiW287BsTjC/kqmbCKO6WCWyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Mo9MKbYjctucc+9lexQJz5zKtuWY5fPJdoILIB0noABfMha3H0vNbS1NYyip/9AKP1
         ApMUQ3FtmiH+FM56aLIrkjZOSv4A2fJuQnonfo918KnZVrP7VjbeG2v9veGsLuvyXo0Q
         2RUcvW0IVUlIOHN9LwUZ7/YIEznndy6TGbhAs=
Received: by 10.181.216.12 with SMTP id t12mr524239bkq.122.1234838558801; Mon, 
	16 Feb 2009 18:42:38 -0800 (PST)
In-Reply-To: <7v3aedet0j.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110299>

On Tue, Feb 17, 2009 at 3:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> When using the --list option general errors where not properly reported,
>> only errors related with the 'file'. Now they are reported, and 'file'
>> is irrelevant.
>> ...
>> @@ -299,10 +300,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>>               else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
>>                       if (argc != 2)
>>                               usage(git_config_set_usage);
>> -                     if (git_config(show_all_config, NULL) < 0 &&
>> -                                     file && errno)
>> -                             die("unable to read config file %s: %s", file,
>> -                                 strerror(errno));
>> +                     if (git_config(show_all_config, NULL) < 0)
>> +                             die("error processing config file(s)");
>
> Does the author of 93a56c2 (git-config: print error message if the config
> file cannot be read, 2007-10-12) have any comment on this change (cc:ed)?

I looked at the debian bug report[1], the guy complains about 2 things:

1) git-config --file fails silently if the filename isn't absolute

This is still fixed.

2) git-config -l --file doesn't do what you might expect and list the
contents of the specified file. Instead it ignores the --file option since it
came after the -l. Nice way to shoot oneself in the foot.

This is now fixed after the parseopt patch.

Also, before this patch 'git config --global -l' would fail silently
if there isn't any ~/.gitconfig. Now at least git reports "error
processing config file(s)".

A more ideal solution would be:

if (config_exclusive_filename)
	die("unable to read config file %s: %s",
	    config_exclusive_filename, strerror(errno));
else
	die("error processing config file(s)");

So, if a file is specified with --file, --global, or --system, then
the correct error would be reported.

I digged a bit more and it turns out if there's parse error
git_config() will die immediately, and the only time it will return a
negative value is when the config file(s) are not present, at which
point there will be an errno set, and when config_exclusive_filename
is specified that means the errno will be the one of fopen trying to
open that file.

Still, "error processing config file(s)" will be reported when no file
is specified 'git config -l', there isn't any repo config file (cwd is
not in a git repo).

Even better I think would be to allow 'git config -l' to work even if
we are not in a git repo, and error only when there isn't any config
file (repo, system or global).

This is how it would look like:

 int git_config(config_fn_t fn, void *data)
 {
-       int ret = 0;
+       int ret = 0, found = 0;
        char *repo_config = NULL;
        const char *home = NULL;

        /* Setting $GIT_CONFIG makes git read _only_ the given config file. */
        if (config_exclusive_filename)
                return git_config_from_file(fn,
config_exclusive_filename, data);
-       if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
+       if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
                ret += git_config_from_file(fn, git_etc_gitconfig(),
                                            data);
+               found += 1;
+       }

        home = getenv("HOME");
        if (git_config_global() && home) {
                char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-               if (!access(user_config, R_OK))
+               if (!access(user_config, R_OK)) {
                        ret += git_config_from_file(fn, user_config, data);
+                       found += 1;
+               }
                free(user_config);
        }

        repo_config = git_pathdup("config");
-       ret += git_config_from_file(fn, repo_config, data);
+       if (!access(repo_config, R_OK)) {
+               ret += git_config_from_file(fn, repo_config, data);
+               found += 1;
+       }
        free(repo_config);
+       if (found == 0)
+               error("no config file found");
        return ret;
 }

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=445208

-- 
Felipe Contreras

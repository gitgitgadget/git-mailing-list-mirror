From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 15:55:31 +0700
Message-ID: <CACsJy8DskoCi9Lg+HW0JeQBe4HX-bMXNHUgfrsg+DoqBN9-ntQ@mail.gmail.com>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txw8H-0003Sb-A2
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 09:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab3AWI4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 03:56:06 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34444 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab3AWI4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 03:56:03 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so11213obb.14
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 00:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uoBeg8SXzv2e12P6SDv/pMcv3MP4kRGuorpwzS6F4uU=;
        b=u9oYxY79MSx9rNZVnkhkhNbRYHngsKfk1z3a/b+b+dN86edGpJK6v6vsa6J6JDeV5n
         5o+Ixrqjjlm9uab44PUEcx84krpVbEv4sGXl/Kn9wdO6NLX5ZYvo4Dth90sIJCu5Z8DH
         uL2JZvuBYdQWsP4FDTCpFPmDRW1Y4ebfk4o0UlkvPlyX4MW0JX1XxlxsCCECxxVewC5b
         UIcuYbZaeY3i+SdFc6CYaCRoYEafRinom9EriljYiFRSH7ThpCQ9oe9Zlbap48gCzGCk
         2CCCr9YziAWqi0YWdsS87g3EmHpSMNJQ5CnpNSGHDDlh0k1Ml3uMtnXmnLaCsEh62Fsk
         SgTw==
X-Received: by 10.60.22.164 with SMTP id e4mr385831oef.87.1358931362051; Wed,
 23 Jan 2013 00:56:02 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 23 Jan 2013 00:55:31 -0800 (PST)
In-Reply-To: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214301>

On Wed, Jan 23, 2013 at 3:12 PM, Lars Hjemli <hjemli@gmail.com> wrote:
> +NAME
> +----
> +git-all - Execute a git command in multiple repositories

I agree with Junio "git-all" is too generic. Maybe "git-for-each-repo"

> +static int get_repo_state()
> +{
> +       const char *diffidx[] = {"diff", "--quiet", "--cached", NULL};
> +       const char *diffwd[] = {"diff", "--quiet", NULL};
> +
> +       if (run_command_v_opt(diffidx, RUN_GIT_CMD) != 0)
> +               return DIRTY;
> +       if (run_command_v_opt(diffwd, RUN_GIT_CMD) != 0)
> +               return DIRTY;
> +       return CLEAN;
> +}

Perhaps we could add the subrepo's object data to the in-memory object
database of git-all, then do the diff without launching new commands?

> +static int walk(struct strbuf *path, int argc, const char **argv)
> +{
> +       DIR *dir;
> +       struct dirent *ent;
> +       struct stat st;
> +       size_t len;
> +
> +       dir = opendir(path->buf);
> +       if (!dir)
> +               return errno;
> +       strbuf_addstr(path, "/");
> +       len = path->len;
> +       while ((ent = readdir(dir))) {
> +               if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
> +                       continue;
> +               if (!strcmp(ent->d_name, ".git")) {
> +                       strbuf_addstr(path, ent->d_name);
> +                       setenv(GIT_DIR_ENVIRONMENT, path->buf, 1);
> +                       strbuf_setlen(path, len - 1);
> +                       setenv(GIT_WORK_TREE_ENVIRONMENT, path->buf, 1);
> +                       handle_repo(path->buf, argv);
> +                       strbuf_addstr(path, "/");
> +                       continue;
> +               }
> +               strbuf_setlen(path, len);
> +               strbuf_addstr(path, ent->d_name);
> +               switch (DTYPE(ent)) {
> +               case DT_UNKNOWN:
> +                       /* Use stat() instead of lstat(), since we want to
> +                        * know if we can follow this path into another
> +                        * directory - it's  not important if it's actually
> +                        * a symlink which gets us there.
> +                        */
> +                       if (stat(path->buf, &st) || !S_ISDIR(st.st_mode))
> +                               break;
> +                       /* fallthrough */
> +               case DT_DIR:
> +                       walk(path, argc, argv);
> +                       break;
> +               }
> +               strbuf_setlen(path, len);
> +       }
> +       closedir(dir);
> +       return 0;
> +}

I'm not a user of this command so this is more of bikeshedding. I
think we should have an option to list repos listed in index. For
directory walk, how about reusing fill_directory() to do the job for
you? You could then limit repositories by name. "ls-files -o" code
should be very similar.
-- 
Duy

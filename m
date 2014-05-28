From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] Add an explicit GIT_DIR to the list of excludes
Date: Wed, 28 May 2014 19:36:27 +0700
Message-ID: <CACsJy8By-58wBoV8BydWbpDkpUG6jJhM16aO+Ed8J2ucq66VcQ@mail.gmail.com>
References: <1401163007-5808-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 14:37:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpd6N-0001LS-Q3
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 14:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbaE1Mg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 08:36:58 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:39042 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaE1Mg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 08:36:58 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so17224803qge.22
        for <git@vger.kernel.org>; Wed, 28 May 2014 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c4v2m2FgakMsHL7+vzkse4DvYWvh1lj8SKtMQHmMcuM=;
        b=TIAAAlJr4DL4swCC7dpfJyQ7/i7I0wzOZp4x30lM9lMx3stzOsky9z7TO/0uF8CJiV
         tbP3er6TiIh46pFzZufRpgrcq0rMnYz+Zo/geUIAPrlElCglAAAOPXbO8E6dLSH6rxqh
         ZXwLkE51vNpFfbdhv2XmAvmVftNL/HXbIUN9c7QwOktBBdcQD80GPn1OSplJVo64s3nv
         4mZMNdVTncqyrL59AiasuE10BB83ucDPClyOsOiwkjTFw5LTI11L+JN31lc4wTc76/pU
         qVACWk9AFa/3/oLrpNcd512HKNagNLJjixHGDYZcXU1oKXQ9ql3qaz8Sbr8SA3D1/jhv
         5ccA==
X-Received: by 10.140.107.137 with SMTP id h9mr49515946qgf.30.1401280617223;
 Wed, 28 May 2014 05:36:57 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 28 May 2014 05:36:27 -0700 (PDT)
In-Reply-To: <1401163007-5808-1-git-send-email-pasha.bolokhov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250279>

On Tue, May 27, 2014 at 10:56 AM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
> @@ -1588,6 +1588,38 @@ void setup_standard_excludes(struct dir_struct *dir)
>  {
>         const char *path;
>         char *xdg_path;
> +       const char *r_git, *gitdir = get_git_dir();
> +       char *n_git, *basename;
> +       int len, i;
> +
> +       /*
> +        * Add git directory to the ignores; do this only if
> +        * GIT_DIR does not end with "/.git"
> +        */
> +       r_git = real_path(absolute_path(gitdir));
> +       n_git = xmalloc(strlen(r_git) + 1 + 1);
> +       normalize_path_copy(n_git, r_git);
> +
> +       len = strlen(n_git); /* real_path() has stripped trailing slash */
> +       for (i = len - 1; i > 0 && !is_dir_sep(n_git[i]); i--) ;
> +       basename = n_git + i;
> +       if (is_dir_sep(*basename))
> +               basename++;
> +       if (strcmp(basename, ".git")) {

I think normalize_path_copy makes sure that dir sep is '/', so this
code may be simplified to "if (strcmp(n_git, .git") && (len == 4 ||
strcmp(n_git + len - 5, "/.git")))"?

> +               const char *worktree = get_git_work_tree();
> +
> +               if (worktree == NULL ||
> +                   dir_inside_of(n_git, get_git_work_tree()) >= 0) {
> +                       struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
> +                                                       "GIT_DIR setup");
> +
> +                       /* append a trailing slash to exclude directories */
> +                       n_git[len] = '/';
> +                       n_git[len + 1] = '\0';
> +                       add_exclude(basename, "", 0, el, 0);
> +               }
> +       }
> +       free(n_git);

All this add-only code makes me think it may be nice to make it a
separate function. A good function name could replace the comment near
the beginning of the block.
-- 
Duy

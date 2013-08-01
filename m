From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Difficulty adding a symbolic link, part 3
Date: Thu, 1 Aug 2013 08:17:08 +0700
Message-ID: <CACsJy8DZ11zFEgL_vZ-kG2tuwodU=vBJZqZxUPWtYh9u8o-_Tg@mail.gmail.com>
References: <201307312029.r6VKT4vC023100@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 01 03:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4hWS-00016B-F3
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 03:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab3HABRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 21:17:40 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:42882 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3HABRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 21:17:39 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so3083887oag.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 18:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hlAPqgQGKC0TZXbiYzuOwe2cLBmxoR6/hyGoiZyF0lY=;
        b=xH7I4Gkt1j9I0zjW7AfM1Dz73oQnA4F8KoExmQMZinCEmF6ya47a7dRf+HqZSZkLaO
         4ZvEPuumDnGVTaqjCU0BALY9n8/mL70Dmzu4GKDHERaLBRyUp+DMEEVd7DBpFdhnNTll
         0c9cJX4QSF0f+mU0OEIIs4vPSHerU8UF+WrV8xsoSfvV2w5v6Ftq6CHmXnU9Hq6pVgvY
         VKlJBH02Frcsxl9gL68huAQILUgTzD84/SZChp3aV67e44g8JQjhC1JvlF4Cu2naEfvH
         EWbm0/iWwZq+sSiH86JVLC8s1nGLDqiYdh0nhz0cTGckTLwH5eUsLFEvNoQgrEZ86wfF
         PwjA==
X-Received: by 10.60.143.68 with SMTP id sc4mr29376968oeb.24.1375319859424;
 Wed, 31 Jul 2013 18:17:39 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 31 Jul 2013 18:17:08 -0700 (PDT)
In-Reply-To: <201307312029.r6VKT4vC023100@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231482>

On Thu, Aug 1, 2013 at 3:29 AM, Dale R. Worley <worley@alum.mit.edu> wrote:
> I've run into a problem (with Git 1.8.3.3) where I cannot add a
> symbolic link (as such) to the repository *if* its path is given
> absolutely; instead Git adds the file the symbolic link points to.
> (If I give the path relatively, Git does what I expect, that is, adds
> the symbolic link.)
>
> I've written a test script that shows the problem and included it
> below.
>
> I would not expect *how* a path is presented to Git to change how Git
> processes the path.  In the test case, I would expect "/bin/awk" and
> "../../bin/awk" to produce the same effect when used as arguments to
> "git add".
>
> What is going on in the code is this:  In "git add", all paths are
> normalized by the function prefix_path_gently() in abspath.c.  That
> function removes symbolic links from the pathspec *only if* it is
> absolute, as shown in the first few lines of the function:
>
>  static char *prefix_path_gently(const char *prefix, int len, const char *path)
>  {
>          const char *orig = path;
>          char *sanitized;
>          if (is_absolute_path(orig)) {
> -                const char *temp = real_path(path);
> +                const char *temp = absolute_path(path);
>                  sanitized = xmalloc(len + strlen(temp) + 1);
>                  strcpy(sanitized, temp);
>          } else {
>
> real_path() is specified to remove symbolic links.  As shown, I've
> replaced real_path() with absolute_path(), based on the comment at the
> top of real_path():
>
> /*
>  * Return the real path (i.e., absolute path, with symlinks resolved
>  * and extra slashes removed) equivalent to the specified path.  (If
>  * you want an absolute path but don't mind links, use
>  * absolute_path().)  The return value is a pointer to a static
>  * buffer.
>  *
>
> If I replace real_path() with absolute_path() as shown, the problem I
> am testing for disappears.

I think it also reverts 18e051a (setup: translate symlinks in filename
when using absolute paths - 2010-12-27). real_path() (or
make_absolute_path() back then) is added to resolve symlinks, at least
ones leading to the work tree, not ones inside the work tree, if I
understand the commit message correctly.

>
> With the above change, the test suite runs with zero failures, so it
> doesn't affect any common Git usage.

It means the test suite is incomplete. As you can see, the commit
introducing this change does not come with a test case to catch people
changing this.

>
> But I don't know enough about the internal architecture of Git to know
> that my change is correct in all cases.  I'm almost certain that the
> normalization process for pathspecs should *not* normalize a final
> component that is a symbolic link.  But I would expect it would be
> desirable to normalize non-final components that are symbolic links.
> On the other hand, that might not matter.
>
> Can someone give me advice on what this code *should* do?

It does as the function name says: given cwd, a prefix (i.e. a
relative path with no ".." components) and a path relative to
cwd+prefix, convert 'path' to something relative to cwd. In the
simplest case, prepending the prefix to 'path' is enough. cwd is also
get_git_work_tree().

I agree with you that this code should not resolve anything in the
components after 'cwd', after rebasing the path to 'cwd' (not just the
final component). Not sure how to do it correctly though because we do
need to resolve symlinks before cwd. Maybe a new variant of real_path
that stops at 'cwd'?

We may also have problems with resolve symlinks before cwd when 'path'
is relative, as normalize_path_copy() does not resolve symlinks. We
just found out emacs has this bug [1] but did not realize we also have
one :-P.

[1] http://thread.gmane.org/gmane.comp.version-control.git/231268

>
> I believe I can prepare a proper test for the test suite for this, so
> once I know what the code change should be, I can prepare a proper
> patch for it.
>
> Dale
-- 
Duy

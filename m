From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v3 0/4] setup: Don't dereference in-tree symlinks for
 absolute paths
Date: Fri, 31 Jan 2014 21:21:42 +0100
Message-ID: <20140131202142.GA9731@mule>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richih@debian.org, gitster@pobox.com, tboegi@web.de,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 21:22:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Kb6-0005fA-65
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 21:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbaAaUVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 15:21:51 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:47222 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaUVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 15:21:50 -0500
Received: by mail-la0-f47.google.com with SMTP id hr17so3849056lab.34
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vMkQk7J5JmZ8D+U6xR4r9TQ0kvCplYlzR3YIZyr9Kqg=;
        b=M3FrYiSxewogS1l6KwBQx8nP7KNnS4xCZ9oe65cZuvea9ck/XUTTeNR0QIufJpX9Ue
         5iFN19qQpPYTS+mtnHRObJnsdPnYTQiEZeUBuhTfUiQQVLPYCL9N88t+v4xEZ/lwuYBT
         Hy5DYJ1JLnb05EqqSd/pMwhSQSegIhjP0j+hnORDE3/F0ozUnDtrr1bUSEdTsyW6EwdH
         VcK4tDghZQvLJGb7qoVqFQSwCNnDypjhD1LW0ugNjodl1dPhCTIcK6712y0q3oc5g+xk
         BxP/E8QJ7r18eIbuOQ9GP8yZws4hBqXbDFvHavKhP8fg7al2Q7Ese0IxkOgptT7ezSXD
         PGnA==
X-Received: by 10.112.164.5 with SMTP id ym5mr2537485lbb.48.1391199708291;
        Fri, 31 Jan 2014 12:21:48 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id g8sm15777401lae.1.2014.01.31.12.21.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 12:21:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241314>

On Mon, Jan 27, 2014 at 08:31:37AM -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
> > In order to manipulate symliks in the
> > work tree using absolute paths, symlinks should only be dereferenced
> > outside the work tree.
> 
> I agree 100% with this reasoning (modulo s/symliks/symlinks/).
> 
> As to the implementation, it looks a bit overly complicated,
> though.  I haven't tried writing the same myself, but 
> 
>  * I suspect that strbuf would help simplifying the allocation and
>    deallocation;
> 
>  * Also I suspect that use of string-list to split and then join is
>    making the code unnecessarily complex. In Python/Perl, that would
>    be a normal approach, but in C, it would be a lot simpler if you
>    prepare a writable temporary in wtpart[], walk from left to right
>    finding '/' and replacing it temporarily with NUL to terminate in
>    order to check with real_path(), restore the NUL back to '/' to
>    check deeper, and rinse and repeat.
> 
>    Having said that, I am not absolutely sure if the repeated
>    calls to real_path() are doing the right thing, though ;-)
> 
> > diff --git a/setup.c b/setup.c
> > index 5432a31..0789a96 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -22,11 +22,51 @@ char *prefix_path_gently(const char *prefix, int len,
> >     const char *orig = path;
> >     char *sanitized;
> >     if (is_absolute_path(orig)) {
> > -           const char *temp = real_path(path);
> > -           sanitized = xmalloc(len + strlen(temp) + 1);
> > -           strcpy(sanitized, temp);
> > +           int i, match;
> > +           size_t wtpartlen;
> > +           char *npath, *wtpart;
> > +           struct string_list list = STRING_LIST_INIT_DUP;
> > +           const char *work_tree = get_git_work_tree();
> > +           if (!work_tree)
> > +                   return NULL;
> > +           npath = xmalloc(strlen(path) + 1);
> >             if (remaining_prefix)
> >                     *remaining_prefix = 0;
> > +           if (normalize_path_copy_len(npath, path, remaining_prefix)) {
> > +                   free(npath);
> > +                   return NULL;
> > +           }
> > +
> > +           string_list_split(&list, npath, '/', -1);
> > +           wtpart = xmalloc(strlen(npath) + 1);
> > +           i = 0;
> > +           match = 0;
> > +           strcpy(wtpart, list.items[i++].string);
> > +           strcat(wtpart, "/");
> > +           if (strcmp(real_path(wtpart), work_tree) == 0) {
> > +                   match = 1;
> > +           } else {
> > +                   while (i < list.nr) {
> > +                           strcat(wtpart, list.items[i++].string);
> > +                           if (strcmp(real_path(wtpart), work_tree) == 0) {
> > +                                   match = 1;
> > +                                   break;
> > +                           }
> > +                           strcat(wtpart, "/");
> > +                   }
> > +           }
> > +           string_list_clear(&list, 0);
> > +           if (!match) {
> > +                   free(npath);
> > +                   free(wtpart);
> > +                   return NULL;
> > +           }
> > +
> > +           wtpartlen = strlen(wtpart);
> > +           sanitized = xmalloc(strlen(npath) - wtpartlen);
> > +           strcpy(sanitized, npath + wtpartlen + 1);
> > +           free(npath);
> > +           free(wtpart);
> >     } else {
> >             sanitized = xmalloc(len + strlen(path) + 1);
> >             if (len)
> > @@ -34,26 +74,10 @@ char *prefix_path_gently(const char *prefix, int len,
> >             strcpy(sanitized + len, path);
> >             if (remaining_prefix)
> >                     *remaining_prefix = len;
> > -   }
> > -   if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix))
> > -           goto error_out;
> > -   if (is_absolute_path(orig)) {
> > -           size_t root_len, len, total;
> > -           const char *work_tree = get_git_work_tree();
> > -           if (!work_tree)
> > -                   goto error_out;
> > -           len = strlen(work_tree);
> > -           root_len = offset_1st_component(work_tree);
> > -           total = strlen(sanitized) + 1;
> > -           if (strncmp(sanitized, work_tree, len) ||
> > -               (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
> > -           error_out:
> > +           if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
> >                     free(sanitized);
> >                     return NULL;
> >             }
> > -           if (sanitized[len] == '/')
> > -                   len++;
> > -           memmove(sanitized, sanitized + len, total - len);
> >     }
> >     return sanitized;
> >  }
> > diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> > index 3a0677a..03a12ac 100755
> > --- a/t/t0060-path-utils.sh
> > +++ b/t/t0060-path-utils.sh
> > @@ -190,7 +190,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
> >     test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
> >  '
> >  
> > -test_expect_failure SYMLINKS 'prefix_path works with work tree symlinks' '
> > +test_expect_success SYMLINKS 'prefix_path works with work tree symlinks' '
> >  
> >     ln -s target symlink &&
> >     test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"

On Mon, Jan 27, 2014 at 07:49:42AM +0700, Duy Nguyen wrote:
(...)
> All this new code looks long enough to be a separate function with a
> meaningful name. And we could travese through each path component in
> npath without wtpart (replacing '/' with '\0' to terminate the string
> temporarily for real_path()). But it's up to you. Whichever way is
> easier to read to you.
(...)

I've reworked my patchset to add a specialised 'abspath_part_inside_repo'
function which does traversing and temporary NUL-separation as suggested.

I've also added a new test for a regression which I managed to hit.

I'm not particularly happy with the name of the function, but since
path_inside_repo already exists for something quite different, it seemed
important to distinguish it.

I've not added any test cases specific to the function, since some of it is
already covered thought prefix_path, and some things I'm unsure if possible to
test sanely (e.g. work tree is /).

Repeatedly calling 'real_path' feels somewhat clunky, but I haven't managed
to come up with an alternative method that would work, since symlinks change
the path arbitrarily there's no way to separate the result of dereferencing two
symlinks at once.

Martin Erik Werner (4):
  t0060: Add test for manipulating symlinks via absolute paths
  t0060: Add test for prefix_path when path == work tree
  setup: Add 'abspath_part_inside_repo' function
  setup: Don't dereference in-tree symlinks for absolute paths

 cache.h               |  1 +
 setup.c               | 99 ++++++++++++++++++++++++++++++++++++++++-----------
 t/t0060-path-utils.sh | 11 ++++++
 3 files changed, 91 insertions(+), 20 deletions(-)

-- 
1.8.5.2

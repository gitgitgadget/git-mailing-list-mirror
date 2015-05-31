From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 11/14] pull: teach git pull about --rebase
Date: Sun, 31 May 2015 16:18:56 +0800
Message-ID: <CACRoPnRvjyjtbdT4CY7f4kFqq1rTiksp7eUnpFza+h8ZAq-4gg@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-12-git-send-email-pyokagan@gmail.com>
	<ea07c7ecec761a0bb2d9f4936a8d2411@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 31 10:19:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyySY-0000Sy-QI
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894AbbEaITC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:19:02 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:33381 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571AbbEaIS6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 May 2015 04:18:58 -0400
Received: by labpy14 with SMTP id py14so70548220lab.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vU0BaXh1xGuTSR4DvEcj4QkimS3jakfd+w4NqpQVSQQ=;
        b=JysNRNnAi4wzGGQDL3KJt3hd1a6DmlcyAqSmQggfl/ksfr/C+No9j+vHn/jLBKsc0J
         BooaHAG/Tw6o+d7uOdQMq2WrSEoHi6Gq0a7Xc4h+wqJ3nYFb6M0VQKYhwk2xIjfrtRqL
         zF+AsOTYHKKWJFQYA7IlLwM9Wl1EEIccjI+HcD2652m3IPl8mZAdJ8nB6jhZ+nRzdhlU
         Wclaz3L4Wl+xC35kuviq+FBRGmHPMkBU3jeTv0RGxMvW0zVny4O7XvaeUyF2HRWzdBeT
         BTJgPCF4Ro4LC7EGl629iKHzlWPVowISaPD6PYkbRz4s0LjsYteFlmIDCzFqYLeWvLBh
         4qkw==
X-Received: by 10.152.6.105 with SMTP id z9mr15401352laz.98.1433060336254;
 Sun, 31 May 2015 01:18:56 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sun, 31 May 2015 01:18:56 -0700 (PDT)
In-Reply-To: <ea07c7ecec761a0bb2d9f4936a8d2411@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270321>

Hi Johannes,

On Tue, May 19, 2015 at 9:04 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-05-18 17:06, Paul Tan wrote:
>> +/**
>> + * Given a refspec, returns the merge branch. Returns NULL if the refspec src
>> + * does not refer to a branch.
>> + *
>> + * FIXME: It should return the tracking branch. Currently only works with the
>> + * default mapping.
>> + */
>> +static char *get_merge_branch_2(const char *repo, const char *refspec)
>> +{
>> +     struct refspec *spec;
>> +     const char *remote;
>> +     char *merge_branch;
>> +
>> +     spec = parse_fetch_refspec(1, &refspec);
>> +     remote = spec->src;
>> +     if (!*remote || !strcmp(remote, "HEAD"))
>> +             remote = "HEAD";
>> +     else if (skip_prefix(remote, "heads/", &remote))
>> +             ;
>> +     else if (skip_prefix(remote, "refs/heads/", &remote))
>> +             ;
>> +     else if (starts_with(remote, "refs/") ||
>> +             starts_with(remote, "tags/") ||
>> +             starts_with(remote, "remotes/"))
>> +             remote = "";
>> +
>> +     if (*remote) {
>> +             if (!strcmp(repo, "."))
>> +                     merge_branch = mkpathdup("refs/heads/%s", remote);
>> +             else
>> +                     merge_branch = mkpathdup("refs/remotes/%s/%s", repo, remote);
>> +     } else
>> +             merge_branch = NULL;
>> +
>> +     free_refspec(1, spec);
>> +     return merge_branch;
>> +}
>
> I have to admit that it took me a substantial amount of time to deduce from the code what `get_merge_branch_2()` really does (judging from the description, I thought that it would be essentially the same as `get_merge_branch_1()` without the hard-coded "HEAD"). If the comment above the function would have said something like:
>
> /**
>  * Given a refspec, returns the name of the local tracking ref.
>  */
>
> I would have had an easier time. Also, I wonder if something like this would do the job:

Yeah whoops, this came from a confusion over the difference over
"merge branch" and "remote tracking branch". A merge branch would be a
remote tracking branch, but a remote tracking branch is not
necessarily a merge branch.

>         spec = parse_fetch_refspec(1, &refspec);
>         if (spec->dst)
>                 return spec->dst;

Hmm, I notice that get_remote_merge_branch() only looks at the src
part of the refspec. However, I guess it is true that if the dst part
is provided, the user may be wishing for that to be interpreted as the
"remote tracking branch", so we should be looking at it to calculate
the fork point.

>         if (!(remote = get_remote(remote_name)))
>                 return NULL;
>         if (remote_find_tracking(remote, spec))
>                 return spec->dst;

... and if the dst part of the refspec is not provided, we fall back
to see if there is any remote tracking branch in the repo for the src
part of the ref, which matches the intention of
get_remote_merge_branch() I think, while being better because
remote_find_tracking() takes into account the actual configured fetch
refspecs for the remote.

However, we also need to consider if the user provided a wildcard
refspec, as it will not make sense in this case. From my reading,
remote_find_tracking(), which calls query_refspecs(), would just match
the src part literally, so I guess we should explicitly detect and
error out in this case.

>         return NULL;
>
> (I guess we'd have to `xstrdup()` the return values because the return value of `get_merge_branch_1()` needs to be `free()`d, but maybe we can avoid so much `malloc()/free()`ing.) Again, the function name should probably be changed to something clearer, maybe to `get_tracking_branch()`.

Yeah, it should be changed to get_tracking_branch(), since it is
different from get_merge_branch().

> One thing that is not clear at all to me is whether
>
>         git pull --rebase origin master next
>
> would error out as expected, or simply rebase to `origin/master`.

In git-pull.sh, for the rebase fork point calculation it just used the
first refspec. However, when running git-rebase it checked to see if
there was only one merge base, which is replicated here:

    @@ -573,6 +792,10 @@ int cmd_pull(int argc, const char **argv,
const char *prefix)
                    if (merge_heads.nr > 1)
                            die(_("Cannot merge multiple branches into
empty head."));
                    return pull_into_void(*merge_heads.sha1, curr_head);
    +       } else if (opt_rebase) {
    +               if (merge_heads.nr > 1)
    +                       die(_("Cannot rebase onto multiple branches."));
    +               return run_rebase(curr_head, *merge_heads.sha1,
rebase_fork_point);
            } else
                    return run_merge();
     }

Since this is just a 1:1 rewrite I just tried to keep as close to the
original as possible. However, thinking about it, since we *are* just
using the first refspec for fork point calculation, I do agree that we
should probably give an warning() here as well if the user provided
more than one refspec, like "Cannot calculate rebase fork point as you
provided more than one refspec. git-pull will not be able to handle a
rebased upstream". I do not think it is fatal enough that we should
error() or die(), as e.g. the first refspec may be a wildcard refspec
that matches nothing, and the second refspec that matches one merge
head for rebasing. This is pretty contrived though, but still
technically legitimate. I dunno.

>> +/**
>> + * Sets fork_point to the point at which the current branch forked from its
>> + * remote merge branch. Returns 0 on success, -1 on failure.
>> + */
>> +static int get_rebase_fork_point(unsigned char fork_point[GIT_SHA1_RAWSZ],
>> +             const char *repo, const char *refspec)
>> +{
>> +     int ret;
>> +     struct branch *curr_branch;
>> +     char *remote_merge_branch;
>> +     struct argv_array args = ARGV_ARRAY_INIT;
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +     struct strbuf sb = STRBUF_INIT;
>> +
>> +     if (!(curr_branch = branch_get("HEAD")))
>> +             return -1;
>> +
>> +     if (refspec)
>> +             remote_merge_branch = get_merge_branch_2(repo, refspec);
>> +     else
>> +             remote_merge_branch = get_merge_branch_1(repo);
>> +
>> +     if (!remote_merge_branch)
>> +             return -1;
>
> We should probably `return error(_"No tracking branch found for %s@, refspec ? refspec : "HEAD");` so that the user has a chance to understand that there has been a problem and how to solve it.

Just like the above, I don't think this is serious enough to be
considered an error() though. Sure, this means that we cannot properly
handle the case where the upstream has been rebased, but this is not
always the case. We could probably have a warning() here, but I think
the message should be improved to tell the user what exactly she is
losing out on. e.g. "No tracking branch found for %s. git-pull will
not be able to handle a rebased upstream."

>> +     argv_array_pushl(&args, "merge-base", "--fork-point",
>> +                     remote_merge_branch, curr_branch->name, NULL);
>> +     cp.argv = args.argv;
>
> Let's just use `cp.args` directly...

Yeah, whoops.

>> +     cp.no_stdin = 1;
>> +     cp.no_stderr = 1;
>> +     cp.git_cmd = 1;
>> +
>> +     if ((ret = capture_command(&cp, &sb, GIT_SHA1_HEXSZ)))
>> +             goto cleanup;
>> +
>> +     if ((ret = get_sha1_hex(sb.buf, fork_point)))
>> +             goto cleanup;
>> +
>> +cleanup:
>> +     free(remote_merge_branch);
>> +     strbuf_release(&sb);
>> +     return ret ? -1 : 0;
>> +}
>> +
>> +[...]
>> +/**
>> + * Given the current HEAD SHA1, the merge head returned from git-fetch and the
>> + * fork point calculated by get_rebase_fork_point(), runs git-rebase with the
>> + * appropriate arguments and returns its exit status.
>> + */
>> +static int run_rebase(unsigned char curr_head[GIT_SHA1_RAWSZ],
>> +             unsigned char merge_head[GIT_SHA1_RAWSZ],
>> +             unsigned char fork_point[GIT_SHA1_RAWSZ])
>> +{
>> +     int ret;
>> +     unsigned char oct_merge_base[GIT_SHA1_RAWSZ];
>> +     struct argv_array args = ARGV_ARRAY_INIT;
>> +
>> +     if (!get_octopus_merge_base(oct_merge_base, curr_head, merge_head,
>> fork_point))
>
> It might be my mail program only that mangled the diff here. But it could also be that this line is a little long (by my count, it is 81 columns wide).

Yeah, it is, but I felt that breaking the line would reduce readability.

Thanks, these were some really hard questions that you raised ;-).

Regards,
Paul

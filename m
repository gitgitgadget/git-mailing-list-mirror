From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 15/19] pull: teach git pull about --rebase
Date: Wed, 10 Jun 2015 15:55:26 +0800
Message-ID: <CACRoPnR5shi800KZ_Do5V469ZgZYAzUZKy9mNYNNRPF6HFqs_w@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-16-git-send-email-pyokagan@gmail.com>
	<xmqqk2vcuy10.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2arF-0002So-3X
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145AbbFJHz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:55:29 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33226 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbbFJHz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:55:28 -0400
Received: by wiwd19 with SMTP id d19so39570704wiw.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zRZDeQr2wGSP8XPwZEzVGvXG6RTwTkv+ilBYn7y3Js4=;
        b=uMYmtn5fd5BDY3Gxw8g5T7rV51dDe09NUT8lhBc6YnNqcWOPvAG1u3xsFOaI3U4eCw
         l5pn2+hUaxCH3VQ9ano797dq6RqD8S2HmaPzlzlpllvW+Y4jfGbmvXDeay4PNw3icaAs
         NtRYio8w1QxdVOWOwjSNgoZ/1maT1bjsqcDbxj3+m1BPfvbQrbaFcPgKYU4ocqtQXnve
         fM5AClkPldqIaCBgbfW4Z08pBEtCNMnk5c5LbkLicO6o5VBK4qDhRYwaD2MEiIcYwM+J
         6+Afbkq23gorDjLA+JDKKXklNpPBU6Iecvu53hu4SvMd6+i2ImgOsMrv6F9ymVGSjeW2
         UgUA==
X-Received: by 10.180.103.227 with SMTP id fz3mr5738573wib.45.1433922926487;
 Wed, 10 Jun 2015 00:55:26 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Wed, 10 Jun 2015 00:55:26 -0700 (PDT)
In-Reply-To: <xmqqk2vcuy10.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271269>

On Wed, Jun 10, 2015 at 9:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> +enum rebase_type {
>> +     REBASE_INVALID = -1,
>> +     REBASE_FALSE = 0,
>> +     REBASE_TRUE,
>> +     REBASE_PRESERVE
>> +};
>> +
>> +/**
>> + * Parses the value of --rebase, branch.*.rebase or pull.rebase. If value is a
>> + * false value, returns REBASE_FALSE. If value is a true value, returns
>> + * REBASE_TRUE. If value is "preserve", returns REBASE_PRESERVE. Otherwise,
>> + * returns -1 to signify an invalid value.
>> + */
>> +static enum rebase_type parse_config_rebase(const char *value)
>> +{
>> +     int v = git_config_maybe_bool("pull.rebase", value);
>> +     if (!v)
>> +             return REBASE_FALSE;
>> +     else if (v >= 0)
>> +             return REBASE_TRUE;
>
> It is somewhat misleading to say "v >= 0" when you already use !v to
> signal something else.  Perhaps "else if (v > 0)" is better?

Ah, right.

>> +/**
>> + * Returns remote's upstream branch for the current branch. If remote is NULL,
>> + * the current branch's configured default remote is used. Returns NULL if
>> + * `remote` does not name a valid remote, HEAD does not point to a branch,
>> + * remote is not the branch's configured remote or the branch does not have any
>> + * configured upstream branch.
>> + */
>> +static char *get_upstream_branch(const char *remote)
>> +{
>> +     struct remote *rm;
>> +     struct branch *curr_branch;
>> +
>> +     rm = remote_get(remote);
>> +     if (!rm)
>> +             return NULL;
>> +
>> +     curr_branch = branch_get("HEAD");
>> +     if (!curr_branch)
>> +             return NULL;
>> +
>> +     if (curr_branch->remote != rm)
>> +             return NULL;
>> +
>> +     if (!curr_branch->merge_nr)
>> +             return NULL;
>> +
>> +     return xstrdup(curr_branch->merge[0]->dst);
>> +}
>
> Hmph, it is somewhat surprising that we do not have such a helper
> already. Wouldn't we need this logic to implement $branch@{upstream}
> syntax?

Right, the @{upstream} syntax is implemented by branch_get_upstream()
in remote.c. It, however, does not check to see if the branch's remote
matches what is provided on the command-line, so we still have to
implement this check ourselves, which means this helper function is
still required.

I guess we could still use branch_get_upstream() in this function though.

>> +/**
>> + * Derives the remote tracking branch from the remote and refspec.
>> + *
>> + * FIXME: The current implementation assumes the default mapping of
>> + * refs/heads/<branch_name> to refs/remotes/<remote_name>/<branch_name>.
>> + */
>> +static char *get_tracking_branch(const char *remote, const char *refspec)
>> +{
>
> This does smell like an incomplete reimplementation of what
> get_fetch_map() knows how to do.

Yeah, this is just a direct rewrite of get_remote_merge_branch() in
git-parse-remote.sh. Johannes pointed out[1] that
remote_find_tracking() in remote.c does the exact same thing without
the assumption of the default fetch refmap. However, this would be a
separate modification on its own, so it may be better to do it in a
separate patch with regression tests. (e.g. what should we do if the
refspec dst is provided?)

[1] http://thread.gmane.org/gmane.comp.version-control.git/269258/focus=269350

>> +/**
>> + * Given the repo and refspecs, sets fork_point to the point at which the
>> + * current branch forked from its remote tracking branch. Returns 0 on success,
>> + * -1 on failure.
>> + */
>> +static int get_rebase_fork_point(unsigned char fork_point[GIT_SHA1_RAWSZ],
>> +             const char *repo, const char *refspec)
>> +{
>> +...
>> +}
>
> This function looks OK (the two get_*_branch() helpers it uses I am
> not sure about though).
>
> Same comment on "fork_point[]" parameter's type applies here,
> though.  While I do not mind if you used "struct object_id" to
> represent these object names, if you are sticking to the traditional
> "unsigned char [20]", then these should be "unsigned char *" to be
> consistent with others.

Okay.

Thanks,
Paul

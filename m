From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] worktree: add 'list' command
Date: Mon, 10 Aug 2015 15:10:54 -0700
Message-ID: <xmqqr3nau74h.fsf@gitster.dls.corp.google.com>
References: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
	<1439239982-42826-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:11:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvHa-0003kt-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933079AbbHJWK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:10:58 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35657 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbbHJWK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:10:57 -0400
Received: by pacgr6 with SMTP id gr6so35382000pac.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yuMIvcTU77su0CCi29lZceUP41QA3+WA47VEkYEUqhU=;
        b=oJvAs+h3vjoYzgSYAQd3x4xYD1ChnfQKg2ipfz9uNBKFFs8GMRNHwI+exzWzrsdRHB
         jLx3N/OgWTZdTSBZvZ9dOJMWSJfFUthG401ZjHxJCRVpxAkfO5h2Na0k4nfQy16TmxzB
         nKkvBxEGocWdoR3Att/Yx/Nh1SVgAcEay+x3iJ22V1G7jOGiyfYr5xAAXVrlqlCNlaOE
         zJSRnBEl1VyMGj1oSbQIKyizXTHMihqHVAaxHaUDkLkJZX2nTG0aeZItiOfKFP/nArJy
         t2SN0ZaIXs8Aq73cerbez3itoug8sQTO19byH4TuZIOz02OepN/fDgSu64kWO2z+ahrs
         GKHA==
X-Received: by 10.68.197.101 with SMTP id it5mr48484931pbc.117.1439244656696;
        Mon, 10 Aug 2015 15:10:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id ft7sm16443612pdb.58.2015.08.10.15.10.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 15:10:55 -0700 (PDT)
In-Reply-To: <1439239982-42826-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Mon, 10 Aug 2015 16:53:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275655>

Michael Rappazzo <rappazzo@gmail.com> writes:

> +static int list(int ac, const char **av, const char *prefix)
> +{
> +	int main_only = 0;
> +	struct option options[] = {
> +		OPT_BOOL(0, "main-only", &main_only, N_("only list the main worktree")),
> +		OPT_END()
> +	};

Hmm, main-only is still there?

> +
> +	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> +	if (ac)
> +		usage_with_options(worktree_usage, options);
> +
> +	struct strbuf main_path = STRBUF_INIT;
> +	const char* common_dir = get_git_common_dir();

Asterisks stick to the variable names, not types.

> +	int is_bare = is_bare_repository();

Please do not introduce decl-after-stmt.

> +	if (is_bare) {
> +		strbuf_addstr(&main_path, absolute_path(common_dir));

Hmm, interesting.

Because .git/config is shared, core.bare read from that tells us if
the "main" one is bare, even if you start this command from one of
its linked worktrees.  So in that sense, this test of is_bare
correctly tells if "main" one is a bare repository.

But that by itself feels wrong.  Doesn't the presense of a working
tree mean that you should not get "is_bare==true" in such a case
(i.e. your "main" one is bare, you are in a linked worktree of it
that has the index and the working tree)?

Duy?  Eric?  What do you guys think?

There are many codepaths that change their behaviour (e.g. if we
create reflogs by default) based on the return value of
is_bare_repository().  If I am reading this correctly, I _think_ a
new working area that was prepared with "git worktree add" out of a
bare repository would not work well, as these operations behave as
if we do not have a working tree.  Perhaps is_bare_repository() in
such a working area _should_ say "No", even if core.bare in the
shared bare one is set to true.

> +		strbuf_strip_suffix(&main_path, "/.");

In any case, what is that stripping of "/." about?  Who is adding
that extra trailing string?

What I am getting at is (1) perhaps it shouldn't be adding that in
the first place, and (2) if some other code is randomly adding "/."
at the end, what guarantees you that you would need to strip it only
once here---if the other code added that twice, don't you have to
repeatedly remove "/." from the end?

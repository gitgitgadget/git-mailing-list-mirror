From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 02:34:32 +0200
Message-ID: <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:34:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPK0D-0008CT-Do
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 02:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031AbbHLAel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 20:34:41 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:62185 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932798AbbHLAek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 20:34:40 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZPK06-000LDd-DB
	for git@vger.kernel.org; Wed, 12 Aug 2015 02:34:38 +0200
Received: by ykdt205 with SMTP id t205so1650715ykd.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 17:34:32 -0700 (PDT)
X-Received: by 10.129.70.69 with SMTP id t66mr31288459ywa.4.1439339672500;
 Tue, 11 Aug 2015 17:34:32 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 11 Aug 2015 17:34:32 -0700 (PDT)
In-Reply-To: <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275749>

On Tue, Aug 11, 2015 at 10:57 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Add new option "notes.<ref>.merge" option which specifies the merge
> strategy for merging into a given notes ref. This option enables
> selection of merge strategy for particular notes refs, rather than all
> notes ref merges, as user may not want cat_sort_uniq for all refs, but
> only some. Note that the <ref> is the local reference we are merging
> into, not the remote ref we merged from. The assumption is that users
> will mostly want to configure separate local ref merge strategies rather
> than strategies depending on which remote ref they merge from. Also,
> notes.<ref>.merge overrides the general behavior as it is more specific.

Thanks for working on this, and I apologize for not properly reviewing
this part of the series before now. More comments below.

>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/config.txt            |  6 ++++++
>  Documentation/git-notes.txt         |  6 ++++++
>  builtin/notes.c                     |  7 +++++--
>  t/t3309-notes-merge-auto-resolve.sh | 39 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 488c2e8eec1b..2c283ebc309e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1912,6 +1912,12 @@ notes.merge::
>         STRATEGIES" section of linkgit:git-notes[1] for more information
>         on each strategy.
>
> +notes.<localref>.merge::
> +       Which merge strategy to choose if the local ref for a notes merge
> +       matches <localref>, overriding "notes.merge". <localref> just be a

s/just/must/

> +       fully qualified refname. See "NOTES MERGE STRATEGIES" section in
> +       linkgit:git-notes[1] for more information on the available strategies.

I sort of get the reason for "fully qualified refname", but I think

  notes.refs/notes/commits.merge

looks much uglier than

  notes.commits.merge

Especially since we have the opposite precedence for branch.<name>.*,
e.g. we already have

  branch.master.merge

and not

  branch.refs/heads/master.merge

I know that we don't yet have a "proper" place to put remote notes refs,
but the <ref> in notes.<ref>.merge _must_ be a "local" notes ref (you even
use the <localref> notation in the documentation below). Thus, I believe
we can presume that the local notes ref must live under refs/notes/*,
and hence drop the "refs/notes/" prefix from the config key (just like
branch.<name>.* can presume that <name> lives under refs/heads/*).

...

Which brings me to another small gripe about the naming here:
branch.<name>.merge names the remote ref (at branch.<name>.remote)
that we will pull from, but notes.<ref>.merge has a very different
meaning.

If we - in the future - were to provide a similar config mechanism for a
hypothetical "git notes pull" command, then it would be natural to model
its config similarly: notes.<name>.remote and notes.<name>.merge
specifies whence we fetch, and what we (notes-)merge, respectively.

Except that this patch in its current form will occupy the .merge config
key...

Can you rename to notes.<name>.mergestrategy instead? Or even better,
take inspiration from branch.<name>.mergeoptions, and provide
notes.<name>.mergeoptions instead, which you can then set like:

  git config notes.foo.mergeoptions "--strategy=cat_sort_uniq"

Even though 'git notes merge' don't yet accept any other options that
should be configurable, I think it's worth emulating the mechanisms
that alread exist for branches. It gives is some amount of future-
proofing as well.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net

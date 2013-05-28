From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 2/2] cherry-pick: add --skip-commits option
Date: Tue, 28 May 2013 07:06:26 -0400
Message-ID: <20130528110626.GB1264@hmsreliant.think-freely.org>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
 <1369673539-28692-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 13:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhHjm-0003SC-SI
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 13:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758351Ab3E1LGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 07:06:37 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:47613 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab3E1LGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 07:06:36 -0400
Received: from 99-127-245-201.lightspeed.rlghnc.sbcglobal.net ([99.127.245.201] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1UhHjY-0004wX-N4; Tue, 28 May 2013 07:06:35 -0400
Content-Disposition: inline
In-Reply-To: <1369673539-28692-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225629>

On Mon, May 27, 2013 at 11:52:19AM -0500, Felipe Contreras wrote:
> Pretty much what it says on the tin.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-cherry-pick.txt   |  3 +++
>  builtin/revert.c                    |  2 ++
>  sequencer.c                         |  5 ++++-
>  sequencer.h                         |  1 +
>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>  5 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index c205d23..fccd936 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -129,6 +129,9 @@ effect to your index in a row.
>  	redundant commits are ignored.  This option overrides that behavior and
>  	creates an empty commit object.  Implies `--allow-empty`.
>  
> +--skip-empty::
> +	Instead of failing, skip commits that are or become empty.
> +
>  --strategy=<strategy>::
>  	Use the given merge strategy.  Should only be used once.
>  	See the MERGE STRATEGIES section in linkgit:git-merge[1]
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 0401fdb..0e5ce71 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -118,6 +118,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  		OPT_END(),
>  		OPT_END(),
>  		OPT_END(),
> +		OPT_END(),
>  	};
>  
>  	if (opts->action == REPLAY_PICK) {
> @@ -127,6 +128,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
>  			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
>  			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
> +			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
>  			OPT_END(),
>  		};
I like the idea, but this option seems a bit awkward to me.  At the very least
here, don't you now need to check for conflicts if --keep-redundant-commits and
skip-empty are both specified (as iirc git doens't see the difference between
empty commits and commits made empty by prior commits in the current history).
what if we merged the two options to an OPT_STRING, something like
--empty-commits=[keep|skip|ask].  The default currently is an impiled, since the
sequencer stops on an empty commit.

Neil

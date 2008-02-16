From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] git-branch: allow --track to work w/local
 branches
Date: Fri, 15 Feb 2008 21:10:29 -0800
Message-ID: <7v7ih5fpve.fsf@gitster.siamese.dyndns.org>
References: <1203133557-50013-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 06:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQFKk-0006he-PZ
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 06:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbYBPFKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 00:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbYBPFKp
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 00:10:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYBPFKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 00:10:43 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E304DA6;
	Sat, 16 Feb 2008 00:10:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 ED1F44DA4; Sat, 16 Feb 2008 00:10:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74015>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/builtin-branch.c b/builtin-branch.c
> index e414c88..94ab195 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -402,6 +402,16 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
>  		return error("Tracking not set up: name too long: %s",
>  				new_ref);
>  
> +	if (!prefixcmp(orig_ref, "refs/heads/")) {
> +		sprintf(key, "branch.%s.remote", new_ref);
> +		git_config_set(key, ".");
> +		sprintf(key, "branch.%s.merge", new_ref);
> +		git_config_set(key, orig_ref);
> +		printf("Branch %s set up to track local branch %s.\n",
> +			       new_ref, orig_ref);
> +		return 0;
> +	}
> +
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	if (for_each_remote(find_tracked_branch, &tracking) ||

Although I am not so familiar with this area, the patch somehow
did not feel right, so I ended up doing a bit of digging.

After the context of the patch, we have this:

	if (tracking.matches == 1) {
		sprintf(key, "branch.%s.remote", new_ref);
		git_config_set(key, tracking.remote ?  tracking.remote : ".");
		sprintf(key, "branch.%s.merge", new_ref);
		git_config_set(key, tracking.src);

So it looks to me that the code already has intention to set the
"branch.*.remote" variable to "." when certain condition is met.
And the condition is "when tracking.remote is NULL, or it is
already a dot".

for_each_remote() iterates thru the remotes and
find_tracked_branch() does this:

        static int find_tracked_branch(struct remote *remote, void *priv)
        {
                struct tracking *tracking = priv;

                if (!remote_find_tracking(remote, &tracking->spec)) {
                        if (++tracking->matches == 1) {
                                tracking->src = tracking->spec.src;
                                tracking->remote = remote->name;
                        } else {
                                free(tracking->spec.src);
                                if (tracking->src) {
                                        free(tracking->src);
                                        tracking->src = NULL;
                                }
                        }
                        tracking->spec.src = NULL;
                }

                return 0;
        }

So if there is a remote whose name is "." (or NULL, but I do not
know when that can happen --- remote.c::make_remote() does not
allow creating such a remote as far as I can tell), that would
be found without the added extra code, wouldn't it?

I did a bit of experiment and with this in .git/config:

	[remote "."]
                fetch = refs/*:refs/*

it turns out that you do not have to patch the code at all.  The
above manual configuration feels somewhat like an ugly hack but
perhaps we should make the above two lines implied?  This area
was last cleaned up in 6f084a5 (branch --track: code cleanup and
saner handling of local branches).  I do not know if the
original intention of the code was to allow a hack like this to
work, or it is just an unintended accident that it happens to
work.  Dscho, any ideas?

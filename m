From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] git-tag: Allow --points-at syntax to create a tag
 pointing to specified commit
Date: Thu, 14 Mar 2013 13:36:29 +0000
Message-ID: <20130314133629.GA4256@serenity.lan>
References: <4150f65f3e425d6120ed80c6bec36c1fe209a876.1363264398.git.minovotn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Novotny <minovotn@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 14:37:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG8LJ-00017v-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 14:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab3CNNgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 09:36:45 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43236 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757886Ab3CNNgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 09:36:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 592AD6064EE;
	Thu, 14 Mar 2013 13:36:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDeZ2G+lWp-1; Thu, 14 Mar 2013 13:36:38 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id EEAAA6064F3;
	Thu, 14 Mar 2013 13:36:34 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <4150f65f3e425d6120ed80c6bec36c1fe209a876.1363264398.git.minovotn@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218135>

On Thu, Mar 14, 2013 at 01:34:54PM +0100, Michal Novotny wrote:
> This patch adds the option to specify SHA-1 commit hash using --points-at
> option of git tag to create a tag pointing to a historical commit.

What does this do that "git tag <name> <commit>" doesn't?

> This was pretty easy in the past for the lightweight tags that are just simple
> pointers (by creating .git/refs/tags/$tagname with SHA-1 hash) but it was not
> possible for signed and annotated commits.
> 
> It's been tested for all of the tag types mentioned - lightweight tags, signed
> tags and also annotated tags and everything is working fine in all scenarios
> mentioned above.
> 
> Differences between v1 and v2 (this one):
>  - The bogus sha1-lookup.h hunk has been removed as it's not required and
>    I accidentally forgot to remove it before posting v1
> 
> Michal
> 
> Signed-off-by: Michal Novotny <minovotn@redhat.com>
> ---
>  builtin/tag.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index f826688..f642acd 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -437,7 +437,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	struct create_tag_options opt;
>  	char *cleanup_arg = NULL;
>  	int annotate = 0, force = 0, lines = -1, list = 0,
> -		delete = 0, verify = 0;
> +		delete = 0, verify = 0, points_at_commit = 0;
>  	const char *msgfile = NULL, *keyid = NULL;
>  	struct msg_arg msg = { 0, STRBUF_INIT };
>  	struct commit_list *with_commit = NULL;
> @@ -521,8 +521,24 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		die(_("-n option is only allowed with -l."));
>  	if (with_commit)
>  		die(_("--contains option is only allowed with -l."));
> -	if (points_at.nr)
> -		die(_("--points-at option is only allowed with -l."));
> +	if (points_at.nr) {
> +		if (points_at.nr > 1)
> +			die(_("--points-at option is only allowed with -l or a single "
> +				"SHA-1 hash is allowed to create a tag to commit."));
> +		else {
> +			unsigned char *ref = points_at.sha1[0];
> +
> +			struct object *obj = parse_object(ref);
> +			if ((obj != NULL) && (obj->type == OBJ_COMMIT)) {
> +				memcpy(object, ref, 20);
> +				points_at_commit = 1;
> +			}
> +			else
> +				die(_("--points-at option points to an invalid commit"));
> +
> +			free(ref);
> +		}
> +	}
>  	if (delete)
>  		return for_each_tag_name(argv, delete_tag);
>  	if (verify)
> @@ -548,12 +564,16 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  
>  	tag = argv[0];
>  
> -	object_ref = argc == 2 ? argv[1] : "HEAD";
>  	if (argc > 2)
>  		die(_("too many params"));
>  
> -	if (get_sha1(object_ref, object))
> -		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
> +	/* Option --points-at option is setting this already */
> +	if (!points_at_commit) {
> +		object_ref = argc == 2 ? argv[1] : "HEAD";
> +
> +		if (get_sha1(object_ref, object))
> +			die(_("Failed to resolve '%s' as a valid ref."), object_ref);
> +	}
>  
>  	if (strbuf_check_tag_ref(&ref, tag))
>  		die(_("'%s' is not a valid tag name."), tag);
> -- 
> 1.7.11.7

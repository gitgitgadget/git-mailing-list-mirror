From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: [PATCH] push: warn users about updating existing tags on push
Date: Mon, 30 Aug 2010 09:38:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008300924550.20874@narbuckle.genericorp.net>
References: <20100828012101.GB2004@burratino> <1282983736-3233-1-git-send-email-cxreg@pobox.com> <7v7hj8frxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 18:40:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq7P5-0006Pp-NP
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 18:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab0H3QkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 12:40:08 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:40798 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755370Ab0H3QkH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 12:40:07 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o7UGcxxc026972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Aug 2010 11:38:59 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <7v7hj8frxg.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154831>

On Mon, 30 Aug 2010, Junio C Hamano wrote:

Thanks for the critique and comments

> Dave Olszewski <cxreg@pobox.com> writes:
> 
> > Generally, tags are considered a write-once ref (or object), and updates
> > to them are the exception to the rule.
> 
> This may be just the naming issue and you could say "moving them",
> "updates to them" or "changing them" interchangeably in the above;
> among them, "updates to them" sounds the most natural.
> 
> Can you change the "moving" in the patch to make them consistent with the
> above description?

Sure, no problem.  Would you like this changed in the variable and
config names as well, or just the printed text?


> > diff --git a/remote.c b/remote.c
> > index 9143ec7..fbca1e6 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -50,6 +50,8 @@ static int explicit_default_remote_name;
> >  static struct rewrites rewrites;
> >  static struct rewrites rewrites_push;
> >  
> > +static int deny_moving_tags;
> > +
> >  #define BUF_SIZE (2048)
> >  static char buffer[BUF_SIZE];
> >  
> > @@ -385,6 +387,10 @@ static int handle_config(const char *key, const char *value, void *cb)
> >  			add_instead_of(rewrite, xstrdup(value));
> >  		}
> >  	}
> > +	if (!strcmp(key, "push.denymovingtags")) {
> > +		deny_moving_tags = git_config_bool(key, value);
> > +		return 0;
> > +	}
> 
> Hmm, shouldn't this be per-remote (rather, shouldn't a per-remote variant
> be allowed to override this)?

I wasn't sure about this.  I like the idea of a single setting with
per-remote override, I'll implement that.


> > @@ -1266,6 +1272,31 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
> >  			continue;
> >  		}
> >  
> > +		/* If a tag already exists on the remote and points to
> > +		 * a different object, we don't want to push it again
> > +		 * without requiring the user to indicate that they know
> > +		 * what they are doing.
> > +		 */
> 
> 	/*
>          * We try to format
>          * multi-line comment
>          * like this.
>          */

Ok.


> > +		if (!prefixcmp(ref->name, "refs/tags/") &&
> > +		    !ref->deletion &&
> > +		    !is_null_sha1(ref->old_sha1)) {
> > +			if (deny_moving_tags) {
> > +				/* Set `nonfastforward` for the sake of displaying
> > +				 * this update as forced
> > +				 */
> > +				ref->nonfastforward = 1;
> 
> I think you are propagating this bit to print_ok_ref_status() in
> transport.c; it indicates that after your change, "nonfastforward" does
> not mean non-fast-forward anymore, doesn't it?
> 
> Perhaps the bit needs to be renamed to "update_forced" or something?

Good point.  I arrived at making this change pretty late in the patch
and didn't consider the rename.  Thanks.


> > +				if (!ref->force && !force_update) {
> > +					ref->status = REF_STATUS_REJECT_MOVING_TAG;
> > +				}
> > +			} else {
> > +				if (!ref->force && !force_update)
> > +					warning("You are changing the value of an upstream tag.  This may\n"
> > +						"be deprecated in a future version of Git.  Please use --force\n"
> > +						"if this was intentional, and consider setting push.denyMovingTags.");
> > +			}
> > +			continue;
> > +		}
> > +
> >  		/* This part determines what can overwrite what.
> >  		 * The rules are:
> >  		 *
> 
> You are changing the rule that determine what can overwrite what, aren't
> you?  It is Ok (although it is in general frowned upon if you do so when
> you do not have to) to add your new rule before an existing rule, but your
> rule should be added as a new rule to the enumeration in the comment, and
> the code that implements the new rule after the comment, no?

The reason I wanted to put it first is that a tag update could be either
fast-forward or not, and I wanted to have consistent behavior for both
cases.  I can move the comment block and describe the full set of cases.


> > diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> > index c718253..7906ba5 100755
> > --- a/t/t5400-send-pack.sh
> > +++ b/t/t5400-send-pack.sh
> > @@ -106,6 +106,20 @@ test_expect_success 'denyNonFastforwards trumps --force' '
> >  	test "$victim_orig" = "$victim_head"
> >  '
> >  
> > +test_expect_success 'denyMovingTags trumps --force' '
> > +	(
> > +	    cd victim &&
> > +	    ( git tag moving_tag master^ || : ) &&
> 
> In which circumstance is it allowed for this "git tag" command to
> fail and the entire test to succeed?

Cargo-cult error, good catch, thanks.

Fixed patch forthcoming.

    Dave

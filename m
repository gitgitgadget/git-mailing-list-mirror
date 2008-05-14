From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mergetool feature request - select remote or local
Date: Wed, 14 May 2008 12:19:47 -0700
Message-ID: <7vtzh0n164.fsf@gitster.siamese.dyndns.org>
References: <200805140721.13719.xenoterracide@gmail.com>
 <7vzlqsok0y.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0805141351540.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 14 21:21:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwMX1-0004DH-Ex
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 21:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757002AbYENTUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbYENTUE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 15:20:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbYENTUC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 15:20:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A8B445CE;
	Wed, 14 May 2008 15:19:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 357B545C9; Wed, 14 May 2008 15:19:51 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0805141351540.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 14 May 2008 14:40:47 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD741F8C-21EA-11DD-B51B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82136>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 14 May 2008, Junio C Hamano wrote:
> ...
>> If this turns out to be a better approach, perhaps we would further want
>> to tweak things to make:
>> 
>> 	$ git checkout --unmerged MERGE_HEAD [--] [<pathspec>...]
>> 
>> to work (if you want "local", you would use "HEAD" instead of
>> "MERGE_HEAD").
>
> This is "for all (or some, by pathspecs) files currently unmerged in the 
> index, resolve them to the version in MERGE_HEAD", right?

Yeah, and possibly limited by pathspec as usual.

>> I would have done so here if "git checkout" were still a scripted version,
>> but now it is in C, it would take significantly more effort than it is
>> worth just to raise a weatherbaloon.
>
> Like this (also untested)? (This is missing defaulting to a pathspec of 
> '.' if --unmerged is used without any pathspecs)

Looks easy enough.  Caleb, does this approach fit the situation you
described better?

> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 10ec137..0bae1d4 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -42,6 +42,8 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
>  	return run_command(&proc);
>  }
>  
> +static int unmerged;
> +
>  static int update_some(const unsigned char *sha1, const char *base, int baselen,
>  		       const char *pathname, unsigned mode, int stage)
>  {
> @@ -59,6 +61,13 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
>  	hashcpy(ce->sha1, sha1);
>  	memcpy(ce->name, base, baselen);
>  	memcpy(ce->name + baselen, pathname, len - baselen);
> +	if (unmerged) {
> +		int pos = cache_name_pos(ce->name, len);
> +		if (!(pos && pos < active_nr && ce_same_name(active_cache[pos], active_cache[pos + 1]))) {
> +			free(ce);
> +			return 0;
> +		}
> +	}
>  	ce->ce_flags = create_ce_flags(len, 0);
>  	ce->ce_mode = create_ce_mode(mode);
>  	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> @@ -508,6 +517,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  			BRANCH_TRACK_EXPLICIT),
>  		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
>  		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
> +		OPT_BOOLEAN( 0 , "unmerged", &unmerged, "check out unmerged paths"),
>  		OPT_END(),
>  	};
>  

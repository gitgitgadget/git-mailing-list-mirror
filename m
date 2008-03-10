From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revisions: refactor init_revisions and setup_revisions.
Date: Mon, 10 Mar 2008 00:25:25 -0700
Message-ID: <7v63vvkplm.fsf@gitster.siamese.dyndns.org>
References: <20080304231945.GC24131@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 08:26:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYcOk-0006Gq-9b
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 08:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbYCJHZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 03:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbYCJHZe
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 03:25:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbYCJHZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 03:25:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D1558184D;
	Mon, 10 Mar 2008 03:25:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 12767184A; Mon, 10 Mar 2008 03:25:27 -0400 (EDT)
In-Reply-To: <20080304231945.GC24131@artemis.madism.org> (Pierre Habouzit's
 message of "Wed, 05 Mar 2008 00:19:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76702>

Pierre Habouzit <madcoder@debian.org> writes:

    struct rev_info gains two new fields:
    
     * .def to store --default argument;
     * .show_merge 1-bit field.
    
    The refactor consists of the following steps:
    
     * init_revisions now takes the --default argument to initialize .def
       properly, instead of getting it through setup_revisions.
    
     * setup_revisions has been split in two:
    
       - parse_revisions that does (almost) only argument parsing, to be more
         like what parse-options can do, and
    
       - setup_revisions that does the rest.
    
    Many places had no arguments to pass to setup_revisions, and those don't
    use parse_revisions at all.

Conceptually, I like the split up into three, which are:

 - initializes the structure (init_revisions);

 - parses the user arguments (parse_revisions -- the naming could probably
   be improved, though);

 - prepares the derived/derivable fields for the real work
   (setup_revisions).

Was there a particular reason you moved default to init_revisions() and
not kept it with setup_revisions()?  All the callers of cmd_log_init()
needs to say "I want to default to HEAD" because of it, instead of letting
cmd_log_init() say it at only one place.  Also the caller needs to decide
upfront before calling init_revisions() what the default should be.

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>   This is a required patch for revisions parse-optification that splits
>   the logic of revision arguments parsing in parsing, and post-processing.
>
>   The aim is to replace parsing with parse-opt at some point.
>
>   The final version (using parse-options) will probably need more rework
>   in revisions.[hc], but I'd like to avoid rebasing this patch over and
>   over, and I'd be glad if it's merged now, as it's not _that_
>   intrusive.

>   I've been using a git with this patch for a week without issues.

... which is a nice assuring comment ;-)

> @@ -892,8 +893,7 @@ static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token
>  		opt->regflags = REG_NEWLINE;
>  		revs->grep_filter = opt;
>  	}
> -	append_grep_pattern(revs->grep_filter, ptn,
> -			    "command line", 0, what);
> +	append_grep_pattern(revs->grep_filter, ptn, "command line", 0, what);
>  }

Made me go "huh?".

But everything else looked pretty mechanical conversion, and in that sense
it is not that intrusive.

Applying this to 'master' and then merging 'pu' shows that there are a few
topics that are cooking that would conflict with this change.  Merging
'next' seems to go cleanly (I haven't checked the result), so it is not
too bad for me to carrry this at this moment, if we were not this close to
the rc freeze.  I dunno.

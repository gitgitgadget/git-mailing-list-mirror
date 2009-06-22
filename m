From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fast-export: Add a --tag-of-filtered-object option for newly dangling tags
Date: Mon, 22 Jun 2009 11:34:53 -0700
Message-ID: <7vd48wazhu.fsf@alter.siamese.dyndns.org>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
	<1245676001-14734-5-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusmabite@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 22 20:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIoMB-0007SF-6Q
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 20:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZFVSex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 14:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbZFVSew
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 14:34:52 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47401 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbZFVSev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 14:34:51 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090622183453.VUVN20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Mon, 22 Jun 2009 14:34:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 76at1c00E4aMwMQ046atav; Mon, 22 Jun 2009 14:34:53 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=OiL_M0LvDgkA:10 a=pGLkceISAAAA:8
 a=7rd_MpdBodtyJb8rRGMA:9 a=BV0QIU00448pufZCY1AA:7
 a=F8oUH7pQ5Rm_wHGQZ0htPG3z7zQA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122053>

newren@gmail.com writes:

> From: Elijah Newren <newren@gmail.com>
>
> When providing a list of paths to limit what is exported, the object that
> a tag points to can be filtered out entirely.  This new switch allows
> the user to specify what should happen to the tag in such a case.  The
> default action, 'abort' will exit with an error message.  With 'drop', the
> tag will simply be omitted from the output.  With 'rewrite', if the object
> tagged was a commit, the tag will be modified to tag an ancestor of the
> removed commit.

I had to wonder what "an ancestor" means in the above sentence.

 - It cannot be the "direct ancestor", as such a commit could also have
   been filtered out.  it will probably find an ancestor of the tagged
   commit that is not TREESAME, i.e. changes one of the specified paths.
   is that what the code tries to do?

 - Assuming that the answer is true, finding an ancestor means go back in
   the ancestry graph.  How should a merged history be handled?

   - If two branches merged, only one among which touched the paths, then
     the simplication would have linearized the history already, so it is
     a non issue;

   - If a merge really had changes from both branches, that merge would
     remain in the output, and the tag will be moved there.

   - Did I miss any other case?

If I have to wonder, many other people who read the "git log" output later
will get puzzled, too.  Please clarify.

> @@ -333,10 +349,42 @@ static void handle_tag(const char *name, struct tag *tag)
>  			}
>  	}
>  
> +	/* handle tag->tagged having been filtered out due to paths specified */
> +	struct object * tagged = tag->tagged;
> +	int tagged_mark = get_object_mark(tagged);
> +	if (!tagged_mark) {
> +		switch(tag_of_filtered_mode) {
> +		case ABORT:
> +			die ("Tag %s tags unexported commit; use "
> +			     "--tag-of-filtered-object=<mode> to handle it.",
> +			     sha1_to_hex(tag->object.sha1));
> +		case DROP:
> +			/* Ignore this tag altogether */
> +			return;
> +				/* fallthru */

Doesn't fall through...

> +		case REWRITE:
> +			if (tagged->type != OBJ_COMMIT) {
> +				die ("Tag %s tags unexported commit; use "
> +				     "--tag-of-filtered-object=<mode> to handle it.",
> +				     sha1_to_hex(tag->object.sha1));
> +			}
> +			commit = (struct commit *)tagged;
> +			switch (rewrite_one_commit(revs, &commit)) {
> +			case rewrite_one_ok:
> +				tagged_mark = get_object_mark(&commit->object);
> +				break;
> +			case rewrite_one_noparents:
> +			case rewrite_one_error:
> +				die ("Can't find replacement commit for tag %s\n",
> +				     sha1_to_hex(tag->object.sha1));
> +			}
> +		}
> +	}
> +

This makes me a bit worried.  The rewrite_one() function is never designed
to be called from outside while the main traversal has still work to do,
nor called more than once on the same commit object.  I do not know what
would happen if somebody did so.

Granted, all of this processing happens after the revision traversing
machinery is done with all the commits, and rewriting commits further here
will not have a chance of breaking the subtleties in get_revision() and
everything called from it that already has happened in the main traversal,
but still I would prefer not exposing this function out of revision.c to
avoid mistakes if possible.

Also, are you absolutely sure that your revs is always limited at this
point?  Otherwise, the parents of this commit are queued in rev->list,
expecting somebody else to later pick them up and further process, but
there is nobody who does that in your codepath as far as I can see.  What
will happen to these parent commits?

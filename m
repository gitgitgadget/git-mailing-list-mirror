From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Directory renames without breaking git log.
Date: Thu, 04 Sep 2008 15:06:27 -0700
Message-ID: <7vfxof1s7w.fsf@gitster.siamese.dyndns.org>
References: <200809032338.35359.kai@samba.org>
 <200809042145.09573.kai@samba.org>
 <7vtzcv1yk8.fsf@gitster.siamese.dyndns.org>
 <200809042252.37329.kai@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 00:07:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbMzN-0001Un-Os
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 00:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbYIDWGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 18:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754101AbYIDWGf
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 18:06:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbYIDWGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 18:06:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56833735DC;
	Thu,  4 Sep 2008 18:06:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 73C28735DA; Thu,  4 Sep 2008 18:06:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC14CEF2-7ACD-11DD-897C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94964>

Kai Blin <kai@samba.org> writes:

> On Thursday 04 September 2008 21:49:27 Junio C Hamano wrote:
>
>> > git blame still works, and git log --sparse path/to/file works, of
>> > course. --sparse makes giving a path a bit pointless, of course, but we
>> > probably can live with that for time being. I'm still open for
>> > suggestions, of course. :)
>>
>> Give both directories, like:
>>
>> 	"git log -- newdir olddir"
>>
>> perhaps?
>
> Better, but really ugly, as we'll have to keep doing this for the rest
> of the project's life to get the full history. And while it's all nice
> and fun for git log -- source3/configure.in source/configure.in, it's
> less fun for deeper paths.

Yes, following across subtree merges _could_ be improved.

But another thing I should mention in this context is that you should not
take --follow option (at least in the current form) too seriously.

I see it's been a while --- the last time I did this was October 2006 if I
am not mistaken.  It's time of the year I should point at one of the most
important articles ever written on this mailing list:

    http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217

After understanding what Linus envisioned back then, why what he said are
important are important and why what he dismissed as uninteresting are
indeed uninteresting, things to think about now are:

 - "blame" (especially with -C -C), as you found out already, does answer
   the more important question "where did this come from"; and

 - the question "log --follow $this_file" is asking is exactly "where did
   this file come from".  Remember what adjective was used for the
   question in the article?

I also should mention that --follow was done by Linus as a hack with
known limitations.

Potential improvements to follow possible renames fully would involve:

 * allow not just a single path but a set of pathspecs to be recorded
   during --follow traversal;

 * allow the above information be associated with individual commits, not
   as a single global state in the traversal machinery;

 * enhance the logic to update the pathspecs information kept above when
   you hit renames while traversing the history.  An important part of
   this job involves inferring a wholesale rename of a directory by
   looking at many files moved from one place to another, which we
   currently do not do anywhere in git.

If you do all of the above, it will become a feature, not a hack with
known limitation.  But I do not think anybody so far thought it is worth
the effort, only to answer the "where did this file come from" (ituot ue
zaf m eqzeunxq cgqefuaz).

Personally I feel that this is slightly closer to "I might do this myself
if I had infinite amount of time and I am really bored" than "I don't
care; patches welcome" category.

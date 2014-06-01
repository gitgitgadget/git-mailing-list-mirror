From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 1/3] replace: add --graft option
Date: Sun, 01 Jun 2014 18:06:26 +0200 (CEST)
Message-ID: <20140601.180626.1114637687965252195.chriscool@tuxfamily.org>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
	<20140522213307.27162.14455.chriscool@tuxfamily.org>
	<20140523195153.GB19088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, mhagger@alum.mit.edu
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jun 01 18:06:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr8HM-000839-3g
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 18:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbaFAQG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 12:06:29 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:55945 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbaFAQG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 12:06:28 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7352476;
	Sun,  1 Jun 2014 18:06:26 +0200 (CEST)
In-Reply-To: <20140523195153.GB19088@sigill.intra.peff.net>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250531>

From: Jeff King <peff@peff.net>

> On Thu, May 22, 2014 at 11:33:04PM +0200, Christian Couder wrote:
> 
>> The usage string for this option is:
>> 
>> git replace [-f] --graft <commit> [<parent>...]
>> 
>> First we create a new commit that is the same as <commit>
>> except that its parents are [<parents>...]
>> 
>> Then we create a replace ref that replace <commit> with
>> the commit we just created.
>> 
>> With this new option, it should be straightforward to
>> convert grafts to replace refs, with something like:
>> 
>> cat .git/info/grafts | while read line
>> do git replace --graft $line; done
> 
> I think this script at the end should end up in the documentation or a
> contrib script (probably the former, as it is short enough that somebody
> might just cut-and-paste).
> 
> The graft file ignores comments and blank lines, so maybe "grep '^[^#]'"
> would be in order.
> 
> And maybe it's just me, but I think spacing it like:
> 
>   grep '^[^#]' .git/info/grafts |
>   while read line; do
> 	git replace --graft $line
>   done
> 
> is more readable (I think some would even argue for putting the "do" on
> a separate line).

Thanks, I used something like that in the contrib script.
 
>> +	/* make sure the commit is not corrupt */
>> +	if (parse_commit_buffer(commit, buf.buf, buf.len))
>> +		die(_("Could not parse commit: '%s'"), old_ref);
> 
> I guess the checks here are sufficient to make...
> 
>> +	/* find existing parents */
>> +	parent_start = buf.buf;
>> +	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
>> +	parent_end = parent_start;
>> +
>> +	while (starts_with(parent_end, "parent "))
>> +		parent_end += 48; /* "parent " + "hex sha1" + "\n" */
> 
> ...this number-based parsing safe, though it would miss removing a stray
> parent line elsewhere in the commit.

Yeah, but I don't think that it is a problem.

Those parent lines are not standard in the first place, because they
are not parsed by parse_commit_buffer(). And I don't think this option
should mess with non standard stuff.

> It still feels rather magical to
> me, as we are depending on unspoken format guarantees defined inside
> parse_commit_buffer. 

My opinion is that we are depending on the standard way to parse
headers, and that's good. I think it would be "black magic" to mess
with non standard stuff.

> I'd prefer something like the line-based parser I
> showed in the other thread, but I suppose it may just be a matter of
> preference.

Yeah probably.

Thanks,
Christian.

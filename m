From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Fri, 26 Apr 2013 13:44:14 -0700
Message-ID: <7vd2thvx7l.fsf@alter.siamese.dyndns.org>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
	<7vhaiu1a89.fsf@alter.siamese.dyndns.org>
	<7v4neu19mj.fsf@alter.siamese.dyndns.org>
	<20130425232410.GN29963@google.com>
	<7vvc7ayy84.fsf@alter.siamese.dyndns.org>
	<7vobd2yy3c.fsf@alter.siamese.dyndns.org>
	<20130425235624.GO29963@google.com>
	<7vhaiuywps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpVH-0002Dm-3K
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab3DZUoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:44:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab3DZUoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:44:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A387B1A7C5;
	Fri, 26 Apr 2013 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W0yvVFqTV16t/42I2xSv6iId0cA=; b=iaDZy9
	ZhyhMxLiCO9Yfg4tY+EMs/h1Gvh5grW5g5BxRGI2Dd9skY+fNzhhW/qoFLD80LOJ
	QUWnNisuLaJghkd+rJPtTCwo2TJqTSpqU4GrJiUSAvfYDEZnZ81YmmIjB2bmcuGB
	o8bglORQkgB5cecTd/6majOXRyc7dfAYfqBA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mG5+x0VeoIlWza4djEsGPer39kYnXtRn
	kB5ACaL/TridjslZka1xhWAaNUeEJsiMercbUfm++tKZ5mnVOeLu6R2lrsiKXGEm
	837JItsZEm1lXxIv8IPivQy6UTi4KZ3/STrKsu9hxf80s026Zx5sT35smHWgR2jw
	GKePkUvmxPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97B5E1A7C3;
	Fri, 26 Apr 2013 20:44:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D97D61A7C1;
	Fri, 26 Apr 2013 20:44:15 +0000 (UTC)
In-Reply-To: <7vhaiuywps.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Apr 2013 17:14:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F526A08-AEB2-11E2-B16D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222578>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Maybe the warning should happen after add_file_to_index() has run,
>> letting git compare the old and new index entries for that path?
>
> Yeah, new and deleted cases we do not have to worry about, so a
> no-op add_file_to_index() is the only case we have to be careful.
> There is a "if verbose, say 'add %s'" logic in the funciton, so it
> should be possible to enhance the API without affecting existing
> callers to extract that necessary information out of it.

I've thought about this a bit more.

One possible solution would go like this:

 - Extend add_file_to_index() (the logic is add_to_index() in
   read-cache.c) so that it can return an extra boolean "I would add
   it, but that would be a no-op---the index already has that
   object" to the caller.

 - In update_callback(), when we are comparing _all_ paths due to
   "implicit-dot" logic, check if the path is outside the current
   directory, instead of unconditionally calling warn_pathless_add():

   * If fix_unmerged_status() tells us that we would go to the
     remove_file_from_index() codepath, instead of calling it, call
     warn_pathless_add() instead.

   * If we are going to call add_file_to_index(), call it with
     ADD_CACHE_PRETEND on using the extended interface to see if it
     is adding already up-to-date contents. If not, call
     warn_pathless_add().

But I think it is a much better solution to just refresh the index
like the attached patch when implicit_dot is active and we are not
at the top level directory.  The paths that are stat-dirty but have
the up-to-date contents need to be hashed at least once _anyway_ to
see if the current contents match with what is in the index.  If we
use the approach outlined above, the rehashing will be done in the
extended add_file_to_index(). If we simply refresh the entire cache,
the same check will be done there.  The only performance penalty
would be that we may end up running lstat() twice.

Incidentally, I noticed that we set implicit_dot=1 even when we are
already at the top-level directory.  I suspect the code may become
somewhat simpler if we set it only when (prefix != NULL), but it
probably would not matter.


 builtin/add.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index daf02c6..ec2359c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -495,6 +495,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		refresh(verbose, pathspec);
 		goto finish;
 	}
+	if (implicit_dot && !prefix)
+		refresh_cache(REFRESH_QUIET);
 
 	if (pathspec) {
 		int i;

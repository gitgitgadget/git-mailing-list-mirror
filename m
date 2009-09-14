From: Owen Taylor <otaylor@redhat.com>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Sun, 13 Sep 2009 22:35:19 -0400
Message-ID: <1252895719.11581.53.camel@localhost.localdomain>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
	 <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 04:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn1Pq-00033g-JO
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 04:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbZINCf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 22:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbZINCf0
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 22:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56295 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbZINCfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 22:35:20 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8E2ZLmi002630;
	Sun, 13 Sep 2009 22:35:22 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8E2ZKG7011723;
	Sun, 13 Sep 2009 22:35:21 -0400
In-Reply-To: <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128435>

On Sun, 2009-09-13 at 17:47 -0700, Junio C Hamano wrote:
> Without reading much of the code, my knee jerk reactions are:
> 
>  * This probably can (and from the longer term perspective, should) be
>    done inside a pre-push hook that can decline pushing;

Certainly, within the logic of the operation, there's a potential hook.
(Much like pre-receive but on the client side.)

But even if this behavior was in pre-push.sample, it would not meet what
I'm looking for. Which is an easy-to-use behavior you can turn on, no
matter how many different repositories you work in.

Would it work to do it as a helper program? - if "advanced" options are 
found it feeds the list of candidate ref updates through
git-push--helper or something?

>  * I do not think it should use two separate push_refs call into transport
>    (first with dry-run and second with real).
> 
>    Immediately after match_refs() call in transport_push(), you know if
>    the push is a non-fast-forward (in which case you do not know what you
>    will be losing anyway because you haven't seen what you are missing
>    from the other end) or exactly what your fast-forward push will be
>    sending, so between that call and the actual transport->push_refs()
>    would be the ideal place to call the hook, with a list of "ref old
>    new", without running a dry-run.

The reason I had to do two calls to transport->push_refs is not because
it actually pushes the refs twice. It's because the logic for
classifying the refs is in builtin-send-pack.c. When you pass in
args.dry_run=1 you get the classification logic without the network
traffic.

(There's a little messiness about whether it sends the "flush" 0000 or
not that I had to work around, but that's peripheral.)

The way to clean it up is pretty obvious:

 - You add another vfunc to the transport - '->get_capabilities' or
   something - that encapsulates server_supports("delete-refs").

 - You split the classification logic out into a helper function
   (maybe still in builtin-send-pack.c, maybe moved into some other
   file... don't know what's appropriate.)

   After all, if there was another push_refs backend, it shouldn't be
   duplicating the classification logic...

 - You pass pre-classified ref updates to ->push_refs

I don't know how that interacts with other planned changes to this code.

> for a few reasons.
> 
>  (1) When push.confirm is set, you do not want to interact with the user
>      when the standard input is not a terminal.  But an automated script
>      that runs git-push can still use an appropriate pre-push hook to make
>      the decision to intervene without human presense.
> 
>  (2) As your --show-subjects patch shows, the likes and dislikes of the
>      output format for confirmation would be highly personal.  A separate
>      hook that is fed list of <ref, old, new> would make it easier to
>      customize this to suite people's tastes.

The --show-subjects idea is equally useful for --dry-run. And even when
for successful/failed pushes when neither --confirm not --dry-run is
passed.

I'm not that convinced that there's that much scope for configurability
in this area. Clearly there's some arbitrary decisions I made - that
abbreviated hashes wouldn't be useful. That up to 8 commit subjects
should be shown. Etc.

But as yet, there's no data as to whether people would actually want to
make *different* arbitrary decisions.

Adding more configurability (formats, etc.) doesn't really bother me,
though it does seem like coding in advance of need. But what would
bother me is if the feature isn't useful without complex configuration
or installing custom scripts.

>  (3) I do not trust the use of the fmt_merge_message() code in this
>      codepath.  That code, like all the major parts of git, relies on
>      being able to use the object flag bits for its own purpose, and there
>      is a chance that the way transports (present and future) optimizes
>      (or may want to optimize in the future) the object transfer by
>      implementing clever common ancestry discovery, similar to what is
>      done for the fetch-pack side.
> 
>      If we force the actual confirmation process out to a separate process
>      that runs a hook, I do not have to worry about that, which is a huge
>      relief for maintainability of the system.

Well, I guess that's one way to look at the maintainability issues
involved...

I have to take your word as gospel on this ... I don't have a
comprehensive or even a non-comprehensive view of the use of flags.
Certainly almost same code could be put into a git-push--helper binary.

>  (4) The same objects flag bits contamination issue makes me worried about
>      your approach of running one transport_push() with dry-run and then
>      another without.

With only one example of a transport that implements 'push_refs', it's a
little hard to say what a transport *might* do. But as described above,
this is just a code-structure issue.

- Owen

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: remote-helpers: http-push protocol
Date: Tue, 7 Sep 2010 17:14:01 -0500
Message-ID: <20100907221401.GA29102@capella.cs.uchicago.edu>
References: <AANLkTim=HKiQ-25QEAPPRcH6wwLLAsDdoRqTsanM67SK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 00:14:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot6Qc-00040V-FM
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 00:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab0IGWOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 18:14:05 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:55735 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab0IGWOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 18:14:04 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 2D6D7B927;
	Tue,  7 Sep 2010 17:14:01 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 6AA9BDF9FB; Tue,  7 Sep 2010 17:14:01 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim=HKiQ-25QEAPPRcH6wwLLAsDdoRqTsanM67SK@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155747>

Hi,

Here's a know-nothing view (and I assume you have already done this
legwork; just summarizing for myself).  Following along in do_push().

Sverre Rabbelier wrote:

> When fetching from the remote, the helper is called with 'list',

get_ref_map() -> transport_get_remote_refs() ->
transport::get_refs_list()

[...]
> What happens next is the part that confuses me, a certain set of refs
> is pushed, by calling the helper with 'push <refspec>'.

The transport_push() codepath in transport.c.  For remote helpers, it
relies on the push_refs() method, calling:

 - transport::get_refs_list() to get the list of remote refs
 - get_local_heads() for the local refs
 - match_refs() to list remote refs matching the refspec/--all/
   --mirror
 - transport::push_refs() to push the list of refs chosen
 - transport_print_push_status() for a nice message
 - set_upstreams() to handle --set-upstream requests
 - transport_update_tracking_ref() to update the local remote-tracking
   refs.

> I am unclear
> how this set of refs is chosen

remote.c's match_refs() calls:

 - parse_push_refspec() to convert the refspec strings to
   structs refspec, separating src, dest, and +/*/no-dest-specified
   flags
 - match_explicit_refs() to build a linked list of struct ref
   explicitly requested with non-wildcard refspecs (the easy ones)
 - check_pattern_match() for each remote ref, to figure out which
   refspec, if any, it corresponds to.  If any:
    - Refs outside the refs/heads/ hierarchy are excluded (unless
      --mirror as used) when not named by a refspec, as you mentioned.
    - Where actual refspecs are concerned, though, they can match.
    - A local peer is determined with find_ref_by_name().
    - Enforces the "push matching" rule: do not push a new branch
      unless it was explicitly requested by naming it, --all, or
      --mirror.
 
> I see that only refs that have a
> peer_ref are sent, unless mirror is also set (I don't think I
> understand the significance)?

$ git log -S'"matching refs"; traditionally we pushed everything' remote.c
commit 098e711e6c0d123dff2f38d6b804ec632ad7dd78
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Jul 1 19:00:08 2007 -0700

    "git-push $URL" without refspecs pushes only matching branches

    When "git push" is run without any refspec (neither on the
    command line nor in the config), we used to push "matching refs"
    in the sense that anything under refs/ hierarchy that exist on
    both ends were updated.  This used to be a sane default for
    publishing your repository to another back when we did not have
    refs/remotes/ hierarchy, but it does not make much sense these
    days.

    This changes the semantics to push only "matching branches".

So I suspect this is to ensure that with "[push] default = matching",

 $ git push

pushes branches and not remote-tracking refs, but

 $ git push --mirror

pushes everything.

> After the push, the helper write a set
> of 'ok/error' messages sometimes for refs that were not asked to be
> pushed in the first place

Part of transport::push_refs().  I think it only allows status
messages for refs that were actually pushed; otherwise it will print

	warning: helper reported unexpected status of <ref>

> Can you clarify the behavior I described? How can I best hook into the
> 'refs that need to be pushed selection' in the 'export' command [0]?

Hmm --- do you want some other hierarchy than refs/heads/* for the
"push matching" rule?

Thanks for the nice introduction.

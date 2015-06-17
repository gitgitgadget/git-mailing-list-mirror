From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] notes: Use get_sha1_committish instead of read_ref in
 init_notes()
Date: Wed, 17 Jun 2015 18:40:36 +0900
Message-ID: <20150617094036.GA536@glandium.org>
References: <1434503731-26414-1-git-send-email-mh@glandium.org>
 <xmqq1thb58i8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 11:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z59q5-00077Y-GR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 11:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbbFQJkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 05:40:51 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40919 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbbFQJkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 05:40:45 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Z59pk-0000Ke-7w; Wed, 17 Jun 2015 18:40:36 +0900
Content-Disposition: inline
In-Reply-To: <xmqq1thb58i8.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271823>

On Tue, Jun 16, 2015 at 08:17:03PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > init_notes() is essentially the only point of entry to the notes API.
> > It is an arbitrary restriction that all it allows as input is a strict
> > ref name, when callers may want to give an arbitrary committish.
> 
> While it may be a good idea to allow reading from any note-shaped
> tree-ish, not just what is at the tip of a ref, I suspect that the
> use of read_ref() is not an arbitrary restriction, but is an
> effective way to achieve safety against callers that update notes.
> 
> That is, you can feed refs/notes/commit@{4.days.ago} to the
> machinery and show you notes from 4 days ago, but you cannot update
> that as if it were a ref.
> 
> Hence, if you are loosening the safety at init_notes() site, you
> would at least need to add a similar safety in the write codepath, I
> would think.  
> 
> One thing you would need to be careful about is that you would give
> users a crappy experience, if an operation reads notes, does its own
> thing, and then tries to write updated notes (think: rebase that
> transplants notes from original to rewritten commits), and you fail
> the operation only at the very last phase of updating.  In order to
> prevent that, "in the write codepath" above has to be "reject any
> non-ref note, e.g. --notes=refs/notes/commit@{4.days.ago} upfront,
> if the operation will write updated notes".

Looking around in the code, I'm not sure how to address this.
Considering the APIs, it would seem logical to have individual callers
care about filtering the refs themselves, on the other hand, there's
room for shooting oneself in the foot when adding new code paths needing
writes.

I'm tempted to make init_notes itself do the check, based on the value
it is given for a "read_only" argument. On the other hand, some commands
do their ref resolving themselves already. For example, notes_merge uses
read_ref_full and check_refname_format itself (not necessarily in the
right order, btw). OTOH, I'm not even sure it ends up using init_notes
at all.

Mike

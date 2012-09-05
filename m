From: Robin Stocker <robin@nibor.org>
Subject: Re: [PATCH] cherry-pick: Append -x line on separate paragraph
Date: Wed, 5 Sep 2012 22:36:07 +0200 (CEST)
Message-ID: <1410595949.1269.1346877367487.JavaMail.root@bazinga.schuettel.ch>
References: <7vsjaxaasv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:36:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9MKj-0005AD-C1
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 22:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189Ab2IEUgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 16:36:14 -0400
Received: from cust.static.212-90-207-187.cybernet.ch ([212.90.207.187]:48363
	"EHLO bazinga.schuettel.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754946Ab2IEUgN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 16:36:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bazinga.schuettel.ch (Postfix) with ESMTP id 1AE0E1C0474;
	Wed,  5 Sep 2012 22:36:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at schuettel.ch
Received: from bazinga.schuettel.ch ([127.0.0.1])
	by localhost (bazinga.schuettel.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fONcHeBg2aNm; Wed,  5 Sep 2012 22:36:07 +0200 (CEST)
Received: from bazinga.schuettel.ch (cust.static.212-90-207-187.cybernet.ch [212.90.207.187])
	by bazinga.schuettel.ch (Postfix) with ESMTP id AAEB41C0061;
	Wed,  5 Sep 2012 22:36:07 +0200 (CEST)
In-Reply-To: <7vsjaxaasv.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [77.58.214.140]
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - FF3.0 (Linux)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204846>

Junio C Hamano writes:
> Robin Stocker <robin@nibor.org> writes:
> 
> >  		if (opts->record_origin) {
> > + /* Some implementations don't terminate message with final \n, so
> > add it */
> > + if (msg.message[strlen(msg.message)-1] != '\n')
> > + strbuf_addch(&msgbuf, '\n');
> 
> I can agree that this is a good change.
> 
> > + strbuf_addch(&msgbuf, '\n');
> 
> But this is somewhat dubious. Even if what we are adding is merely
> an extra LF, that changes the mechanically generated output format
> and can break existing hooks that read from these generated commit
> log template.

Hm, for a script to break because of an extra LF it would have to be
very badly written. If it looks for "\n(cherry picked ...", it would
still work. But I see the point.

> Is there a reason better than "having an empty line there look
> better to _me_" to justify this change?

Yes:

* If the original commit message consisted just of a summary line,
  the commit message after -x would then not have a blank second
  line, which is bad style, e.g.:

The title of the original commit
(cherry picked ...)

* If the original message did not have any trailers, the appended
  text would stick to the last paragraph, even though it is a
  separate thing.

These don't apply to the git project itself, as its commit message
always have at least a Signed-off-by. But there are projects where
this is not the case and the above reasons apply.

Maybe the solution is to detect if the original commit message
ends with a trailer and in that case keep the existing behavior
of not inserting a blank line?

> >  			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
> >  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
> >  			strbuf_addstr(&msgbuf, ")\n");
> 
> Having said that, I've seen proposals to update this message to
> format more like the other trailers, so that we would see this:
> 
> The title of the original commit
> 
> The log message taken from the original
> commit comes here.
> 
> Signed-off-by: First person who signed off the original
> Signed-off-by: Another person who signed off the original
> Cherry-picked-from: a9bbc121ea850e49d52ba3cb5a6b7f8077d195d2
> 
> in the editor, to allow you to add your own Sign-off at the end to
> make it look like this:
> 
> The title of the original commit
> 
> The log message taken from the original
> commit comes here.
> 
> Signed-off-by: First person who signed off the original
> Signed-off-by: Another person who signed off the original
> Cherry-picked-from: a9bbc121ea850e49d52ba3cb5a6b7f8077d195d2
> Signed-off-by: Me who did the cherry-pick
> 
> I think that might be a worthwhile thing to do perhaps as an
> optional behaviour (e.g. perhaps triggered with a new option
> "--trailer", or with the same "-x" but only when "cherry-pick.origin
> = trailer" configuration is set, or something). At that point, the
> output will look vastly different to existing hooks and those who
> care how this field looks like are forced to be updated, but as long
> as it is an opt-in feature, it may be worth it.

Oh, I like that proposal. I'd lean towards a new --trailer option I
think.

It would have the same problem of having to append it on a separate
paragraph if the original commit message does not already have a
trailer though.

But I still think that adding the "(cherry picked ..." on a separate
paragraph would be a good thing until "Cherry-picked-from" can be
used.

Regards,
  Robin Stocker

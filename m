From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [PATCH] Notes: Connect the %N flag to --{show,no}-notes
Date: Sun, 11 Apr 2010 00:20:31 +0200
Message-ID: <20100410222031.GA12507@dualtron.lan>
References: <7vaatbw00u.fsf@alter.siamese.dyndns.org>
 <1270935032-10536-1-git-send-email-heipei@hackvalue.de>
 <7v1venvuv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:20:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0j2K-0001IE-4A
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0DJWUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:20:14 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:58463 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab0DJWUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:20:13 -0400
Received: from u-6-099.vpn.rwth-aachen.de ([137.226.102.99]:52819 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O0j2A-0002b6-Ax; Sun, 11 Apr 2010 00:20:10 +0200
Content-Disposition: inline
In-Reply-To: <7v1venvuv8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 137.226.102.99
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144602>

On 10/04/10 14:51, Junio C Hamano wrote:
> > -	if (!rev->show_notes_given && !rev->pretty_given)
> > +	if (!rev->show_notes_given)
> >  		rev->show_notes = 1;
> 
> I am puzzled by this change and its possible interaction with codepaths
> that do not have anything to do with %N.  When there is no show-notes and
> an explicit --pretty, we do not want to have rev->show_notes set.
> 
> Admittedly, the real end result we want to see in such a case is just that
> notes are not shown (and rev->show_notes being false is one natural way to
> achieve that), and if ...
Yes, it might seem a little dirty looking at the name of the flags. If
no --show-notes was given and --pretty was supplied, rev->show_notes
should have a value of 'maybe' ;)

I was aiming for minimally invasive changes while keeping the former
behaviour and only dealing with the "only %N" case, which is what this
patch does.

> > -	if (rev->show_notes)
> > +	if (rev->show_notes && (!rev->pretty_given || rev->show_notes_given))
> >  		init_display_notes(&rev->notes_opt);
> 
> ... this change is about ensuring the same outcome by not initializing the
> notes tree, that may work, but it somehow feels iffy.  It would leave some
> codepaths (and another one you just added, I think, with the other hunk in
> this patch) that say "do this only when rev->show_notes is set" and some
> other codepaths that say "unconditionally try to show notes and rely on
> the caller not have initialized the notes tree when it is not wanted."  Is
> that what is going on?
The implicit initialization of the notes_trees only happens if --pretty
is used alone, and in no other case. I was under the impression that not
initializing the notes_trees if one isn't sure of it's use was meant to
be a performance criterion. While --show-notes will always use the notes
when using plain log/show, it won't necessarily use the notes for
certain --pretty/--format formats. Granted, right now I can use --pretty
and --show-notes although I don't use %N and intentionally waste memory
by initializing the trees.

> Unfortunately I don't think of a better and cleaner solution offhand
> (perhaps such a cleaner solution would involve adding a bit more state in
> the rev structure, but I haven't thought things through).
Yes, I came across that structure too but was happy enough my patch
works as it is. I'll leave design decisions up to more involved
contributors, my main agenda is simply to not have git segfault with
something as harmless as "git log '%N'" ;)

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0xD47A7FFC
GPG-Fingerprint: 5441 D425 6D4A BD33 B580  618C 3CDC C4D0 D47A 7FFC

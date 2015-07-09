From: Mike Hommey <mh@glandium.org>
Subject: Re: suboptimal behavior of fast-import in some cases with "from"
Date: Thu, 9 Jul 2015 14:52:27 +0900
Message-ID: <20150709055227.GA32360@glandium.org>
References: <20150706220746.GA29367@glandium.org>
 <xmqq4mlgzyl0.fsf@gitster.dls.corp.google.com>
 <20150709050314.GA6013@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 07:52:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD4lR-0003WY-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 07:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbbGIFwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 01:52:43 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40201 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbbGIFwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 01:52:33 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZD4l1-000131-Sa; Thu, 09 Jul 2015 14:52:27 +0900
Content-Disposition: inline
In-Reply-To: <20150709050314.GA6013@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273723>

On Thu, Jul 09, 2015 at 02:03:15PM +0900, Mike Hommey wrote:
> On Mon, Jul 06, 2015 at 03:54:35PM -0700, Junio C Hamano wrote:
> > Mike Hommey <mh@glandium.org> writes:
> > 
> > > One of the first things parse_from does is unconditionally throw away
> > > the tree for the given branch, and then the "from" tree is loaded. So
> > > when the "from" commit is the current head of the branch, that make
> > > fast-import do more work than necessary.
> > 
> > If it is very common that the next commit the input stream wants to
> > create is often on top of the commit that was just created, and if
> > it is very common that the input stream producer knows what the
> > commit object name of the commit that was just created, then
> > optimising for that case does not sound too bad.  It really depends
> > on two factors:
> > 
> >  - How likely is it that other people make the same mistake?
> 
> Looks like the answer is: very. Assuming my quick glance at the code is
> not mistaken, the same mistake is made in at least git-p4.py (yes, the
> one that comes with git), felipec's git-remote-hg, and hg-fast-export,
> and that's 100% of the sample I looked at.
> 
> I won't claim to know what fast-import is doing, not having looked at
> more than the parse_from* functions and the commit message for 4cabf858,
> but it seems plausible this also skips making tree deltas for those
> trees.

It doesn't /seem/ to be the case.

> >  - How bad the damage to parse_from() would be if we wanted to
> >    optimize for this case?
> 
> I /think/ it would look like this (untested), which doesn't seem too
> damaging:

It's actually not enough. It does avoid to reread trees, but it doesn't
avoid the pack to be closed/reopened.

Mike

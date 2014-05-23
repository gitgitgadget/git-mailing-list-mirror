From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [BUG] auto-repack exits prematurely, locking other processing out
Date: Sat, 24 May 2014 00:34:37 +0200
Message-ID: <20140523223437.GA4230@angband.pl>
References: <20140523195121.GA923@angband.pl>
 <xmqqy4xsgome.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 00:34:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wny36-00009a-6c
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 00:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbaEWWeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 18:34:44 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:38368 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbaEWWeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 18:34:44 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.80)
	(envelope-from <kilobyte@tartarus.angband.pl>)
	id 1Wny2v-0001F7-Af; Sat, 24 May 2014 00:34:37 +0200
Content-Disposition: inline
In-Reply-To: <xmqqy4xsgome.fsf@gitster.dls.corp.google.com>
X-Junkbait: adolf@angband.pl, zareba@angband.pl
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@tartarus.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250042>

On Fri, May 23, 2014 at 02:40:41PM -0700, Junio C Hamano wrote:
> Adam Borowski <kilobyte@angband.pl> writes:
> > It looks like the periodic auto-repack backgrounds itself when it shouldn't
> > do so.  This causes the command it has triggered as a part of to fail:
> 
> Duy, 9f673f94 (gc: config option for running --auto in background,
> 2014-02-08) turns to be not such a hot idea.  Sure, if we kick it
> off background after doing something heavy, immediately before
> giving control back to the end-user, and expect that the user will
> stay thinking without making new changes (i.e. read-only stuff like
> "git show" would be OK), then daemonize might be a great thing, but
> we forgot, while doing that commit, that long-running operations
> trigger the auto gc in the middle *and* they want it finish before
> they continue, as the purpose of gc is to help the performance
> during their further operation.

Just add a lock that's triggered by daemonize, and have things block on this
lock.  This handles all cases:
* --auto in the middle of a command: the block will kick in immediately,
  effectively reverting to non-daemonized version
* --auto at the end, the user does nothing: gc will finish its work in the
  background, just as you wanted
* --auto at the end, the user starts a new write two seconds later: gc works
  in the foreground with those 2 seconds headstart

The only loss is the lack of a progress indicator, and even that can be
done.

-- 
Gnome 3, Windows 8, Slashdot Beta, now Firefox Ribbon^WAustralis.  WTF is going
on with replacing usable interfaces with tabletized ones?

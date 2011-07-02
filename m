From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/13] revert: Catch incompatible command-line options
 early
Date: Sat, 2 Jul 2011 05:04:36 -0500
Message-ID: <20110702100436.GB19090@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-10-git-send-email-artagnon@gmail.com>
 <20110621170416.GN15461@elie>
 <BANLkTinN6KdPnuMWbrdE4jf4ijKDC=35Aw@mail.gmail.com>
 <20110702095334.GA19090@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 12:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcx4B-0001Cw-G9
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 12:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab1GBKEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 06:04:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65418 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab1GBKEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 06:04:42 -0400
Received: by iwn6 with SMTP id 6so3380941iwn.19
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MrUYnC/naghh4UlBq3LgeO8IcoBP6XB6GToGHGLLgCE=;
        b=H4cEef4Dij2ADHSUzRdUFC3lxwhLgp03ve2hLjIcqEsxYgMT9XBrmTrTo0JYvIqX+r
         QV589l1p9Q2IL8fTTWf1itK649PR6NDdMmCC7MOT8x5FeWlruz2jd+fqWVtl/YIZW0n/
         6kf3/jbegj76liv6fHtGquff+qpQKh0izE0YA=
Received: by 10.231.144.200 with SMTP id a8mr3781157ibv.85.1309601081422;
        Sat, 02 Jul 2011 03:04:41 -0700 (PDT)
Received: from elie (adsl-68-255-98-241.dsl.chcgil.sbcglobal.net [68.255.98.241])
        by mx.google.com with ESMTPS id x13sm2392761ibh.67.2011.07.02.03.04.39
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 03:04:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110702095334.GA19090@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176550>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:

>>     Some incompatible command-line options are caught in pick_commits
>>     after parse_args has parsed the options and populated the options
>>     structure.  Change this so that parse_args only parses valid
>>     command-line options
[...]
> Alas, I still don't get it.  How can I (the fearful reader) demonstrate
> the problem that this fixes?  Is it a big problem?  How does the patch
> fix it?  Does the patch have downsides, or is it mostly risk-free?

To be clearer, here's a quick example in some hypothetical alternate
world:

	cherry-pick/revert: do not create a nonsense "struct opts" when given nonsense argv

	The --foo and --bar options make no sense together, but if I
	run "git cherry-pick --foo --bar" then parse_cherry_pick_option
	will return a nonsense struct with both "fooing" and "barring"
	set to true, which makes no sense.  Currently it's not a
	problem since the code that cares is protected by a check:

		if (opts.fooing && opts.barring)
			die("cannot foo and bar at the same time");

	But that is very fragile --- the frob() code-path relies on
	opts.fooing and opts.barring not both being true without such
	a check and it's only a coincidence that futz() is called
	first and makes that check, protecting it.

	We can make sure such a nonsensical options struct is never
	created by checking right away that --foo and --bar are not
	passed together at option-parsing time.  Meanwhile, make sure
	regressions in maintaining this invariant are caught in the
	future by adding an assertion "assert(!opts->fooing ||
	!opts->barring)" to both frob() and futz().

	The discussion above also applies to --bar and --qux.  Fix
	that, too.

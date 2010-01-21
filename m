From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 07:08:51 +0200
Message-ID: <20100121050850.GA18896@Knoppix>
References: <20100121004756.GA18213@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 06:09:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXpHy-0007y2-3Q
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 06:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab0AUFI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 00:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438Ab0AUFI6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 00:08:58 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:57600 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab0AUFI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 00:08:57 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 23C328C57A;
	Thu, 21 Jan 2010 07:08:56 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00CF905164; Thu, 21 Jan 2010 07:08:56 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id A90EA27D8C;
	Thu, 21 Jan 2010 07:08:52 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100121004756.GA18213@onerussian.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137630>

On Wed, Jan 20, 2010 at 07:47:56PM -0500, Yaroslav Halchenko wrote:

Added spearce to cc.

> Dear Git Developers,
> 
> Some users of our project started recently to complain that they could not
> clone the repository via http (git:// wasn't a choice due to heavy firewalling)
> and because http:// was used as a protocol to get sources in some distributions
> (e.g. macports).
> 
> Cloning of the repository works fine with v1.6.5.7 but fails with v1.6.6-rc0.
> I haven't done full bisection since that repository is relatively bulky and
> poor server is quite loaded anyways, so I thought you just would get a clue
> without going brute-force.  But here are the details:  in case of failing
> operation, I immediately get failure:
> 
> $> GIT_TRACE=2 ./git clone http://git.debian.org/git/pkg-exppsy/pymvpa.git
> trace: built-in: git 'clone' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> warning: templates not found /home/yoh/share/git-core/templates
> Initialized empty Git repository in /home/yoh/proj/misc/git/pymvpa/.git/
> trace: run_command: 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> trace: exec: 'git' 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> trace: exec: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> trace: run_command: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?

Looks like remote-curl (which handles http) issues request for:

'.../info/refs?service=git-upload-pack'

And expects that if there is no smart HTTP server there for the request to be
interpretted as:

'.../info/refs'

(i.e. webserver would ignore the query). This isn't true for git.debian.org.
Requesting the latter works (and the data formatting looks sane), but the
former is 404. This causes the fetch to fail.

-Ilari

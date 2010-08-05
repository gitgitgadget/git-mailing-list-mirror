From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC/PATCH 0/3] instaweb: fix and improve WEBrick support
Date: Thu, 5 Aug 2010 09:14:12 +0000
Message-ID: <20100805091412.GA20998@dcvr.yhbt.net>
References: <1272BF62-A0C8-4940-9472-E46C05BF1723@gmail.com> <m34ofbpcyr.fsf@localhost.localdomain> <20100804102545.GA32128@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Dippery <mdippery@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Mike Dalessio <mike@csa.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 11:14:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgwWq-0001dQ-VO
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 11:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab0HEJOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 05:14:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56826 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab0HEJOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 05:14:14 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99FC1F4E1;
	Thu,  5 Aug 2010 09:14:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100804102545.GA32128@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152626>

Eric Wong <normalperson@yhbt.net> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Michael Dippery <mdippery@gmail.com> writes:
> > > I _do_ have webrick. Asking around a bit, I was told the the problem
> > > may have been introduced in commit be5347b. Is this so? If not, any
> > > other ideas on what may be causing the problem?
> > 
> > To be more exact commit be5347b (git-instaweb: Put httpd logs in a
> > "$httpd_only" subdirectory, 2010-05-28) by Pavan Kumar Sunkara added
> > resolve_full_httpd before running *_config (webrick_config in this
> > case).  But resolve_full_httpd() beside setting $httpd_only needed
> > later for functionality provided by this commit, does also setting
> > $full_httpd and checking if given web server can be run.
> > 
> I wouldn't mind making it more like what we do with plackup and
> having a single Ruby script, eventually.

Done in 2/3 of my instaweb patch series.
3/3 also adds logging support to WEBrick so it should support
everything other web servers support.

> > The solution would be to either split resolve_full_httpd() into one
> > function generating $httpd and $httpd_only, and second function
> > generating $full_httpd and checing for web server existence, or create
> > a separate check for 'webrick'.
> 
> I just split out the check and started modelling things after the code
> for plackup.  Unfortunately, I haven't had any luck getting gitweb.cgi
> to respect $GITWEB_CONFIG environment with webrick so the following
> patch just ensures webrick is properly started, not useful.

I had to use the undocumented :CGIInterpreter option of WEBrick
along with a shell script wrapper to pass environment variables.

CGI support in WEBrick is implemented strangely: it executes a new Ruby
interpreter after forking (but before executing the actual gitweb.cgi).
Thus I couldn't just neuter the "ENV.delete" method in the webrick.rb
file as the child process would just restore the default behavior.

Pushed out to the "webrick" branch of git://git.bogomips.org/git-svn

Eric Wong (3):
      instaweb: fix WEBrick server support
      instaweb: minimize moving parts for WEBrick
      instaweb: add access+error logging for WEBrick

-- 
Eric Wong

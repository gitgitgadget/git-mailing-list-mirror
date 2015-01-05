From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git 2.2.x: Unexpected, overstrict file permissions after "git
 update-server-info"
Date: Mon, 05 Jan 2015 23:23:12 +0100
Message-ID: <54AB0ED0.3000400@web.de>
References: <20150105210724.032e9718@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 05 23:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8G3s-00021T-NL
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 23:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbbAEWXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 17:23:40 -0500
Received: from mout.web.de ([212.227.15.14]:58053 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbbAEWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 17:23:40 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M1lTm-1Xo6Vn2Xow-00to7D; Mon, 05 Jan 2015 23:23:32
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20150105210724.032e9718@x230>
X-Provags-ID: V03:K0:jeEsOjIBadG9scilS+ORDS3FwjdCBSRvmHTNzgTlCGP6lS4Gbwp
 G8l4VzWAhM5hVF2mf/oJ5VVLdsVfxQCz/RkWomajNuQrrPIolFObT9ck8nRmWhOAn05nAkH
 8wg0o82q4/aOAs3QFH18GE6mpsibhQuwq+OmwPfuC7Xmjx04nLF1pn4CK1kphEkex1i6HhT
 +abBbmCOGgKpfEwasKxiw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262039>

On 2015-01-05 20.07, Paul Sokolovsky wrote:
> Hello,
> 
> We recently upgraded to git 2.2.1 from 2.1.x and faced issue with
> accessing repositories over dump HTTP protocol. In our setting,
> repositories are managed by Gerrit, so owned by Gerrit daemon user,
> but we also offer anon access via smart and dumb HTTP protocols. For the
> latter, we of course rely on "git update-server-info" being run.
> 
> So, after the upgrade, users started to report that accessing
> info/refs file of a repo, as required for HTTP dump protocol, leads to
> 403 Forbidden HTTP error. We traced that to 0600 filesystem permissions
> for such files (for objects/info/packs too) (owner is gerrit user, to
> remind). After resetting permissions to 0644, they get back to 0600
> after some time (we have a cronjob in addition to a hook to run "git
> update-server-info"). umask is permissive when running cronjob (0002).
> 
> 
> I traced the issue to:
> https://github.com/git/git/commit/d38379ece9216735ecc0ffd76c4c4e3da217daec
> 
> It says: "Let's instead switch to using a unique tempfile via mkstemp."
> Reading man mkstemp: "The  file  is  created  with permissions 0600".
> So, that's it. The patch above contains call to adjust_shared_perm(),
> but apparently it doesn't promote restrictive msktemp permissions to
> something more accessible.
> 
> Hope this issue can be addressed.
> 
> 
> Thanks,
> Paul
Does 
git config core.sharedRepository 0644 
help?

Unless the the repo is configured as shared, 
adjust_shared_perm() will not widen the access bits:

http://git-htmldocs.googlecode.com/git/git-config.html

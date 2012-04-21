From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-remote-testgit: fix race when spawning fast-import
Date: Sun, 22 Apr 2012 01:42:12 +0200
Message-ID: <20120421234211.GC20473@ecki>
References: <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
 <20120419233445.GA20790@padd.com>
 <4F9145A1.6020201@gmail.com>
 <20120421201524.GA18419@padd.com>
 <20120421234555.GA11808@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 02:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLkGI-0006Ms-5t
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 02:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab2DVACE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 20:02:04 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:37142 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab2DVACD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 20:02:03 -0400
Received: from [127.0.0.1] (p5B22E4D1.dip.t-dialin.net [91.34.228.209])
	by bsmtp.bon.at (Postfix) with ESMTP id 107C02C4004;
	Sun, 22 Apr 2012 02:02:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120421234555.GA11808@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196066>

On Sat, Apr 21, 2012 at 07:45:55PM -0400, Pete Wyckoff wrote:
>
> @@ -258,6 +264,7 @@ def main(args):
>  
>      more = True
>  
> +    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
>      while (more):
>          more = read_one_line(repo)

There's another read in do_import(). I am not sure if it also suffers
from this race condition, but it certainly has the potential.

> +test_expect_success 'racily pushing to local repo' '
> +	cp -a server server2 &&
> +	git clone "testgit::${PWD}/server2" localclone2 &&
> +	test_when_finished "rm -rf server2 localclone2" &&
> +	(cd localclone2 &&
> +	echo content >>file &&
> +	git commit -a -m three &&
> +	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
> +	compare_refs localclone2 HEAD server2 HEAD
> +'

Should this test be running unconditionally? It will delay the otherwise
almost instant test by 2 seconds.

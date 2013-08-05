From: Tony Finch <dot@dotat.at>
Subject: git-http-backend vs gitweb pathinfo mode
Date: Mon, 5 Aug 2013 16:34:49 +0100
Message-ID: <alpine.LSU.2.00.1308051624570.16837@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tony Finch <dot@dotat.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 05 17:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6MoA-0004Hq-OP
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab3HEPev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:34:51 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:52721 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab3HEPeu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:34:50 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:43013)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1V6Mo5-0001bW-hE (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 05 Aug 2013 16:34:49 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1V6Mo5-0005Sc-BV (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 05 Aug 2013 16:34:49 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231658>

Background:

You cam make the same URL work for gitwe and git clone as described in
git-http-backend(1). It says:

   To serve gitweb at the same url, use a ScriptAliasMatch to only
   those URLs that git http-backend can handle, and forward the rest
   to gitweb:

       ScriptAliasMatch \
               "(?x)^/git/(.*/(HEAD | \
                               info/refs | \
                               objects/(info/[^/]+ | \
                                        [0-9a-f]{2}/[0-9a-f]{38} | \
                                        pack/pack-[0-9a-f]{40}\.(pack|idx)) | \
                               git-(upload|receive)-pack))$" \
               /usr/libexec/git-core/git-http-backend/$1

       ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/

Gitweb has a friendly URL mode that uses pathinfo instead of query
parameters.

Problem:

In pathinfo mode, gitweb sometimes produces URLs ending in /HEAD which
match the git-http-backend regex and therefore get passed to the wrong
CGI.

For example, go to https://git.csx.cam.ac.uk/i/ucs/git/git.git/tree
and click on the gitweb subdirectory which takes you to
https://git.csx.cam.ac.uk/i/ucs/git/git.git/tree/HEAD:/gitweb
then click on [git/git.git] to go back, which takes you to
https://git.csx.cam.ac.uk/i/ucs/git/git.git/tree/HEAD

Half-arsed solution:

I have amended the regex to start like

               "(?x)^/git/(.*/((?<=[.]git/)HEAD | \

which solves the problem for me since all my repos have names ending in
.git and this doesn't clash with any gitweb action names. I don't think
this is a general solution because some people like bare extensionless
repo names. On the other hand I don't think the regex should list all the
dozens of gitweb action names. So I'm not sure what the best fix is.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first.
Rough, becoming slight or moderate. Showers, rain at first. Moderate or good,
occasionally poor at first.

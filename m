From: "=?iso-8859-1?Q?Jason=20Wagner?=" <jason@nialscorva.net>
Subject: =?iso-8859-1?B?R2l0IG92ZXIgSFRUUFM=?=
Date: Sun, 01 Feb 2009 15:55:50 -0400
Message-ID: <20090201195550.9011.qmail@server262.com>
Reply-To: "=?iso-8859-1?Q?Jason=20Wagner?=" <jason@nialscorva.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 21:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTiXv-0003UY-4h
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 21:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbZBAUCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 15:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZBAUCd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 15:02:33 -0500
Received: from server262.com ([64.14.68.15]:59503 "EHLO server262.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbZBAUCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 15:02:32 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Feb 2009 15:02:32 EST
Received: (qmail 9012 invoked by uid 2004); 1 Feb 2009 19:55:50 -0000
X-Mailer: WebMail 2.55
X-Originating-IP: 71.171.119.126
X-Originating-Email: jason@nialscorva.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107990>

I'm trying to set up a git repository on DAV on Apache, but having some trouble pushing via HTTPS.  I've set everything up according to the documentation-- http.sslVerify=false, .netrc setup, bare repository and update-server-info, etc.  The goal is to have read access available by http, but require authed https to write.  Here's the config I've been using:

Alias /public.git /var/git/public
<Location /public.git>
   DAV on
   Options +Indexes
#TEST    <LimitExcept GET PROPFIND OPTIONS>
#TEST       AuthType Basic
#TEST      AuthName "Git repository"
#TEST       AuthUserFile /var/git/public.git.httpusers
#TEST       Require valid-user
#TEST       SSLRequireSSL
#TEST     </LimitExcept>
</Location>

I turned off the LimitExcept for testing purposes.  Inside of public is "logging", a git init --bare repository.  When testing, I can do the following:
git config repository.http.url http://jason@platinum/public.git/logging
git config repository.https.url https://jason@platinum/public.git/logging

git pull http
git push http
# fresh local repository
git pull https

When I do "git push https -f --all -v" after changing a single file, I get:

Pushing to https://jason@platinum/public.git/logging
Getting pack list
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from b8339306a895f5f18675116ab202b001cfbb95ce
  to   00d2d209b62f6f5322e943726b90bbf75f8a940a

Then it freezes until I ctrl-c it.  Sometimes the process stays around afterwards sometimes and needs a kill -9.

In the apache logs, I see the same requests coming in on both the http and https pushes.  It seems to be locking on
[01/Feb/2009:14:36:05 -0500] 127.0.0.1 TLSv1 RC4-MD5 "MKCOL /public.git/logging/refs/ HTTP/1.1" 321

or 

[01/Feb/2009:08:43:51 -0500] 127.0.0.1 TLSv1 RC4-MD5 "UNLOCK /public.git/logging/info/refs HTTP/1.1" -

I've done this on both git 1.5.6.6 and 1.6.2 to the same results.  I'm using a fully updated Fedora 9 install on the server machine.  Has anyone run into similar problems or have any suggestions?
---
Jason Wagner

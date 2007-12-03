From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Mon, 3 Dec 2007 10:44:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031036530.27959@racer.site>
References: <20071128165837.GA5903@laptop>  <Pine.LNX.4.64.0711281703470.27959@racer.site>
  <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com> 
 <Pine.LNX.4.64.0711281717460.27959@racer.site> 
 <fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com> 
 <Pine.LNX.4.64.0711281810410.27959@racer.site>  <7v3aunb0q4.fsf@gitster.siamese.dyndns.org>
  <fcaeb9bf0711302250ldfb543evd6d5f70d95ae51f7@mail.gmail.com> 
 <7v4pf25jiq.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0712022003w4a3df0f0j21a5b23f3f073597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 11:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8np-0002kv-7X
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbXLCKpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbXLCKpJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:45:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:58690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752090AbXLCKpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:45:07 -0500
Received: (qmail invoked by alias); 03 Dec 2007 10:45:06 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp039) with SMTP; 03 Dec 2007 11:45:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mQlIROfnmKrG2UfQ8BmT06LlgcIFzmdNj1i9Ad4
	nmZKBeDp+n+6un
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0712022003w4a3df0f0j21a5b23f3f073597@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66904>

Hi,

On Mon, 3 Dec 2007, Nguyen Thai Ngoc Duy wrote:

> The patch's behaviour is barf if the repository version is too new.
> The list of files that use setup_git_directory_gently is not long. I
> am going to have a look over the files before amending the patch again
> to make it only barf if nongit_ok is NULL.

In the interest of least surprise, _gently() should not ignore a too new 
repository format.  It is also keeping the semantics simpler, which is 
good for users like me.

So I'd test it with "git apply", just because it is the first on the list.  
Something like

-- snip --
cat > patch << EOF
diff a/empty-file b/empty-file
--- a/empty-file
+++ b/empty-file
@@ -0,0 +1,1 @@
+narf
EOF

test_expect_success '_gently() respects repositoryversion' '

	mkdir way_too_new &&
	(cd way_too_new &&
	 git init &&
	 git config core.repositoryFormatVersion 999999 &&
	 : > empty-file &&
	 ! git apply < ../patch 2> error.out &&
	 grep "git repo version" error.out &&
	 ! test -s empty-file

'
-- snap --

Hmm?

Ciao,
Dscho

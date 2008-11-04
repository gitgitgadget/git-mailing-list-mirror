From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libxdiff and patience diff
Date: Tue, 4 Nov 2008 06:39:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davidel@xmailserver.org, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 06:34:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxEYJ-0004kW-2Z
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 06:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYKDFcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 00:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYKDFcY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 00:32:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:52581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbYKDFcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 00:32:23 -0500
Received: (qmail invoked by alias); 04 Nov 2008 05:32:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 04 Nov 2008 06:32:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fRSQKSJHfDY+6X4RUe+3E1+HVo+mbDz6OdVF6eA
	Z90T/w7QyQCTjU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081104004001.GB29458@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100040>

Hi,

On Tue, 4 Nov 2008, Pierre Habouzit wrote:

> I've been working tonight, trying to make libxdiff support the patience 
> diff algorithm, but I've totally failed, because I _thought_ I 
> understood what xdl_split was doing, but it appears I don't.

I thought about it, too, at the GitTogether, although I want to finish my 
jGit diff first.

The main idea I had about patience diff is that you can reuse a lot of 
functions in libxdiff.

But the requirement of taking just unique lines/hashes into account, and 
_after_ splitting up, _again_ determine uniqueness _just_ in the 
between-hunk part made me think that it may be wiser to have a separate 
function for the patience diff stuff.

Basically, you would start to have libxdiff split the lines and hash them 
as normal, but then determine the unique hashes (I'd start with the 
smaller text, just to have a better chance to end up with unique hashes).

Once they are determined, you can search for those exact lines (hash 
first) in the post-document.

Once that is done, you'd have to find the longest common subsequence, 
which you could do using the existing infrastructure, but that would 
require more work (as we already know the lines are unique).

After that, you would have to recurse to the same algorithm _between_ 
known chunks.  Eventually, that would have to resort to classical libxdiff 
(if there are no, or not enough, unique lines).

Ciao,
Dscho

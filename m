From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and auto crlf convertion.
Date: Tue, 30 Oct 2007 23:30:12 -0700
Message-ID: <20071031063012.GA7798@muzzle>
References: <200710311049.43861.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 07:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In76C-00030J-Sp
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 07:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbXJaGaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 02:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbXJaGaQ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 02:30:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44525 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753294AbXJaGaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 02:30:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A21657DC0FE;
	Tue, 30 Oct 2007 23:30:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200710311049.43861.litvinov2004@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alexander Litvinov <litvinov2004@gmail.com> wrote:
> Hello.
> 
> I have private svn repo with cpp source file in windows encoding (\r\n line 
> ending). I am tring to import it into git using git-svn. To make correct crlf 
> convertion I have made git svn init first then create 
> correct .git/info/attributes file and import repo using git svn fetch 
> command. But after import done I have strange situation: after git 
> checkout -f master git status show that almost all text files are modified.
> 
> As I understand situation git-svn put \r\n encoded files into repo without 
> convertng them to \n notation. git-checkout,git-status does the job right and 
> found 'modification' as far as they do the needed convertion.

Disclaimer: I'm not yet familiar with git attributes, having never used them.

> Is there any way to configure git-svn to make proper convertion or it is 
> broken and need to be fixed ?

As far as I can tell, SVN itself will store files with either LF or CRLF
in the repository when the file is created/updated and applies the line
conversion properties only to the working tree upon checkout.  This
means that the SVN repository can have a file that's LF but only
converted to CRLF when checked out and vice-versa.

git-svn takes and imports whatever raw data SVN gives it, ignoring any
properties set in SVN.  This is very important because SVN transfers
deltas for updating files, and if we change the base file; we can't
apply the delta SVN gives us.

If we converted the newlines in the raw data that SVN gave us, we would
need to store what format the original data we got from SVN was in
because of the delta.

What I assume svn does is it either:

a) reconverts before doing `svn update' or `svn switch'
b) it ignores newline-only changes when running `svn status' or `svn diff'

git (as far as I know, and hope) does neither.

-- 
Eric Wong

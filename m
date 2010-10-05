From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Trac+Git: rev-list with pathspec performance?
Date: Mon, 04 Oct 2010 18:09:40 -0700 (PDT)
Message-ID: <m3r5g5fnth.fsf@localhost.localdomain>
References: <13399611.436896.1286218134223.JavaMail.root@mail.hq.genarts.com>
	<27777603.436995.1286223710787.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 03:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2w2P-000689-Vl
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 03:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab0JEBJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 21:09:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37139 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab0JEBJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 21:09:43 -0400
Received: by bwz11 with SMTP id 11so4215869bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=r4WW2EBlCMsxgAIq5jKG3oZUk2NppsDHfRBQVo3cu3w=;
        b=BtHksQewlG9ym92THsQVWz/9+Y8STK7SQurXz220fIA6OEblS9U9T7xcdK/h29Z0t9
         WUuwXa6ut1vWfYoKYqMUnL35o1Irf6lcj+07fXzfOjvOXgkMN7wRAJWNP+UOOnjUmMI8
         0w9+w7K9SnekT9EW2Lr1YjOPSk1P7s0iEBj5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Y+kdTlf/GDWHZhtYcgl3D3e5dRp7KKl8ZXs6AKYTwdM79bpj9chKxB+PpazGG9D6lN
         LDzksCZjT8yxNnUhwGWc1NLW2g2GERa3qkqvQc86mTP7tfE31VOop3l9eHA2XXnBYHaK
         QUwSabp/QEmt54KcdXi3dQ7dhMXLVw50LFo4Y=
Received: by 10.204.55.135 with SMTP id u7mr7848350bkg.122.1286240982019;
        Mon, 04 Oct 2010 18:09:42 -0700 (PDT)
Received: from localhost.localdomain (aeho253.neoplus.adsl.tpnet.pl [79.186.196.253])
        by mx.google.com with ESMTPS id y19sm4364743bkw.6.2010.10.04.18.09.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 18:09:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9519Ap0029458;
	Tue, 5 Oct 2010 03:09:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9518xd9029452;
	Tue, 5 Oct 2010 03:08:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <27777603.436995.1286223710787.JavaMail.root@mail.hq.genarts.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158152>

Stephen Bash <bash@genarts.com> writes:

> I'm trying to improve the performance of Trac [1], the GitPlugin for
> Trac[2], and Git.  Trac is being extremely sluggish while browsing
> source, and profiling revealed the majority of the time was the
> GitPlugin calling git rev-list.  When I directly entered the
> rev-list calls from the shell, I found Git itself was performing
> slower than I would expect...
> 
> The bottleneck is while Trac is populating the "last change to file"
> column in the source browser (see the "rev" column of [3] for an
> *cough* SVN *cough* example).  This concept of "find the last change
> to a file" was discussed a few weeks ago [4], but unlike that
> thread, the GitPlugin is simply calling git rev-list --max-count=1
> branchName -- fileName for each file in the current directory.  For
> files modified recently this is very fast (thousandths of a second),
> but for older files rev-list takes a long time to come up with an
> answer (~2-3 seconds on our server).
[...]

> References:
> [1] http://trac.edgewall.org
> [2] http://trac-hacks.org/wiki/GitPlugin
> [3] http://trac.edgewall.org/browser/trunk
> [4] http://article.gmane.org/gmane.comp.version-control.git/150183/

Note that later[5] in mentioned thread[4] there is proof of concept
"tree blame" (in Perl) which generates such 'last change to file'
information, I think faster than running 'git rev-list -1 <file>' for
each file.  Even better would be to encode used algorithm in C.

[5] http://thread.gmane.org/gmane.comp.version-control.git/150063/focus=150183

P.S. Alternate solution would be to simply get rid of SVN-inspired
view.  Git tracks history of a *project* as a whole, not set of
histories for individual files (like CVS).

-- 
Jakub Narebski
Poland
ShadeHawk on #git

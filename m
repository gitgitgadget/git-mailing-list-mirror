From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] Make Git::SVN and Git::SVN::Ra canonicalize paths
 and urls.
Date: Sat, 28 Jul 2012 09:11:26 -0500
Message-ID: <20120728141126.GD9715@burratino>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-8-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 16:12:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv7ka-0005c4-EL
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 16:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab2G1OLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 10:11:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58586 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab2G1OLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 10:11:31 -0400
Received: by yhmm54 with SMTP id m54so3951509yhm.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qoQ5YYh1Fyo4aJ1NuwdlkQYBHU0LhMGU2P9LYpKzRj8=;
        b=h6KfMls6FemXBgYakjXGl8QFo69dU0Q+mLysbaPzC3YB956Z4DfIlYhALftHwXtB+Z
         7ifOp2N6as11K3NrKO5g1U4ae9NbXoaLBoVw/SYuBEhBVQU1W3Vj5kbUWPsYVV0W/rit
         LW5bByf1LZrp9hxC12FN4N7GGiOc8Df19ZumrGiHYcTWE6C4P+yecQ9KAFRX+RzyKsVt
         mSe9TBGzlGSi/JTnTb7lBF3D7lnHYUlrs9CjpprN8eZNjWewYapE6tKs7FDlKQztixr9
         m0+eEJm3DWCQs0FlWzoaKS61WlOu29milTGKCc1qCzcJrCw/LXkEAEi8699z6/IsHAap
         CP6Q==
Received: by 10.50.207.40 with SMTP id lt8mr4518092igc.16.1343484690879;
        Sat, 28 Jul 2012 07:11:30 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id aj7sm3864996igc.16.2012.07.28.07.11.29
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 07:11:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343468312-72024-8-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202438>

Michael G. Schwern wrote:

> This canonicalizes paths and urls as early as possible so we don't
> have to remember to do it at the point of use.

Yay!  Am I correct in imagining this makes the following sequence of
commands[1] no longer trip an assertion failure in svn_path_join[2]
with SVN 1.6?

	git svn init -Thttp://trac-hacks.org/svn/tagsplugin/trunk \
		-thttp://trac-hacks.org/svn/tagsplugin/tags \
		-bhttp://trac-hacks.org/svn/tagsplugin/branches
	git svn fetch

[1] http://bugs.debian.org/616168
[2] 
  $ git svn fetch
  W: Ignoring error from SVN, path probably does not exist: (160013): Filesystem has no item: File not found: revision 100, path '/tagsplugin'
  W: Do not be alarmed at the above message git-svn is just searching aggressively for old history.
  This may take a while on large repositories
  perl: /build/buildd-subversion_1.6.17dfsg-4-i386-MgNPeW/subversion-1.6.17dfsg/subversion/libsvn_subr/path.c:115: svn_path_join: Assertion `svn_path_is_canonical(component, pool)' failed.
  error: git-svn died of signal 6

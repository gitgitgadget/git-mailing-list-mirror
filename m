From: Jim Meyering <jim@meyering.net>
Subject: unchecked uses of strdup
Date: Wed, 05 Apr 2006 18:02:24 +0200
Message-ID: <87d5fwau3z.fsf_-_@rho.meyering.net>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
	<7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
	<20060404105818.GA17326@mars.ravnborg.org>
	<1144165927.30675.32.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 05 18:03:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRASi-00077P-KM
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 18:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWDEQC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDEQC0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 12:02:26 -0400
Received: from mx.meyering.net ([82.230.74.64]:46465 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1751134AbWDEQCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 12:02:25 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id B33285036; Wed,  5 Apr 2006 18:02:24 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <1144165927.30675.32.camel@dv> (Pavel Roskin's message of "Tue,
	04 Apr 2006 11:52:07 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18441>

There are pretty many uses of strdup in git's sources.
Here's one that can cause trouble if it ever returns NULL:

    [from fsck-objects.c]
    static int fsck_head_link(void)
    {
            unsigned char sha1[20];
            const char *git_HEAD = strdup(git_path("HEAD"));
            const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1, 1);

The problem is that resolve_ref does an unconditional `stat'
on the parameter corresponding to the maybe-NULL git_HEAD.

One solution is to change such uses of strdup to uses of xstrdup.

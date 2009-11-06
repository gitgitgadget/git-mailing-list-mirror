From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: suggestions for local configs?
Date: Fri, 06 Nov 2009 08:21:39 +0100
Message-ID: <4AF3CE83.1060400@viscovery.net>
References: <4AF393EE.4030205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Rupp <caphrim007@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 08:21:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6J8l-00023k-GB
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 08:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZKFHVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 02:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbZKFHVh
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 02:21:37 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:44142 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752442AbZKFHVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 02:21:37 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N6J8e-0007RQ-72; Fri, 06 Nov 2009 08:21:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E9F839F88; Fri,  6 Nov 2009 08:21:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AF393EE.4030205@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132278>

Tim Rupp schrieb:
> I have a piece of software that has default and local configuration
> files. The default files ship with the tarball. The local files are
> copied over from the default folder during installation and can be
> modified for a particular install.

This is how *I* would organize it, but it is a bit overengineered if the
changes needed in the configuration are only minimal:

  ---o--o--X1--o--o--X2--o          master (aka upstream)
      \     \             \
       R-----M1------------M3       rename
        \     \             \
         Y-----M2------------M4     production

We need two branches in addition to master, which tracks upstream version.

1. The first branch *renames* the example configuration to the effective
configuration:

   git mv foo.conf.example foo.conf
   # commit R
   git commit -m "Use the example configuration"

It is important that *no change* is made to the configuration file, and it
furthermore assumes that the production configuration (foo.conf) does not
exist [*].

The point of this commit is that git can determine that the file was
renamed with 100% similarity.

2. The second branch is actually where the customization happens, this is
commit Y:

   git checkout production
   edit foo.conf
   # commit Y
   git commit -m "configuration changes needed in production"


Assume, upstream made changes to the configuration (commit X1). These
changes are merged in the following way:

1.  git checkout rename && git merge master

This creates M1. git detects that on our side the file was renamed, and
merges the upstream changes into the renamed file. Since we didn't modify
the file in R, there are no conflicts.

2.  git checkout production && git merge rename

This creates M2. This is a regular merge that integrates upstream changes
with the local changes made in Y, possibly with conflicts.

You repeat the procedure when upstream makes more changes to the example
configuration in X2. This time, git merge again detects that the file was
renamed with 100% similarity, and things work just like with M1 and M2.

[*] If there is a configuration file in addition to the example
configuration, another branch is needed that removes it.

-- Hannes

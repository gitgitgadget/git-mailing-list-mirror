From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/3] setup: stop ignoring GIT_WORK_TREE (when GIT_DIR is
 unset)
Date: Wed, 19 Jan 2011 06:37:32 -0600
Message-ID: <20110119123732.GA23222@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 13:37:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfXIP-0001zM-Aw
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 13:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab1ASMhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 07:37:47 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55283 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab1ASMhq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 07:37:46 -0500
Received: by qwa26 with SMTP id 26so781382qwa.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gC1ZaCj+yej048JiLJqr76Vr3JP6B2XU7r8hPcmbXEc=;
        b=F0Ry2t1mj4zbj9gBSVab3y7T5tbRLifIr8eE1W0W7aTJav8U5yEc38OmxSQr8WvGE5
         eTqc/6IKVxDG9uefytmQC4dTH5o6h1Ouq9GMyHg9xPFAsl/lsY5BBI3CIYFfVq83uKlt
         160aHY4Qr5Zk9PwzY3bcpLVHlUBkuLuhGUA2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OZ+BVUGHYxw/0gcwgPK6s4k1iir4GziQZCGT2V42/wL0QUCF2Tabddf/webTgf4vV/
         KTyObRW/kMUI0gHy4M234FJltu4z8oSUAbBd9EEvfhi9aNxeACxamzR+4PBS4STfhwiD
         rghfHmxymErMSB6DZzMLmNxOi+HRk2ZSZ1oMQ=
Received: by 10.229.211.6 with SMTP id gm6mr591740qcb.112.1295440665575;
        Wed, 19 Jan 2011 04:37:45 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id s10sm4680059qco.23.2011.01.19.04.37.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 04:37:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1v4aknij.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165263>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/setup.c
>> @@ -419,6 +419,11 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>>  		return NULL;
>>  	}
>>  
>> +	if (getenv(GIT_WORK_TREE_ENVIRONMENT)) {
>> +		warning("GIT_WORK_TREE without explicit GIT_DIR is deprecated");
>> +		return setup_explicit_git_dir(gitdir, cwd, offset, nongit_ok);
>> +	}
>> +
>
> My knee-jerk reaction is that calling this "deprecated" is probably
> confusing. git merely failed to notice misconfiguration

After staring at test results, I agree.  The rule, before nd/setup,
seems to be something like this:

 - if GIT_DIR is set, you're safe
 - if GIT_DIR is unset and .git is in the current directory,
   GIT_WORK_TREE will work by accident
 - otherwise, git errors out.

The patch below should be more robust.  It prints a warning:

	warning: pretending GIT_DIR was supplied alongside GIT_WORK_TREE

As the night winds on I am less sure that that warning is a good idea.
The .git discovery behavior seems relatively safe.  What is more
worrisome for the future of the use of GIT_WORK_TREE independent of
cwd is the interaction with pathspecs.

Jonathan Nieder (3):
  tests: cosmetic improvements to the repo-setup test
  tests: make the setup tests briefer
  setup: stop ignoring GIT_WORK_TREE and core.worktree

 setup.c               |   27 +-
 t/t1510-repo-setup.sh | 5166 +++++++------------------------------------------
 2 files changed, 729 insertions(+), 4464 deletions(-)

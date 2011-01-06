From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: git mergetool broken when rerere active
Date: Wed, 5 Jan 2011 22:39:07 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101052119530.26654@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Magnus Baeck <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 04:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pagh7-0001BU-31
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 04:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab1AFDjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 22:39:16 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46771 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab1AFDjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 22:39:15 -0500
Received: by qyj19 with SMTP id 19so18928063qyj.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 19:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:message-id:user-agent:mime-version:content-type;
        bh=VEuvsXOldSwuW+ZsPvY3HFZ34cWTgj5NrAU5IWa0gvE=;
        b=XijZ5JX/UZwCXhv8bPKNP4oPVbSgJ3TCBmuHVMNMI2Ky6Vdy9eC7S5SxHw1tR70JwR
         uLMzOheZxl1DFpGFzN9NgFmqPMsFhtJlCF1Z2+oeuz/h8mTQLPN1J8Okm2XQdpq6Tj89
         82iQo9kX3QAkkQH9cCvFkO7aN2xYZ8wb5hXbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:message-id:user-agent
         :mime-version:content-type;
        b=U10M3FeBmRQY0lX4dkc+vKiN7bFcahWKN5UBXEAjmGZOllz3a8Y84bT3fXSUz0IwBC
         lOVnbdX9DHCcDGJNWv+7BPDZhjmtNfdIBJmhGWVeM3wwk63Aen37mZ68EhC1BJct4Hyl
         hUwrP8ZeNY3O92EI3ejTBaAwH9rvoOJul+RNY=
Received: by 10.224.46.91 with SMTP id i27mr22940792qaf.15.1294285153285;
        Wed, 05 Jan 2011 19:39:13 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm12595197qco.23.2011.01.05.19.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 19:39:12 -0800 (PST)
X-X-Sender: martin@debian
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164622>

Hi,

When rerere is enabled, git mergetool uses 'git rerere status' to find
out which files to run the merge tool on. This was introduced in
bb0a484 (mergetool: Skip autoresolved paths, 2010-08-17). Before that,
'git ls-files -u' was used, whether or not rerere was active.

This change caused two problems:

 (1) Before this change, it used to be that case that all conflicts
     would be resolved and added to the index after running 'git
     mergetool' without arguments, i.e. on all files. After the
     change, conflicts of type 'deleted by them' or 'deleted by us'
     would be ignored, since they are not listed shown by 'git rerere
     status'. Previously, git mergetool would ask whether to pick the
     modified file or to delete the file.

 (2) When running mergetool again after resolving some (or all)
     conflicts, so that some of the files have already been added to
     the index, mergetool will now print something like

     file1: file does not need merging
     Continue merging other unresolved paths (y/n) ?

     Before the change, any files that were already added to the index
     would just be skipped, without mergetool asking the user whether
     to continue.

I would like to have both the original properties in (1) and (2) back,
i.e. being ready for commit once 'git mergetool' has been successfully
completed, and having it ignore any files that have already been added
to the index.

I was reading the original thread [1], but I didn't quite understand
why just enabling rerere.autoupdate would not solve the problem. Maybe
it was just that the goal was a solution that works even with
rerere.autoupdate disabled? Can we fix it in some way by combining the
output of 'git rerere status' and 'git ls-files -u'?


Regards,
Martin

[1] http://thread.gmane.org/gmane.comp.version-control.git/153420

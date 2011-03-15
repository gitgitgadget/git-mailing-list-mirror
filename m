From: Jakob Pfender <jpfender@elegosoft.com>
Subject: [RFD] git stash over OpenBSD/Linux NFS - cp -p breakage
Date: Tue, 15 Mar 2011 11:08:36 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D7F3AA4.1080202@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: casey@nrlssc.navy.mil, jon.seymour@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 11:09:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzRBe-0005Ow-7A
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 11:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab1COKIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 06:08:45 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:57917 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab1COKIo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 06:08:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 24FAE1B4BC2;
	Tue, 15 Mar 2011 11:08:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RrKfI6TNNNcb; Tue, 15 Mar 2011 11:08:37 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id A7E2B1B4BBD;
	Tue, 15 Mar 2011 11:08:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169056>

We have an NFS setup with Linux machines mounting an NFS that is hosted 
on an OpenBSD server. Recently, we discovered git-stash breaking with:

$ git stash
cp: preserving permissions for 
`/home/jpfender/stashtest/.git/.git-stash.3056-index': Operation not 
supported
Cannot save the current worktree state

This was discovered to be caused by a bug in cp that causes 'cp -p' to 
fail in this particular NFS setup - preserving permissions in an NFS 
shared across Linux and OpenBSD machines doesn't work.

I looked at git-stash.sh and could not discover a reason why it had to 
use 'cp -p'. I patched it to use only cp without preserving permissions, 
and everything seemed to work fine. All stash tests succeeded (bar two 
known breakages).

So my question is: Does git-stash really need 'cp -p'? Is it safe to remove?

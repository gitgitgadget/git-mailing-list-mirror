From: David Michael Barr <david.barr@cordelta.com>
Subject: Subversion integration with git
Date: Fri, 26 Mar 2010 01:17:42 +1100
Message-ID: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 15:18:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nunsl-0006tL-W8
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 15:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab0CYORz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 10:17:55 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:62308 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab0CYORy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 10:17:54 -0400
Received: by fxm23 with SMTP id 23so1114999fxm.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=61uNrrZUNeCqcvP9NOZhuTPTy8Vhle8eenu9fPtLsmc=;
        b=mlaWks5FzzSJEsnq8hb3VIi9E/ONhxdx9T9cC3g90somvOzoo6HJyxxe+B5+r6MvV+
         LLeB8TKjduSafzPXT83urWPZbGPPNp7qH/LG4vQnSrXRwF7PLVaTm1w6e+0XWQf54Anh
         xHSkK+ciEYG7lyBYn9cEN3necs8WHNUQtOHqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        b=l6L4WVOjNoReGfho5S9MJemtubJfAQhj1XVh/a68Ww4hTi/FYG4d6A1oMCmFtK1sip
         U/iyTCNMkuPLtFzlNGwGGVr+W71KPp4ZwARvGC9vs/GrZ0jeV17tLv2huYXC1ECkAC9F
         Q+LX6yx49Qwb3Cv49BLrOpT9gkT3k00Ih/qDc=
Received: by 10.102.164.10 with SMTP id m10mr568869mue.52.1269526672144;
        Thu, 25 Mar 2010 07:17:52 -0700 (PDT)
Received: from [192.168.1.2] (d122-109-106-179.mit3.act.optusnet.com.au [122.109.106.179])
        by mx.google.com with ESMTPS id n7sm7335986mue.45.2010.03.25.07.17.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 07:17:50 -0700 (PDT)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143180>

Hi folks,

As my first posting to the list, I'd like to start by giving a big thank you to all the git developers and maintainers for such a great tool.

Unfortunately, I still have to interact with lesser tools such as Subversion and that is what leads me to post.

I'm employed on proprietary project which is supported by a large number of open source tools. The 'canonical' source repository is hosted on a Subversion server on the other side of a rather unreliable WAN link. To date I've been using a combination of git-svn, cron, and a handful of bash scripts to handle marshalling commits between our git repositories and the Subversion instance. However, whilst this solution works well for incremental commits, every time a branch is created on the remote repository it's a hassle to synchronise.
So I thought I'd use git-svn and standard layout - this resulted in blasting my link with so many HTTP requests that I got a stern warning from our sysadmin and I'm sure the firm on the other side of the link weren't impressed.
After exploring a few solutions I used SVK to create a local mirror of the repository.

When I pointed git-svn at the local mirror, it took 4 days, a whole lot of RAM and fell over at 90% completion with a checksum error.

When I pointed svn-all-fast-export at the repository it had to skip three commits or would indefinitely spew garbage.

When I pointed svn2git.py at a dump of the repository it successfully imported 50% of commits and then ran at snail's pace, ETA next century.

I decided that I liked the idea of subversion dump in - git fast-import out but it had to scale well.

So I grabbed the git-fast-import documentation and the Subversion dump format documentation and tried to design a data structure that would map well between them and scale linearly with my repository.

I started a new project to implement my design and am curious as to how many git users actually care about this kind of problem. While conversion is once off for most projects - there are an awful number of projects currently using Subversion. As the community and tool-chain builds around git, that will mean many desiring to make the transition. I hope to make it far less painful than it has been for me.

My project is still in the preview phase but has enough to import commit-tree structure bar symlinks and executable flags. It imports my 22000+ commit 2.8GB dump in 4 minutes. It is currently 840 non-comment lines of C. I aim to produce output that git-svn can take over from.

Is it worthwhile to start a new project - or would it be better to grok the internals of existing projects and try to make them scale?

Best regards,
David M Barr
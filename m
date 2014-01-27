From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Mon, 27 Jan 2014 10:58:29 -0800
Message-ID: <20140127185829.GE27577@google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
 <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
 <20140127175953.GA18041@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Mon Jan 27 19:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7rOV-00023l-Jp
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 19:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbaA0S6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 13:58:36 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:41761 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbaA0S6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 13:58:35 -0500
Received: by mail-bk0-f43.google.com with SMTP id mx11so3060268bkb.30
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8Xk0ivniNvP4DDaoU3N/iVW2cFoKS0Pqp6WwZJEUlJQ=;
        b=AG+8OZsKqlADbFSh4CRTndeeFWaZOyx59LNkBBA4QrcInsSWPIrdd9xNaUKwnUmzqY
         50vxVSBDOtXFMU2OuSBHIbDQh7yXQ7b88MofuDBuGS9J58bzFHhoGjQWLi81StvYiIZ9
         E4Cl82FcOXMsKLYYItxbQLQHS/ZMqJdvt5YSL3W9X5pgye6fkAKOXE3/hDZNxzKvIAdX
         ksdLbzFlzvY6aCAlzadBZDLaHS/KQrsaAGl9abBjE7lWqktwGK2IGD02yoMYPGY4h4Pm
         yxaUR7lgk3FP0B7BZVQ8yLS3MNhVfMI4ixC9dpqEXXLW0NDhOsLMhC+oxGmP3kyU8RJI
         RKaQ==
X-Received: by 10.204.167.193 with SMTP id r1mr2623581bky.99.1390849114465;
        Mon, 27 Jan 2014 10:58:34 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d5sm14373853bkc.9.2014.01.27.10.58.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 10:58:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140127175953.GA18041@camk.edu.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241152>

Hi,

Kacper Kornet wrote:

> The change in release numbering also breaks down gitolite v2 setups. One
> of the gitolite commands, gl-compile-conf, expects the output of git --version 
> to match /git version (\d+)\.(\d+)\.(\d+)/. 
>
> I have no idea how big problem it is, as I don't know how many people
> hasn't migrate to gitolite v3 yet. 

http://qa.debian.org/popcon.php?package=gitolite says there are some.
I guess soon we'll see if there are complaints.

http://gitolite.com/gitolite/migr.html says gitolite v2 is still
maintained.  Hopefully the patch to gitolite v2 to fix this would not
be too invasive --- e.g., how about this patch (untested)?

Thanks,
Jonathan

diff --git i/src/gl-compile-conf w/src/gl-compile-conf
index f497ae5..8508313 100755
--- i/src/gl-compile-conf
+++ w/src/gl-compile-conf
@@ -394,8 +394,9 @@ die "
     the server.  If it is not, please edit ~/.gitolite.rc on the server and
     set the \$GIT_PATH variable to the correct value\n
 " unless $git_version;
-my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.(\d+)/);
+my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.([^.-]*)/);
 die "$ABRT I can't understand $git_version\n" unless ($gv_maj >= 1);
+$gv_patchrel = 0 unless ($gv_patchrel =~ m/^\d+$/);
 $git_version = $gv_maj*10000 + $gv_min*100 + $gv_patchrel;  # now it's "normalised"
 
 die "\n\t\t***** AAARGH! *****\n" .

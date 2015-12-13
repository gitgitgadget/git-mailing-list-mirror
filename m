From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: What's "wrong" with this fast-import?
Date: Sun, 13 Dec 2015 01:53:39 +0100
Message-ID: <1449968019-9570-1-git-send-email-szeder@ira.uka.de>
References: <20151212192540.4ba49fea@viper.int.arc7.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: com.git-scm@io7m.com
X-From: git-owner@vger.kernel.org Sun Dec 13 01:54:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7uvn-0001uj-B6
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbbLMAy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:54:27 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51960 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbbLMAy1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Dec 2015 19:54:27 -0500
Received: from x590c0945.dyn.telefonica.de ([89.12.9.69] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a7uve-0004dp-I3; Sun, 13 Dec 2015 01:54:24 +0100
X-Mailer: git-send-email 2.7.0.rc0.37.g77d69b9
In-Reply-To: <20151212192540.4ba49fea@viper.int.arc7.info>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1449968064.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282315>

> The symptom of the bug seems to be that if a branch B is created from
> branch A, files committed to B, and then B merged with A, the committed
> files are not present in the head of A.

fast-import's 'merge' command doesn't actually perform a merge, it
merely records that the new commit has one more parent.  All changes
compared to the first parent (i.e. the addition of that new readme file
on the side branch) have to be listed explicitly.

> As an example:
> 
>   http://waste.io7m.com/2015/12/12/fossilexport/
> 
> The given test.fossil repository was populated with the following steps:
> 
>   1. Create fossil repository.
>   2. Add README.txt and commit in trunk.
>   3. Create branch 'b0' and switch to it.
>   4. Add README-b0.txt and commit in b0.
>   5. Switch to trunk.
>   6. Merge and commit 'b0'.
> 
> The HEAD of the fossil repository now contains README.txt and
> README-b0.txt.
> 
> Exporting the repository (see test.export) produces:
> 
> --
> blob
> mark :4
> data 7
> Hello.
> 
> blob
> mark :10
> data 10
> Hello b0.
> 
> commit refs/heads/trunk
> mark :3
> committer someone <someone> 1449930286 +0000
> data 22
> initial empty check-in
> deleteall
> 
> commit refs/heads/trunk
> mark :7
> committer someone <someone> 1449930317 +0000
> data 7
> Initial
> from :3
> M 100644 :4 README.txt
> 
> commit refs/heads/b0
> mark :9
> committer someone <someone> 1449930338 +0000
> data 28
> Create new branch named "b0"
> from :7
> 
> commit refs/heads/b0
> mark :13
> committer someone <someone> 1449930374 +0000
> data 13
> Add README-b0
> from :9
> M 100644 :10 README-b0.txt
> 
> commit refs/heads/trunk
> mark :15
> committer someone <someone> 1449930396 +0000
> data 8
> Merge b0
> from :7
> merge :13

I.e. this commit should also contain the following filemodify command
to add that new readme file:

  M 100644 :10 README-b0.txt

From: Luke Diamand <luke@diamand.org>
Subject: git-p4: labels
Date: Sun, 18 Dec 2011 18:33:39 +0000
Message-ID: <4EEE3203.10605@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>,
	Michael Horowitz <michael.horowitz@ieee.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 18 19:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcLYI-0000Kx-Es
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 19:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab1LRSde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 13:33:34 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:41837 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1LRSdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 13:33:33 -0500
Received: by werm1 with SMTP id m1so929069wer.19
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 10:33:32 -0800 (PST)
Received: by 10.216.137.155 with SMTP id y27mr3182570wei.53.1324233212409;
        Sun, 18 Dec 2011 10:33:32 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id gd6sm22814790wbb.1.2011.12.18.10.33.30
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Dec 2011 10:33:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187426>

I've been looking at fixing the --detect-labels flag in git-p4. I'm now 
thinking that the current way it's done is just all wrong.

The current code has a few annoying bugs which I mostly have fixes for:

- it only works when there is no more than one label per changelist;

- if the count of files in the p4 label doesn't match the count of files 
in the p4 changelist then the label gets dropped (by design);

- git-p4 rebase ignores --detect-labels

- it imports all the label/file mappings each time (I haven't fixed this 
yet)

However, the thing that's more annoying is that it only imports labels 
when importing the changelist they are pointing at.

So, for example, if you do something like this:

p4 edit; p4 submit
p4 tag TAG1
git-p4 rebase
p4 tag TAG2
git-p4 rebase

then TAG1 will be detected, but TAG2 won't.

This is a particular nuisance for me, as I just have git-p4 running all 
the time eating commits, so there's no scope for a human to delay the 
git-p4 and pickup the label.

I think what's needed is to do something completely different.

This is speculation at the moment, and I'd welcome comments before I 
start hacking.

There will be a new _command_, import-labels. This command will find all 
the labels that git knows about, and the labels that p4 knows about, and 
then do the obvious diff. It will then create tags as needed directly 
(i.e. not using fast-import).

It will unfortunately need to hunt through the revision history looking 
for the git hash <h> that matches p4 changelist <c>. This could get 
quite slow, although no worse than O(n).

Something like:

p4 edit; p4 submit
p4 tag TAG1
git-p4 rebase
git-p4 import-labels
p4 tag TAG2
git-p4 import-labels

I'm going to try to work up a patch with some test cases but in the 
meantime if anyone thinks I've missed something, please let me know.

Thanks
Luke

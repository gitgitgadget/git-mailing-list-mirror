From: Thomas Perl <th.perl@gmail.com>
Subject: [BUG] gitweb generates wrong links in grep search results (git_search_files)
Date: Mon, 2 Jan 2012 14:29:01 +0100
Message-ID: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 02 14:29:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhhws-0001cw-66
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 14:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787Ab2ABN3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 08:29:04 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34332 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab2ABN3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 08:29:03 -0500
Received: by eaad14 with SMTP id d14so7984409eaa.19
        for <git@vger.kernel.org>; Mon, 02 Jan 2012 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=OgeA8xiIMJKFKK/y/baGszqyvcYYehRybGvZF3PQCIE=;
        b=Aa3N9bSmbrRBpfjPqqGjfmmGG2RsbR17iaM785niLf6GbdaRUqi4Ty24zZjHNi7WtF
         DRI+5QJJKnAXH+28zo90VpqA5c9/R8AmuunlNPHgoOcjGDGO95aMm3m3F9dpgR9IluUp
         VIG+FFBV/EIhSX1rIVyMnZDXNHxwpFpWmkxXA=
Received: by 10.204.156.210 with SMTP id y18mr11444782bkw.118.1325510941663;
 Mon, 02 Jan 2012 05:29:01 -0800 (PST)
Received: by 10.204.201.72 with HTTP; Mon, 2 Jan 2012 05:29:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187839>

Hi,

I think I found a bug in gitweb when grep'ing for text in a branch
different from "master". Here's how to reproduce it:

1. Have a project with a master branch and a branch different from master
2. Start gitweb for that project (e.g. using "git instaweb") and open
it in a web browser
3. Switch to the non-master branch (e.g.
http://127.0.0.1:1234/?p=.git;a=shortlog;h=refs/heads/mynonmasterbranch)
4. In the top right search box, select "grep" in the combo box and
enter a text that only appears in the non-master branch
5. Submit the search by pressing enter, you should be at:
http://127.0.0.1:1234/?p=.git&a=search&h=refs%2Fheads%2Fmynonmasterbranch&st=grep&s=somesearchtext

ACTUAL RESULT
In that list of results, you should now see some files matching the
search - note that the links for the file names and the line numbers
go to e.g. http://127.0.0.1:1234/?p=.git;a=blob;f=somefile.txt for a
file "somefile.txt". The links therefore go to the master branch,
while the search results refer to the non-master branch.

EXPECTED RESULT
The link should (presumably) go to
http://127.0.0.1:1234/?p=.git;a=blob;hb=refs%2Fheads%2Fmynonmasterbranch;f=somefile.txt
so that when the link is clicked, the right file (somefile.txt in
mynonmasterbranch) is shown.

I also investigated a bit in where the problem happens, and nailed it
down to: gitweb/gitweb.perl, sub git_search_files, line 5871 in commit
17b4e93d5b849293e6a3659bbc4075ed8a6e97e2 (current master tip of
https://github.com/gitster/git). I haven't looked at the intrinsics of
the "href" sub, but I believe that it should somehow get the "h"
parameter from the original page and incorporate it into the final
link (as "hb" parameter?) to the file. The same fix that is applied
there then also needs to be applied at line 5891 (same commit, same
file).

No patch, because after several tries, I didn't get it to work, my
Perl foo might not be up to the task, and I believe that someone more
familiar with gitweb's code base might have an easier time to fix
this.

Thanks,
Thomas

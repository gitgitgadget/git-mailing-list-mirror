From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC] remarks about custom diff driver
Date: Mon, 27 Aug 2007 12:36:34 +0200
Message-ID: <vpq8x7x5knh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 12:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbxj-0007iK-BX
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXH0Kgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbXH0Kgs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:36:48 -0400
Received: from imag.imag.fr ([129.88.30.1]:47661 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbXH0Kgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:36:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7RAaYct012047
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 12:36:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IPbxS-0006MZ-Hr; Mon, 27 Aug 2007 12:36:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IPbxS-0005R6-Ey; Mon, 27 Aug 2007 12:36:34 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 27 Aug 2007 12:36:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56808>

Hi,

The following is a reflexion about Git's custom diff drivers, thought
after setting up a custom diff driver for OpenDocument files.

  http://www-verimag.imag.fr/~moy/opendocument/

Indeed, my solution has a few drawbacks: it doesn't take advantage of
git's diff engine. --color, --color-words do not work. I could use
git-diff within my script, but I can't get the argument passed on the
command-line, so I can hardcode --color for example, but not be
consistant with the rest of the diff (in case "git diff" shows the
diff between two text files and two OpenDocument files).

Also, git-diff doesn't have a -L option, so using git-diff would mean
having some a/tmp/oodiff.xzy.1 in the output, which is ugly.

Indeed, what I would have needed is a custum text converter. In my
case, I would have said something like

# ~/.gitconfig
[textconverter "odt2txt"]
	command=odt2txt

Then, in .gitattributes

*.ods textconverter=odt2txt
*.odp textconverter=odt2txt
*.odt textconverter=odt2txt

And git-diff could apply an algorithm like

if custom-diff-driver-specified
then
    custom-diff-command $1 .. $7
elif custom-textconverter-specified
    echo "Using textconverter $textconverter"
    custom-textconverter-command $file1 > $tmpfile1
    custom-textconverter-command $file2 > $tmpfile2
    use git engine on $tmpfile1 and $tmpfile2
else
    use git engine on $file1 and $file2
fi

This way, someone specifying a textconverter would automatically
benefit from all the facilities that git has for text files (all the
good stuff of git-diff, --color, --color-words, correct diff label
without bothering with -L option of diff, ...). One could imagine also
have "git-blame" work for these files, ...

One drawback: making this too much transparent, users may want to use
"git apply", or just "patch" on the generated diffs. So,
git-format-patch shouldn't use it, and that's why my pseudo-code above
displays a message "Using textconverter ...".

Any opinion? Do you think that's overkill? Anyone else have a
particuliar experience with custom diff engine?

-- 
Matthieu

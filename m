From: Peter Krefting <peter@softwolves.pp.se>
Subject: Implementing $Date$ substitution - solution using pre-commit
Date: Thu, 13 Aug 2009 07:47:25 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908130742470.18241@ds9.cixit.se>
References: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 08:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbU66-0002SI-Mj
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 08:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbZHMGr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 02:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbZHMGr0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 02:47:26 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:43376 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752686AbZHMGr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 02:47:26 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7D6lQQv020411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Aug 2009 08:47:26 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7D6lPhL020407;
	Thu, 13 Aug 2009 08:47:25 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 13 Aug 2009 08:47:26 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125787>

Hi!

So, my filter-based approach at doing RCS-like $Date$ expansion didn't work 
out. Since I wanted to have the Date expand on check-in, not on check-out, 
and be expanded in history, I had made it into a "clean" filter. But due to 
how Git internally checks if files are clean, that did not work properly.

The solution to this was instead to make the Date expansion into a 
pre-commit hook. Using .gitattributes, I set "datereplace=true" on all the 
files I want to have "$Date$" expand in, and then install the following 
file as .git/hooks/pre-commit:

===8< pre-commit >8===
#!/bin/bash -e

# Find base commit
if git-rev-parse --verify HEAD >/dev/null 2>&1
then
 	against=HEAD
else
 	# Initial commit: diff against an empty tree object
 	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Set up Date substitution
export NOW=$(date +"%Y-%m-%d %H:%M:%S")
for file in $(git diff-index --cached --diff-filter=AM --name-only $against); do
   if git check-attr datereplace -- "$file" | grep 'datereplace: true' > /dev/null; then
     perl -w -i.bak -e 'my $now = $ENV{"NOW"};
$now =~ s/[^-:0-9 ]//g;
while (<>)
{
  if (/\$Date:?[^\$]*\$/)
  {
    s/\$Date:?[^\$]*\$/\$Date: ${now} \$/;
  }
  print
}' "$file"
     git update-index --add "$file"
   fi
done

exit 0
===8< pre-commit >8===

This has the added bonus over a filter that it all files committed at the 
same time will have the same date stamp, whereas the filter would expand on 
the time "git add" is executed.

-- 
\\// Peter - http://www.softwolves.pp.se/

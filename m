From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: [script] find largest pack objects
Date: Fri, 10 Jul 2009 13:16:50 +1200
Message-ID: <A67AA762-487D-4CFB-B555-718C88C5787D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 03:17:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP4ja-0004VL-Nj
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 03:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbZGJBQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 21:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZGJBQ6
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 21:16:58 -0400
Received: from mail-pz0-f175.google.com ([209.85.222.175]:40710 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZGJBQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 21:16:57 -0400
Received: by pzk5 with SMTP id 5so370951pzk.33
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=MrQRMYKQu4fx/TlOJLP6W7crfqoIFRdnWKTJ9Eo24XE=;
        b=Mo3BfW4hEsh3q9bsKN3aTYnZN9CXyZFArbqhdbSVdfag6Ji7c8TRe2fL1FTmNHbnWl
         H3OLeqWc8YHe8TL2L1wIMjg7JAMQDRs6Uvin6OApPD36AJ6XLDeqDgdiGGDBmO+FG8rQ
         wwuWuoIyFDSBNoP7wwa/lOGzbvV8fGhzaHrRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=b8TP4Qmx9BhhMfxFPo6ZD+K0FkEw1vohcc4lj05kxPVPwXR0zqr23Rrt5VmritIWwU
         YvfvaoEabQb3tW24tbKHHn50DPrzKIYVTauGFcKWutc78od5A9wLDWxkBbeDBxtmRkdg
         jZxfdZCXEQWNfTAWgW3qKqxllSRVQ0Ait97HI=
Received: by 10.115.108.20 with SMTP id k20mr1242620wam.4.1247188615946;
        Thu, 09 Jul 2009 18:16:55 -0700 (PDT)
Received: from ?10.10.10.123? (mail.vgaca.co.nz [60.234.161.39])
        by mx.google.com with ESMTPS id l38sm671811waf.26.2009.07.09.18.16.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 18:16:55 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123027>

Blog post about git pruning history and finding large objects in your  
repo: http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/

This is a script I put together after migrating the Spring Modules  
project from CVS, using git-cvsimport (which I also had to patch, to  
get to work on OS X / MacPorts). I wrote it because I wanted to get  
rid of all the large jar files, and documentation etc, that had been  
put into source control. However, if _large files_ are deleted in the  
latest revision, then they can be hard to track down.

#!/bin/bash
#set -x

# Shows you the largest objects in your repo's pack file.
# Written for osx.
#
# @see http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
# @author Antony Stubbs

# set the internal field spereator to line break, so that we can  
iterate easily over the verify-pack output
IFS=$'\n';

# list all objects including their size, sort by size, take top 10
objects=`git verify-pack -v .git/objects/pack/pack-*.idx | grep -v  
chain | sort -k3nr | head`

echo "All sizes are in kB's. The pack column is the size of the  
object, compressed, inside the pack file."

output="size,pack,SHA,location"
for y in $objects
do
	# extract the size in bytes
	size=$((`echo $y | cut -f 5 -d ' '`/1024))
	# extract the compressed size in bytes
	compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
	# extract the SHA
	sha=`echo $y | cut -f 1 -d ' '`
	# find the objects location in the repository tree
	other=`git rev-list --all --objects | grep $sha`
	#lineBreak=`echo -e "\n"`
	output="${output}\n${size},${compressedSize},${other}"
done

echo -e $output | column -t -s ', '

More info on the blog post: http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/

Regards,
Antony Stubbs

Talk to me about Wicket, Spring, Maven consulting, small scale  
outsourcing to Australasia and India and Open Source development!

Check out the Spring Modules fork at http://wiki.github.com/astubbs/spring-modules 
  ! We've just done the first release of the project in over a year!

Website: http://sharca.com
Blog: http://stubbisms.wordpress.com
Linked In: http://www.linkedin.com/in/antonystubbs
Podcast: http://www.illegalargument.com

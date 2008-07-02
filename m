From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 22:33:29 +0400
Message-ID: <37fcd2780807021133y3a02ca80g9647b1f0854fec2b@mail.gmail.com>
References: <20080702143519.GA8391@cuci.nl>
	 <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
	 <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
	 <20080702181021.GD16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 20:35:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7AR-0004Hw-7s
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYGBSdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 14:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYGBSdc
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 14:33:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:30810 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYGBSdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 14:33:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so149328yxm.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wB0kihb30dxSy2dB+j2JDBCXZZt2ST/rY7EeMOMYMEQ=;
        b=THFsObFBx231zXGFYjL1s1fQL3n2bgSffskkrCO2IPRJXEcpn3QIWhfO1hhsWA7XNu
         NJBrEOrKmRU9BoaMPjRpAmH+Prgl82k4M/WAIfoYo9tvCPBBFSvreMr4klVJXX2ZLJpP
         t0Md4sJKxggryUxlrRcp+uzOM38h9bodYLaP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lcV182hpXR0asjCe7dflWV9iYhQYq7Zf5GoSp6Vj+LLVh2IMGznTZtLgD0eXdkM+lL
         eS1vJTCktP8NjhfNvg3QOr5IaY4fHDucfwQ7C4zDdHdPxUfzxbR7xwtLw5qqfzmweNbe
         XNmymQXHvt3yHs/2jVBsCTC6MF+SmvNep9PQA=
Received: by 10.142.240.9 with SMTP id n9mr3189234wfh.79.1215023609701;
        Wed, 02 Jul 2008 11:33:29 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Wed, 2 Jul 2008 11:33:29 -0700 (PDT)
In-Reply-To: <20080702181021.GD16235@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87174>

On Wed, Jul 2, 2008 at 10:10 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Dmitry Potapov wrote:
>>On second thought, it may be not necessary. You can extract an old commit
>>object, edit it, put it into Git with a new SHA1, and then use the graft file to
>>replace all references from an old to a new one. And you will be able to see
>>changes immediately in gitk.
>
> Hmmmm, interesting thought.  That just might solve my problem.

This script is just a prove of the concept. It seems to work for me, but
I don't really tested it.

===========================================
#!/bin/bash

set -e

# creating some silly repo
git init
# creating some history
for ((i=0; $i<10; i++))
do
	echo foo$i > foo$i
	git add foo$i
	git commit -m "add foo$i"
done

# run gitk to see it
gitk --all &

# dump all graft info to text file
git rev-list --parents --all > .git/info/grafts.tmp
mv .git/info/grafts.tmp .git/info/grafts

# please choose what commit you want to edit
echo
while read -p 'Edit commit: ' C
do
C=$(git rev-parse "$C") || continue
# edit commit C
git cat-file commit $C > .git/COMMIT_OBJ
vim .git/COMMIT_OBJ

C2=$(git hash-object -w -t commit .git/COMMIT_OBJ)

# replace all references from C to C2
sed -e 's/\<'$C'\>/'$C2'/g' < .git/info/grafts > .git/info/grafts.tmp
mv .git/info/grafts.tmp .git/info/grafts
done
===========================================

Dmitry

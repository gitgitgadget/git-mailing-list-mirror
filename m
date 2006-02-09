From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb using "--cc"?
Date: Thu, 9 Feb 2006 12:27:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> <43EAA560.8030504@didntduck.org>
 <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org> <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org> <Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
 <7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 21:28:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7IOg-0004aV-VW
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWBIU2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWBIU2H
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:28:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750770AbWBIU2F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 15:28:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19KS1DZ018690
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 12:28:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19KRweS011019;
	Thu, 9 Feb 2006 12:27:59 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15823>



On Thu, 9 Feb 2006, Junio C Hamano wrote:
>
> I was wondering if we could teach not diff_tree_combined_merge
> but show_combined_diff to do this, so that diff-files -c would
> benefit from the raw output as wel.

I wanted to do it that way, but it seemed less intrusive this way.

I agree that it is the correct thing to do, though.

> That aside, one remaining nit with your patch is printing
> p->path.  diff.c::diff_flush_raw() does something like this:
> 
> 	if (line_termination) {
> 		path_one = quote_one(path_one);
> 		path_two = quote_one(path_two);
> 	}
> 	...
> 	printf("%s%c%s", status, inter_name_termination, path_one);

Good point.

I found another nitpick: file removal doesn't seem to generate a good 
diff in "git-diff-tree --cc" (but it's correct in the new "raw" format 
diff).

Here's a test-case, in case you care. Do "git-diff-tree --cc HEAD" in the 
merge-test directory.

Finally, I think it would be good to have a "--ignore-mode" flag that 
drops the mode info from the raw format (that repeating "100644" really 
isn't very interesting, and caring about mode changes is pretty rare).

		Linus

---
#!/bin/sh
rm -rf merge-test
mkdir merge-test
cd merge-test/
git-init-db 

echo "hello" > a
echo "hi there" > b
git add a b
git commit -m "Initial commit of 'a' and 'b'"
git branch other

echo "different hello" > a
git commit -m "Changed 'a'" a

git checkout other
echo "another different hello" > a
git commit -m "Changed 'a' differently" a

git checkout master
git merge "merge other" HEAD other >& /dev/null

echo "final hello" > a
rm -f b
echo "new file" > c
git-update-index --add --remove a b c
git commit -m "Evil merge"

From: =?utf-8?B?UMSTdGVyaXMgS8S8YXZpxYbFoQ==?= <klavins@netspace.net.au>
Subject: Re: An interaction with ce_match_stat_basic() and autocrlf
Date: Tue, 8 Jan 2008 18:12:18 +0100
Message-ID: <fm0au5$i65$1@ger.gmane.org>
References: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 18:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCI0x-0005wm-Dn
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 18:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762959AbYAHRM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 12:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbYAHRM4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 12:12:56 -0500
Received: from main.gmane.org ([80.91.229.2]:56787 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762955AbYAHRMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 12:12:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JCI0Q-0002Lu-Ry
	for git@vger.kernel.org; Tue, 08 Jan 2008 17:12:50 +0000
Received: from host74-244-static.104-82-b.business.telecomitalia.it ([82.104.244.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 17:12:50 +0000
Received: from klavins by host74-244-static.104-82-b.business.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 17:12:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host74-244-static.104-82-b.business.telecomitalia.it
In-Reply-To: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org>
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16545
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69893>

> At this point, the index records a blob with LF line ending,
> while the work tree file has the same content with CRLF line
> ending.

I think this needs more than just sleeping on.

There are two separate problems related to crlf treatment in git that 
manifest themselves in the quirks you see in the current implementation:

(1) The fact that the index may be misaligned with the work tree. Junio's 
example demonstrates this well. I have resorted to

$ rm -rf *
$ git reset --hard

in the past to get a work tree that passes

$ git status

without false positives after changing the value of autocrlf.

(2) The fact that repository content may be mangled in an indeterminate way 
because of the current work tree <-> repository transformation algorithm. 
While criticism in the past has mainly been levelled at not knowing whether 
a truly binary file will be correctly determined as such, content can be 
lost in the round trip work tree -> repository -> work tree much more 
simply:

$ git init
$ git config core.autocrlf true
$ echo ab | tr ab \\r\\n >a.txt
$ od -t a a.txt
0000000  cr  nl  nl
0000003
$ git add a.txt
$ git commit
$ rm a.txt
$ git reset --hard
$ od -t a a.txt
0000000  cr  nl  cr  nl
0000004

In summary, it irks me that autocrlf true mode is a second cousin of 
autocrlf false and I think that there *should* be an acceptable 
deterministic solution to this.

The solution to (2) seems easier than (1): could the transformation 
algorithm be made deterministic and changed to something like "convert all 
crlf pairs to lf if and only if no singleton cr or lf exist in the file 
before conversion"? If a binary file gets mangled in error, it would be an 
easy transformation with standard tools to get the file back again. If an 
otherwise text file has mixed lf and crlf endings, or additional cr or lf 
sprinkled randomly through it, the file is not transformed.

Given a deterministic transformation algorithm, the solution to (1) boils 
down to recording for each file in the work tree whether the transformation 
algorithm was used or not in arriving at the file's current contents, 
together with a way of telling git to force the use of the transformation 
algorithm or not for a particular file. It seems to me the place that this 
information *should* be recorded is the index, given that both .git/config 
and .gitattributes can be changed independently of the work tree. Recording 
the information in the index would mean that both autocrlf true and autocrlf 
false clones of the same repository would produce equally valid work trees 
with no loss of information. I am however not well versed enough in git 
internals at the moment to know whether this is an acceptable solution or 
not. 

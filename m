From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 02:53:42 +0200
Message-ID: <op.utv93sdo1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 02:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4PCr-0000Bg-Em
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 02:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbZENAxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbZENAxp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 20:53:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:37175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752455AbZENAxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 20:53:44 -0400
Received: (qmail invoked by alias); 14 May 2009 00:53:44 -0000
Received: from g225203118.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.225.203.118]
  by mail.gmx.net (mp055) with SMTP; 14 May 2009 02:53:44 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19S0V0TV9pS7ZNB6yKczeGezcqXaG/OJGI+V52Avb
	iDiPmXnjQTY8eY
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 208BE9464A
	for <git@vger.kernel.org>; Thu, 14 May 2009 02:53:43 +0200 (CEST)
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119122>

Greetings,

I found a way to break git fast-export accidentally. I'm looking at the  
master branch, currently v1.6.3.1-9-g95405ba for me.

The short story is, I tried to regenerate signed tag objects after  
doctoring the history in a repo to fix b0rked addresses after conversion,  
doing something like:

	git tag -f -s foo foo

when I should have done

	git tag -f -s foo foo^{commit}

Now I have  tag "foo" twice in my repo, and this screws some operations  
royally.

Here's a script to generate such a b0rked repo:

#! /bin/sh
#
# On your marks
set -eu
IFS=$(printf '\n\t')
#
# Set
dir=$(mktemp -d)
cd $dir
git init
echo foo >bar
git add bar
git commit -m "add bar"
git tag -s baz -m "tag bar as baz"
#
# Go - this is correct, but we'll do wrong
#git tag -f -s baz baz^{commit} -m "regenerate tag"
#
# This is wrong and confuses git fast-export:
git tag -f -s baz baz -m "regenerate tag"
#
# Print the result
git show baz


This is quite prominent in git fast-export --all --signed-tags=strip  
output:

...
tag baz
 from :2
tagger Matthias Andree <matthias.andree@gmx.de> 1242259705 +0200
data 15
tag bar as baz

tag baz
 from :0
tagger Matthias Andree <matthias.andree@gmx.de> 1242259705 +0200
data 11
regenerate

And the "from :0" hunk kills git fast-import afterwards as the mark :0  
isn't defined. Not sure if it could cope with a duplicate tag otherwise.  
Probably not how git-tag should behave.

Questions:

1. how do I get a list of all such tags? git tag -l doesn't work. git  
rev-list --all is a bit unspecific for my taste, and not very helpful...

2. how do I trash the accidentally created 2nd "baz" tag object, i. e.  
remove it from the (packed) object database? Of course, I can hack some  
script (or use a text editor) to grind this git-fast-export into shape and  
re-importing it...

3. is this a shortcoming in git tag that doesn't properly resolve its 2nd  
non-option argument to a commit?

Thanks.

-- 
Matthias Andree

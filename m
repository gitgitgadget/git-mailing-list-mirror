From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 01 Jul 2008 20:16:32 -0400
Message-ID: <486AC8E0.60002@verizon.net>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com> <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Adam Brewster <adambrewster@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 02:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDq33-0006Q0-H8
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 02:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbYGBAQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYGBAQm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 20:16:42 -0400
Received: from main.gmane.org ([80.91.229.2]:38454 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbYGBAQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 20:16:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KDq1X-0005DQ-VD
	for git@vger.kernel.org; Wed, 02 Jul 2008 00:16:40 +0000
Received: from pool-71-246-235-165.washdc.fios.verizon.net ([71.246.235.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 00:16:39 +0000
Received: from mdl123 by pool-71-246-235-165.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 00:16:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-246-235-165.washdc.fios.verizon.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87073>

Junio C Hamano wrote:

> 
> Well, I have a moderately strong objection to this.
> 
> This very much feels like adding a missing feature to "git bundle" command
> itself.  Why isn't it a new option to it?
> 

I have implemented (in script form) a different approach: basically, I just keep 
a local copy of the refs pushed out via bundle in refs/remotes/*, just as for 
any other remote, and then use those as the basis for later bundles. My longer 
term goal is to integrate this into git push, so that with a properly configured 
remote "git push foo" will create a bundle based upon the local knowledge of the 
remote's basis and update the local copy of the refs.


For reference, this is the script I currently use ...

#!/bin/sh
# usage
if test $# -lt 4
then
     echo "usage: $0 repoDirectory bundleName remote [git-for-each-ref args]"
     exit 1
fi

# must be at toplevel
cd $1 || exit 1
cd ./$(git rev-parse --show-cdup) || exit 1

bundleName=$2
remote=$3
shift 3

# get list of what we want to bundle up
newrefs=$(git for-each-ref --format="%(refname)" $*)

# get list of the current bundle
basis=$(git for-each-ref --format="^%(objectname)" refs/remotes/$remote)

# create the bundle
if git bundle create "$bundleName" $newrefs $basis
then
     # update our record of basis from the bundle
     git bundle list-heads "$bundleName" | \
     while read sha1 refname
     do
         git update-ref refs/remotes/"$remote"/"${refname##refs/}" $sha1
     done
else
     rm -f "$bundleName"
fi

Mark

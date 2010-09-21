From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Deleting of the specified ref during the post-receive hook
Date: Tue, 21 Sep 2010 08:40:50 -0600
Message-ID: <4C98C3F2.9050006@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 16:41:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy41r-0000dO-MB
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 16:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0IUOkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 10:40:55 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:36552 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab0IUOkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 10:40:55 -0400
Received: (qmail 10424 invoked by uid 399); 21 Sep 2010 08:40:53 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.198.56)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2010 08:40:53 -0600
X-Originating-IP: 75.196.198.56
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100825 Lightning/1.0b3pre Thunderbird/3.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156724>

  I've recently asked whether there was a public script to act as an 
automatic 'maintainer', something akin to Gerrit's push always 
succeeding without having to pull first when using Git as a central 
repository.  I received a number of suggestions, and I have begun trial 
implementations.

My current line of thought has an auto-merging script that monitors the 
refs/for/ namespace (similar to Gerrit) and then applies --no-ff merges 
to the appropriate branch.  For instance, when the user pushes to 
refs/for/master, the post-receive hook creates a secondary ref called 
refs/for/master-SHA1-timestamp and then deletes the refs/for/master ref:

#!bin/sh
# post-receive hook
while read oldrev newrev ref
do
     case $ref in
         refs/for/*)
             timestamp=`date +%s`
             `git update-ref $ref-$newrev-$timestamp $newrev`
             `git update-ref -d $ref`
         ;;
     esac
done

If you'll pardon my lacking shell script skills (I'm open to learn!), my 
primary question concerns safety.  When receiving a ref via an SSH-based 
server (which happens to be Gitolite, but I don't think that is relevant 
here), is the post-receive hook guaranteed to be run in a lockstep 
manner?  That is, if two people push to 'refs/for/master' at the same 
time, is there a lock to process one user and then the other user?

The auto-merging script is just simple at the moment.  It runs 'git 
fetch origin refs/for/*:refs/for/*', sorts the refs/for/ entries by 
timestamp, and merges into the specified branch, emailing the user on 
success or failure (not implemented yet... I'm sure Gitolite gives me 
access to the username, but I haven't looked it up yet).

Before I go too much deeper down this path, am I way off base here?

Thanks.

Josh

From: Jan Smets <jan.smets@alcatel-lucent.com>
Subject: repository corruption when pushing commits to a repository running
 'git gc --prune='
Date: Wed, 14 Oct 2015 15:44:59 +0200
Message-ID: <561E5C5B.3090207@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 15:56:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmMX7-00076C-AM
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 15:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbbJNNzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 09:55:49 -0400
Received: from fr-hpgre-esg-01.alcatel-lucent.com ([135.245.210.22]:37902 "EHLO
	smtp-fr.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932114AbbJNNzr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2015 09:55:47 -0400
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2015 09:55:47 EDT
Received: from fr711usmtp1.zeu.alcatel-lucent.com (unknown [135.239.2.122])
	by Websense Email Security Gateway with ESMTPS id 50B4B7358D52
	for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:45:07 +0000 (GMT)
Received: from FR712WXCHHUB03.zeu.alcatel-lucent.com (fr712wxchhub03.zeu.alcatel-lucent.com [135.239.2.74])
	by fr711usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id t9EDiobM028784
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 14 Oct 2015 15:45:09 +0200
Received: from [172.31.139.43] (135.239.27.39) by
 FR712WXCHHUB03.zeu.alcatel-lucent.com (135.239.2.74) with Microsoft SMTP
 Server (TLS) id 14.3.195.1; Wed, 14 Oct 2015 15:45:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Originating-IP: [135.239.27.39]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279574>

Hi

I've recently expired my reflog to prune loose objects. On a live, bare, 
repository I ran 'git gc --prune=now'

All clients ended up having problems, they would report:
  error: refs/heads/master does not point to a valid object!
Running 'git log' on the bare repo gave : fatal: bad object HEAD



So I did a couple of tries reproducing the issue and with this little 
test I got a couple of interesting different/similar outcomes

A: mkdir -p /tmp/test; cd /tmp/test ; git init --bare bare ;
B: cd /tmp/test ; git clone bare 1 ; cd 1;  touch test; git add test; 
while true; do date >> test ; git commit -m "$(date)" test ; git push || 
break; done
A: cd bare; git gc --prune=now  (or run it in a loop)


1)

fatal: bad object 22f0351258fa0bb4cd28984b6473510957fbce69
fatal: bad object 22f0351258fa0bb4cd28984b6473510957fbce69
To /tmp/test/bare
  ! [remote rejected] master -> master (missing necessary objects)

2)

remote: error: unable to write sha1 filename 
objects/05/cdb51bb0ea3e229734a4b1bddd5ec70fbc65ed: No such file or directory
remote: fatal: failed to write object
error: unpack failed: unpack-objects abnormal exit
To /tmp/test/bare
  ! [remote rejected] master -> master (unpacker error)

3)

error: Ref refs/heads/master is at 
e992810e70949e797d33041bf6bc961c9fa4f3e5 but expected 
0000000000000000000000000000000000000000
remote: error: Cannot lock ref 'refs/heads/master':
To /tmp/test/bare
  ! [remote rejected] master -> master (failed to update ref)

4)

remote: error: cannot lock ref 'refs/heads/master': Unable to create 
'/tmp/test/bare/refs/heads/master.lock': File exists.
remote:
remote: If no other git process is currently running, this probably means a
remote: git process crashed in this repository earlier. Make sure no 
other git
remote: process is running and remove the file manually to continue.
To /tmp/test/bare
  ! [remote rejected] master -> master (failed to update ref)
error: failed to push some refs to '/tmp/test/bare'


And eventually running 'git gc --prune=now/all' on the bare repository 
could end with this message:

$ git gc --prune=all
error: refs/heads/master does not point to a valid object!
fatal: bad object refs/heads/master
error: failed to run repack
$ git log -1
fatal: bad object HEAD


This behaviour has been observed with version 2.4.4, 2.5.[12] and 2.6.1

Thank you

- Jan

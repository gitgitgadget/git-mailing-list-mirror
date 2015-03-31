From: Mike Hommey <mh@glandium.org>
Subject: git branch --contains is slow with a lot of branches
Date: Tue, 31 Mar 2015 10:45:11 +0900
Message-ID: <20150331014511.GA28418@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:45:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YclF4-00029v-To
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbbCaBpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:45:18 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:58188 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932AbbCaBpR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:45:17 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YclEt-0000eY-G4
	for git@vger.kernel.org; Tue, 31 Mar 2015 10:45:11 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266504>

Hi,

Sometimes I want to know what (possibly remote) branch contains a given
commit. The repository where I do that has thousands of branches:

$ git for-each-ref | wc -l
7657

And a lot of commits:

$ git rev-list --all | wc -l
538174

Using git branch --contains can be a very expensive thing:

$ time git branch --contains 0812b94 --all > /dev/null

  real  3m0.871s
  user  3m0.828s
  sys   0m0.084s

I'd argue this shouldn't take much more time than enumerating all revs:

$ time git rev-list --all | wc -l
538174

real    0m4.842s
user    0m4.488s
sys     0m1.332s

This can be reproduced to a certain degree with the git git repo:

$ git clone https://github.com/git/git
$ cd git
$ for i in $(seq 1 1000); do git branch branch$i master; done
$ git gc # will pack the refs
$ time git rev-list --all | wc -l
40886

real    0m0.505s
user    0m0.464s
sys     0m0.108s

$ time git branch --contains v2.0.0 > /dev/null

real    0m6.207s
user    0m6.204s
sys     0m0.004s

(especially in this case where all branches point to the same commit)

It's also essentially linear on the number of branches:

$ for i in $(seq 1001 7000); do git branch branch$i master; done
$ git gc
$ time git rev-list --all | wc -l
40886

real    0m0.493s
user    0m0.484s
sys     0m0.076s

$ time git branch --contains v2.0.0 > /dev/null

real    0m43.446s
user    0m43.436s
sys     0m0.040s

Mike

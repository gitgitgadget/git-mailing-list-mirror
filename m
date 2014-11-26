From: Mike Hommey <mh@glandium.org>
Subject: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Wed, 26 Nov 2014 09:42:42 +0900
Message-ID: <20141126004242.GA13915@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 01:42:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtQh3-0006eb-IZ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 01:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaKZAmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 19:42:50 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:52151 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbaKZAmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 19:42:49 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XtQgs-0003kf-GD
	for git@vger.kernel.org; Wed, 26 Nov 2014 09:42:42 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260256>

Hi,

I have a note tree with a bit more than 200k notes.

$ time git notes --ref foo show $sha1 > /dev/null
real    0m0.147s
user    0m0.136s
sys     0m0.008s

That's a lot of time, especially when you have a script that does that
on a fair amount of sha1s.

Now, the interesting thing is this:

$ time git ls-tree -r refs/notes/foo $sha1 ${sha1:0:2}/${sha1:2:38} ${sha1:0:2}/${sha1:2:2}/${sha1:4:36} > /dev/null
real    0m0.006s
user    0m0.008s
sys     0m0.000s

$ time git cat-file blob $objsha1 > /dev/null
real    0m0.002s
user    0m0.000s
sys     0m0.000s

And even better:

$ wc -l /tmp/note
39 /tmp/note
$ time git ls-tree refs/notes/foo $(awk '{print $1, substr($1,1,2) "/" substr($1,3), substr($1,1,2) "/" substr($1,3,2) "/" substr($1,5)}' /tmp/note) | awk '{print $3}' | git cat-file --batch > /dev/null
real    0m0.035s
user    0m0.028s
sys     0m0.004s

Reading 39 notes with ls-tree and cat-file --batch takes less time than
using git notes show for only one of them...

(and reading all 39 of them with git notes show takes 5.5s)

Mike

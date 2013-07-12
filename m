From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Bug in .mailmap handling?
Date: Fri, 12 Jul 2013 18:07:21 +0200
Message-ID: <51E029B9.20108@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 18:07:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxfsU-0004Sa-5F
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 18:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904Ab3GLQHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 12:07:22 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:62825 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964785Ab3GLQHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 12:07:21 -0400
Received: by mail-wi0-f176.google.com with SMTP id ey16so866328wid.15
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=2tJGuzBBBNA7MdYtbFAe4KUGjb/QX8kUwamGY/bQcSo=;
        b=JGjG0NveM7nDZCXuGtXZ0RPW1OqCUatTH6Bt9PDoS0Gy7LQ7W/hjL25cJBJ6yaJlA4
         2PN/xnBpyPjWTmqJ8x1rLCt8lQMl9Oua3FOYIaZyOQDWC8Po0q62gQjmPpzE8/LlVClW
         atmUq8IoW4qxey/uhNcJzdmW1weTjf74k8tmwD9v9TAAY37Xc4JeVIBTPPxix8LTrwEj
         sdCTbLnu/7KzzPuVBX01/ij0CPFIerc+LaupQgbQxsDubqpQcc6Mwq4jsbZxz+aCysHy
         5jzaW9w2SDqnY7todr9R6HwyFh26/c9pCIVQRBqcpdZwIvLVAgTwAwOyo9eeIDRvsq8s
         r7ow==
X-Received: by 10.194.82.97 with SMTP id h1mr24314234wjy.95.1373645240312;
        Fri, 12 Jul 2013 09:07:20 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z6sm4280296wiv.11.2013.07.12.09.07.19
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 09:07:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230201>

Hello,

you may have noticed I am currently trying to bring the 
mailmap file of git itself up to date. I noticed
some behavior, which I did not expect. Have a look yourself:

---
	# prepare test environment:
	mkdir testmailmap
	cd testmailmap/
	git init

	# do a commit:
	echo "asdf" > test1 
	git add test1
	git commit -a --author="A <A@example.org>" -m "add test1"

	# commit with same name, but different email 
	# (different capitalization does the trick already, 
	# but here I am going to use a different mail)
	echo "asdf" > test2
	git add test2
	git commit -a --author="A <changed_email@example.org>" -m "add test2"

	# how do we know it's the same person?
	git shortlog
	A (2):
		  add test1
		  add test2

	# reports as expected:
	git shortlog -sne
		  1  A <A@example.org>
		  1  A <changed_email@example.org>
		  
	# Adding the line to the mailmap should make life easy, so we know
	# it's the same person
	echo "A <A@example.org> <changed_email@example.org>" > .mailmap

	# Come on, I just wanted to have it reported as one person!
	git shortlog -sne
		 1  A <A@example.org>
		 1  A <a@example.org>
		 
	# So let's try another line in the mailmap file, (small 'a')
	echo "A <a@example.org> <changed_email@example.org>" > .mailmap

	# We're not there yet?
	git shortlog -sne
		 1  A <A@example.org>
		 1  A <a@example.org>

	# Now let's write it rather explicit: 
	# (essentially just write 2 lines into the mailmap file)
	cat << EOF > .mailmap
	A <a@example.org> <changed_email@example.org>
	A <a@example.org> <A@example.org>
	EOF
		 
	# works as expected now
	git shortlog -sne
		 2  A <a@example.org>

	# works as expected now as well
	git shortlog      
	A (2):
		  add test1
		  add test2

From: Jim Hill <gjthill@gmail.com>
Subject: "not in cache" error from `git ls-files -m | git checkout-index -f
 --stdin` ?
Date: Tue, 12 May 2015 14:47:04 -0700
Message-ID: <20150512214704.GA25107@gadabout.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 23:47:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsI1h-0008WG-9g
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933970AbbELVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:47:14 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33130 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933142AbbELVrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:47:12 -0400
Received: by iebgx4 with SMTP id gx4so14765164ieb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=d3LqvsPAOH/gABxZMMUmB84gO4c2zPzrqDoMt2hZdFs=;
        b=nRlKEWQ1Y6Ihzl+kI6YNDArkH2ZFA7Eqqer08pkGtsM8iu/03sP26jkQOmSRrYLNY4
         a6kV003t1QZEvZGkQ8h303p8r/GFvwuiW+MvkcpiQ7NPqNn2YbZD4kGj/IKLdXs85v7X
         cLU9aNe9k58V4tuPcqFm7BmXobw2aCNnaDHn0i+rtEw/gYidcHG9kEyaWPmnm+3IWXh3
         US65koQO/obHyzIQwFKK70jEU3s4GZtsMLh2K+dxxq4Dzv+75mihBajAx9AFn/WLjU8w
         S70ul6qM3Hj06+GEFc2upQXjHDRlUCzNhXptQOioTB6rOrE4vRwgvPOCG/yYANf/Al1A
         yhTg==
X-Received: by 10.42.128.84 with SMTP id l20mr5653564ics.21.1431467231511;
        Tue, 12 May 2015 14:47:11 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id j20sm2083698igt.16.2015.05.12.14.47.10
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 14:47:10 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268896>

Hi, it seems to me that in this sequence:

    git ls-files -m | git checkout-index --stdin -m

c-i should never complain that a file isn't in the cache, but that's
exactly what this script produces for me:

-8<----------

#!/bin/sh
rm -rf reproduce-c-i-weirdity
git init --template= reproduce-c-i-weirdity
cd reproduce-c-i-weirdity

mkdir content
mkdir deployment

echo '*/' >>.gitignore
echo '!content/' >>.gitignore

echo deployme >>content/deployme

git add .
git commit -m-

git init --template= --bare test.git
git remote add test $PWD/test.git

mkdir test.git/hooks
cat >test.git/hooks/pre-receive <<\EOD
#!/bin/sh -x
while read old new ref; do [[ $ref = refs/heads/master ]] && {
	export GIT_WORK_TREE=../deployment
	export GIT_INDEX_FILE=deployment-manifest
	git read-tree -um `git write-tree` $new:content \
	|| { git ls-files -m | tee /dev/stderr | git checkout-index -f --stdin;
		git read-tree -um `git write-tree` $new:content; } \
	|| exit $?
}
done
EOD
chmod +x test.git/hooks/pre-receive

git push test master

echo nonono > deployment/deployme
echo yesyes > content/deployme

git commit -am-
git push test master

->8-------------------

read-tree and ls-files can both find the file and see that it's changed,
so why not checkout-index?

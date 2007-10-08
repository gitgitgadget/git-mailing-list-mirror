From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 18:09:50 -0600
Message-ID: <51419b2c0710071709s2f797df0u986447f5455f306d@mail.gmail.com>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
	 <20071007213817.GJ31659@planck.djpig.de>
	 <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
	 <20071007221920.GF2765@steel.home>
	 <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com>
	 <20071007234039.GH2765@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 02:10:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IegCI-00029u-Ua
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 02:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXJHAJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 20:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXJHAJv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 20:09:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:51746 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXJHAJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 20:09:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1468158wah
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 17:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AJ1Ps88OjOe2V/nrY5pAm6IuDDeYqXDPXcWnuNS346E=;
        b=A0vzKNyqEKHXv5squ9XPSanmrLNL1GJszbQ1VvRgwtoYN6O5WxVwZdpKXKQnfoMKXHpbg/GEGSGa4lGfLMR8EEgx9Jk0qBOsWJDCkCxBfZyybxF+7hjxI3m2OK7kPzywMRxEim9968sT+hIV0918Wovep/WVPGp4MZovwZ9Je90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q+EZfZ8BEkRLmWSGF2I6mI6LgdS14kLhkEU+B+967IKMJxlPAios11OB/UsAWTJCgmUUm2gZAxJnwf0N/EgC1Zx6Y3zsPbkes440cQ2FVObIXeQ2UwmDi/j1Kdqm9YvNXDfK9rDUnT6v58FTltr7p3BC0kyaSzJ6qx4s2/D1ClA=
Received: by 10.114.61.1 with SMTP id j1mr4715781waa.1191802190146;
        Sun, 07 Oct 2007 17:09:50 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 17:09:50 -0700 (PDT)
In-Reply-To: <20071007234039.GH2765@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60267>

On 10/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> you missed something. Your example compresses to about 124k.

What version of git are you running?  I reran all the steps to which
you responded (repeated below for clarity) with git-1.5.3.3 and still
get 11MB.  Also, you must have different filesystem extents than me
since an empty git repo takes 196k here[1], so I don't think any repo
is going to get down to 124k.

My understanding of the steps you suggest would work:

# Make a small repo
mkdir test
cd test
git init
echo hi > there
git add there
git commit -m 'Small repo'

# Add a random 10M binary file
dd if=/dev/urandom of=testme.txt count=10 bs=1M
git add testme.txt
git commit -m 'Add big binary file'

# Remove the 10M binary file
git rm testme.txt
git commit -m 'Remove big binary file'

# Compress the repo, see how big the repo is
git gc --aggressive --prune
du -ks .                       # 10548K
du -ks .git                    # 10532K

# Try to rewrite history to remove the binary file
git-filter-branch --tree-filter 'rm -f testme.txt' HEAD
git reset --hard

# Try to recompress and clean up, then check the new size
git gc --aggressive --prune
du -ks .                       # 10580K !?!?!?
du -ks .git                    # 10564K

# Do the stuff Alex suggests to trim the history
rm -rf .git/refs/original/
vi .git/packed-refs
# Use vi to remove the line referring to refs/original...
git reflog expire --all
git gc --aggressive --prune
du -ks .                      # Still 10564K


Thanks,
Elijah

[1] An empty git repo takes 196k for me, as can be seen by:
$mkdir tmp
$cd tmp
$git init
$du -hs .
196K    .

From: Michael Geddes <michael@frog.wheelycreek.net>
Subject: Bug in alternates
Date: Thu, 12 Aug 2010 08:26:52 +0800
Message-ID: <201008120826.53902.michael@frog.wheelycreek.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 02:39:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjLp6-000375-Am
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 02:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933621Ab0HLAh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 20:37:29 -0400
Received: from smtpauth.rollernet.us ([208.79.240.5]:45871 "EHLO
	smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933615Ab0HLAhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 20:37:21 -0400
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2010 20:37:21 EDT
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
	by smtpauth.rollernet.us (Postfix) with ESMTP id F214E59406C
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 17:27:00 -0700 (PDT)
Received: from wheelycreek.net (unknown [203.59.141.93])
	(Authenticated sender: nellwheelycreek)
	by smtpauth.rollernet.us (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 17:26:57 -0700 (PDT)
Received: from hiro.localnet ([192.168.22.2]:43075)
	by wheelycreek.net with [XMail 1.26 ESMTP Server]
	id <SDD5> for <git@vger.kernel.org> from <michael@frog.wheelycreek.net>;
	Thu, 12 Aug 2010 00:26:56 -0000
User-Agent: KMail/1.13.2 (Linux/2.6.35-7-generic; KDE/4.4.2; i686; ; )
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://rollernet.us/abuse.php
X-Rollernet-Submit: Submit ID 23fc.4c633fd1.54047.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153319>

Hi - I had a bit of a hiccup with git yesterday - there's a bit of a story to 
it, which at the least might be amusing. There's script to reproduce at the 
bottom if you don't care for the story.

I had done a 
 git clone --reference Foo  git@host:Foo Foo.New
then after getting it right, I  did
 mv Foo Foo.old
 mv Foo.New Foo

Then I  had all these missing references, and I thought .. oh yeah, that's 
cause it can't find the references.. well I don't really know how to change 
that (I do now), but I want all the objects in that directory anyway for when 
I delete the Foo.old directory..
so I did a 

cd Foo
git fetch

.. so all was good for a while.. It was all there and hunky-dory.

Then.. the fated git gui  'garbage collect' dialogue appeared, and I thought, 
"why not", so I did.

At that point, git decided to pack all the references (yay) .. and then it 
said.. hmm.. are those available in my alternates .. let's see  
..Foo/.git/objects  .. yeah - all those objects are there.. so I can just 
remove that pack.

Woops. 

If you're not following the story, the Foo repo had itself as an alternate.

Include me in replies please- I'm not on the list.

//.ichael Geddes

Here's the script:
------------8<-----------testalt--------------
#!/bin/sh
mkdir testaltrep
cd testaltrep
git init 
for i in 1 2 3 4 5 6 7 8 9 ; do
  touch $i.txt
  git add $i.txt 
done
git commit -m "Commit" 
echo "$PWD/.git/objects" > .git/objects/info/alternates
# Seems like it has to be done like this to get it to repack.
git repack -adl && git repack -ad  && git repack -adl
if git checkout master   ; then
  echo OK
  ret=0
else
  echo BAD Unable to checkout reference
  ret=1
fi

cd ..
rm -rf testaltrep

exit ${ret}

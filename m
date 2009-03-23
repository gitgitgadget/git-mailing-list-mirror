From: Michiel Detailleur <michiel.detailleur@gmail.com>
Subject: Can't grok this: tracking 3rd party code (from git/svn repositories 
	and/or snapshots)
Date: Mon, 23 Mar 2009 17:37:29 +0100
Message-ID: <b9d48b370903230937v57c6add9i78a05919111c5a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 17:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlnB3-0003wM-32
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbZCWQhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbZCWQhd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:37:33 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:47209 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbZCWQhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 12:37:32 -0400
Received: by bwz17 with SMTP id 17so1841760bwz.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=dc5pw860YFXGMDscengayvzEtOqiQ0+paDYGj91iYoM=;
        b=Mkbc6A3vee6h8rJeayDlOMTMQETLx2xfsJ3KWyF3zfXXhuxpvr8O2ztc3x+GQ44/++
         oEyPs6Cug4i+hgKgnUiFktUJQlNZgeLQ2FwX5bo9kIlP35EGyMMthi5p9WAldXJx67lS
         OJOwbGVP2OaWJw6vnsPHT7sd/TnmNPGQsY0dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Nlaf4oEDWGsTtfz+7MeRg7n/F/qRlOTlixsSFIFI9BfE4jrxM/NVYWY6B0Pz7kt0Gi
         /3qw3Jay/SvJfsAGTfIJrQZPORlU59TUS/3ndlS8DbMs8p4Kidd7269FCO2piVqFGRIF
         CRGCphmMLEUX/+erpQHtAu2W0tnerhoCPOyvk=
Received: by 10.223.106.14 with SMTP id v14mr6192706fao.49.1237826249278; Mon, 
	23 Mar 2009 09:37:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114334>

Hi,

I can't seem to grok the different solutions I've found and studied
for tracking external code. Let alone understand how to apply them to
my use case...

Would you guys be so kind to shed some light on this and help me with
my specific use case? What would be the best solution for the
following, concrete problem? (I'm not gonna attempt to generalize my
problem, since I might make wrong assumptions about stuff, especially
since I'm so new with all this...)

I'm building a website in Django (a web framework in Python). Now,
there are a lot of 3rd party plugins available for use with Django
(Django calls them 'apps'), that you can drop in your project. Some of
these apps might require a bit of modification to get working like I
want them. But if you start making modifications to 3rd party code you
introduce the problem of updating that code when newer versions appear
AND at the same time keeping your local modifications.

So, the way I would do that in Subversion is by using vendor branches.
My repository layout would look like this:

/trunk
  ...
  /apps
    /blog-app
  ...
/tags
  ...
/branches
  ...
/vendor
  /django-apps
    /blog-app
      /1.2
      /1.3
      /current
    /other-app
      /3.2
      /current

In this case /trunk/apps/blog-app would have been svn copy'd of one of
the tags in /vendor/django-apps/blog-app. Say that it was v1.2. And
that I now want to upgrade my version in trunk to v1.3. As you can
see, I have already updated /vendor/django-apps/blog-app/current
(using svn_load_dirs) and 'tagged' (svn copy) it as
/vendor/django-apps/blog-app/1.3.
Now I can update /trunk/apps/blog-app by svn merge'ing the changes
between /vendor/django-apps/blog-app/1.2 and
/vendor/django-apps/blog-app/1.3 on /trunk/apps/blog-app. This will
keep my local changes.
(for people unknown with this process, it is described in the
Subversion handbook:
http://svnbook.red-bean.com/en/1.5/svn.advanced.vendorbr.html)

Now I want to do this whole process in Git. How can I do this?

Let me re-iterate the requirements:

* I must be able to place the external code in an arbitrary position in the tree
* I must be able to modify the external code and keep (commit) these
modifications in my Git repos
* I must be able to easily update the external code, should a new
version be released, whilst keeping my changes

Extra (for bonus points ;-) ):

* Preferably I want to do this without something like svn_load_dirs. I
think it should be possible to track the apps and their updates
straight from their repository (most 3rd party Django apps are kept in
Subversion). Giving me the added benefit of being able to view
individual commit messages between releases. And fixing merge
conflicts more easily since I can deal with a lot of small commits
instead of the one artificial commit created by svn_load_dirs.
I think one would do this with svn:externals in Subversion, but I have
never worked with that before...

A solution where a combination of both methods could be used would be
even more preferable, since there might be app developers who don't
use source control or don't make their repos available publicly.
(Meaning both svn_load_dirs-like behavior and tracking straight from a
Subversion reposity (or another Git))

I'm eagerly awaiting your responses! Please be as verbose as possible
when replying, since I already had a hard time understanding other
examples found online.

Thanks in advance,
Michiel

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: move out of contrib
Date: Wed, 07 May 2014 05:10:03 -0500
Message-ID: <536a067b3b1ca_5e8fbfd30879@nysa.notmuch>
References: <1399077403-19678-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq38gmctzn.fsf@gitster.dls.corp.google.com>
 <536989d764672_250b14ed2ec66@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 12:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whyy8-0007Ru-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 12:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbaEGKUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 06:20:50 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:37541 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbaEGKUt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 06:20:49 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so919334oac.8
        for <git@vger.kernel.org>; Wed, 07 May 2014 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=RtalrzyOkwnSaEgoyPBoRHYZEt+Mkkm3ofZEdCQYKws=;
        b=dFlBgklWhq9DNFKZXQtsz1HyrbiVqjoBY58Il6rywfWQdoS27uA2m9jK06R4bBI3q5
         r4FTfFkBC5uaY5V7IyRHjf062D6Q8zwDvRBu9iYGhgRNBbhk5XAvvLl0UBJBBtqTYdSo
         xKmYUH68NJH808ku+s6l9/MO2Pnev5qgbkoa1dvYkv+t94GE0j11KOZiFlATxKSYpD55
         dDmAgwwoOvBrtISdl+BOjh1KtSHdD4pQv+AN44sJSZ3oBcaBiP78Yn6Oy4a+HLzZISEA
         UGScOndBPiHKY4ccTZ3+WyvCcND30AzmlP4yStnO0Pwxj7qQDiDZghlzNcBl0EKwAApZ
         Oicw==
X-Received: by 10.60.39.103 with SMTP id o7mr18868011oek.17.1399458048585;
        Wed, 07 May 2014 03:20:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm33538123obq.18.2014.05.07.03.20.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 03:20:47 -0700 (PDT)
In-Reply-To: <536989d764672_250b14ed2ec66@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248293>

Felipe Contreras wrote:
> Yes, *if* they have been packaging them, they have a way. But what if
> they haven't been doing so?
> 
> And for the ones that have a way, now they need one hack less.

As an example of all the hacks needed by a real distribution package,
here's the stuff ArchLinux packagers have to do:

  # bash completion
  mkdir -p "$pkgdir"/usr/share/bash-completion/completions/
  install -m644 ./contrib/completion/git-completion.bash "$pkgdir"/usr/share/bash-completion/completions/git
  # fancy git prompt
  mkdir -p "$pkgdir"/usr/share/git/
  install -m644 ./contrib/completion/git-prompt.sh "$pkgdir"/usr/share/git/git-prompt.sh
  # emacs
  make -C contrib/emacs prefix=/usr DESTDIR="$pkgdir" install
  # gnome credentials helper
  install -m755 contrib/credential/gnome-keyring/git-credential-gnome-keyring \
      "$pkgdir"/usr/lib/git-core/git-credential-gnome-keyring
  make -C contrib/credential/gnome-keyring clean
  # the rest of the contrib stuff
  cp -a ./contrib/* $pkgdir/usr/share/git/

  # scripts are for python 2.x
  sed -i 's|#![ ]*/usr/bin/env python$|#!/usr/bin/env python2|' \
    $(find "$pkgdir" -name '*.py') \
    "$pkgdir"/usr/share/git/gitview/gitview \
    "$pkgdir"/usr/share/git/remote-helpers/git-remote-bzr \
    "$pkgdir"/usr/share/git/remote-helpers/git-remote-hg
  sed -i 's|#![ ]*/usr/bin/python$|#!/usr/bin/python2|' \
    "$pkgdir"/usr/share/git/svn-fe/svnrdump_sim.py

  # remove perllocal.pod, .packlist, and empty directories.
  rm -rf "$pkgdir"/usr/lib/perl5

And here's what debian packagers have to do:

  # bash completion
  install -d -m0755 '$(GIT)'/etc/bash_completion.d
  install -m0644 contrib/completion/git-completion.bash \
    '$(GIT)'/etc/bash_completion.d/git
  # gitweb
  install -d -m0755 '$(GIT)'/usr/share/gitweb
  ln -s gitweb.cgi '$(GIT)'/usr/share/gitweb/index.cgi
  # contrib hooks
  install -d -m0755 '$(GIT)'/usr/share/git-core/contrib/hooks
  install -m0644 contrib/hooks/* \
    '$(GIT)'/usr/share/git-core/contrib/hooks/
  # contrib
  install -d -m0755 '$(GIT)'/usr/share/doc/git
  cp -R contrib '$(GIT)'/usr/share/doc/git/
  rm -rf '$(GIT)'/usr/share/doc/git/contrib/completion
  rm -rf '$(GIT)'/usr/share/doc/git/contrib/emacs
  find '$(GIT)'/usr/share/doc/git/contrib -type f | xargs chmod 0644
  find '$(GIT)'/usr/share/doc/git/contrib -type d | xargs chmod 0755
    # remove contrib hooks, they are now installed in
    # /usr/share/git-core/contrib, keep symlink for backward compatibility
  rm -rf '$(GIT)'/usr/share/doc/git/contrib/hooks
  ln -s ../../../git-core/contrib/hooks \
    '$(GIT)'/usr/share/doc/git/contrib/
  find '$(GIT)'/usr/share/doc/git/ -name .gitignore | xargs rm -f

If our build system was sane, they wouldn't need so many hacks.

-- 
Felipe Contreras

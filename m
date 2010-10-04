From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git svn project shuffle
Date: Mon, 4 Oct 2010 13:54:24 -0500
Message-ID: <20101004185424.GA6343@burratino>
References: <AANLkTimL18WHOrLjA5iWNcsgd6H8Eeq19LfJNjkKu_b-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Snapp <snappca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:57:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qEN-0007bq-KK
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab0JDS5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:57:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48134 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab0JDS5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:57:41 -0400
Received: by gwj17 with SMTP id 17so1741282gwj.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=L5XiR9Ftei4zzULT42i99Q2vYMKQIPfd9H5vpABvFDM=;
        b=qntOD93OmFA4rWEIjgVICdNdcWDKk7q1MddKTcy4+a9Jv1JnC/GYH7xG2EDr2vm7k4
         az/97beBwxQV6txx9rbISCZaALYglIT/O9SDRMMymF5zkOOErBE89cByRCCY0qud7duo
         gS3KVa6uztI+6T7OQUf5TKyQPWLmLWVsDqT4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mw4YeKVrFdvlQQtAy2JfUgW7cSyGOlHtgavA/p67BjFMYxQDcjyiiyIbO+wpzEfyFF
         MDsjB9kogJWmFAKew1jJ0LPRAKq9XEERRIh4jbVLHGIsuSvJWptCPUzq4jev5HEDgKLn
         Ka/AQveH57V1WW5m+7ZvLHk3aQNHjfWRdMKss=
Received: by 10.231.35.202 with SMTP id q10mr10617374ibd.138.1286218660889;
        Mon, 04 Oct 2010 11:57:40 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id u6sm3597287ibd.6.2010.10.04.11.57.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 11:57:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimL18WHOrLjA5iWNcsgd6H8Eeq19LfJNjkKu_b-@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158092>

Hi Chris,

Christopher Snapp wrote:

> # If I try to start from scratch by using git svn clone --stdlayout
> the "newproj" location I lose all of the revision history associated
> with "oldproj/trunk" that has been copied to newproj/trunk/oldproj.
> How can I have git understand the history for the
> newproj/trunk/oldproj location?

If I were in your situation I would do the following:

 0. Make backups!
 1. git svn init -Rnew ...newproj info...
 2. Edit .git/config to put the new project in a separate
     refs/remotes/newproj/ hierarchy.
 3. git svn -Rnew fetch
 4. gitk --all.  Look around.
 5. For each "tip" of the old history:
     git replace <corresponding new commit> <old branch tip>
 6. gitk --all.  Make sure it looks right.
 7. git filter-branch -- --all
 8. rm -fr .git/svn.  This is destructive, but only of information
    you're probably not using.  (It forgets old properties, for
    example.)
 9. Edit .git/config and use "git branch -r -d" to get rid of references
    to oldproj.  Rename the newproj svn-remote to "svn" again.
10. git svn fetch.
11. gitk --all.  Everything good?  Push.

> # An alternative would be if I could somehow reconfigure my already
> checked out oldproj git repo so I retain all of the version history
> and my local branches and can move forward checking code into the
> newproj/trunk/oldproj location?

If your history in each branch is not published and is linear, you
could also try just putting the old and new histories in one temporary
repo and rebasing your private branches.

Or you can export your own work with "git format-patch" or "git
fast-export" and reimport it with "git am" or "git fast-import".

Hope that helps,
Jonathan

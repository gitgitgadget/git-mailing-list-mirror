From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: more concerns about '--git-dir'
Date: Fri, 23 May 2014 11:41:15 -0700
Message-ID: <CAKpPgvf_UfgtOkotPz+aF4=UqQTOmk0O8tXg4Cm3zjzFimUoHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:41:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnuPU-0003xd-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbaEWSlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 14:41:37 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:33143 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbaEWSlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 14:41:36 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so5986927oag.13
        for <git@vger.kernel.org>; Fri, 23 May 2014 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=O7TM00W3z+8YIQ0PrdTRb5d0c6An2CA8uQ4v9hx9qz0=;
        b=m0GxbtMLzC76IpvPR4Pd/rfws9SW72L1plUJ7aZ/eLCI4vAg83/o71KSJggYJ+O3aX
         yEa0fcY93Hxs89A625loKEbVG7AhPtHB5sdrDkkwnsmu6qv5NhkdZshzPEE1SBKE1vdI
         fF2FC6b8m532JeiPcbcmgwmvmZ4HCqU8eZB3omelR9MK3MQrzanFwkogA0NNLQfFPTOg
         VIN946iW7mqlqvPw6YoWXG1hFb3kwuy3mzMM3X7+GeU9AY9NluP5Vp0hYMdDJ4n50xjh
         QM8zeH0yJz9djcqNCXtchIvNkvriM8OyJztauk7IUDqRR4c6T8PY+Erk0/meG31mF/SG
         BpAA==
X-Received: by 10.182.104.101 with SMTP id gd5mr7058424obb.54.1400870496100;
 Fri, 23 May 2014 11:41:36 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Fri, 23 May 2014 11:41:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250011>

        Hi,

        Since at it, I have discovered a couple more minor things with
this rarely-used option. I'm however a bit wary of stepping on
somebody's nerve with this sort of picking things.. :)

        Nevertheless,

1) an apparent missing "normalize_path(git_dir)", when GIT_DIR is an
absolute path:

don't even need to name the repository anything different, but run this command:

$ cd ~/tmp/
$ git init
$ git --git-dir=$HOME/tmp/../tmp/./././.git --work-tree=$HOME/tmp/../tmp/ status

You won't notice anything different in the output of course, but the
environment will be odd:
    GIT_DIR=../tmp/./././.git
    GIT_WORK_TREE=$HOME/tmp
Notice how the work-tree has been normalized and git-dir hasn't. It's
kinda hard to imagine when this can lead to an error, but never know.
Would there be objections to fixing this?


2) "git --git-dir=meta status" complains:

$ git --git-dir=meta init
$ git --git-dir=meta status

yells that work-tree isn't setup and denies to run. I'm sure most
people are aware of this. Yet, the "git-config" man page says that if
--git-dir or GIT_DIR is given then work-tree is assumed to be the
current directory. The difference with the actual behaviour is
explained by the fact that when the repository is not named anything
that ends with ".git" then it is considered a bare repository (if no
--work-tree is given), and the work-tree doesn't get setup and thus
the complaint. It maybe a safety precaution, so that Git doesn't
assume that it's at the top of work-tree while it may be actually
somewhere in the middle. But how is it different if the user runs "git
--git-dir=/opt/sparc/src/.git add sccs.c" while still sitting in the
middle of the tree? I can't judge myself which behaviour would be
right here, and ask for an opinion


    thanks
Pasha

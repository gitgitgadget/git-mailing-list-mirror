From: Christian Jaeger <chrjae@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 16:43:26 +0000
Message-ID: <CAEjYwfUfOo1huAJE2oLrMorV0tQy0Y79y2WPGEK8R0T_wq4k9g@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 17:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFnlx-0003Za-0H
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 17:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbaBRQns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 11:43:48 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56764 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaBRQnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 11:43:47 -0500
Received: by mail-oa0-f43.google.com with SMTP id h16so19593884oag.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5puhovPHf2GrAQz9Mi955Wbd8H8lFifr7pnBdVDPk1A=;
        b=yCc3QgpAGI2maPxcf++24t9ioEcAwb8liDlsjQtN6NFQ1eZpf6+2Kp8qUFLjheUOHl
         9oUEhRPX5QomI/N3pN279j4EH3ImMEaJwE8fEm5Yl/ezm2EVA07+uxIDe1fYpt6S+202
         RHTgwpVz4n2gd2G8xuNml0wjVyjVEkNknmDV9uSb00Z+uUDJYpmk+sSyGBWJVR/H70n2
         ApvD667qQvN8wjtc/aAPFxE6IkVgGFPUIuZnB0RSpvdwExQGfxpdHYb3lQaLzhvg7rQC
         gnTS4TmRNFUSn9spL8Bi5GN5Df+XWcWGQyTc46G3I1TTjBgPg2H/au09QScUAXWFhGl2
         qAtA==
X-Received: by 10.182.126.167 with SMTP id mz7mr1675378obb.69.1392741826979;
 Tue, 18 Feb 2014 08:43:46 -0800 (PST)
Received: by 10.76.27.73 with HTTP; Tue, 18 Feb 2014 08:43:26 -0800 (PST)
In-Reply-To: <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242330>

2014-02-18 9:45 GMT+00:00 Duy Nguyen <pclouds@gmail.com>:
> Christian can try "git repack -adf"

That's what I already mentioned in my first mail is what I used to fix
the problem.

Here are some 'hard' numbers, FWIW:

- both ~/scr and swap are on the same SSD;

$ free
             total       used       free     shared    buffers     cached
Mem:       3996748    3800828     195920          0     377176    1078848
-/+ buffers/cache:    2344804    1651944
Swap:      2097148     169760    1927388

git only used up to about 100 MB of VIRT or RSS when I checked, there
was an ulimit of "-S -v 1200000".

- this is git version 1.7.10.4 (1:1.7.10.4-1+wheezy1 i386 Debian)

- after my attempted merge (which had conflicts and I had then
cancelled by way of git reset --hard), and then a "git gc", the times
were:

~/scr$ time git log --raw > _THELOG

real 3m7.002s
user 2m0.252s
sys 1m6.008s

- on a copy:

/dev/shm/scr$ time git repack -a -d -f
Counting objects: 34917, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (27038/27038), done.
Writing objects: 100% (34917/34917), done.
Total 34917 (delta 13928), reused 0 (delta 0)

real 4m33.193s
user 3m42.950s
sys 1m13.821s

/dev/shm/scr$ time git log --raw > _THELOG2

real 0m8.276s
user 0m7.192s
sys 0m1.052s

(not sure why it took 8s here, perhaps I had another process running
at the same time? Compare with the "0m4.913s" below.)

/dev/shm/scr$ time g-gc --aggressive
Counting objects: 36066, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (27812/27812), done.
Writing objects: 100% (36066/36066), done.
Total 36066 (delta 14367), reused 21699 (delta 0)
Checking connectivity: 36066, done.

real 5m52.013s
user 8m28.652s
sys 1m4.308s

/dev/shm/scr$ time git log --raw > _THELOG2

real 1m34.430s
user 0m47.291s
sys 0m46.615s

/dev/shm/scr$ time git repack -adf
Counting objects: 36066, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (27812/27812), done.
Writing objects: 100% (36066/36066), done.
Total 36066 (delta 14256), reused 21699 (delta 0)

real 2m32.083s
user 1m51.295s
sys 1m4.940s

/dev/shm/scr$ time git log --raw > _THELOG3

real 0m4.913s
user 0m3.944s
sys 0m0.944s

/dev/shm/scr$ du -s .git
43728 .git

- back in the original place:

~/scr$ time git repack -a -d -f
Counting objects: 36066, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (27812/27812), done.
Writing objects: 100% (36066/36066), done.
Total 36066 (delta 14257), reused 21700 (delta 0)

real 4m6.503s
user 3m16.568s
sys 1m11.640s

~/scr$ time git log --raw > _THELOG2

real 0m5.002s
user 0m4.032s
sys 0m0.952s

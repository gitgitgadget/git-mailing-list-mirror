From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Sat, 23 May 2015 09:54:05 -0700
Message-ID: <xmqq1ti7dyky.fsf@gitster.dls.corp.google.com>
References: <555FD1EA.2060706@rightscale.com>
	<CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
	<20150523022256.GA17789@lanh> <20150523053900.GA2364@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Thorsten von Eicken <tve@rightscale.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 23 18:54:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwCgg-0006wQ-QE
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 18:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009AbbEWQyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 12:54:11 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37170 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957AbbEWQyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 12:54:08 -0400
Received: by igbsb11 with SMTP id sb11so10724911igb.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tXZ+D3Q5Rl/3bWYz9UnTxYOTu/zbqIthagDNLhpj27U=;
        b=tRlaEZPMG/O8tZRzkocgDB5o+B5vPMq2L1PMfoMHOTN8BSV83v75CGMIdRNhNW/unv
         y1xGzruK/JibEz5R9ULoMT+OCMe5qtOc7hK76PHaRUSxOnwFurOTiCooD8axiArNPSDe
         VRciIqmjkq7pjYcznevbDp9ghtm+JAP551QKRT6aySoCLwozrvwt7iyzbE2VaeTdha+O
         IEjzf6T7x7tJnwztrkHnEO2VGu8rnxUGAzBTaJz4RElKDA196/E5P3AJbfsICMqLZ994
         D6jg45s1DKYFq47HYBnIJ0FSaZ3D3dTZk80NEbRlQytDuAvh2HNSt2CAHgoS15Nht2AE
         bbTg==
X-Received: by 10.42.67.80 with SMTP id s16mr15309822ici.25.1432400047900;
        Sat, 23 May 2015 09:54:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id a74sm4520384ioe.36.2015.05.23.09.54.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 09:54:06 -0700 (PDT)
In-Reply-To: <20150523053900.GA2364@glandium.org> (Mike Hommey's message of
	"Sat, 23 May 2015 14:39:00 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269806>

Mike Hommey <mh@glandium.org> writes:

> On Sat, May 23, 2015 at 09:22:56AM +0700, Duy Nguyen wrote:
>> On Fri, May 22, 2015 at 07:03:48PM -0700, Junio C Hamano wrote:
>> > As far as I know, GIT_DIR was prepared as a mechanism to point at
>> > another .git directory that does not live inside the working tree, not
>> > as a mechanism to rename it to arbitrary name. E.g.
>> > 
>> >  $ git init
>> >  $ mv .git .svn
>> >  $ GIT_DIR=$(pwd)/.svn ; export GIT_DIR
>> > 
>> > is not expected to work.
>> ...
>> ++
>> +Note that if GIT_DIR is set explicitly to a directory inside working
>> +tree, the directory name must be ".git".
>
> Isn't the requirement that it _ends_ with ".git" (that is,
> GIT_DIR=/path/to/foo.git would work)

I think both of you are wrong ;-)

The thing is, what you are seeing does not have much to do with
GIT_DIR.  It is "what Git does when it finds a directory inside the
working tree of a project".  And ".git" is the only special thing in
that context.

When we find a directory whose name is ".git", whether it is the
same as GIT_DIR or not (and "not" case includes when you do not have
GIT_DIR defined), "git add" thinks "Ah, that is a repository proper,
and I wouldn't add it to my project".  It can do two things.  (1) if
it is not at the top of the working tree, i.e. some/directory/.git,
then some/directory is a submodule of the project that has the
working tree we are talking about (unless some/.git exists which
makes some/directory/.git a submodule of the project that has some/
as its working tree, of course), so "git add" would treat
some/directory as a thing to add.  (2) if it is at the top of the
working tree, it does not do anything to it, as it does not make
sense to add the whole working tree as a separate submodule of
ourselves.

The same for "git status".  (1) is treated as a submodule and we do
not consider individual files in some/directory/.git as untracked.
(2) we do not cconsider individual files in .git as untracked.

GIT_DIR further comes into play when it is _not_ defined.  In that
case we try upwards to find a directory that has ".git" subdirectory
and contains our $(cwd), and then declare it as our repository.

And when GIT_DIR points at somewhere that does not affect all of the
above (i.e. trying to see if a random directory inside our working
tree is a ".git" repository), it can be named anything.  If you are
working in /path/to/my/work/tree with GIT_DIR set, it can point at
/path/to/my/repository_git (note that it does not end with ".git",
and note also that it is outside our working tree) just fine.

If you move that directory to /path/to/my/worktree/repository_git,
and point at it with GIT_DIR, we will notice that is our repository
metadata, but "git add" and friends will see "repository_git" is
different from ".git" and the special casing rules for directories
inside working tree do not kick in.

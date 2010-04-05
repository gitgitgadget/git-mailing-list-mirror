From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH 0/7 (v5)] rev-cache
Date: Mon, 05 Apr 2010 20:57:43 +0100
Message-ID: <4BBA40B7.1060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail
X-From: git-owner@vger.kernel.org Mon Apr 05 21:57:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NysQg-0007Gw-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296Ab0DET5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:57:46 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:33419 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207Ab0DET5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:57:44 -0400
Received: by ewy20 with SMTP id 20so121824ewy.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=8b5goOg4iBKljK0fFNQBK2OrSS/Fzyiw7I7vZR3vLNU=;
        b=w/nxGWC78+SFVqb69Q08Bh9q6CiONzCfsO99ejREoqmWUs2ce/SLJCE8g5q433EyZJ
         Zx+rHYJAevI1onET7Fht0PImxSfx3XfjOFBhyaoX2uQoFGYv7CD9m2ZstZ4+H84uGfw1
         fdkJgOPXxRzAnHbNS/Otl9ttqbW8E65Fn2pUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=H3EEQ1h6cmcF4TAf2nnnFNk726kmzuqofvsDiQfjvxi0arbczeDoSm33NIRgyhRffV
         I3zrDSUbDOZvz8i5oOS/g+0m2BtPtKp4eFOyNwuW9Y5T8N7Ok/aQaMh7eACR8ESVlVH9
         rHkS85jMioENazT/xZHU3fXJMEDKb1N3wJ9A8=
Received: by 10.213.37.11 with SMTP id v11mr3263772ebd.60.1270497462844;
        Mon, 05 Apr 2010 12:57:42 -0700 (PDT)
Received: from [192.168.55.86] (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 15sm6490826ewy.8.2010.04.05.12.57.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 12:57:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144057>

SUGGESTED FOR 'PU':

Traversing objects is currently very costly, as every commit and tree must be
loaded and parsed.  Much time and energy could be saved by caching metadata and
topological info in an efficient, easily accessible manner.  Furthermore, this
could improve git's interfacing potential, by providing a condensed summary of
a repository's commit tree.

This is a series to implement such a revision caching mechanism, aptly named
rev-cache.  The series will provide:
 - a core API to manipulate and traverse caches
 - an integration into the internal revision walker
 - a porcelain front-end providing access to users and (shell) applications
 - a series of tests to verify/demonstrate correctness
 - documentation of the API, porcelain and core concepts

In cold starts rev-cache has sped up packing and walking by a factor of 4, and
over twice that on warm starts.  The mechanism is minimally intrusive: most of
the changes take place in seperate files, and only a handful of git's existing
functions are modified.

Slides from the presentation I gave at GitTogether'09 give a good overview of
the mechanism, usage and performance of rev-cache.  (well, they complement the
documentation well.  they're a bit bare without the dialogue...)  You can find
them at http://www.flickr.com/photos/sirnot/sets/72157623652754819/

The patchset is structured so that each patchfile represents a fully
functional, incremental development of rev-cache.  Unfortunately the addition
of several files makes for some obscenely large patchfiles.  I apologize and
regret that this is somewhat unavoidable; my only consolation is that
patchfiles are less 'patches' and more additions of files.

Hope you find this useful.

 - Nick

---
Hi everyone.  I'm sorry about the (very) belated patchset -- University has a
tendency of being very absorbing.  It's spring break now though, so I've
finally got around to finalizing rev-cache!  The only significant change from
last time (besides the bugfixes) is how structures are read/written --
excessive care is now taken to ensure a standardized file format.

This time round I've also got some swanky slides I made for GitTogether.  Hehe.

 Documentation/git-rev-cache.txt       |  194 +++
 Documentation/technical/rev-cache.txt |  634 +++++++++
 Makefile                              |    2 +
 builtin.h                             |    1 +
 builtin/gc.c                          |    9 +
 builtin/rev-cache.c                   |  339 +++++
 command-list.txt                      |    1 +
 commit.c                              |   36 +-
 git.c                                 |    1 +
 list-objects.c                        |   46 +-
 object.h                              |    3 +-
 rev-cache.c                           | 2468 +++++++++++++++++++++++++++++++++
 rev-cache.h                           |  123 ++
 revision.c                            |   90 +-
 revision.h                            |   44 +-
 t/t6019-rev-cache-list.sh             |  263 ++++
 16 files changed, 4227 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/git-rev-cache.txt
 create mode 100644 Documentation/technical/rev-cache.txt
 create mode 100644 builtin/rev-cache.c
 create mode 100644 rev-cache.c
 create mode 100644 rev-cache.h
 create mode 100644 t/t6019-rev-cache-list.sh

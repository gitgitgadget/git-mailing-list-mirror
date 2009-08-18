From: "Nick Edelen" <sirnot@gmail.com>
Subject: Re: [PATCH 0/6 (v4)] revision caching mechanism to significantly
 speed up packing/walking (last version)
Date: Tue, 18 Aug 2009 13:51:46 +0200
Message-ID: <op.uyuwkkq9tdk399@sirnot.private>
References: <op.uys3qdnntdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Nick Edelen" <sirnot@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.n
X-From: git-owner@vger.kernel.org Tue Aug 18 13:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdNEj-0007DA-0E
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 13:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758508AbZHRLvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 07:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbZHRLvv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 07:51:51 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:62766 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbZHRLvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 07:51:50 -0400
Received: by ewy3 with SMTP id 3so1509339ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from
         :content-type:mime-version:references:content-transfer-encoding
         :message-id:in-reply-to:user-agent;
        bh=sVXe37Fmz+9sc7PiMztKipf1L2gY83L0sxoBtiomnPY=;
        b=ubgWKdLMNhL8aU6byIfuBP5FeIlorONWHohxEqOVxxnSzY4kqIG4hmVlsFjG8iuWj+
         uCJUGOjY9LeVYJO4nOQQGrAfeDh3fUWDL4byJ83aDNqGgGB86b5Wo9bLDeZH0hED2pbQ
         soEQuYCd/Sg/U/OhiRWT1ux+siXAttLBprG88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:content-type:mime-version:references
         :content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=lS98nrwSfI6A7nx0GlgIkgavLU5ptMh/vwfEe5VKSzZbuUN+gsNxtaOGpO8EtOW9rK
         NxHjy6KXwRkXt8o54TLkCR3DRenpIP/bjZHsI7OIR72iadmfS3Rxk931ViyYpZOkZVM5
         6Oq0Z+0TDjVyTh7345Y8AQ9JiqaImkgDZE5Vk=
Received: by 10.216.52.194 with SMTP id e44mr1238298wec.34.1250596310824;
        Tue, 18 Aug 2009 04:51:50 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id m5sm18764413gve.18.2009.08.18.04.51.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 04:51:50 -0700 (PDT)
In-Reply-To: <op.uys3qdnntdk399@sirnot.private>
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126377>

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
over twice that on warm starts.  Some times on slax for the linux repository:

rev-list --all --objects >/dev/null
 default
   cold    1:13
   warm    0:43
 rev-cache'd
   cold    0:19
   warm    0:02

pack-objects --revs --all --stdout >/dev/null
 default
   cold    2:44
   warm    1:21
 rev-cache'd
   cold    0:44
   warm    0:10

The mechanism is minimally intrusive: most of the changes take place in
seperate files, and only a handful of git's existing functions are modified.

Hope you find this useful.

 - Nick

---
Ok, this really is the last time I send all these.

 Documentation/git-rev-cache.txt       |  162 +++
 Documentation/technical/rev-cache.txt |  614 +++++++++
 Makefile                              |    2 +
 builtin-gc.c                          |    9 +
 builtin-rev-cache.c                   |  323 +++++
 builtin.h                             |    1 +
 commit.c                              |    2 +
 git.c                                 |    1 +
 list-objects.c                        |   49 +-
 rev-cache.c                           | 2316 +++++++++++++++++++++++++++++++++
 rev-cache.h                           |  124 ++
 revision.c                            |   90 +-
 revision.h                            |   44 +-
 t/t6015-rev-cache-list.sh             |  251 ++++
 14 files changed, 3963 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/git-rev-cache.txt
 create mode 100644 Documentation/technical/rev-cache.txt
 create mode 100644 builtin-rev-cache.c
 create mode 100644 rev-cache.c
 create mode 100644 rev-cache.h
 create mode 100755 t/t6015-rev-cache-list.sh

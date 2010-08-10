From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] memory leak reported by valgrind
Date: Mon, 9 Aug 2010 22:26:48 -0500
Message-ID: <20100810032647.GA2386@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 05:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OifVo-0008Cs-DG
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 05:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766Ab0HJD2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 23:28:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53007 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab0HJD2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 23:28:17 -0400
Received: by yxg6 with SMTP id 6so3633675yxg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MWEaq4eo5F1dqraYNX/4mSXkUIrftavE0qxDsZJHbpA=;
        b=h49gEBk3gClrTHXgjdHQDx6S1ZN17eAdtCSdfeY+wK3d8IhXfJB1vIZ5Cq9hqiPqRX
         WfYcE3tRM6ubj7q97waeIQfXIBQ97lcG6NNG3MqpoBb4WXPEhcmvfEs7qSgvPSnG0eFz
         Odi2/jbJwEEWAOmONchFnYkM9IEhISxyCp4/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CjJqEb47nSwE9zdMPPjZFXPA9jYhFJih7arVXeZeiB8zlD/QgxQ24yBFomjd8EVIwf
         81/YcwlmXF1nlkgeD4kK/5Y/XzZwf0PmHk3wORq0jK2RHEqixKQKKNnq4hpXiBUiseNj
         SVD8QCNxp01HCtk0bxOW6qt6DfK4up5gB5vbU=
Received: by 10.151.102.16 with SMTP id e16mr2967780ybm.251.1281410897038;
        Mon, 09 Aug 2010 20:28:17 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q1sm5502322ybk.20.2010.08.09.20.28.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 20:28:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1va760ip.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153072>

Junio C Hamano wrote:

> Thanks, but doesn't it essentially sit at the end of main(), only for=
 _exit(2)
> to clean after us?

Right.  This is the case for many leaks reported by valgrind for git; i=
t
is hard to separate the ones the matter.

Example: the lockfile records.  There are so few per process as not to
matter except for the sake of valgrind, and they cannot be removed
before exiting because the list they are inserted in is singly-linked.
I am cooking a patch to free them at exit optionally, somewhat like
Pierre=E2=80=99s leaky()[1].  Could something like leaky() be used to i=
nsert
an artificial stack frame at allocation time to make suppressions
simpler to write?

Well, that=E2=80=99s a separate story.  Here are a few run-of-the-mill =
leaks.

Jonathan Nieder (3):
  core: Stop leaking ondisk_cache_entrys
  write-tree: Avoid leak when index refers to an invalid object
  read-tree: stop leaking tree objects

 cache-tree.c   |    4 +++-
 read-cache.c   |    5 ++++-
 unpack-trees.c |    7 ++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/86138
